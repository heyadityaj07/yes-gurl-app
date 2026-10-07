// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart';
import '/flutter_flow/custom_functions.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

Future<bool> hasUnreadCommunity(DocumentReference userRef) async {
  try {
    // ---------------------------------------------------------
    // 1. Get communities hosted by the user
    // ---------------------------------------------------------
    final hostedCommunities = await FirebaseFirestore.instance
        .collection('community')
        .where('created_by', isEqualTo: userRef)
        .get();

    // Store unique communities.
    final communities = <String, DocumentReference>{};

    for (final community in hostedCommunities.docs) {
      final newMembers = await community.reference
          .collection('members')
          .where(
            'created_at',
            isGreaterThan: FFAppState().lastCommunitySeenAt,
          )
          .limit(1)
          .get();

      if (newMembers.docs.isNotEmpty) {
        return true;
      }
      communities[community.reference.path] = community.reference;
    }

    // ---------------------------------------------------------
    // 2. Get communities where the user is a member
    // ---------------------------------------------------------
    final memberships = await FirebaseFirestore.instance
        .collectionGroup('members')
        .where('user_ref', isEqualTo: userRef)
        .get();

    for (final membership in memberships.docs) {
      final communityRef = membership.reference.parent.parent;

      if (communityRef != null) {
        communities[communityRef.path] = communityRef;
      }
    }

    debugPrint(
      '[hasUnreadCommunity] checking ${communities.length} communities',
    );

    if (communities.isEmpty) {
      return false;
    }

    // ---------------------------------------------------------
    // 3. Check each community
    // ---------------------------------------------------------
    for (final communityRef in communities.values) {
      final newMembers = await communityRef
          .collection('members')
          .where(
            'created_at',
            isGreaterThan: FFAppState().lastCommunitySeenAt,
          )
          .limit(1)
          .get();

      if (newMembers.docs.isNotEmpty) {
        return true;
      }
      debugPrint(
        '[hasUnreadCommunity] checking community ${communityRef.id}',
      );

      // -------------------------------------------------------
      // Find the latest message already seen by this user.
      // Only fetch ONE message.
      // -------------------------------------------------------
      final lastSeenQuery = await communityRef
          .collection('messages')
          .where(
            'message_seen_by',
            arrayContains: userRef,
          )
          .orderBy(
            'created_at',
            descending: true,
          )
          .limit(1)
          .get();

      // -------------------------------------------------------
      // CASE 1:
      // User has NEVER seen a message in this community.
      // -------------------------------------------------------
      if (lastSeenQuery.docs.isEmpty) {
        debugPrint(
          '[hasUnreadCommunity] ${communityRef.id}: '
          'no previously seen messages',
        );

        // Check whether at least ONE message exists.
        // We don't load all messages.
        final firstMessageQuery = await communityRef
            .collection('messages')
            .orderBy(
              'created_at',
              descending: true,
            )
            .limit(1)
            .get();

        if (firstMessageQuery.docs.isEmpty) {
          // Community has no messages.
          continue;
        }

        final messageData = firstMessageQuery.docs.first.data();

        // Ignore deleted messages.
        if (messageData['deleted_at'] != null) {
          continue;
        }

        // Ignore user's own message.
        if (messageData['user_ref'] == userRef) {
          continue;
        }

        // There is at least one message the user hasn't seen.
        debugPrint(
          '[hasUnreadCommunity] unread message found in '
          '${communityRef.id} (first-time user)',
        );

        return true;
      }

      // -------------------------------------------------------
      // CASE 2:
      // User has seen messages before.
      // -------------------------------------------------------
      final lastSeenData = lastSeenQuery.docs.first.data();
      final lastSeenCreatedAt = lastSeenData['created_at'];

      if (lastSeenCreatedAt is! Timestamp) {
        continue;
      }

      // -------------------------------------------------------
      // Only fetch ONE message after the latest seen message.
      // -------------------------------------------------------
      final unreadQuery = await communityRef
          .collection('messages')
          .where(
            'created_at',
            isGreaterThan: lastSeenCreatedAt,
          )
          .orderBy('created_at')
          .limit(1)
          .get();

      if (unreadQuery.docs.isEmpty) {
        continue;
      }

      final messageData = unreadQuery.docs.first.data();

      // Ignore deleted messages.
      if (messageData['deleted_at'] != null) {
        continue;
      }

      // Ignore messages created by the current user.
      if (messageData['user_ref'] == userRef) {
        continue;
      }

      // -------------------------------------------------------
      // One unread message is enough.
      // -------------------------------------------------------
      debugPrint(
        '[hasUnreadCommunity] unread message found in '
        '${communityRef.id}',
      );

      return true;
    }

    // No unread messages found in any community.
    debugPrint(
      '[hasUnreadCommunity] no unread community messages',
    );

    return false;
  } catch (error, stackTrace) {
    debugPrint(
      '[hasUnreadCommunity] error: $error\n$stackTrace',
    );

    return false;
  }
}

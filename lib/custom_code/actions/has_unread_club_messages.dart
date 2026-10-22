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

import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

Future<bool> hasUnreadClubMessages(
  DocumentReference? userRef,
) async {
  // Add your function code here!
  final targetUserRef = userRef ?? currentUserReference;
  if (targetUserRef == null) return false;

  final effectiveRoomRef = FirebaseFirestore.instance
      .collection('chat_rooms')
      .doc('VaptPPzsVMyO5KYpGYPb');

  try {
    final messagesColl = effectiveRoomRef.collection('chat_messages');

    // Find the latest message already seen by this user
    DocumentSnapshot<Map<String, dynamic>>? lastSeenDoc;
    try {
      final lastSeenQuery = await messagesColl
          .where('message_seen_by', arrayContains: targetUserRef)
          .orderBy('created_at', descending: true)
          .limit(1)
          .get();

      if (lastSeenQuery.docs.isNotEmpty) {
        lastSeenDoc = lastSeenQuery.docs.first;
      }
    } catch (e) {
      try {
        final recentQuery = await messagesColl
            .orderBy('created_at', descending: true)
            .limit(50)
            .get();

        for (final doc in recentQuery.docs) {
          final data = doc.data();
          final seenBy = data['message_seen_by'];
          if (seenBy is List && seenBy.contains(targetUserRef)) {
            lastSeenDoc = doc;
            break;
          }
        }
      } catch (_) {}
    }

    // CASE 1: User has NEVER seen any messages
    if (lastSeenDoc == null) {
      final latestMsgQuery = await messagesColl
          .orderBy('created_at', descending: true)
          .limit(1)
          .get();

      if (latestMsgQuery.docs.isEmpty) return false;

      final data = latestMsgQuery.docs.first.data();
      if (data['deleted_at'] != null) return false;
      if (data['user_ref'] == targetUserRef) return false;

      return true;
    }

    // CASE 2: User has seen messages before
    final lastSeenCreatedAt = lastSeenDoc.data()?['created_at'];
    if (lastSeenCreatedAt is! Timestamp) return false;

    final unreadQuery = await messagesColl
        .where('created_at', isGreaterThan: lastSeenCreatedAt)
        .orderBy('created_at', descending: true)
        .limit(5)
        .get();

    for (final doc in unreadQuery.docs) {
      final data = doc.data();
      if (data['deleted_at'] != null) continue;
      if (data['user_ref'] == targetUserRef) continue;
      final seenBy = data['message_seen_by'];
      if (seenBy is! List || !seenBy.contains(targetUserRef)) {
        return true;
      }
    }

    return false;
  } catch (e) {
    debugPrint('[hasUnreadClubMessages] error: $e');
    return false;
  }
}

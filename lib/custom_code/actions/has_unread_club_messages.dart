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
  final targetUserRef = userRef ?? currentUserReference;
  if (targetUserRef == null) return false;

  final effectiveRoomRef = FirebaseFirestore.instance
      .collection('chat_rooms')
      .doc('VaptPPzsVMyO5KYpGYPb');

  final targetUid = targetUserRef.id;

  try {
    final messagesColl = effectiveRoomRef.collection('chat_messages');

    // Single-field query (created_at DESC) - NO composite index required!
    final snap = await messagesColl
        .orderBy('created_at', descending: true)
        .limit(20)
        .get();

    if (snap.docs.isEmpty) {
      return false;
    }

    for (final doc in snap.docs) {
      final data = doc.data();

      // Skip soft-deleted or removed messages
      if (data['deleted_at'] != null || data['is_removed_by_admin'] == true) {
        continue;
      }

      // Check if message was sent by target user
      final authorRef = data['user_ref'];
      final isByMe = authorRef == targetUserRef ||
          (authorRef is DocumentReference && authorRef.id == targetUid) ||
          (authorRef is String &&
              (authorRef == targetUid || authorRef.endsWith('/$targetUid')));

      if (isByMe) {
        // Message sent by target user; check earlier messages in case an older message was unseen
        continue;
      }

      // Check if target user has seen this message
      final seenBy = data['message_seen_by'];
      bool hasSeen = false;
      if (seenBy is Iterable) {
        for (final item in seenBy) {
          if (item == targetUserRef) {
            hasSeen = true;
            break;
          }
          if (item is DocumentReference && item.id == targetUid) {
            hasSeen = true;
            break;
          }
          if (item is String &&
              (item == targetUid || item.endsWith('/$targetUid'))) {
            hasSeen = true;
            break;
          }
        }
      }

      if (!hasSeen) {
        // Found a recent message not sent by user and not seen yet!
        return true;
      } else {
        // The most recent valid message has already been seen by the user.
        // Since messages are ordered descending, the user is caught up to date!
        return false;
      }
    }

    return false;
  } catch (e) {
    debugPrint('[hasUnreadClubMessages] error: $e');
    return false;
  }
}

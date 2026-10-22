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

Future markClubMessagesAsSeen(
  DocumentReference? roomRef,
  DocumentReference? userRef,
) async {
  final targetUserRef = userRef ?? currentUserReference;
  if (targetUserRef == null) return;

  final effectiveRoomRef = roomRef ??
      FirebaseFirestore.instance
          .collection('chat_rooms')
          .doc('VaptPPzsVMyO5KYpGYPb');

  try {
    final messagesColl = effectiveRoomRef.collection('chat_messages');

    // 1. Find the latest message already seen by this user.
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
      debugPrint('[markClubMessagesAsSeen] index query fallback: $e');
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
      } catch (fallbackErr) {
        debugPrint('[markClubMessagesAsSeen] fallback error: $fallbackErr');
      }
    }

    Query<Map<String, dynamic>> messagesQuery =
        messagesColl.orderBy('created_at', descending: true);

    if (lastSeenDoc != null) {
      // Returning user: only fetch messages newer than the last seen one
      final lastSeenData = lastSeenDoc.data();
      final lastSeenCreatedAt = lastSeenData?['created_at'];

      if (lastSeenCreatedAt is Timestamp) {
        messagesQuery = messagesQuery.where(
          'created_at',
          isGreaterThan: lastSeenCreatedAt,
        );
      }
    } else {
      // First time user: only mark the last 5 messages as seen
      messagesQuery = messagesQuery.limit(5);
    }

    final messages = await messagesQuery.get();

    if (messages.docs.isEmpty) {
      return;
    }

    // 2. Mark the messages as seen in batches
    WriteBatch batch = FirebaseFirestore.instance.batch();
    int batchCount = 0;

    for (final message in messages.docs) {
      final data = message.data();

      // Skip soft-deleted messages
      if (data['deleted_at'] != null) {
        continue;
      }

      final seenBy = data['message_seen_by'];

      if (seenBy is! List || !seenBy.contains(targetUserRef)) {
        batch.update(message.reference, {
          'message_seen_by': FieldValue.arrayUnion([targetUserRef]),
        });
        batchCount++;

        // Commit in chunks if necessary (Firestore max is 500)
        if (batchCount >= 400) {
          await batch.commit();
          batch = FirebaseFirestore.instance.batch();
          batchCount = 0;
        }
      }
    }

    if (batchCount > 0) {
      await batch.commit();
    }
    debugPrint(
      '[markClubMessagesAsSeen] successfully processed seen messages for user ${targetUserRef.id}',
    );
  } catch (e, stackTrace) {
    debugPrint(
      '[markClubMessagesAsSeen] error: $e\n$stackTrace',
    );
  }
}

Future getClubMessage(
  DocumentReference? roomRef,
  DocumentReference? userRef,
) async =>
    markClubMessagesAsSeen(roomRef, userRef);

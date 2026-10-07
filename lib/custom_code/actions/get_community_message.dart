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

import 'index.dart'; // Imports other custom actions

Future getCommunityMessage(
  DocumentReference communityRef,
  DocumentReference? userRef,
) async {
  if (userRef == null) return;

  try {
    final lastSeenQuery = await communityRef
        .collection('messages')
        .where(
          'message_seen_by',
          arrayContains: userRef,
        )
        .orderBy('created_at', descending: true)
        .limit(1)
        .get();

    Query<Map<String, dynamic>> messagesQuery = communityRef
        .collection('messages')
        .orderBy('created_at', descending: true);

    if (lastSeenQuery.docs.isNotEmpty) {
      // User has seen messages before.
      final lastSeenData = lastSeenQuery.docs.first.data();
      final lastSeenCreatedAt = lastSeenData['created_at'];

      if (lastSeenCreatedAt is Timestamp) {
        messagesQuery = messagesQuery.where(
          'created_at',
          isGreaterThan: lastSeenCreatedAt,
        );
      }
    } else {
      // First time user.
      messagesQuery = messagesQuery.limit(5);
    }

    final messages = await messagesQuery.get();

    if (messages.docs.isEmpty) {
      return;
    }

    // 3. Mark the new messages as seen.
    final batch = FirebaseFirestore.instance.batch();

    for (final message in messages.docs) {
      final data = message.data();
      print(
        '[getCommunityMessage] processing message ${message.id} with data: $data',
      );

      if (data['deleted_at'] != null) {
        continue;
      }

      final seenBy = data['message_seen_by'];

      if (seenBy is! List || !seenBy.contains(userRef)) {
        batch.update(message.reference, {
          'message_seen_by': FieldValue.arrayUnion([userRef]),
        });
      }
    }

    await batch.commit();
  } catch (e, stackTrace) {
    debugPrint(
      '[getCommunityMessage] error: $e\n$stackTrace',
    );
  }
}

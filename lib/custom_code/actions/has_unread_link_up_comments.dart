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

import 'package:stream_transform/stream_transform.dart';

import 'index.dart'; // Imports other custom actions

import '/auth/firebase_auth/auth_util.dart';

Future<bool> hasUnreadLinkUpComments(DocumentReference userRef) async {
  try {
    final event = await FirebaseFirestore.instance
        .collection('events')
        .where('date', isGreaterThanOrEqualTo: FFAppState().lastLinkupSeenAt)
        .get();
    if (event.docs.length > 0) {
      return true;
    }

    final eventsCollection = FirebaseFirestore.instance.collection('events');
    final hostedEvents =
        await eventsCollection.where('created_by', isEqualTo: userRef).get();
    final attendingEvents =
        await eventsCollection.where('attending', arrayContains: userRef).get();

    final eventsByPath = <String, QueryDocumentSnapshot>{};
    for (final event in [...hostedEvents.docs, ...attendingEvents.docs]) {
      eventsByPath[event.reference.path] = event;
    }

    final commentsCollection =
        FirebaseFirestore.instance.collection('events_comment');
    for (final linkUp in eventsByPath.values) {
      final comments = await commentsCollection
          .where('comment_eventRef', isEqualTo: linkUp.reference)
          .get();

      for (final comment in comments.docs) {
        final commentData = comment.data();
        if (commentData['comment_userRef'] == userRef) continue;

        final seenBy = commentData['comment_seen_by'];
        if (seenBy is! List || !seenBy.contains(userRef)) {
          return true;
        }
      }
    }
  } catch (error) {
    debugPrint('hasUnreadLinkUpComments error: $error');
  }

  return false;
}

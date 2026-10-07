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

Future getEventComments(
  DocumentReference eventRef,
  DocumentReference userRef,
) async {
  // Add your function code here!
  if (eventRef == null) return;

  final comments = await FirebaseFirestore.instance
      .collection('events_comment')
      .where('comment_eventRef', isEqualTo: eventRef)
      .get();

  for (final comment in comments.docs) {
    comment.reference.update({
      'comment_seen_by': FieldValue.arrayUnion([userRef])
    });
  }
}

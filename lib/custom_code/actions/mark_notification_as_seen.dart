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

Future markNotificationAsSeen(
  NotificationRecord? notification,
  DocumentReference? currentUserRef,
) async {
  // Add your function code here!
  if (notification == null || currentUserRef == null) return;

  try {
    if (notification.manage.toLowerCase() == 'admin') {
      // For admin notifications, we add the user to the seen_list
      if (!notification.seenList.contains(currentUserRef)) {
        await notification.reference.update({
          'seen_list': FieldValue.arrayUnion([currentUserRef]),
        });
      }
    } else {
      // For standard notifications, we set the seen boolean to true
      if (!notification.seen) {
        await notification.reference.update({
          'seen': true,
        });
      }
    }
  } catch (e) {
    debugPrint('Error marking notification as seen: $e');
  }
}

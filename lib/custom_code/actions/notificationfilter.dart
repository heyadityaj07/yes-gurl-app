// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// make list from given notification list with filter user is not in the list of given field for each notification document
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<DocumentReference>> notificationfilter(
  DocumentReference user,
  List<DocumentReference> notification,
  String field,
) async {
  List<DocumentReference> filteredNotifications = [];

  for (DocumentReference notificationRef in notification) {
    try {
      // Get the notification document
      DocumentSnapshot notificationDoc = await notificationRef.get();

      if (notificationDoc.exists) {
        Map<String, dynamic>? data =
            notificationDoc.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey(field)) {
          // Get the field value which should be a list
          dynamic fieldValue = data[field];

          if (fieldValue is List) {
            // Convert list items to DocumentReference if they aren't already
            List<DocumentReference> userList = [];
            for (dynamic item in fieldValue) {
              if (item is DocumentReference) {
                userList.add(item);
              }
            }

            // Check if the user is NOT in the list
            bool userNotInList = !userList.any((ref) => ref.path == user.path);

            if (userNotInList) {
              filteredNotifications.add(notificationRef);
            }
          } else {
            // If field is not a list, include the notification
            filteredNotifications.add(notificationRef);
          }
        } else {
          // If field doesn't exist, include the notification
          filteredNotifications.add(notificationRef);
        }
      }
    } catch (e) {
      // If there's an error reading the document, skip it
      continue;
    }
  }

  return filteredNotifications;
}

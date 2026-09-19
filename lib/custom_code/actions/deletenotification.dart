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

import 'package:cloud_firestore/cloud_firestore.dart';

Future deletenotification(
  DocumentReference currentUserRef,
  DateTime createdTime,
) async {
  // Add your function code here!
  if (currentUserRef == null || createdTime == null) return;

  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('notification')
        .where(
          Filter.or(
            Filter('user', isEqualTo: currentUserRef),
            Filter('manage', isEqualTo: 'admin'),
          ),
        )
        .orderBy('sent_at', descending: true)
        .get();

    final docs = querySnapshot.docs;

    // ✅ Step 2: Filter once (avoid repeated .where)
    final filtered = docs.where((doc) {
      final data = doc.data();
      final sentAt = data['sent_at'] as Timestamp?;
      return sentAt != null && sentAt.toDate().isAfter(createdTime);
    }).toList();

    final futures = <Future>[];

    for (final doc in filtered) {
      final data = doc.data();

      if (data['manage'] == 'admin') {
        futures.add(
          doc.reference.update({
            'delete_list': FieldValue.arrayUnion([currentUserRef])
          }),
        );
      } else if (data['user'] == currentUserRef) {
        futures.add(doc.reference.delete());
      }
    }
    await Future.wait(futures);
  } catch (e) {
    print('Error deleting notifications: $e');
  }
}

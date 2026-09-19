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
import 'package:firebase_auth/firebase_auth.dart';

Future<void> recordUserActivity() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    print('recordUserActivity: no logged-in user');
    return;
  }

  try {
    final userRef = FirebaseFirestore.instance.collection('user').doc(user.uid);

    final snapshot = await userRef.get();

    final data = snapshot.data();

    if (data != null) {
      final lastActive = data['last_active'];
      final now = DateTime.now();
      final lastActiveTime = lastActive.toDate();

      final difference = now.difference(lastActiveTime);

      if (difference.isNegative || difference < const Duration(hours: 1)) {
        print('Skipped: last_active was updated less than 1 hour ago');

        return;
      }
    }

    await userRef.set(
      {
        'last_active': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  } catch (e) {
    print('recordUserActivity error: $e');
  }
}

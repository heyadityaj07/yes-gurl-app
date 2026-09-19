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

import 'package:firebase_auth/firebase_auth.dart';

Future fcmtokendelete() async {
  // Add your function code here!
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final firestore = FirebaseFirestore.instance;

  try {
    // Reference to user's fcm_tokens subcollection
    final tokensRef =
        firestore.collection('user').doc(user.uid).collection('fcm_tokens');

    // Fetch all token documents
    final snapshot = await tokensRef.get();

    // Delete each document
    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }

    print("✅ All FCM tokens deleted and user logged out.");
  } catch (e) {
    print("❌ Error during logout: $e");
  }
}

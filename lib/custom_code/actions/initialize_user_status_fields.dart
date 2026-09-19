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
import '/auth/firebase_auth/auth_util.dart';

Future initializeUserStatusFields() async {
  final user = currentUserReference;

  if (user == null) {
    return;
  }

  final userDoc = await user.get();

  if (!userDoc.exists) {
    return;
  }

  final data = userDoc.data() as Map<String, dynamic>;

  final Map<String, dynamic> fieldsToAdd = {};

  if (!data.containsKey('isDeactivated')) {
    fieldsToAdd['isDeactivated'] = false;
  }

  if (!data.containsKey('banned')) {
    fieldsToAdd['banned'] = false;
  }

  if (!data.containsKey('hideProfile')) {
    fieldsToAdd['hideProfile'] = false;
  }

  // Only update if at least one field is missing.
  if (fieldsToAdd.isNotEmpty) {
    await user.set(
      fieldsToAdd,
      SetOptions(merge: true),
    );
  }
}

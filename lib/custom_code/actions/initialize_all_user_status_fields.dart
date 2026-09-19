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

/// One-time migration: For every user, set isDeactivated / banned /
/// hideProfile to false only when the field is missing or null/invalid.
///
/// Users are fetched in batches of 500 so we don't load the entire user
/// collection into memory at once.
Future<int> initializeAllUserStatusFields() async {
  final firestore = FirebaseFirestore.instance;
  final usersCollection = firestore.collection('user');

  const int fetchBatchSize = 500;

  int updatedCount = 0;
  int processedUsers = 0;

  DocumentSnapshot<Map<String, dynamic>>? lastDocument;

  while (true) {
    Query<Map<String, dynamic>> query =
        usersCollection.orderBy(FieldPath.documentId).limit(fetchBatchSize);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument!);
    }

    final usersSnapshot = await query.get();

    if (usersSnapshot.docs.isEmpty) {
      break;
    }

    print(
      'Fetched ${usersSnapshot.docs.length} users. '
      'Processed so far: $processedUsers',
    );

    WriteBatch batch = firestore.batch();
    int operationsInBatch = 0;

    for (final doc in usersSnapshot.docs) {
      final data = doc.data();

      final fieldsToAdd = <String, dynamic>{};

      if (_needsDefaultFalse(data, 'isDeactivated')) {
        fieldsToAdd['isDeactivated'] = false;
      }

      if (_needsDefaultFalse(data, 'banned')) {
        fieldsToAdd['banned'] = false;
      }

      if (_needsDefaultFalse(data, 'hideProfile')) {
        fieldsToAdd['hideProfile'] = false;
      }

      if (fieldsToAdd.isNotEmpty) {
        batch.set(
          doc.reference,
          fieldsToAdd,
          SetOptions(merge: true),
        );

        operationsInBatch++;
        updatedCount++;
      }
    }

    // Commit current batch.
    if (operationsInBatch > 0) {
      await batch.commit();

      print(
        'Committed $operationsInBatch updates. '
        'Total updated: $updatedCount',
      );
    }

    processedUsers += usersSnapshot.docs.length;

    // Last document becomes the starting point for the next query.
    lastDocument = usersSnapshot.docs.last;

    // If fewer than 500 were returned, we reached the end.
    if (usersSnapshot.docs.length < fetchBatchSize) {
      break;
    }
  }

  print(
    'Migration completed. '
    'Processed users: $processedUsers, '
    'Updated users: $updatedCount',
  );

  return updatedCount;
}

bool _needsDefaultFalse(
  Map<String, dynamic> data,
  String field,
) {
  if (!data.containsKey(field)) {
    return true;
  }

  final value = data[field];

  // Existing true/false values are preserved.
  if (value == true || value == false) {
    return false;
  }

  // Null or any unexpected value gets false.
  return true;
}

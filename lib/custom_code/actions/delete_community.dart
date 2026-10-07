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
import 'package:firebase_storage/firebase_storage.dart';

import 'send_multiple_user_notifications.dart';

Future<bool> deleteCommunity(DocumentReference? community) async {
  // Add your function code here!
  if (community == null) {
    return false;
  }

  try {
    final communitySnap = await community.get();
    if (!communitySnap.exists) {
      return false;
    }

    final data = communitySnap.data() as Map<String, dynamic>? ?? {};
    final name = (data['name'] as String?)?.trim();
    final communityName =
        (name == null || name.isEmpty) ? 'This community' : name;

    // Notify while member docs still exist. Failure here should not block delete.
    try {
      await sendMultipleUserNotifications(
        community,
        'Community deleted',
        '$communityName has been deleted',
      );
    } catch (_) {}

    await _deleteQuery(community.collection('members'));
    await _deleteQuery(community.collection('messages'));
    await _deleteQuery(community.collection('join_requests'));
    // await _deleteQuery(
    //   NotificationRecord.collection.where('community', isEqualTo: community),
    // );

    final imageUrl = data['community_image'];
    if (imageUrl is String &&
        imageUrl.contains('firebasestorage.googleapis.com')) {
      try {
        await FirebaseStorage.instance.refFromURL(imageUrl).delete();
      } catch (_) {}
    }

    await community.delete();
    return true;
  } catch (_) {
    return false;
  }
}

Future<void> _deleteQuery(Query query) async {
  while (true) {
    final snap = await query.limit(400).get();
    if (snap.docs.isEmpty) {
      return;
    }
    final batch = FirebaseFirestore.instance.batch();
    for (final doc in snap.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
    if (snap.docs.length < 400) {
      return;
    }
  }
}

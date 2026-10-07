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

import '/auth/firebase_auth/auth_util.dart';
import '/backend/push_notifications/push_notifications_util.dart';

Future sendMultipleUserNotifications(
  DocumentReference communityRef,
  String title,
  String message,
) async {
  // Add your function code here!
  if (title.trim().isEmpty || message.trim().isEmpty) {
    return;
  }

  final members = await queryMembersRecordOnce(parent: communityRef);
  final eligibleUsers = <DocumentReference>[];

  for (final member in members) {
    if (!member.notificationsEnabled) {
      continue;
    }
    final userRef = member.userRef;
    if (userRef == null || userRef.id == currentUserUid) {
      continue;
    }

    final userSnap = await userRef.get();
    if (!userSnap.exists) {
      continue;
    }
    final user = UserRecord.fromSnapshot(userSnap);
    if (!user.isNotificationEnabled) {
      continue;
    }
    eligibleUsers.add(userRef);
  }

  if (eligibleUsers.isEmpty) {
    return;
  }

  triggerPushNotification(
    notificationTitle: title,
    notificationText: message,
    notificationSound: 'default',
    userRefs: eligibleUsers,
    initialPageName: 'communityDetail',
    parameterData: {
      'communityRef': communityRef,
    },
  );

  const batchSize = 400;
  for (var i = 0; i < eligibleUsers.length; i += batchSize) {
    final chunk = eligibleUsers.skip(i).take(batchSize);
    final batch = FirebaseFirestore.instance.batch();
    for (final userRef in chunk) {
      batch.set(
        NotificationRecord.collection.doc(),
        createNotificationRecordData(
          title: message,
          sentBy: currentUserReference,
          user: userRef,
          sentAt: getCurrentTimestamp,
          notificationType: 'community',
          seen: false,
          community: communityRef,
          forAdmin: false,
        ),
      );
    }
    await batch.commit();
  }
}

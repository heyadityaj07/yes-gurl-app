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
import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> deleteUser(DocumentReference userRef) async {
  // Add your function code here!

  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    return true;
  }

  final uid = user.uid;

  try {
    await user.delete();
    print("Firebase Auth user deleted.");
  } catch (e) {
    print("User deletion failed: $e");
    return true;
  }

  try {
    final chatA = await FirebaseFirestore.instance
        .collection('chat')
        .where('userA', isEqualTo: userRef)
        .get();

    // Chats where userB == userRef
    final chatB = await FirebaseFirestore.instance
        .collection('chat')
        .where('userB', isEqualTo: userRef)
        .get();

    // Combine chats
    final allChats = [...chatA.docs, ...chatB.docs];

    // Loop chats
    for (final chatDoc in allChats) {
      // Delete messages linked to this chat
      final messages = await FirebaseFirestore.instance
          .collection('Chat_Message')
          .where('chatRef', isEqualTo: chatDoc.reference)
          .get();

      for (final messageDoc in messages.docs) {
        await messageDoc.reference.delete();
      }

      // Delete chat document
      await chatDoc.reference.delete();
    }

    final events = await FirebaseFirestore.instance.collection('events').get();

    for (final eventDoc in events.docs) {
      final data = eventDoc.data();

      bool changed = false;

      // Remove from attending
      if (data['attending'] != null &&
          (data['attending'] as List).contains(userRef)) {
        await eventDoc.reference.update({
          'attending': FieldValue.arrayRemove([userRef])
        });
        changed = true;
      }

      // Remove from invited_user
      if (data['invited_user'] != null &&
          (data['invited_user'] as List).contains(userRef)) {
        await eventDoc.reference.update({
          'invited_user': FieldValue.arrayRemove([userRef])
        });
        changed = true;
      }
      // Remove from report_user_list
      if (data['report_user_list'] != null &&
          (data['report_user_list'] as List).contains(userRef)) {
        await eventDoc.reference.update({
          'report_user_list': FieldValue.arrayRemove([userRef])
        });
        changed = true;
      }
    }

    final comments = await FirebaseFirestore.instance
        .collection('events_comment')
        .where('comment_userRef', isEqualTo: userRef)
        .get();

    for (final commentDoc in comments.docs) {
      await commentDoc.reference.delete();
    }
    final notification = await FirebaseFirestore.instance
        .collection('notification')
        .where('user', isEqualTo: userRef)
        .get();

    for (final notificationDoc in notification.docs) {
      await notificationDoc.reference.delete();
    }
    final sendnotification = await FirebaseFirestore.instance
        .collection('notification')
        .where('sent_by', isEqualTo: userRef)
        .get();

    for (final sendnotificationDoc in sendnotification.docs) {
      await sendnotificationDoc.reference.delete();
    }
    final report = await FirebaseFirestore.instance
        .collection('report')
        .where('user_reference', isEqualTo: userRef)
        .get();

    for (final reportDoc in report.docs) {
      await reportDoc.reference.delete();
    }

    print("User related data deleted.");

    // Delete user document
    await FirebaseFirestore.instance.collection('user').doc(uid).delete();

    print("User Firestore document deleted.");
    return false;
  } catch (e) {
    print("Error deleting Firestore data: $e");
    return true;
  }

  // final auth = FirebaseAuth.instance;
  // final currentUser = auth.currentUser;

  // // If there is NO signed in user → Already deleted OR logged out
  // if (currentUser == null) {
  //   print("User no longer exists in Firebase Auth.");
  //   // Chats where userA == userRef
  //   final chatA = await FirebaseFirestore.instance
  //       .collection('chat')
  //       .where('userA', isEqualTo: userRef)
  //       .get();

  //   // Chats where userB == userRef
  //   final chatB = await FirebaseFirestore.instance
  //       .collection('chat')
  //       .where('userB', isEqualTo: userRef)
  //       .get();

  //   // Combine chats
  //   final allChats = [...chatA.docs, ...chatB.docs];

  //   // Loop chats
  //   for (final chatDoc in allChats) {
  //     // Delete messages linked to this chat
  //     final messages = await FirebaseFirestore.instance
  //         .collection('Chat_Message')
  //         .where('chatRef', isEqualTo: chatDoc.reference)
  //         .get();

  //     for (final messageDoc in messages.docs) {
  //       await messageDoc.reference.delete();
  //     }

  //     // Delete chat document
  //     await chatDoc.reference.delete();
  //   }

  //   final events = await FirebaseFirestore.instance.collection('events').get();

  //   for (final eventDoc in events.docs) {
  //     final data = eventDoc.data();

  //     bool changed = false;

  //     // Remove from attending
  //     if (data['attending'] != null &&
  //         (data['attending'] as List).contains(userRef)) {
  //       await eventDoc.reference.update({
  //         'attending': FieldValue.arrayRemove([userRef])
  //       });
  //       changed = true;
  //     }

  //     // Remove from invited_user
  //     if (data['invited_user'] != null &&
  //         (data['invited_user'] as List).contains(userRef)) {
  //       await eventDoc.reference.update({
  //         'invited_user': FieldValue.arrayRemove([userRef])
  //       });
  //       changed = true;
  //     }
  //     // Remove from report_user_list
  //     if (data['report_user_list'] != null &&
  //         (data['report_user_list'] as List).contains(userRef)) {
  //       await eventDoc.reference.update({
  //         'report_user_list': FieldValue.arrayRemove([userRef])
  //       });
  //       changed = true;
  //     }
  //   }

  //   final comments = await FirebaseFirestore.instance
  //       .collection('events_comment')
  //       .where('comment_userRef', isEqualTo: userRef)
  //       .get();

  //   for (final commentDoc in comments.docs) {
  //     await commentDoc.reference.delete();
  //   }
  //   final notification = await FirebaseFirestore.instance
  //       .collection('notification')
  //       .where('user', isEqualTo: userRef)
  //       .get();

  //   for (final notificationDoc in notification.docs) {
  //     await notificationDoc.reference.delete();
  //   }
  //   final sendnotification = await FirebaseFirestore.instance
  //       .collection('notification')
  //       .where('sent_by', isEqualTo: userRef)
  //       .get();

  //   for (final sendnotificationDoc in sendnotification.docs) {
  //     await sendnotificationDoc.reference.delete();
  //   }
  //   final report = await FirebaseFirestore.instance
  //       .collection('report')
  //       .where('user_reference', isEqualTo: userRef)
  //       .get();

  //   for (final reportDoc in report.docs) {
  //     await reportDoc.reference.delete();
  //   }

  //   // Clean up Firestore data
  //   await FirebaseFirestore.instance
  //       .collection('user')
  //       .doc(userRef.id)
  //       .delete();

  //   return false; // user
  // }

  // final uid = currentUser.uid;

  // try {
  //   // Force a token refresh → will fail if user is deleted
  //   await currentUser.reload();
  // } catch (e) {
  //   print("User no longer exists in Firebase Auth. Error: $e");
  //   // Chats where userA == userRef
  //   final chatA = await FirebaseFirestore.instance
  //       .collection('chat')
  //       .where('userA', isEqualTo: userRef)
  //       .get();

  //   // Chats where userB == userRef
  //   final chatB = await FirebaseFirestore.instance
  //       .collection('chat')
  //       .where('userB', isEqualTo: userRef)
  //       .get();

  //   // Combine chats
  //   final allChats = [...chatA.docs, ...chatB.docs];

  //   // Loop chats
  //   for (final chatDoc in allChats) {
  //     // Delete messages linked to this chat
  //     final messages = await FirebaseFirestore.instance
  //         .collection('Chat_Message')
  //         .where('chatRef', isEqualTo: chatDoc.reference)
  //         .get();

  //     for (final messageDoc in messages.docs) {
  //       await messageDoc.reference.delete();
  //     }

  //     // Delete chat document
  //     await chatDoc.reference.delete();
  //   }

  //   final events = await FirebaseFirestore.instance.collection('events').get();

  //   for (final eventDoc in events.docs) {
  //     final data = eventDoc.data();

  //     bool changed = false;

  //     // Remove from attending
  //     if (data['attending'] != null &&
  //         (data['attending'] as List).contains(userRef)) {
  //       await eventDoc.reference.update({
  //         'attending': FieldValue.arrayRemove([userRef])
  //       });
  //       changed = true;
  //     }

  //     // Remove from invited_user
  //     if (data['invited_user'] != null &&
  //         (data['invited_user'] as List).contains(userRef)) {
  //       await eventDoc.reference.update({
  //         'invited_user': FieldValue.arrayRemove([userRef])
  //       });
  //       changed = true;
  //     }
  //     // Remove from report_user_list
  //     if (data['report_user_list'] != null &&
  //         (data['report_user_list'] as List).contains(userRef)) {
  //       await eventDoc.reference.update({
  //         'report_user_list': FieldValue.arrayRemove([userRef])
  //       });
  //       changed = true;
  //     }
  //   }

  //   final comments = await FirebaseFirestore.instance
  //       .collection('events_comment')
  //       .where('comment_userRef', isEqualTo: userRef)
  //       .get();

  //   for (final commentDoc in comments.docs) {
  //     await commentDoc.reference.delete();
  //   }
  //   final notification = await FirebaseFirestore.instance
  //       .collection('notification')
  //       .where('user', isEqualTo: userRef)
  //       .get();

  //   for (final notificationDoc in notification.docs) {
  //     await notificationDoc.reference.delete();
  //   }
  //   final sendnotification = await FirebaseFirestore.instance
  //       .collection('notification')
  //       .where('sent_by', isEqualTo: userRef)
  //       .get();

  //   for (final sendnotificationDoc in sendnotification.docs) {
  //     await sendnotificationDoc.reference.delete();
  //   }
  //   final report = await FirebaseFirestore.instance
  //       .collection('report')
  //       .where('user_reference', isEqualTo: userRef)
  //       .get();

  //   for (final reportDoc in report.docs) {
  //     await reportDoc.reference.delete();
  //   }

  //   // Clean up Firestore data
  //   await FirebaseFirestore.instance.collection('user').doc(uid).delete();

  //   return false; // user deleted
  // }

  // // User still exists → return true
  // return true;
}

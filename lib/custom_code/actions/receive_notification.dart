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

import 'index.dart'; // Imports other custom actions

import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '../../backend/push_notifications/push_notifications_handler.dart';
import '/index.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

bool _fcmInitialized = false;

/// Checks if an incoming FCM notification is for Babes Club chat
bool _isBabesClubNotification(Map<String, dynamic> data) {
  final page = (data['initialPageName'] ?? data['initial_page_name'] ?? '')
      .toString()
      .trim();
  if (page == 'babesClubChatScreen') {
    return true;
  }

  final type = (data['type'] ??
          data['notification_type'] ??
          data['chat_type'] ??
          data['category'] ??
          '')
      .toString()
      .trim()
      .toLowerCase();
  if (type.contains('babes') ||
      type == 'babes_club_chat' ||
      type == 'babesclub') {
    return true;
  }

  final paramStr =
      (data['parameterData'] ?? data['parameter_data'] ?? '').toString();
  if (paramStr.contains('babes_club') ||
      paramStr.contains('babesClub') ||
      paramStr.contains('VaptPPzsVMyO5KYpGYPb')) {
    return true;
  }

  return false;
}

/// Checks if the user is currently on the Babes Club chat screen
bool _isBabesChatScreenActive() {
  if (FFAppState().isBabesChatOpen) {
    return true;
  }
  if (custom_widgets.BabesClubChatWidget.isChatOpen) {
    return true;
  }
  return false;
}

/// ✅ Background handler MUST be top-level + entry-point
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("_firebaseMessagingBackgroundHandler");
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

Future<void> _showLocalNotification(RemoteMessage message) async {
  // Title/body preference: notification -> data -> fallback
  final String title =
      message.notification?.title ?? message.data['title']?.toString() ?? '';
  final String body =
      message.notification?.body ?? message.data['body']?.toString() ?? '';

  // If nothing to show, skip
  if (title.isEmpty && body.isEmpty) return;

  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'high_importance_channel',
    'High Importance Notifications',
    channelDescription: 'This channel is used for important notifications.',
    importance: Importance.high,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,
  );

  const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  const NotificationDetails details = NotificationDetails(
    android: androidDetails,
    iOS: iosDetails,
  );

  final int notifId = DateTime.now().millisecondsSinceEpoch ~/ 1000;

  await flutterLocalNotificationsPlugin.show(
    notifId,
    title,
    body,
    details,
    payload: jsonEncode(message.data), // tap payload
  );
}

Future<void> _updateBadge(RemoteMessage message) async {
  // Optional: If server sends badge in data: {"badge":"5"}
  final badgeRaw = message.data['badge'];
  final int? badge =
      badgeRaw == null ? null : int.tryParse(badgeRaw.toString());
}

Future receiveNotification() async {
  if (_fcmInitialized) {
    print("initializeFCM already called - skipping re-init");
    return;
  }
  _fcmInitialized = true;

  await Firebase.initializeApp();

  if (kIsWeb) {
    print("FCM not supported on web for local notifications");
    return;
  }

  if (!(Platform.isAndroid || Platform.isIOS)) {
    print("Unsupported platform for FCM local notifications");
    return;
  }

  // ✅ Register background handler (do this early)
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // ✅ iOS permissions (and generally safe to call)
  final NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    provisional: false,
  );
  print('User granted permission: ${settings.authorizationStatus}');

  // ✅ Local notifications init
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final DarwinInitializationSettings iosSettings =
      DarwinInitializationSettings();

  final InitializationSettings initSettings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
    macOS: iosSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      print("Notification tapped with payload: ${response.payload}");
      if (response.payload != null && response.payload!.isNotEmpty) {
        try {
          final data = jsonDecode(response.payload!) as Map<String, dynamic>;
          final initialPageName =
              (data['initialPageName'] ?? data['initial_page_name']) as String?;

          final contextToUse = appNavigatorKey.currentContext;

          // Directly navigate to Babes Club Chat if it's a Babes Club message
          if (_isBabesClubNotification(data) ||
              initialPageName == 'babesClubChat' ||
              initialPageName == 'babesClubChatScreen' ||
              initialPageName == 'babes_club_chat') {
            print(
                "Navigating to BabesClubChatScreenWidget from local notification tap");
            contextToUse?.pushNamed(BabesClubChatScreenWidget.routeName);
            return;
          }

          if (initialPageName != null) {
            final initialParameterData = getInitialParameterData(data);
            print("Extracted initialParameterData: $initialParameterData");
            final parametersBuilder = parametersBuilderMap[initialPageName];
            print("Found parametersBuilder: ${parametersBuilder != null}");
            if (parametersBuilder != null) {
              final parameterData =
                  await parametersBuilder(initialParameterData);
              print(
                  "Built parameterData: ${parameterData.pathParameters} | extra: ${parameterData.extra}");
              contextToUse?.pushNamed(
                initialPageName,
                pathParameters: parameterData.pathParameters,
                extra: parameterData.extra,
              );
              print("pushNamed called!");
            }
          }
        } catch (e, st) {
          print('Error navigating from local notification: $e\n$st');
        }
      }
    },
  );

  // ✅ Android 13+ runtime permission for notifications (local notifications)
  if (Platform.isAndroid) {
    final androidPlugin =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    // If plugin supports it, request permission (won't crash on older Android)
    try {
      await androidPlugin?.requestNotificationsPermission();
    } catch (e) {
      print("Android notification permission request error: $e");
    }

    // ✅ Create channel (Android 8+)
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    await androidPlugin?.createNotificationChannel(channel);
  }

  if (Platform.isIOS) {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: false,
      badge: false,
      sound: false,
    );
  }

  // ✅ Subscribe to topic
  try {
    await FirebaseMessaging.instance.subscribeToTopic('all_users');
    print('Subscribed to topic all_users');
  } catch (e) {
    print('Error subscribing to topic: $e');
  }

  // ✅ Token
  final String? token = await FirebaseMessaging.instance.getToken();
  print('FCM Token: $token');

  // ✅ FOREGROUND NOTIFICATION LISTENER
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print('📩 Foreground message received: ${message.messageId}');

    // 1. Prevent showing notification if the user has ALREADY OPENED BABES chat
    if (_isBabesClubNotification(message.data)) {
      if (_isBabesChatScreenActive()) {
        print(
            "DEBUG: Babes Club chat is currently open, skipping notification");
        return; // Do NOT show notification
      }
    }

    String? pageName =
        message.data['initialPageName'] ?? message.data['initial_page_name'];
    String? paramData =
        message.data['parameterData'] ?? message.data['parameter_data'];
    print('pageName: $pageName : $paramData');

    if (pageName == 'broadcast') {
      try {
        final decoded = json.decode(paramData!);

        final String? broadcastPath = decoded['broadcast']?.toString();

        if (broadcastPath == null || broadcastPath.isEmpty) {
          print("Broadcast reference is missing");
          return;
        }

        final DocumentReference broadcastRef =
            FirebaseFirestore.instance.doc(broadcastPath);

        print("Broadcast reference: ${broadcastRef.path}");

        await actions.showBroadcastDialog(broadcastRef);
      } catch (e) {
        print("Error parsing parameterData: $e");
      }
    }

    if (pageName == "chatConnections" && paramData != null) {
      try {
        final decoded = json.decode(paramData);
        final incomingChatRef = decoded['chatRef'];
        print(
            "DEBUG: Incoming chatRef: $incomingChatRef == FFAppState().currentChat?.path: ${FFAppState().currentChat?.path}");
        if (FFAppState().currentChat?.path == incomingChatRef) {
          print("DEBUG: Same chat is open, skipping notification");
          return; // Do not show the local notification
        }
      } catch (e) {
        print("Error parsing parameterData: $e");
      }
    }

    // Show local notification in foreground if not suppressed
    await _showLocalNotification(message);

    // Optional badge handling
    await _updateBadge(message);
  });

  // ✅ When user taps notification and app opens from background
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Notification clicked / opened app!');
    if (_isBabesClubNotification(message.data)) {
      final contextToUse = appNavigatorKey.currentContext;
      contextToUse?.pushNamed(BabesClubChatScreenWidget.routeName);
    }
  });

  // ✅ If app was terminated and opened via notification
  final RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    print('App opened from terminated state via notification!');
    if (_isBabesClubNotification(initialMessage.data)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final contextToUse = appNavigatorKey.currentContext;
        contextToUse?.pushNamed(BabesClubChatScreenWidget.routeName);
      });
    }
  }
}

// import 'index.dart'; // Imports other custom actions

// import 'dart:io';
// import '/custom_code/actions/index.dart' as actions;

// import 'package:flutter/foundation.dart';

// import 'index.dart'; // Imports other custom actions

// import 'package:yes_gurl/auth/base_auth_user_provider.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import '../../backend/push_notifications/push_notifications_handler.dart';
// import 'dart:convert';
// import 'package:firebase_messaging/firebase_messaging.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// bool _fcmInitialized = false;

// /// ✅ Background handler MUST be top-level + entry-point
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("_firebaseMessagingBackgroundHandler");
//   await Firebase.initializeApp();
//   print("Handling a background message: ${message.messageId}");
// }

// Future<void> _showLocalNotification(RemoteMessage message) async {
//   // Title/body preference: notification -> data -> fallback
//   final String title =
//       message.notification?.title ?? message.data['title']?.toString() ?? '';
//   final String body =
//       message.notification?.body ?? message.data['body']?.toString() ?? '';

//   // If nothing to show, skip
//   if (title.isEmpty && body.isEmpty) return;

//   const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//     'high_importance_channel',
//     'High Importance Notifications',
//     channelDescription: 'This channel is used for important notifications.',
//     importance: Importance.high,
//     priority: Priority.high,
//     playSound: true,
//     enableVibration: true,
//   );

//   const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
//     presentAlert: true,
//     presentBadge: true,
//     presentSound: true,
//   );

//   const NotificationDetails details = NotificationDetails(
//     android: androidDetails,
//     iOS: iosDetails,
//   );

//   final int notifId = DateTime.now().millisecondsSinceEpoch ~/ 1000;

//   await flutterLocalNotificationsPlugin.show(
//     notifId,
//     title,
//     body,
//     details,
//     payload: jsonEncode(message.data), // tap payload
//   );
// }

// Future<void> _updateBadge(RemoteMessage message) async {
//   // Optional: If server sends badge in data: {"badge":"5"}
//   final badgeRaw = message.data['badge'];
//   final int? badge =
//       badgeRaw == null ? null : int.tryParse(badgeRaw.toString());
// }

// Future receiveNotification() async {
//   if (_fcmInitialized) {
//     print("initializeFCM already called - skipping re-init");
//     return;
//   }
//   _fcmInitialized = true;

//   await Firebase.initializeApp();

//   if (kIsWeb) {
//     print("FCM not supported on web for local notifications");
//     return;
//   }

//   if (!(Platform.isAndroid || Platform.isIOS)) {
//     print("Unsupported platform for FCM local notifications");
//     return;
//   }

//   // ✅ Register background handler (do this early)
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//   // ✅ iOS permissions (and generally safe to call)
//   final NotificationSettings settings =
//       await FirebaseMessaging.instance.requestPermission(
//     alert: true,
//     badge: true,
//     sound: true,
//     provisional: false,
//   );
//   print('User granted permission: ${settings.authorizationStatus}');

//   // ✅ Local notifications init
//   const AndroidInitializationSettings androidSettings =
//       AndroidInitializationSettings('@mipmap/ic_launcher');
//   final DarwinInitializationSettings iosSettings =
//       DarwinInitializationSettings();

//   final InitializationSettings initSettings = InitializationSettings(
//     android: androidSettings,
//     iOS: iosSettings,
//     macOS: iosSettings,
//   );

//   await flutterLocalNotificationsPlugin.initialize(
//     initSettings,
//     onDidReceiveNotificationResponse: (NotificationResponse response) async {
//       print("Notification tapped with payload: ${response.payload}");
//       if (response.payload != null && response.payload!.isNotEmpty) {
//         try {
//           final data = jsonDecode(response.payload!) as Map<String, dynamic>;
//           final initialPageName = data['initialPageName'] as String?;
//           if (initialPageName != null) {
//             final initialParameterData = getInitialParameterData(data);
//             print("Extracted initialParameterData: $initialParameterData");
//             final parametersBuilder = parametersBuilderMap[initialPageName];
//             print("Found parametersBuilder: ${parametersBuilder != null}");
//             if (parametersBuilder != null) {
//               final parameterData =
//                   await parametersBuilder(initialParameterData);
//               print(
//                   "Built parameterData: ${parameterData.pathParameters} | extra: ${parameterData.extra}");
//               final contextToUse = appNavigatorKey.currentContext;
//               print(
//                   "appNavigatorKey.currentContext is null? ${contextToUse == null}");
//               contextToUse?.pushNamed(
//                 initialPageName,
//                 pathParameters: parameterData.pathParameters,
//                 extra: parameterData.extra,
//               );
//               print("pushNamed called!");
//             }
//           }
//         } catch (e, st) {
//           print('Error navigating from local notification: $e\n$st');
//         }
//       }
//     },
//   );

//   // ✅ Android 13+ runtime permission for notifications (local notifications)
//   if (Platform.isAndroid) {
//     final androidPlugin =
//         flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>();

//     // If plugin supports it, request permission (won't crash on older Android)
//     try {
//       await androidPlugin?.requestNotificationsPermission();
//     } catch (e) {
//       print("Android notification permission request error: $e");
//     }

//     // ✅ Create channel (Android 8+)
//     const AndroidNotificationChannel channel = AndroidNotificationChannel(
//       'high_importance_channel',
//       'High Importance Notifications',
//       description: 'This channel is used for important notifications.',
//       importance: Importance.high,
//       playSound: true,
//       enableVibration: true,
//     );

//     await androidPlugin?.createNotificationChannel(channel);
//   }

//   // // ✅ iOS: ensure foreground notification shows alert/sound/badge
//   // if (Platform.isIOS) {
//   //   await FirebaseMessaging.instance
//   //       .setForegroundNotificationPresentationOptions(
//   //     alert: true,
//   //     badge: true,
//   //     sound: true,
//   //   );
//   // }
//   if (Platform.isIOS) {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: false,
//       badge: false,
//       sound: false,
//     );
//   }

//   // ✅ Subscribe to topic
//   try {
//     await FirebaseMessaging.instance.subscribeToTopic('all_users');
//     print('Subscribed to topic all_users');
//   } catch (e) {
//     print('Error subscribing to topic: $e');
//   }

//   // ✅ Token
//   final String? token = await FirebaseMessaging.instance.getToken();
//   print('FCM Token: $token');

//   // ✅ FOREGROUND NOTIFICATION LISTENER (THIS IS WHAT YOU ASKED)
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//     print('📩 Foreground message received: ${message.messageId}');

//     // Prevent showing notification if the user is already on the chat screen
//     String? pageName = message.data['initialPageName'];
//     String? paramData = message.data['parameterData'];
//     print('pageName: $pageName : $paramData');
//     if (pageName == 'broadcast') {
//       try {
//         final decoded = json.decode(paramData!);

//         final String? broadcastPath = decoded['broadcast']?.toString();

//         if (broadcastPath == null || broadcastPath.isEmpty) {
//           print("Broadcast reference is missing");
//           return;
//         }

//         final DocumentReference broadcastRef =
//             FirebaseFirestore.instance.doc(broadcastPath);

//         print("Broadcast reference: ${broadcastRef.path}");

//         await actions.showBroadcastDialog(broadcastRef);
//       } catch (e) {
//         print("Error parsing parameterData: $e");
//       }
//     }
//     if (pageName == "chatConnections" && paramData != null) {
//       try {
//         final decoded = json.decode(paramData);
//         final incomingChatRef = decoded['chatRef'];
//         print(
//             "DEBUG: Incoming chatRef: $incomingChatRef == FFAppState().currentChat?.path: ${FFAppState().currentChat?.path}");
//         if (FFAppState().currentChat?.path == incomingChatRef) {
//           print("DEBUG: Same chat is open, skipping notification");
//           return; // Do not show the local notification
//         }
//       } catch (e) {
//         print("Error parsing parameterData: $e");
//       }
//     }
//     // Show local notification in foreground
//     await _showLocalNotification(message);

//     // Optional badge handling
//     await _updateBadge(message);
//   });

//   // ✅ When user taps notification and app opens
//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     print('Notification clicked / opened app!');
//     // Handle navigation if required using message.data
//   });

//   // ✅ If app was terminated and opened via notification
//   final RemoteMessage? initialMessage =
//       await FirebaseMessaging.instance.getInitialMessage();
//   if (initialMessage != null) {
//     print('App opened from terminated state via notification!');
//     // Handle navigation if required using initialMessage.data
//   }
// }

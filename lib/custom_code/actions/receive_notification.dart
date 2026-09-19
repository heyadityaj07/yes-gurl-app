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

import 'dart:io';

import 'package:flutter/foundation.dart';

import 'index.dart'; // Imports other custom actions

import 'package:yes_gurl/auth/base_auth_user_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../backend/push_notifications/push_notifications_handler.dart';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

bool _fcmInitialized = false;

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

  print("HELOOOOOOOO");
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
          final initialPageName = data['initialPageName'] as String?;
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
              final contextToUse = appNavigatorKey.currentContext;
              print(
                  "appNavigatorKey.currentContext is null? ${contextToUse == null}");
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

  // // ✅ iOS: ensure foreground notification shows alert/sound/badge
  // if (Platform.isIOS) {
  //   await FirebaseMessaging.instance
  //       .setForegroundNotificationPresentationOptions(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );
  // }
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

  // ✅ FOREGROUND NOTIFICATION LISTENER (THIS IS WHAT YOU ASKED)
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print('📩 Foreground message received: ${message.messageId}');

    // Prevent showing notification if the user is already on the chat screen
    String? pageName = message.data['initialPageName'];
    String? paramData = message.data['parameterData'];

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
    // Show local notification in foreground
    await _showLocalNotification(message);

    // Optional badge handling
    await _updateBadge(message);
  });

  // ✅ When user taps notification and app opens
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Notification clicked / opened app!');
    // Handle navigation if required using message.data
  });

  // ✅ If app was terminated and opened via notification
  final RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    print('App opened from terminated state via notification!');
    // Handle navigation if required using initialMessage.data
  }
}

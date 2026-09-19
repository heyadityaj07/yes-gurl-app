import 'dart:async';
import 'dart:convert';

import 'serialization_util.dart';

import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../index.dart';
import '../../main.dart';

final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    await _handlePushNotificationData(message.data);
  }

  Future _handlePushNotificationData(Map<String, dynamic> messageData) async {
    safeSetState(() => _loading = true);
    try {
      final initialPageName = messageData['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(messageData);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        if (mounted) {
          context.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        } else {
          appNavigatorKey.currentContext?.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        }
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      safeSetState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      handleOpenedPushNotification();
    });
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Container(
          color: Color(0xFFF7CDD0),
          child: Image.asset(
            'assets/images/flutterflow_google_app_icon.png',
            fit: BoxFit.contain,
          ),
        )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'chat': (data) async => ParameterData(
        allParams: {
          'initialTab': getParameter<int>(data, 'initialTab'),
        },
      ),
  'profile': ParameterData.none(),
  'signUp002': ParameterData.none(),
  'signUp003': ParameterData.none(),
  'signUp004': ParameterData.none(),
  'signUp005': ParameterData.none(),
  'signUp009': ParameterData.none(),
  'signUp010': ParameterData.none(),
  'test': ParameterData.none(),
  'testStart': ParameterData.none(),
  'profileEdit': ParameterData.none(),
  'profilePreferences': ParameterData.none(),
  'profileSettings': ParameterData.none(),
  'profilePreferencesRelationship': ParameterData.none(),
  'profilePreferencesChildren': ParameterData.none(),
  'profilePreferencesAge': ParameterData.none(),
  'profilePreferencesLocation': ParameterData.none(),
  'profileEditAdditionalRelationship': ParameterData.none(),
  'profileEditAdditionalChildren': ParameterData.none(),
  'profileEditAdditionalName': ParameterData.none(),
  'profileEditAdditionalLocation': ParameterData.none(),
  'signUp001': ParameterData.none(),
  'signUp006': ParameterData.none(),
  'signUp008Privacy': ParameterData.none(),
  'loginEmail': ParameterData.none(),
  'loginEmailSignUp': ParameterData.none(),
  'signUp001a': ParameterData.none(),
  'signUp007': ParameterData.none(),
  'login': ParameterData.none(),
  'ForgotPassword': ParameterData.none(),
  'testSummary': (data) async => ParameterData(
        allParams: {
          'isFromProfile': getParameter<bool>(data, 'isFromProfile'),
          'personalityParms': getParameter<String>(data, 'personalityParms'),
          'anotherUserProfile':
              getParameter<String>(data, 'anotherUserProfile'),
          'userRef': getParameter<DocumentReference>(data, 'userRef'),
        },
      ),
  'profileEditMyPhoto': ParameterData.none(),
  'potentialMatchesProfile': (data) async => ParameterData(
        allParams: {
          'userRef': getParameter<DocumentReference>(data, 'userRef'),
          'throughUserProfile':
              getParameter<String>(data, 'throughUserProfile'),
        },
      ),
  'profileSettingsEmail': ParameterData.none(),
  'LinkUp': (data) async => ParameterData(
        allParams: {
          'tabIndex': getParameter<int>(data, 'tabIndex'),
        },
      ),
  'LinkUpDetails': (data) async => ParameterData(
        allParams: {
          'eventRef': await getDocumentParameter<EventsRecord>(
              data, 'eventRef', EventsRecord.fromSnapshot),
        },
      ),
  'LinkUpCreate': ParameterData.none(),
  'profileEditPrompts': ParameterData.none(),
  'profileEditletsGoOffline': ParameterData.none(),
  'chatRequest': (data) async => ParameterData(
        allParams: {
          'chatRef': getParameter<DocumentReference>(data, 'chatRef'),
        },
      ),
  'chatConnections': (data) async => ParameterData(
        allParams: {
          'chatRef': getParameter<DocumentReference>(data, 'chatRef'),
        },
      ),
  'profileSettingsFeedback': ParameterData.none(),
  'profileSettingsSuccessStories': ParameterData.none(),
  'share': (data) async => ParameterData(
        allParams: {
          'initialTab': getParameter<int>(data, 'initialTab'),
        },
      ),
  'LinkUpEdit': (data) async => ParameterData(
        allParams: {
          'event': await getDocumentParameter<EventsRecord>(
              data, 'event', EventsRecord.fromSnapshot),
        },
      ),
  'onboarding': ParameterData.none(),
  'onboarding2': ParameterData.none(),
  'onboarding3': ParameterData.none(),
  'onboarding4': ParameterData.none(),
  'notification': ParameterData.none(),
  'adminLinkUpDetails': (data) async => ParameterData(
        allParams: {
          'eventDoc': await getDocumentParameter<EventsRecord>(
              data, 'eventDoc', EventsRecord.fromSnapshot),
        },
      ),
  'onboarding1': ParameterData.none(),
  'profileSettingsReport': ParameterData.none(),
  'potentialConnections': ParameterData.none(),
  'SplashScreen': ParameterData.none(),
  'communities': ParameterData.none(),
  'communitiesSeeAll': (data) async => ParameterData(
        allParams: {
          'initialTab': getParameter<int>(data, 'initialTab'),
        },
      ),
  'communitiesCreate': ParameterData.none(),
  'communityOpen': (data) async => ParameterData(
        allParams: {
          'eventRef': await getDocumentParameter<EventsRecord>(
              data, 'eventRef', EventsRecord.fromSnapshot),
        },
      ),
  'communityClosedInvite': (data) async => ParameterData(
        allParams: {
          'eventRef': await getDocumentParameter<EventsRecord>(
              data, 'eventRef', EventsRecord.fromSnapshot),
        },
      ),
  'communityOpenClosedInviteJoined': (data) async => ParameterData(
        allParams: {
          'eventRef': await getDocumentParameter<EventsRecord>(
              data, 'eventRef', EventsRecord.fromSnapshot),
        },
      ),
  'communityOpenClosedInviteJoinedAdmin': (data) async => ParameterData(
        allParams: {
          'eventRef': await getDocumentParameter<EventsRecord>(
              data, 'eventRef', EventsRecord.fromSnapshot),
        },
      ),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}

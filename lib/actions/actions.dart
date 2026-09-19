import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_manager.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';

Future notificationRequest(BuildContext context) async {
  if (valueOrDefault<bool>(currentUserDocument?.isNotificationEnabled, false) ==
      true) {
    logFirebaseEvent('NotificationRequest_custom_action');
    await actions.receiveNotification();
  }
}

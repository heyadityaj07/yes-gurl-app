import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/profile/logout/logout_widget.dart';
import '/profile/profile_settings_delete_new/profile_settings_delete_new_widget.dart';
import '/profile/profile_settings_pause_new/profile_settings_pause_new_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/permissions_util.dart';
import '/index.dart';
import 'profile_settings_widget.dart' show ProfileSettingsWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileSettingsModel extends FlutterFlowModel<ProfileSettingsWidget> {
  ///  Local state fields for this page.

  int index = 0;

  int userindex = 0;

  DocumentReference? user;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Switch widget.
  bool? switchValue;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  List<EventsRecord>? eventsResults;
  // Stores action output result for [Custom Action - deleteUser] action in Container widget.
  bool? deleteusers;
  // Stores action output result for [Firestore Query - Query a collection] action in Row widget.
  List<EventsRecord>? eventsResult;
  // Stores action output result for [Custom Action - deleteUser] action in Row widget.
  bool? delete;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}

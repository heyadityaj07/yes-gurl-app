import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'profile_settings_email_widget.dart' show ProfileSettingsEmailWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileSettingsEmailModel
    extends FlutterFlowModel<ProfileSettingsEmailWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for settingsEmail widget.
  FocusNode? settingsEmailFocusNode;
  TextEditingController? settingsEmailTextController;
  String? Function(BuildContext, String?)? settingsEmailTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    settingsEmailFocusNode?.dispose();
    settingsEmailTextController?.dispose();
  }
}

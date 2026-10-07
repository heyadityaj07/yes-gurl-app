import '/auth/firebase_auth/auth_util.dart';
import '/chat/update_email/update_email_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'profile_settings_email_widget.dart' show ProfileSettingsEmailWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileSettingsEmailModel
    extends FlutterFlowModel<ProfileSettingsEmailWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for settingsEmail widget.
  FocusNode? settingsEmailFocusNode;
  TextEditingController? settingsEmailTextController;
  String? Function(BuildContext, String?)? settingsEmailTextControllerValidator;
  String? _settingsEmailTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Has to be a valid email address.';
    }
    return null;
  }

  @override
  void initState(BuildContext context) {
    settingsEmailTextControllerValidator =
        _settingsEmailTextControllerValidator;
  }

  @override
  void dispose() {
    settingsEmailFocusNode?.dispose();
    settingsEmailTextController?.dispose();
  }
}

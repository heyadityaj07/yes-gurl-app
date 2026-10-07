import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'login_email_sign_up_widget.dart' show LoginEmailSignUpWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginEmailSignUpModel extends FlutterFlowModel<LoginEmailSignUpWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for emailSignUp widget.
  FocusNode? emailSignUpFocusNode;
  TextEditingController? emailSignUpTextController;
  String? Function(BuildContext, String?)? emailSignUpTextControllerValidator;
  String? _emailSignUpTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'email address is required';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Enter valid email';
    }
    return null;
  }

  // State field(s) for passwordSignUp widget.
  FocusNode? passwordSignUpFocusNode;
  TextEditingController? passwordSignUpTextController;
  late bool passwordSignUpVisibility;
  String? Function(BuildContext, String?)?
      passwordSignUpTextControllerValidator;
  String? _passwordSignUpTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'password is required';
    }

    return null;
  }

  // State field(s) for Checkbox widget.
  bool? checkboxValue;

  @override
  void initState(BuildContext context) {
    emailSignUpTextControllerValidator = _emailSignUpTextControllerValidator;
    passwordSignUpVisibility = false;
    passwordSignUpTextControllerValidator =
        _passwordSignUpTextControllerValidator;
  }

  @override
  void dispose() {
    emailSignUpFocusNode?.dispose();
    emailSignUpTextController?.dispose();

    passwordSignUpFocusNode?.dispose();
    passwordSignUpTextController?.dispose();
  }
}

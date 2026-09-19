import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'sign_up002_widget.dart' show SignUp002Widget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignUp002Model extends FlutterFlowModel<SignUp002Widget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for signupFirstName widget.
  FocusNode? signupFirstNameFocusNode;
  TextEditingController? signupFirstNameTextController;
  String? Function(BuildContext, String?)?
      signupFirstNameTextControllerValidator;
  // State field(s) for signupSecomdName widget.
  FocusNode? signupSecomdNameFocusNode;
  TextEditingController? signupSecomdNameTextController;
  String? Function(BuildContext, String?)?
      signupSecomdNameTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    signupFirstNameFocusNode?.dispose();
    signupFirstNameTextController?.dispose();

    signupSecomdNameFocusNode?.dispose();
    signupSecomdNameTextController?.dispose();
  }
}

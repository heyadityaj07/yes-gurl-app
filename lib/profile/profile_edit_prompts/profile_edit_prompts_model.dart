import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/profile/profile_edit_prompts1/profile_edit_prompts1_widget.dart';
import '/profile/profile_edit_prompts2/profile_edit_prompts2_widget.dart';
import '/profile/profile_edit_prompts3/profile_edit_prompts3_widget.dart';
import 'dart:ui';
import 'profile_edit_prompts_widget.dart' show ProfileEditPromptsWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileEditPromptsModel
    extends FlutterFlowModel<ProfileEditPromptsWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for answer widget.
  FocusNode? answerFocusNode1;
  TextEditingController? answerTextController1;
  String? Function(BuildContext, String?)? answerTextController1Validator;
  // State field(s) for answer widget.
  FocusNode? answerFocusNode2;
  TextEditingController? answerTextController2;
  String? Function(BuildContext, String?)? answerTextController2Validator;
  // State field(s) for answer widget.
  FocusNode? answerFocusNode3;
  TextEditingController? answerTextController3;
  String? Function(BuildContext, String?)? answerTextController3Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    answerFocusNode1?.dispose();
    answerTextController1?.dispose();

    answerFocusNode2?.dispose();
    answerTextController2?.dispose();

    answerFocusNode3?.dispose();
    answerTextController3?.dispose();
  }
}

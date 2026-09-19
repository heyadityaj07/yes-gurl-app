import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/empty_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/potential_connections/blockuserconfirmation/blockuserconfirmation_widget.dart';
import '/potential_connections/chat_dropdown_user/chat_dropdown_user_widget.dart';
import '/potential_connections/compatible/compatible_widget.dart';
import '/potential_connections/possible/possible_widget.dart';
import '/potential_connections/potential_connections_report/potential_connections_report_widget.dart';
import '/potential_connections/try_your_luck/try_your_luck_widget.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'potential_matches_profile_widget.dart'
    show PotentialMatchesProfileWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PotentialMatchesProfileModel
    extends FlutterFlowModel<PotentialMatchesProfileWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Alert Dialog - Custom Dialog] action in IconButton widget.
  String? match;
  // State field(s) for newTextfeild widget.
  FocusNode? newTextfeildFocusNode;
  TextEditingController? newTextfeildTextController;
  String? Function(BuildContext, String?)? newTextfeildTextControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  ChatRecord? chat;
  // Stores action output result for [Backend Call - Create Document] action in Container widget.
  ChatRecord? message;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    newTextfeildFocusNode?.dispose();
    newTextfeildTextController?.dispose();
  }
}

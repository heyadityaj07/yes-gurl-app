import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/chat/chat_dropdown_comment/chat_dropdown_comment_widget.dart';
import '/chat/chat_dropdown_event/chat_dropdown_event_widget.dart';
import '/chat/pausealert/pausealert_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/link_up/no_comment_data/no_comment_data_widget.dart';
import 'dart:async';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'admin_link_up_details_widget.dart' show AdminLinkUpDetailsWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';
import 'package:provider/provider.dart';

class AdminLinkUpDetailsModel
    extends FlutterFlowModel<AdminLinkUpDetailsWidget> {
  ///  Local state fields for this page.

  int commentIndex = 0;

  bool comment = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for leaveComponent widget.
  FocusNode? leaveComponentFocusNode;
  TextEditingController? leaveComponentTextController;
  String? Function(BuildContext, String?)?
      leaveComponentTextControllerValidator;
  // Stores action output result for [Backend Call - Read Document] action in IconButton widget.
  UserRecord? users;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    leaveComponentFocusNode?.dispose();
    leaveComponentTextController?.dispose();
  }
}

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/chat/chat_dropdown/chat_dropdown_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/profile/pause_account_chat/pause_account_chat_widget.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'chat_request_widget.dart' show ChatRequestWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';
import 'package:provider/provider.dart';

class ChatRequestModel extends FlutterFlowModel<ChatRequestWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for newTextfeild widget.
  FocusNode? newTextfeildFocusNode;
  TextEditingController? newTextfeildTextController;
  String? Function(BuildContext, String?)? newTextfeildTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    newTextfeildFocusNode?.dispose();
    newTextfeildTextController?.dispose();
  }
}

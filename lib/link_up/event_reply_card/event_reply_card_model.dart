import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import 'event_reply_card_widget.dart' show EventReplyCardWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EventReplyCardModel extends FlutterFlowModel<EventReplyCardWidget> {
  ///  Local state fields for this component.

  bool comment = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for replyComponent widget.
  FocusNode? replyComponentFocusNode;
  TextEditingController? replyComponentTextController;
  String? Function(BuildContext, String?)?
      replyComponentTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    replyComponentFocusNode?.dispose();
    replyComponentTextController?.dispose();
  }
}

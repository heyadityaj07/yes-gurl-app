import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/chat/block/block_widget.dart';
import '/chat/chat_dropdown/chat_dropdown_widget.dart';
import '/chat/disconnect/disconnect_widget.dart';
import '/chat/pausealert/pausealert_widget.dart';
import '/chat/ready_to_meet/ready_to_meet_widget.dart';
import '/chat/report/report_widget.dart';
import '/chat/we_met/we_met_widget.dart';
import '/components/message_box_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'chat_connections_widget.dart' show ChatConnectionsWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';
import 'package:provider/provider.dart';

class ChatConnectionsModel extends FlutterFlowModel<ChatConnectionsWidget> {
  ///  Local state fields for this page.

  bool isDialogOpen = false;

  int isseenindex = 0;

  String? messageText;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Read Document] action in chatConnections widget.
  ChatRecord? isChatDocument;
  // Stores action output result for [Firestore Query - Query a collection] action in chatConnections widget.
  List<ChatMessageRecord>? messages;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in IconButton widget.
  String? chatOptions;
  List<ChatMessageRecord>? containerPreviousSnapshot;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  int? chatCount;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  ChatMessageRecord? sentedmessage;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}

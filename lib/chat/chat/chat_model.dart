import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/chat/no_chat_connection/no_chat_connection_widget.dart';
import '/chat/no_request_chat/no_request_chat_widget.dart';
import '/chat/pausealert/pausealert_widget.dart';
import '/components/empty_widget.dart';
import '/components/navbar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import '/index.dart';
import 'chat_widget.dart' show ChatWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';
import 'package:provider/provider.dart';

class ChatModel extends FlutterFlowModel<ChatWidget> {
  ///  Local state fields for this page.

  EventsRecord? sharedEvent;

  bool isSearch = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Read Document] action in chat widget.
  EventsRecord? sharedEventRead;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ChatMessageRecord? eventImageChat;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  EventsRecord? event;
  // Model for NoChatConnection component.
  late NoChatConnectionModel noChatConnectionModel;
  // State field(s) for SearchRequestUser widget.
  FocusNode? searchRequestUserFocusNode;
  TextEditingController? searchRequestUserTextController;
  String? Function(BuildContext, String?)?
      searchRequestUserTextControllerValidator;
  // Model for NoRequestChat component.
  late NoRequestChatModel noRequestChatModel;
  // Model for navbar component.
  late NavbarModel navbarModel;

  @override
  void initState(BuildContext context) {
    noChatConnectionModel = createModel(context, () => NoChatConnectionModel());
    noRequestChatModel = createModel(context, () => NoRequestChatModel());
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    textFieldFocusNode?.dispose();
    textController1?.dispose();

    noChatConnectionModel.dispose();
    searchRequestUserFocusNode?.dispose();
    searchRequestUserTextController?.dispose();

    noRequestChatModel.dispose();
    navbarModel.dispose();
  }
}

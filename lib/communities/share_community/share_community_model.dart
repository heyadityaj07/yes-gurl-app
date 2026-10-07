import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/chat/pausealert/pausealert_widget.dart';
import '/components/empty_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/link_up/no_share_connection/no_share_connection_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'share_community_widget.dart' show ShareCommunityWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';
import 'package:provider/provider.dart';

class ShareCommunityModel extends FlutterFlowModel<ShareCommunityWidget> {
  ///  Local state fields for this page.

  bool isSearch = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Column widget.
  ChatMessageRecord? eventImageChats;
  // Model for NoShareConnection component.
  late NoShareConnectionModel noShareConnectionModel;

  @override
  void initState(BuildContext context) {
    noShareConnectionModel =
        createModel(context, () => NoShareConnectionModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    noShareConnectionModel.dispose();
  }
}

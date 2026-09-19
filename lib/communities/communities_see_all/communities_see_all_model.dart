import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/navbar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/permissions_util.dart';
import 'communities_see_all_widget.dart' show CommunitiesSeeAllWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';
import 'package:provider/provider.dart';

class CommunitiesSeeAllModel extends FlutterFlowModel<CommunitiesSeeAllWidget> {
  ///  Local state fields for this page.

  EventsRecord? sharedEvent;

  bool isSearch = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Read Document] action in communitiesSeeAll widget.
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
  // State field(s) for SearchRequestUser widget.
  FocusNode? searchRequestUserFocusNode;
  TextEditingController? searchRequestUserTextController;
  String? Function(BuildContext, String?)?
      searchRequestUserTextControllerValidator;
  // Model for navbar component.
  late NavbarModel navbarModel;

  @override
  void initState(BuildContext context) {
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    textFieldFocusNode?.dispose();
    textController1?.dispose();

    searchRequestUserFocusNode?.dispose();
    searchRequestUserTextController?.dispose();

    navbarModel.dispose();
  }
}

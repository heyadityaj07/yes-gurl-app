import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/communities/no_community/no_community_widget.dart';
import '/components/community_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'communities_see_all_widget.dart' show CommunitiesSeeAllWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';

class CommunitiesSeeAllModel extends FlutterFlowModel<CommunitiesSeeAllWidget> {
  ///  Local state fields for this page.

  EventsRecord? sharedEvent;

  bool isSearch = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  List<CommunityRecord> simpleSearchResults = [];
  // Models for communityCard dynamic component.
  late FlutterFlowDynamicModels<CommunityCardModel> communityCardModels;

  @override
  void initState(BuildContext context) {
    communityCardModels = FlutterFlowDynamicModels(() => CommunityCardModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    communityCardModels.dispose();
  }
}

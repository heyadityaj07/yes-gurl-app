import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/enums/enums.dart';
import '/chat/pausealert/pausealert_widget.dart';
import '/communities/community_option/community_option_widget.dart';
import '/communities/confirmation_dialogue/confirmation_dialogue_widget.dart';
import '/communities/delete_community/delete_community_widget.dart';
import '/components/empty_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/link_up/community_report/community_report_widget.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'community_detail_widget.dart' show CommunityDetailWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';
import 'package:provider/provider.dart';

class CommunityDetailModel extends FlutterFlowModel<CommunityDetailWidget> {
  ///  Local state fields for this page.

  int commentIndex = 0;

  bool comment = false;

  bool about = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for scrolling_Column widget.
  ScrollController? scrollingColumnScrollController;
  double scrollingColumnScrollOffset = 0.0;
  double scrollingColumnScrollMaxExtent = 0.0;
  double scrollingColumnScrollOffsetLastRebuilt = 0.0;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in IconButton widget.
  String? communityOption;
  // State field(s) for Row widget.
  ScrollController? rowController1;
  // State field(s) for Row widget.
  ScrollController? rowController2;
  // State field(s) for leaveComponent widget.
  FocusNode? leaveComponentFocusNode;
  TextEditingController? leaveComponentTextController;
  String? Function(BuildContext, String?)?
      leaveComponentTextControllerValidator;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  UserRecord? host;

  @override
  void initState(BuildContext context) {
    scrollingColumnScrollController = ScrollController();
    rowController1 = ScrollController();
    rowController2 = ScrollController();
  }

  @override
  void dispose() {
    scrollingColumnScrollController?.dispose();
    rowController1?.dispose();
    rowController2?.dispose();
    leaveComponentFocusNode?.dispose();
    leaveComponentTextController?.dispose();
  }
}

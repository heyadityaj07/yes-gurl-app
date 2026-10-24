import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/club/poll_result_item/poll_result_item_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart' hide Type;
import 'poll_screen_widget.dart' show PollScreenWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PollScreenModel extends FlutterFlowModel<PollScreenWidget> {
  ///  Local state fields for this page.

  bool vote = false;

  ///  State fields for stateful widgets in this page.

  // Models for PollResultItem.
  late FlutterFlowDynamicModels<PollResultItemModel> pollResultItemModels;

  @override
  void initState(BuildContext context) {
    pollResultItemModels =
        FlutterFlowDynamicModels(() => PollResultItemModel());
  }

  @override
  void dispose() {
    pollResultItemModels.dispose();
  }
}

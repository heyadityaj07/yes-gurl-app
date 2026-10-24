import '/auth/base_auth_user_provider.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/club/spotlight_card/spotlight_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'friendship_spotlight_widget.dart' show FriendshipSpotlightWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FriendshipSpotlightModel
    extends FlutterFlowModel<FriendshipSpotlightWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for SpotlightCard.
  late FlutterFlowDynamicModels<SpotlightCardModel> spotlightCardModels;

  @override
  void initState(BuildContext context) {
    spotlightCardModels = FlutterFlowDynamicModels(() => SpotlightCardModel());
  }

  @override
  void dispose() {
    spotlightCardModels.dispose();
  }
}

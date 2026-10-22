import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/club/feature_card/feature_card_widget.dart';
import '/club/loyalty_card/loyalty_card_widget.dart';
import '/club/wait_list/wait_list_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'babes_club_widget.dart' show BabesClubWidget;
import 'package:cloud_firestore/cloud_firestore.dart' hide Type;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BabesClubModel extends FlutterFlowModel<BabesClubWidget> {
  ///  Local state fields for this page.

  bool hasUnreadMessages = false;

  bool load = true;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in babesClub widget.
  PerksRecord? perks;
  // Stores action output result for [Firestore Query - Query a collection] action in babesClub widget.
  PollsRecord? poll;
  // Stores action output result for [Firestore Query - Query a collection] action in babesClub widget.
  OnlineEventsRecord? event;
  // Stores action output result for [Custom Action - hasUnreadClubMessages] action in babesClub widget.
  bool? message;
  // Model for FeatureCard.
  late FeatureCardModel featureCardModel1;
  // Model for FeatureCard.
  late FeatureCardModel featureCardModel2;
  // Model for FeatureCard.
  late FeatureCardModel featureCardModel3;
  // Model for FeatureCard.
  late FeatureCardModel featureCardModel4;
  // Model for FeatureCard.
  late FeatureCardModel featureCardModel5;
  // Model for FeatureCard.
  late FeatureCardModel featureCardModel6;
  // Model for FeatureCard.
  late FeatureCardModel featureCardModel7;
  // Model for FeatureCard.
  late FeatureCardModel featureCardModel8;

  @override
  void initState(BuildContext context) {
    featureCardModel1 = createModel(context, () => FeatureCardModel());
    featureCardModel2 = createModel(context, () => FeatureCardModel());
    featureCardModel3 = createModel(context, () => FeatureCardModel());
    featureCardModel4 = createModel(context, () => FeatureCardModel());
    featureCardModel5 = createModel(context, () => FeatureCardModel());
    featureCardModel6 = createModel(context, () => FeatureCardModel());
    featureCardModel7 = createModel(context, () => FeatureCardModel());
    featureCardModel8 = createModel(context, () => FeatureCardModel());
  }

  @override
  void dispose() {
    featureCardModel1.dispose();
    featureCardModel2.dispose();
    featureCardModel3.dispose();
    featureCardModel4.dispose();
    featureCardModel5.dispose();
    featureCardModel6.dispose();
    featureCardModel7.dispose();
    featureCardModel8.dispose();
  }
}

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/club/benefit_row/benefit_row_widget.dart';
import '/club/preview_card/preview_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/revenue_cat_util.dart' as revenue_cat;
import '/index.dart';
import 'join_club_widget.dart' show JoinClubWidget;
import 'package:cloud_firestore/cloud_firestore.dart' hide Type;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class JoinClubModel extends FlutterFlowModel<JoinClubWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in joinClub widget.
  ClubFeaturesRecord? clubFeature;
  // Stores action output result for [Custom Action - joinOrRestoreBabesClub] action in Container widget.
  String? result;
  // Stores action output result for [Custom Action - joinOrRestoreBabesClub] action in Text widget.
  String? data;
  // Model for BenefitRow.
  late BenefitRowModel benefitRowModel1;
  // Model for BenefitRow.
  late BenefitRowModel benefitRowModel2;
  // Model for BenefitRow.
  late BenefitRowModel benefitRowModel3;
  // Model for BenefitRow.
  late BenefitRowModel benefitRowModel4;
  // Model for BenefitRow.
  late BenefitRowModel benefitRowModel5;
  // Model for PreviewCard.
  late PreviewCardModel previewCardModel1;
  // Model for PreviewCard.
  late PreviewCardModel previewCardModel2;
  // Model for PreviewCard.
  late PreviewCardModel previewCardModel3;

  @override
  void initState(BuildContext context) {
    benefitRowModel1 = createModel(context, () => BenefitRowModel());
    benefitRowModel2 = createModel(context, () => BenefitRowModel());
    benefitRowModel3 = createModel(context, () => BenefitRowModel());
    benefitRowModel4 = createModel(context, () => BenefitRowModel());
    benefitRowModel5 = createModel(context, () => BenefitRowModel());
    previewCardModel1 = createModel(context, () => PreviewCardModel());
    previewCardModel2 = createModel(context, () => PreviewCardModel());
    previewCardModel3 = createModel(context, () => PreviewCardModel());
  }

  @override
  void dispose() {
    benefitRowModel1.dispose();
    benefitRowModel2.dispose();
    benefitRowModel3.dispose();
    benefitRowModel4.dispose();
    benefitRowModel5.dispose();
    previewCardModel1.dispose();
    previewCardModel2.dispose();
    previewCardModel3.dispose();
  }
}

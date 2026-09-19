import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/loading_questions_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/personality_test2/exit_test/exit_test_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'test_widget.dart' show TestWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class TestModel extends FlutterFlowModel<TestWidget> {
  ///  Local state fields for this page.

  int? index;

  bool loading = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in test widget.
  List<QuestionsRecord>? questions;
  // Model for loadingQuestions component.
  late LoadingQuestionsModel loadingQuestionsModel;

  @override
  void initState(BuildContext context) {
    loadingQuestionsModel = createModel(context, () => LoadingQuestionsModel());
  }

  @override
  void dispose() {
    loadingQuestionsModel.dispose();
  }
}

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/chat/meet_again/meet_again_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'we_met_widget.dart' show WeMetWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WeMetModel extends FlutterFlowModel<WeMetWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in weMet widget.
  UserRecord? userDoc;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}

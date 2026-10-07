import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'messagereport_widget.dart' show MessagereportWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MessagereportModel extends FlutterFlowModel<MessagereportWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in messagereport widget.
  MessagesRecord? eventDocument;
  // Stores action output result for [Backend Call - Read Document] action in messagereport widget.
  UserRecord? userevent;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}

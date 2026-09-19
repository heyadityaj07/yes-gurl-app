import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'commentreport_widget.dart' show CommentreportWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CommentreportModel extends FlutterFlowModel<CommentreportWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in commentreport widget.
  EventsCommentRecord? eventDocument;
  // Stores action output result for [Backend Call - Read Document] action in commentreport widget.
  UserRecord? userevent;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}

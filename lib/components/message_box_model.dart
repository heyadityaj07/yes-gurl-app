import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'message_box_widget.dart' show MessageBoxWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MessageBoxModel extends FlutterFlowModel<MessageBoxWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in Container widget.
  EventsRecord? eventResults;
  // Stores action output result for [Backend Call - Read Document] action in Container widget.
  EventsRecord? eventResultsData;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}

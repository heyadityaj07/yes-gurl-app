import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'delete_link_up_widget.dart' show DeleteLinkUpWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DeleteLinkUpModel extends FlutterFlowModel<DeleteLinkUpWidget> {
  ///  Local state fields for this component.

  int deleteIndex = 0;

  int userindex = 0;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  UserRecord? user;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}

import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/chat/pausealert/pausealert_widget.dart';
import '/components/empty_widget.dart';
import '/components/navbar_widget.dart';
import '/components/no_match_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/link_up/link_up_message/link_up_message_widget.dart';
import 'dart:async';
import 'dart:math';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'potential_connections_widget.dart' show PotentialConnectionsWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PotentialConnectionsModel
    extends FlutterFlowModel<PotentialConnectionsWidget> {
  ///  Local state fields for this page.

  int index = 0;

  int maxindex = 0;

  List<DocumentReference> userList = [];
  void addToUserList(DocumentReference item) => userList.add(item);
  void removeFromUserList(DocumentReference item) => userList.remove(item);
  void removeAtIndexFromUserList(int index) => userList.removeAt(index);
  void insertAtIndexInUserList(int index, DocumentReference item) =>
      userList.insert(index, item);
  void updateUserListAtIndex(int index, Function(DocumentReference) updateFn) =>
      userList[index] = updateFn(userList[index]);

  bool isLoading = true;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Read Document] action in potentialConnections widget.
  UserRecord? currentUserDoc;
  // Stores action output result for [Custom Action - getMatchingTodayUserProfiles] action in potentialConnections widget.
  List<DocumentReference>? todayuserList;
  // Stores action output result for [Backend Call - API (Fetch Users Potential connections)] action in potentialConnections widget.
  ApiCallResponse? potentialConnection;
  // Stores action output result for [Backend Call - API (Fetch Users Potential connections)] action in showProfile widget.
  ApiCallResponse? potentialConnectionshide;
  // Model for pausealert component.
  late PausealertModel pausealertModel;
  // Model for navbar component.
  late NavbarModel navbarModel;

  @override
  void initState(BuildContext context) {
    pausealertModel = createModel(context, () => PausealertModel());
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    pausealertModel.dispose();
    navbarModel.dispose();
  }
}

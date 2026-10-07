import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'navbar_widget.dart' show NavbarWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NavbarModel extends FlutterFlowModel<NavbarWidget> {
  ///  Local state fields for this component.

  bool linkup = false;

  bool community = false;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - hasUnreadLinkUpComments] action in navbar widget.
  bool? haslinkup;
  // Stores action output result for [Custom Action - hasUnreadCommunity] action in navbar widget.
  bool? hascommunity;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}

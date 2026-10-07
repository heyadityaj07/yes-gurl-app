import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'profile_preferences_age_widget.dart' show ProfilePreferencesAgeWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfilePreferencesAgeModel
    extends FlutterFlowModel<ProfilePreferencesAgeWidget> {
  ///  Local state fields for this page.

  int? age1;

  int? age2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}

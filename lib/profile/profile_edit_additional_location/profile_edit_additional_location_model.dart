import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'profile_edit_additional_location_widget.dart'
    show ProfileEditAdditionalLocationWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileEditAdditionalLocationModel
    extends FlutterFlowModel<ProfileEditAdditionalLocationWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for selectCountrymenay widget.
  String? selectCountrymenayValue;
  FormFieldController<String>? selectCountrymenayValueController;
  // State field(s) for regioncountry widget.
  String? regioncountryValue;
  FormFieldController<String>? regioncountryValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}

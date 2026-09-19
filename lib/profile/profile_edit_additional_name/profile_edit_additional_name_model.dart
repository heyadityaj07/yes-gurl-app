import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'profile_edit_additional_name_widget.dart'
    show ProfileEditAdditionalNameWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileEditAdditionalNameModel
    extends FlutterFlowModel<ProfileEditAdditionalNameWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for editFirstName widget.
  FocusNode? editFirstNameFocusNode;
  TextEditingController? editFirstNameTextController;
  String? Function(BuildContext, String?)? editFirstNameTextControllerValidator;
  String? _editFirstNameTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'first name is required';
    }

    return null;
  }

  // State field(s) for editSecondName widget.
  FocusNode? editSecondNameFocusNode;
  TextEditingController? editSecondNameTextController;
  String? Function(BuildContext, String?)?
      editSecondNameTextControllerValidator;
  String? _editSecondNameTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'second_name is required';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    editFirstNameTextControllerValidator =
        _editFirstNameTextControllerValidator;
    editSecondNameTextControllerValidator =
        _editSecondNameTextControllerValidator;
  }

  @override
  void dispose() {
    editFirstNameFocusNode?.dispose();
    editFirstNameTextController?.dispose();

    editSecondNameFocusNode?.dispose();
    editSecondNameTextController?.dispose();
  }
}

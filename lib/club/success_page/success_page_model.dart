import '/auth/base_auth_user_provider.dart';
import '/club/welcome_gift_card/welcome_gift_card_widget.dart';
import '/club/welcome_pack/welcome_pack_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'success_page_widget.dart' show SuccessPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SuccessPageModel extends FlutterFlowModel<SuccessPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for WelcomeGiftCard.
  late WelcomeGiftCardModel welcomeGiftCardModel;

  @override
  void initState(BuildContext context) {
    welcomeGiftCardModel = createModel(context, () => WelcomeGiftCardModel());
  }

  @override
  void dispose() {
    welcomeGiftCardModel.dispose();
  }
}

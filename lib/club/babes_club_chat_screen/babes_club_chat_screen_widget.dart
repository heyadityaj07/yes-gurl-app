import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'babes_club_chat_screen_model.dart';
export 'babes_club_chat_screen_model.dart';

class BabesClubChatScreenWidget extends StatefulWidget {
  const BabesClubChatScreenWidget({super.key});

  static String routeName = 'babesClubChatScreen';
  static String routePath = '/babesClubChatScreen';

  @override
  State<BabesClubChatScreenWidget> createState() =>
      _BabesClubChatScreenWidgetState();
}

class _BabesClubChatScreenWidgetState extends State<BabesClubChatScreenWidget> {
  late BabesClubChatScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BabesClubChatScreenModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'babesClubChatScreen'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('BABES_CLUB_CHAT_SCREEN_babesClubChatScre');
      logFirebaseEvent('babesClubChatScreen_update_app_state');
      FFAppState().isBabesChatOpen = true;
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    // On page dispose action.
    () async {
      logFirebaseEvent('BABES_CLUB_CHAT_SCREEN_babesClubChatScre');
      logFirebaseEvent('babesClubChatScreen_update_app_state');
      FFAppState().isBabesChatOpen = false;
    }();

    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: AuthUserStreamWidget(
            builder: (context) => Container(
              width: double.infinity,
              height: double.infinity,
              child: custom_widgets.BabesClubChatWidget(
                width: double.infinity,
                height: double.infinity,
                isMember: valueOrDefault<bool>(
                    currentUserDocument?.isSubscriptionActive, false),
                onBack: () async {
                  logFirebaseEvent('BABES_CLUB_CHAT_SCREEN_Container_hrhl8k2');
                  logFirebaseEvent('BabesClubChatWidget_navigate_to');

                  context.goNamed(BabesClubWidget.routeName);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'babes_club_chat_model.dart';
export 'babes_club_chat_model.dart';

class BabesClubChatPageWidget extends StatefulWidget {
  const BabesClubChatPageWidget({super.key});

  static String routeName = 'babesClubChat';
  static String routePath = '/babesClubChat';

  @override
  State<BabesClubChatPageWidget> createState() =>
      _BabesClubChatPageWidgetState();
}

class _BabesClubChatPageWidgetState extends State<BabesClubChatPageWidget> {
  late BabesClubChatModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    FFAppState().isBabesChatOpen = true;
    _model = createModel(context, () => BabesClubChatModel());
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'babesClubChat'});
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    FFAppState().isBabesChatOpen = false;
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: SafeArea(
        top: false,
        bottom: false,
        child: custom_widgets.BabesClubChatWidget(
          width: double.infinity,
          height: double.infinity,
          isMember: true,
          onBack: () async {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              context.goNamed('babesClub');
            }
          },
        ),
      ),
    );
  }
}

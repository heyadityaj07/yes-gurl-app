import '/auth/base_auth_user_provider.dart';
import '/backend/backend.dart';
import '/club/perk_card/perk_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'discount_perk_model.dart';
export 'discount_perk_model.dart';

class DiscountPerkWidget extends StatefulWidget {
  const DiscountPerkWidget({super.key});

  static String routeName = 'discountPerk';
  static String routePath = '/discountPerk';

  @override
  State<DiscountPerkWidget> createState() => _DiscountPerkWidgetState();
}

class _DiscountPerkWidgetState extends State<DiscountPerkWidget> {
  late DiscountPerkModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DiscountPerkModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'discountPerk'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('DISCOUNT_PERK_discountPerk_ON_INIT_STATE');
      logFirebaseEvent('discountPerk_custom_action');
      unawaited(
        () async {
          await actions.logScreenView(
            getCurrentRoute(context) == '/'
                ? (loggedIn == true ? '/splashScreen' : '/login')
                : getCurrentRoute(context),
          );
        }(),
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              buttonSize: 40.0,
              icon: Icon(
                Icons.arrow_back_ios,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 30.0,
              ),
              onPressed: () async {
                logFirebaseEvent('DISCOUNT_PERK_arrow_back_ios_ICN_ON_TAP');
                logFirebaseEvent('IconButton_navigate_back');
                context.safePop();
              },
            ),
          ),
          title: Text(
            'yes gurl',
            style: FlutterFlowTheme.of(context).displaySmall.override(
                  fontFamily: FlutterFlowTheme.of(context).displaySmallFamily,
                  fontSize: 25.0,
                  letterSpacing: 0.0,
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).displaySmallIsCustom,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: StreamBuilder<List<PerksRecord>>(
            stream: queryPerksRecord(
              queryBuilder: (perksRecord) => perksRecord
                  .where(
                    'expiry_date',
                    isGreaterThanOrEqualTo: getCurrentTimestamp,
                  )
                  .orderBy('expiry_date', descending: true),
            ),
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return Center(
                  child: LinearProgressIndicator(
                    color: Color(0xFFFE99AB),
                  ),
                );
              }
              List<PerksRecord> columnPerksRecordList = snapshot.data!;

              return ListView.separated(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: columnPerksRecordList.length,
                separatorBuilder: (_, __) => SizedBox(height: 16.0),
                itemBuilder: (context, columnIndex) {
                  final columnPerksRecord = columnPerksRecordList[columnIndex];
                  return PerkCardWidget(
                    key: Key(
                        'Key4bg_${columnIndex}_of_${columnPerksRecordList.length}'),
                    brand: columnPerksRecord.brandName,
                    isNew: false,
                    offer: columnPerksRecord.description,
                    code: columnPerksRecord.promoCode,
                    imageDesc: columnPerksRecord.imageUrl,
                    url: columnPerksRecord.externalUrl,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

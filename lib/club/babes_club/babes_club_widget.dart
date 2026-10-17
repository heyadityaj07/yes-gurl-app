import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/club/loyalty_card/loyalty_card_widget.dart';
import '/club/wait_list/wait_list_widget.dart';
import '/components/feature_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'babes_club_model.dart';
export 'babes_club_model.dart';

class BabesClubWidget extends StatefulWidget {
  const BabesClubWidget({super.key});

  static String routeName = 'babesClub';
  static String routePath = '/babesClub';

  @override
  State<BabesClubWidget> createState() => _BabesClubWidgetState();
}

class _BabesClubWidgetState extends State<BabesClubWidget> {
  late BabesClubModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BabesClubModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'babesClub'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('BABES_CLUB_PAGE_babesClub_ON_INIT_STATE');
      logFirebaseEvent('babesClub_firestore_query');
      _model.perks = await queryPerksRecordOnce(
        queryBuilder: (perksRecord) => perksRecord.where(
          'expiry_date',
          isGreaterThanOrEqualTo: getCurrentTimestamp,
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      logFirebaseEvent('babesClub_firestore_query');
      _model.poll = await queryPollsRecordOnce(
        queryBuilder: (pollsRecord) => pollsRecord.where(
          'active',
          isEqualTo: true,
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      logFirebaseEvent('babesClub_firestore_query');
      _model.event = await queryOnlineEventsRecordOnce(
        queryBuilder: (onlineEventsRecord) => onlineEventsRecord.where(
          'starts_at',
          isGreaterThanOrEqualTo: getCurrentTimestamp,
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
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
                logFirebaseEvent('BABES_CLUB_arrow_back_ios_ICN_ON_TAP');
                logFirebaseEvent('IconButton_navigate_to');

                context.goNamed(PotentialConnectionsWidget.routeName);
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
        body: Align(
          alignment: AlignmentDirectional(0.0, -1.0),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Wrap(
              spacing: 16.0,
              runSpacing: 24.0,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.horizontal,
              runAlignment: WrapAlignment.start,
              verticalDirection: VerticalDirection.down,
              clipBehavior: Clip.none,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    logFirebaseEvent('BABES_CLUB_PAGE_CommunityChat_ON_TAP');
                    context.pushNamed(BabesClubChatPageWidget.routeName);
                  },
                  child: wrapWithModel(
                    model: _model.featureCardModel1,
                    updateCallback: () => safeSetState(() {}),
                    child: FeatureCardWidget(
                      icon: Icon(
                        Icons.groups_rounded,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 22.0,
                      ),
                      hasDot: true,
                      title: 'community chat',
                      subtitle: 'chat with your babes',
                      status: '',
                    ),
                  ),
                ),
                if (_model.perks != null)
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent('BABES_CLUB_PAGE_FeatureCard_ON_TAP');
                      logFirebaseEvent('FeatureCard_navigate_to');

                      context.pushNamed(DiscountPerkWidget.routeName);
                    },
                    child: wrapWithModel(
                      model: _model.featureCardModel2,
                      updateCallback: () => safeSetState(() {}),
                      child: FeatureCardWidget(
                        icon: Icon(
                          Icons.local_offer_rounded,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 22.0,
                        ),
                        hasDot: false,
                        title: 'discounts and perks',
                        subtitle: 'exclusive offers',
                        status: '',
                        statusColor: Color(0x00000000),
                      ),
                    ),
                  ),
                if (_model.event != null)
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent('BABES_CLUB_PAGE_FeatureCard_ON_TAP');
                      logFirebaseEvent('FeatureCard_navigate_to');

                      context.pushNamed(EventWidget.routeName);
                    },
                    child: wrapWithModel(
                      model: _model.featureCardModel3,
                      updateCallback: () => safeSetState(() {}),
                      child: FeatureCardWidget(
                        icon: Icon(
                          Icons.event_available_rounded,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 22.0,
                        ),
                        hasDot: true,
                        title: 'free events',
                        subtitle: 'join & connect',
                        status: '',
                        statusColor: Color(0x00000000),
                      ),
                    ),
                  ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    logFirebaseEvent('BABES_CLUB_PAGE_FeatureCard_ON_TAP');
                    logFirebaseEvent('FeatureCard_navigate_to');

                    context.pushNamed(BookSessionWidget.routeName);
                  },
                  child: wrapWithModel(
                    model: _model.featureCardModel4,
                    updateCallback: () => safeSetState(() {}),
                    child: FeatureCardWidget(
                      icon: Icon(
                        Icons.video_chat_rounded,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 22.0,
                      ),
                      hasDot: false,
                      title: 'ask the founders',
                      subtitle: 'book a session',
                      status: 'open',
                      statusColor: FlutterFlowTheme.of(context).success,
                    ),
                  ),
                ),
                if (_model.poll != null)
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent('BABES_CLUB_PAGE_FeatureCard_ON_TAP');
                      logFirebaseEvent('FeatureCard_navigate_to');

                      context.pushNamed(PollScreenWidget.routeName);
                    },
                    child: wrapWithModel(
                      model: _model.featureCardModel5,
                      updateCallback: () => safeSetState(() {}),
                      child: FeatureCardWidget(
                        icon: Icon(
                          Icons.auto_awesome_rounded,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 22.0,
                        ),
                        hasDot: false,
                        title: 'have you say',
                        subtitle: 'vote & shape the future',
                        status: '',
                        statusColor: Color(0x00000000),
                      ),
                    ),
                  ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    logFirebaseEvent('BABES_CLUB_PAGE_FeatureCard_ON_TAP');
                    logFirebaseEvent('FeatureCard_navigate_to');

                    context.pushNamed(FriendshipSpotlightWidget.routeName);
                  },
                  child: wrapWithModel(
                    model: _model.featureCardModel6,
                    updateCallback: () => safeSetState(() {}),
                    child: FeatureCardWidget(
                      icon: Icon(
                        Icons.auto_stories_rounded,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 22.0,
                      ),
                      hasDot: false,
                      title: 'friendship spotlight',
                      subtitle: 'friendship starter pack',
                      status: '',
                      statusColor: Color(0x00000000),
                    ),
                  ),
                ),
                Builder(
                  builder: (context) => InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent('BABES_CLUB_PAGE_FeatureCard_ON_TAP');
                      logFirebaseEvent('FeatureCard_alert_dialog');
                      await showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return Dialog(
                            elevation: 0,
                            insetPadding: EdgeInsets.zero,
                            backgroundColor: Colors.transparent,
                            alignment: AlignmentDirectional(0.0, 0.0)
                                .resolve(Directionality.of(context)),
                            child: GestureDetector(
                              onTap: () {
                                FocusScope.of(dialogContext).unfocus();
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              child: WaitListWidget(),
                            ),
                          );
                        },
                      );
                    },
                    child: wrapWithModel(
                      model: _model.featureCardModel7,
                      updateCallback: () => safeSetState(() {}),
                      child: FeatureCardWidget(
                        icon: Icon(
                          Icons.girl,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 22.0,
                        ),
                        hasDot: false,
                        title: 'babes Club 2.0',
                        subtitle: 'check out this',
                        status: '',
                        statusColor: Color(0x00000000),
                      ),
                    ),
                  ),
                ),
                Builder(
                  builder: (context) => InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent('BABES_CLUB_PAGE_FeatureCard_ON_TAP');
                      logFirebaseEvent('FeatureCard_alert_dialog');
                      await showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return Dialog(
                            elevation: 0,
                            insetPadding: EdgeInsets.zero,
                            backgroundColor: Colors.transparent,
                            alignment: AlignmentDirectional(0.0, 0.0)
                                .resolve(Directionality.of(context)),
                            child: GestureDetector(
                              onTap: () {
                                FocusScope.of(dialogContext).unfocus();
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              child: LoyaltyCardWidget(),
                            ),
                          );
                        },
                      );
                    },
                    child: wrapWithModel(
                      model: _model.featureCardModel8,
                      updateCallback: () => safeSetState(() {}),
                      child: FeatureCardWidget(
                        icon: Icon(
                          Icons.card_giftcard,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 22.0,
                        ),
                        hasDot: false,
                        title: 'loyalty rewards',
                        subtitle: 'every 5th event free',
                        status: '',
                        statusColor: Color(0x00000000),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

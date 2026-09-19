import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/empty_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/potential_connections/blockuserconfirmation/blockuserconfirmation_widget.dart';
import '/potential_connections/chat_dropdown_user/chat_dropdown_user_widget.dart';
import '/potential_connections/compatible/compatible_widget.dart';
import '/potential_connections/possible/possible_widget.dart';
import '/potential_connections/potential_connections_report/potential_connections_report_widget.dart';
import '/potential_connections/try_your_luck/try_your_luck_widget.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'potential_matches_profile_model.dart';
export 'potential_matches_profile_model.dart';

class PotentialMatchesProfileWidget extends StatefulWidget {
  const PotentialMatchesProfileWidget({
    super.key,
    required this.userRef,
    this.throughUserProfile,
  });

  final DocumentReference? userRef;
  final String? throughUserProfile;

  static String routeName = 'potentialMatchesProfile';
  static String routePath = '/potentialMatchesProfile';

  @override
  State<PotentialMatchesProfileWidget> createState() =>
      _PotentialMatchesProfileWidgetState();
}

class _PotentialMatchesProfileWidgetState
    extends State<PotentialMatchesProfileWidget> with TickerProviderStateMixin {
  late PotentialMatchesProfileModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PotentialMatchesProfileModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'potentialMatchesProfile'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('POTENTIAL_MATCHES_PROFILE_potentialMatch');
      logFirebaseEvent('potentialMatchesProfile_backend_call');

      await currentUserReference!.update({
        ...mapToFirestore(
          {
            'offline_user_time': FieldValue.delete(),
          },
        ),
      });
    });

    _model.newTextfeildTextController ??= TextEditingController();
    _model.newTextfeildFocusNode ??= FocusNode();

    animationsMap.addAll({
      'textOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(50.0, 0.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'rowOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 80.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'dividerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(50.0, 0.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 100.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'dividerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(50.0, 0.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'textOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(50.0, 0.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'rowOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 80.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'dividerOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(50.0, 0.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 100.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'dividerOnPageLoadAnimation4': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(50.0, 0.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'textOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(50.0, 0.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'dividerOnPageLoadAnimation5': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(50.0, 0.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 100.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'dividerOnPageLoadAnimation6': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(50.0, 0.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    // On page dispose action.
    () async {
      logFirebaseEvent('POTENTIAL_MATCHES_PROFILE_potentialMatch');
      logFirebaseEvent('potentialMatchesProfile_backend_call');

      await currentUserReference!.update(createUserRecordData(
        offlineUserTime: getCurrentTimestamp,
      ));
      logFirebaseEvent('potentialMatchesProfile_update_app_state');
      FFAppState().isScreenActive = false;
      safeSetState(() {});
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
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          iconTheme:
              IconThemeData(color: FlutterFlowTheme.of(context).primaryText),
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderRadius: 30.0,
            buttonSize: 40.0,
            fillColor: Color(0x00FE99AB),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),
            onPressed: () async {
              logFirebaseEvent('POTENTIAL_MATCHES_PROFILE_arrow_back_ios');
              logFirebaseEvent('IconButton_navigate_back');
              context.safePop();
            },
          ),
          title: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Text(
              'yes gurl',
              style: FlutterFlowTheme.of(context).displaySmall.override(
                    fontFamily: FlutterFlowTheme.of(context).displaySmallFamily,
                    fontSize: 25.0,
                    letterSpacing: 0.0,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).displaySmallIsCustom,
                  ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
              child: Stack(
                alignment: AlignmentDirectional(1.0, -1.0),
                children: [
                  Align(
                    alignment: AlignmentDirectional(1.0, 0.0),
                    child: FlutterFlowIconButton(
                      borderRadius: 40.0,
                      buttonSize: 40.0,
                      icon: Icon(
                        Icons.notifications_none,
                        color: FlutterFlowTheme.of(context).accent1,
                        size: 30.0,
                      ),
                      onPressed: () async {
                        logFirebaseEvent(
                            'POTENTIAL_MATCHES_PROFILE_notifications_');
                        logFirebaseEvent('IconButton_navigate_to');

                        context.pushNamed(NotificationWidget.routeName);
                      },
                    ),
                  ),
                  StreamBuilder<List<NotificationRecord>>(
                    stream: queryNotificationRecord(
                      queryBuilder: (notificationRecord) =>
                          notificationRecord.where(Filter.or(
                        Filter(
                          'user',
                          isEqualTo: currentUserReference,
                        ),
                        Filter(
                          'manage',
                          isEqualTo: 'admin',
                        ),
                      )),
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Container(
                          width: 0.0,
                          height: 0.0,
                          child: EmptyWidget(),
                        );
                      }
                      List<NotificationRecord> containerNotificationRecordList =
                          snapshot.data!;

                      return Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        alignment: AlignmentDirectional(1.0, -1.0),
                        child: Visibility(
                          visible: functions.getNotificationCount(
                                  containerNotificationRecordList.toList(),
                                  currentUserReference,
                                  currentUserDocument?.createdTime) !=
                              0,
                          child: Align(
                            alignment: AlignmentDirectional(1.0, -0.6),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 2.0, 0.0),
                              child: AuthUserStreamWidget(
                                builder: (context) => Container(
                                  width: 18.0,
                                  height: 18.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).primary,
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: AlignmentDirectional(1.0, -1.0),
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        functions
                                            .getNotificationCount(
                                                containerNotificationRecordList
                                                    .toList(),
                                                currentUserReference,
                                                currentUserDocument
                                                    ?.createdTime)
                                            .toString(),
                                        '0',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .displaySmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .displaySmallFamily,
                                            fontSize: 10.0,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .displaySmallIsCustom,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: FutureBuilder<UserRecord>(
              future: UserRecord.getDocumentOnce(widget!.userRef!),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(
                    child: LinearProgressIndicator(
                      color: Color(0xFFFE99AB),
                    ),
                  );
                }

                final columnUserRecord = snapshot.data!;

                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            15.0, 0.0, 15.0, 0.0),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.sizeOf(context).height * 0.35,
                          decoration: BoxDecoration(
                            color: Color(0x430F1113),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Stack(
                            children: [
                              if (functions.isValidUrl(
                                      columnUserRecord.displayImage) ??
                                  true)
                                Container(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.35,
                                  child: custom_widgets.ImageView(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.35,
                                    imagePath: columnUserRecord.displayImage,
                                  ),
                                ),
                              if ((functions.getRecommendation(columnUserRecord.personalityType, valueOrDefault(currentUserDocument?.personalityType, '')) != 0) &&
                                  (functions.getRecommendation(
                                          columnUserRecord.personalityType,
                                          valueOrDefault(
                                              currentUserDocument
                                                  ?.personalityType,
                                              '')) !=
                                      1) &&
                                  (columnUserRecord.reference !=
                                      currentUserReference))
                                Align(
                                  alignment: AlignmentDirectional(-1.0, 1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 15.0, 0.0, 15.0),
                                    child: AuthUserStreamWidget(
                                      builder: (context) => FFButtonWidget(
                                        onPressed: () async {
                                          logFirebaseEvent(
                                              'POTENTIAL_MATCHES_PROFILE_ENTJ_BTN_ON_TA');
                                          logFirebaseEvent(
                                              'Button_navigate_to');

                                          context.pushNamed(
                                            TestSummaryWidget.routeName,
                                            queryParameters: {
                                              'isFromProfile': serializeParam(
                                                true,
                                                ParamType.bool,
                                              ),
                                              'personalityParms':
                                                  serializeParam(
                                                columnUserRecord
                                                    .personalityType,
                                                ParamType.String,
                                              ),
                                              'anotherUserProfile':
                                                  serializeParam(
                                                'yes',
                                                ParamType.String,
                                              ),
                                              'userRef': serializeParam(
                                                widget!.userRef,
                                                ParamType.DocumentReference,
                                              ),
                                            }.withoutNulls,
                                          );
                                        },
                                        text: columnUserRecord.personalityType,
                                        options: FFButtonOptions(
                                          width: 120.0,
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.05,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .titleSmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmallFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .titleSmallIsCustom,
                                              ),
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if ((functions.getRecommendation(
                                          columnUserRecord.personalityType,
                                          valueOrDefault(
                                              currentUserDocument
                                                  ?.personalityType,
                                              '')) ==
                                      1) &&
                                  (columnUserRecord.reference !=
                                      currentUserReference))
                                Align(
                                  alignment: AlignmentDirectional(-1.0, 1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 15.0, 0.0, 15.0),
                                    child: AuthUserStreamWidget(
                                      builder: (context) => FFButtonWidget(
                                        onPressed: () async {
                                          logFirebaseEvent(
                                              'POTENTIAL_MATCHES_PROFILE_ENTJ_BTN_ON_TA');
                                          logFirebaseEvent(
                                              'Button_navigate_to');

                                          context.pushNamed(
                                            TestSummaryWidget.routeName,
                                            queryParameters: {
                                              'isFromProfile': serializeParam(
                                                true,
                                                ParamType.bool,
                                              ),
                                              'personalityParms':
                                                  serializeParam(
                                                columnUserRecord
                                                    .personalityType,
                                                ParamType.String,
                                              ),
                                              'anotherUserProfile':
                                                  serializeParam(
                                                'yes',
                                                ParamType.String,
                                              ),
                                              'userRef': serializeParam(
                                                widget!.userRef,
                                                ParamType.DocumentReference,
                                              ),
                                            }.withoutNulls,
                                          );
                                        },
                                        text: columnUserRecord.personalityType,
                                        options: FFButtonOptions(
                                          width: 120.0,
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.05,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme.of(context)
                                              .secondary,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .titleSmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmallFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .titleSmallIsCustom,
                                              ),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if ((functions.getRecommendation(
                                          columnUserRecord.personalityType,
                                          valueOrDefault(
                                              currentUserDocument
                                                  ?.personalityType,
                                              '')) ==
                                      0) ||
                                  (columnUserRecord.reference ==
                                      currentUserReference))
                                Align(
                                  alignment: AlignmentDirectional(-1.0, 1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 15.0, 0.0, 15.0),
                                    child: AuthUserStreamWidget(
                                      builder: (context) => FFButtonWidget(
                                        onPressed: () async {
                                          logFirebaseEvent(
                                              'POTENTIAL_MATCHES_PROFILE_Button_zd4pb0u');
                                          logFirebaseEvent(
                                              'Button_navigate_to');

                                          context.pushNamed(
                                            TestSummaryWidget.routeName,
                                            queryParameters: {
                                              'isFromProfile': serializeParam(
                                                true,
                                                ParamType.bool,
                                              ),
                                              'personalityParms':
                                                  serializeParam(
                                                columnUserRecord
                                                    .personalityType,
                                                ParamType.String,
                                              ),
                                              'anotherUserProfile':
                                                  serializeParam(
                                                'yes',
                                                ParamType.String,
                                              ),
                                              'userRef': serializeParam(
                                                widget!.userRef,
                                                ParamType.DocumentReference,
                                              ),
                                            }.withoutNulls,
                                          );
                                        },
                                        text: valueOrDefault<String>(
                                          columnUserRecord.personalityType,
                                          'estp',
                                        ),
                                        options: FFButtonOptions(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.25,
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.05,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .titleSmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmallFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .titleSmallIsCustom,
                                              ),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.0, 15.0, 0.0, 15.0),
                            child: Text(
                              valueOrDefault<String>(
                                columnUserRecord.displayName,
                                'Tia',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .displaySmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .displaySmallFamily,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 40.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .displaySmallIsCustom,
                                  ),
                            ).animateOnPageLoad(
                                animationsMap['textOnPageLoadAnimation1']!),
                          ),
                          if (widget!.userRef != currentUserReference)
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Builder(
                                builder: (context) => FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 20.0,
                                  buttonSize: 40.0,
                                  icon: Icon(
                                    Icons.more_vert_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 24.0,
                                  ),
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'POTENTIAL_MATCHES_PROFILE_more_vert_roun');
                                    logFirebaseEvent('IconButton_alert_dialog');
                                    await showDialog(
                                      context: context,
                                      builder: (dialogContext) {
                                        return Dialog(
                                          elevation: 0,
                                          insetPadding: EdgeInsets.zero,
                                          backgroundColor: Colors.transparent,
                                          alignment: AlignmentDirectional(
                                                  0.0, 0.0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          child: GestureDetector(
                                            onTap: () {
                                              FocusScope.of(dialogContext)
                                                  .unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: ChatDropdownUserWidget(
                                              chatreference: columnUserRecord,
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(
                                        () => _model.match = value));

                                    if (_model.match == 'report') {
                                      logFirebaseEvent(
                                          'IconButton_alert_dialog');
                                      await showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          return Dialog(
                                            elevation: 0,
                                            insetPadding: EdgeInsets.zero,
                                            backgroundColor: Colors.transparent,
                                            alignment: AlignmentDirectional(
                                                    0.0, 0.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                            child: GestureDetector(
                                              onTap: () {
                                                FocusScope.of(dialogContext)
                                                    .unfocus();
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                              },
                                              child:
                                                  PotentialConnectionsReportWidget(
                                                userref:
                                                    columnUserRecord.reference,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    } else if (_model.match == 'block') {
                                      logFirebaseEvent(
                                          'IconButton_alert_dialog');
                                      await showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          return Dialog(
                                            elevation: 0,
                                            insetPadding: EdgeInsets.zero,
                                            backgroundColor: Colors.transparent,
                                            alignment: AlignmentDirectional(
                                                    0.0, 0.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                            child: GestureDetector(
                                              onTap: () {
                                                FocusScope.of(dialogContext)
                                                    .unfocus();
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                              },
                                              child:
                                                  BlockuserconfirmationWidget(
                                                userreference: widget!.userRef!,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }

                                    safeSetState(() {});
                                  },
                                ),
                              ),
                            ),
                        ],
                      ),
                      if (widget!.userRef != currentUserReference)
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Builder(
                            builder: (context) {
                              if (functions.getRecommendation(
                                      columnUserRecord.personalityType,
                                      valueOrDefault(
                                          currentUserDocument?.personalityType,
                                          '')) ==
                                  0) {
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15.0, 0.0, 15.0, 20.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      logFirebaseEvent(
                                          'POTENTIAL_MATCHES_PROFILE_Container_j5ad');
                                      logFirebaseEvent(
                                          'Container_bottom_sheet');
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        enableDrag: false,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: CompatibleWidget(),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15.0, 12.0, 15.0, 12.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'compatible',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily,
                                                    color: Colors.white,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumIsCustom,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else if (functions.getRecommendation(
                                      columnUserRecord.personalityType,
                                      valueOrDefault(
                                          currentUserDocument?.personalityType,
                                          '')) ==
                                  1) {
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15.0, 0.0, 15.0, 20.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      logFirebaseEvent(
                                          'POTENTIAL_MATCHES_PROFILE_Container_h4yf');
                                      logFirebaseEvent(
                                          'Container_bottom_sheet');
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        enableDrag: false,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: PossibleWidget(),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .secondary,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15.0, 12.0, 15.0, 12.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'possible',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumIsCustom,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15.0, 0.0, 15.0, 20.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      logFirebaseEvent(
                                          'POTENTIAL_MATCHES_PROFILE_Container_dka1');
                                      logFirebaseEvent(
                                          'Container_bottom_sheet');
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        enableDrag: false,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: TryYourLuckWidget(),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15.0, 12.0, 15.0, 12.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'try your luck',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumIsCustom,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      if (widget!.userRef == currentUserReference)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 0.0, 15.0, 20.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'POTENTIAL_MATCHES_PROFILE_Container_qwus');
                              logFirebaseEvent('Container_navigate_to');

                              context.pushNamed(ProfileEditWidget.routeName);
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).primary,
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 12.0, 15.0, 12.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'edit profile',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyMediumIsCustom,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            15.0, 0.0, 15.0, 0.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.cake,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 25.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        functions
                                            .calculateAge(
                                                columnUserRecord.dateOfBirth!)
                                            .toString(),
                                        '25 Years',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLargeFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyLargeIsCustom,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 25.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        columnUserRecord.relationshipStatus,
                                        'single',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLargeFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyLargeIsCustom,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.child_friendly,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 25.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        columnUserRecord.chldren,
                                        'no',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyMediumIsCustom,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.house,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 25.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        columnUserRecord.subCity,
                                        'London',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyMediumIsCustom,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ].divide(SizedBox(width: 15.0)),
                          ),
                        ).animateOnPageLoad(
                            animationsMap['rowOnPageLoadAnimation1']!),
                      ),
                      Divider(
                        height: 30.0,
                        thickness: 1.5,
                        color: FlutterFlowTheme.of(context).alternate,
                      ).animateOnPageLoad(
                          animationsMap['dividerOnPageLoadAnimation1']!),
                      if ((columnUserRecord.prompt1question != null &&
                              columnUserRecord.prompt1question != '') &&
                          (columnUserRecord.prompt1answer != null &&
                              columnUserRecord.prompt1answer != ''))
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 2.0,
                                ),
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(-1.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 16.0, 16.0, 16.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 10.0),
                                          child: Text(
                                            valueOrDefault<String>(
                                              columnUserRecord.prompt1question,
                                              'one word to describe me is',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .titleLarge
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleLargeFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .titleLargeIsCustom,
                                                ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Text(
                                            valueOrDefault<String>(
                                              columnUserRecord.prompt1answer,
                                              'an absolute vibe!',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                  font: GoogleFonts.lexendDeca(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmall
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ).animateOnPageLoad(animationsMap[
                                'containerOnPageLoadAnimation1']!),
                          ),
                        ),
                      if ((columnUserRecord.prompt1question != null &&
                              columnUserRecord.prompt1question != '') &&
                          (columnUserRecord.prompt1answer != null &&
                              columnUserRecord.prompt1answer != ''))
                        Divider(
                          height: 30.0,
                          thickness: 1.5,
                          color: FlutterFlowTheme.of(context).alternate,
                        ).animateOnPageLoad(
                            animationsMap['dividerOnPageLoadAnimation2']!),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            15.0, 15.0, 15.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 20.0),
                              child: Text(
                                'we should go offline for',
                                style: FlutterFlowTheme.of(context)
                                    .displaySmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .displaySmallFamily,
                                      fontSize: 27.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .displaySmallIsCustom,
                                    ),
                              ).animateOnPageLoad(
                                  animationsMap['textOnPageLoadAnimation2']!),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (columnUserRecord.interest1 ==
                                                'arts & crafts')
                                              FaIcon(
                                                FontAwesomeIcons.palette,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest1 ==
                                                'brunch')
                                              Icon(
                                                Icons.brunch_dining,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest1 ==
                                                'coffee')
                                              Icon(
                                                Icons.coffee_sharp,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest1 ==
                                                'deep chat')
                                              Icon(
                                                Icons.comment,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest1 ==
                                                'culture')
                                              Icon(
                                                Icons.museum,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest1 ==
                                                'day parties')
                                              Icon(
                                                Icons.wb_sunny,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest1 ==
                                                'dinner')
                                              Icon(
                                                Icons.dinner_dining,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest1 ==
                                                'drinks')
                                              Icon(
                                                Icons.wine_bar,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest1 ==
                                                'films')
                                              Icon(
                                                Icons.local_movies,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest1 ==
                                                'fitness classes')
                                              Icon(
                                                Icons.sports_gymnastics,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest1 ==
                                                'games')
                                              Icon(
                                                Icons.gamepad,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest1 ==
                                                'live music')
                                              Icon(
                                                Icons.music_note,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest1 ==
                                                'meet up with kids')
                                              Icon(
                                                Icons.child_friendly,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest1 ==
                                                'meet up with pets')
                                              Icon(
                                                Icons.pets,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest1 ==
                                                'outdoor activities')
                                              Icon(
                                                Icons.directions_run,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest1 ==
                                                'nights out')
                                              Icon(
                                                Icons.mode_night,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest1 ==
                                                'reading')
                                              Icon(
                                                Icons.menu_book,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest1 ==
                                                'shopping')
                                              FaIcon(
                                                FontAwesomeIcons.shoppingBag,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest1 ==
                                                'skating')
                                              Icon(
                                                Icons.roller_skating,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest1 ==
                                                'travelling')
                                              Icon(
                                                Icons.airplanemode_active,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest1 ==
                                                'walking')
                                              Icon(
                                                Icons.directions_walk,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest1 ==
                                                'workouts')
                                              FaIcon(
                                                FontAwesomeIcons.weightHanging,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest1 ==
                                                'wellness')
                                              Icon(
                                                Icons.spa,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest1 ==
                                                'voluntary work')
                                              Icon(
                                                Icons.volunteer_activism,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 8.0, 0.0, 0.0),
                                          child: Text(
                                            valueOrDefault<String>(
                                              columnUserRecord.interest1,
                                              'travelling',
                                            ),
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLargeFamily,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLargeIsCustom,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (columnUserRecord.interest2 ==
                                                'arts & crafts')
                                              FaIcon(
                                                FontAwesomeIcons.palette,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest2 ==
                                                'brunch')
                                              Icon(
                                                Icons.brunch_dining,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest2 ==
                                                'coffee')
                                              Icon(
                                                Icons.coffee_sharp,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest2 ==
                                                'deep chat')
                                              Icon(
                                                Icons.comment,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest2 ==
                                                'culture')
                                              Icon(
                                                Icons.museum,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest2 ==
                                                'day parties')
                                              Icon(
                                                Icons.wb_sunny,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest2 ==
                                                'dinner')
                                              Icon(
                                                Icons.dinner_dining,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest2 ==
                                                'drinks')
                                              Icon(
                                                Icons.wine_bar,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest2 ==
                                                'films')
                                              Icon(
                                                Icons.local_movies,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest2 ==
                                                'fitness classes')
                                              Icon(
                                                Icons.sports_gymnastics,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest2 ==
                                                'games')
                                              Icon(
                                                Icons.gamepad,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest2 ==
                                                'live music')
                                              Icon(
                                                Icons.music_note,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest2 ==
                                                'meet up with kids')
                                              Icon(
                                                Icons.child_friendly,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest2 ==
                                                'meet up with pets')
                                              Icon(
                                                Icons.pets,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest2 ==
                                                'outdoor activities')
                                              Icon(
                                                Icons.directions_run,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest2 ==
                                                'nights out')
                                              Icon(
                                                Icons.mode_night,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest2 ==
                                                'reading')
                                              Icon(
                                                Icons.menu_book,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest2 ==
                                                'shopping')
                                              FaIcon(
                                                FontAwesomeIcons.shoppingBag,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest2 ==
                                                'skating')
                                              Icon(
                                                Icons.roller_skating,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest2 ==
                                                'travelling')
                                              Icon(
                                                Icons.airplanemode_active,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest2 ==
                                                'walking')
                                              Icon(
                                                Icons.directions_walk,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest2 ==
                                                'workouts')
                                              FaIcon(
                                                FontAwesomeIcons.weightHanging,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest2 ==
                                                'wellness')
                                              Icon(
                                                Icons.spa,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest2 ==
                                                'voluntary work')
                                              Icon(
                                                Icons.volunteer_activism,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 8.0, 0.0, 0.0),
                                          child: Text(
                                            valueOrDefault<String>(
                                              columnUserRecord.interest2,
                                              'arts & crafts',
                                            ),
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLargeFamily,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLargeIsCustom,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (columnUserRecord.interest3 ==
                                                'arts & crafts')
                                              FaIcon(
                                                FontAwesomeIcons.palette,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest3 ==
                                                'brunch')
                                              Icon(
                                                Icons.brunch_dining,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest3 ==
                                                'coffee')
                                              Icon(
                                                Icons.coffee_sharp,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest3 ==
                                                'deep chat')
                                              Icon(
                                                Icons.comment,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest3 ==
                                                'culture')
                                              Icon(
                                                Icons.museum,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest3 ==
                                                'day parties')
                                              Icon(
                                                Icons.wb_sunny,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest3 ==
                                                'dinner')
                                              Icon(
                                                Icons.dinner_dining,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest3 ==
                                                'drinks')
                                              Icon(
                                                Icons.wine_bar,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest3 ==
                                                'films')
                                              Icon(
                                                Icons.local_movies,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest3 ==
                                                'fitness classes')
                                              Icon(
                                                Icons.sports_gymnastics,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest3 ==
                                                'games')
                                              Icon(
                                                Icons.gamepad,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest3 ==
                                                'live music')
                                              Icon(
                                                Icons.music_note,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest3 ==
                                                'meet up with kids')
                                              Icon(
                                                Icons.child_friendly,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest3 ==
                                                'meet up with pets')
                                              Icon(
                                                Icons.pets,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest3 ==
                                                'outdoor activities')
                                              Icon(
                                                Icons.directions_run,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest3 ==
                                                'nights out')
                                              Icon(
                                                Icons.mode_night,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest3 ==
                                                'reading')
                                              Icon(
                                                Icons.menu_book,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest3 ==
                                                'shopping')
                                              FaIcon(
                                                FontAwesomeIcons.shoppingBag,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest3 ==
                                                'skating')
                                              Icon(
                                                Icons.roller_skating,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest3 ==
                                                'travelling')
                                              Icon(
                                                Icons.airplanemode_active,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest3 ==
                                                'walking')
                                              Icon(
                                                Icons.directions_walk,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest3 ==
                                                'workouts')
                                              FaIcon(
                                                FontAwesomeIcons.weightHanging,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest3 ==
                                                'wellness')
                                              Icon(
                                                Icons.spa,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest3 ==
                                                'voluntary work')
                                              Icon(
                                                Icons.volunteer_activism,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 8.0, 0.0, 0.0),
                                          child: Text(
                                            valueOrDefault<String>(
                                              columnUserRecord.interest3,
                                              'skating',
                                            ),
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (columnUserRecord.interest4 ==
                                                'arts & crafts')
                                              FaIcon(
                                                FontAwesomeIcons.palette,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest4 ==
                                                'brunch')
                                              Icon(
                                                Icons.brunch_dining,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest4 ==
                                                'coffee')
                                              Icon(
                                                Icons.coffee_sharp,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest4 ==
                                                'deep chat')
                                              Icon(
                                                Icons.comment,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest4 ==
                                                'culture')
                                              Icon(
                                                Icons.museum,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest4 ==
                                                'day parties')
                                              Icon(
                                                Icons.wb_sunny,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest4 ==
                                                'dinner')
                                              Icon(
                                                Icons.dinner_dining,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest4 ==
                                                'drinks')
                                              Icon(
                                                Icons.wine_bar,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest4 ==
                                                'films')
                                              Icon(
                                                Icons.local_movies,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest4 ==
                                                'fitness classes')
                                              Icon(
                                                Icons.sports_gymnastics,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest4 ==
                                                'games')
                                              Icon(
                                                Icons.gamepad,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest4 ==
                                                'live music')
                                              Icon(
                                                Icons.music_note,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest4 ==
                                                'meet up with kids')
                                              Icon(
                                                Icons.child_friendly,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest4 ==
                                                'meet up with pets')
                                              Icon(
                                                Icons.pets,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest4 ==
                                                'outdoor activities')
                                              Icon(
                                                Icons.directions_run,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest4 ==
                                                'nights out')
                                              Icon(
                                                Icons.mode_night,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest4 ==
                                                'reading')
                                              Icon(
                                                Icons.menu_book,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest4 ==
                                                'shopping')
                                              FaIcon(
                                                FontAwesomeIcons.shoppingBag,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest4 ==
                                                'skating')
                                              Icon(
                                                Icons.roller_skating,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest4 ==
                                                'travelling')
                                              Icon(
                                                Icons.airplanemode_active,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest4 ==
                                                'walking')
                                              Icon(
                                                Icons.directions_walk,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest4 ==
                                                'workouts')
                                              FaIcon(
                                                FontAwesomeIcons.weightHanging,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest4 ==
                                                'wellness')
                                              Icon(
                                                Icons.spa,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                            if (columnUserRecord.interest4 ==
                                                'voluntary work')
                                              Icon(
                                                Icons.volunteer_activism,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 44.0,
                                              ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 8.0, 0.0, 0.0),
                                          child: Text(
                                            valueOrDefault<String>(
                                              columnUserRecord.interest4,
                                              'chatting',
                                            ),
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLargeFamily,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLargeIsCustom,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(width: 10.0)),
                            ).animateOnPageLoad(
                                animationsMap['rowOnPageLoadAnimation2']!),
                          ],
                        ),
                      ),
                      Divider(
                        height: 32.0,
                        thickness: 1.5,
                        color: FlutterFlowTheme.of(context).alternate,
                      ).animateOnPageLoad(
                          animationsMap['dividerOnPageLoadAnimation3']!),
                      if ((columnUserRecord.prompt2question != null &&
                              columnUserRecord.prompt2question != '') &&
                          (columnUserRecord.prompt2nswer != null &&
                              columnUserRecord.prompt2nswer != ''))
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Visibility(
                              visible: (columnUserRecord.prompt2question !=
                                          null &&
                                      columnUserRecord.prompt2question != '') &&
                                  (columnUserRecord.prompt2nswer != null &&
                                      columnUserRecord.prompt2nswer != ''),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 2.0,
                                  ),
                                ),
                                child: Align(
                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24.0, 16.0, 16.0, 16.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 10.0),
                                            child: Text(
                                              valueOrDefault<String>(
                                                columnUserRecord
                                                    .prompt2question,
                                                'one word to describe me is',
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleLarge
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleLargeFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .titleLargeIsCustom,
                                                  ),
                                            ),
                                          ),
                                          Text(
                                            valueOrDefault<String>(
                                              columnUserRecord.prompt2nswer,
                                              'an absolute vibe!',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ).animateOnPageLoad(animationsMap[
                                  'containerOnPageLoadAnimation2']!),
                            ),
                          ),
                        ),
                      if ((columnUserRecord.prompt2question != null &&
                              columnUserRecord.prompt2question != '') &&
                          (columnUserRecord.prompt2nswer != null &&
                              columnUserRecord.prompt2nswer != ''))
                        Divider(
                          height: 30.0,
                          thickness: 1.5,
                          color: FlutterFlowTheme.of(context).alternate,
                        ).animateOnPageLoad(
                            animationsMap['dividerOnPageLoadAnimation4']!),
                      if (columnUserRecord.bio != null &&
                          columnUserRecord.bio != '')
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(),
                          child: Visibility(
                            visible: columnUserRecord.bio != null &&
                                columnUserRecord.bio != '',
                            child: Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 0.0, 15.0, 0.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 20.0),
                                        child: Text(
                                          'more about me',
                                          style: FlutterFlowTheme.of(context)
                                              .displaySmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .displaySmallFamily,
                                                fontSize: 27.0,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .displaySmallIsCustom,
                                              ),
                                        ).animateOnPageLoad(animationsMap[
                                            'textOnPageLoadAnimation3']!),
                                      ),
                                      Text(
                                        columnUserRecord.bio,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLargeFamily,
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .bodyLargeIsCustom,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (columnUserRecord.bio != null &&
                          columnUserRecord.bio != '')
                        Divider(
                          height: 32.0,
                          thickness: 1.5,
                          color: FlutterFlowTheme.of(context).alternate,
                        ).animateOnPageLoad(
                            animationsMap['dividerOnPageLoadAnimation5']!),
                      if ((columnUserRecord.prompt3question != null &&
                              columnUserRecord.prompt3question != '') &&
                          (columnUserRecord.prompt3answer != null &&
                              columnUserRecord.prompt3answer != ''))
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 15.0, 15.0, 15.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 2.0,
                                ),
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(-1.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 16.0, 16.0, 16.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 10.0),
                                          child: Text(
                                            valueOrDefault<String>(
                                              columnUserRecord.prompt3question,
                                              'one word to describe me is',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .titleLarge
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleLargeFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .titleLargeIsCustom,
                                                ),
                                          ),
                                        ),
                                        Text(
                                          valueOrDefault<String>(
                                            columnUserRecord.prompt3answer,
                                            'an absolute vibe!',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ).animateOnPageLoad(animationsMap[
                                'containerOnPageLoadAnimation3']!),
                          ),
                        ),
                      if ((columnUserRecord.prompt3question != null &&
                              columnUserRecord.prompt3question != '') &&
                          (columnUserRecord.prompt3answer != null &&
                              columnUserRecord.prompt3answer != ''))
                        Divider(
                          height: 32.0,
                          thickness: 1.5,
                          color: FlutterFlowTheme.of(context).alternate,
                        ).animateOnPageLoad(
                            animationsMap['dividerOnPageLoadAnimation6']!),
                      if (widget!.throughUserProfile == null ||
                          widget!.throughUserProfile == '')
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 30.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 30.0, 0.0, 30.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15.0, 0.0, 0.0, 0.0),
                                        child: Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.75,
                                          height: 55.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                            border: Border.all(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              width: 2.0,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          15.0, 0.0, 8.0, 0.0),
                                                  child: TextFormField(
                                                    controller: _model
                                                        .newTextfeildTextController,
                                                    focusNode: _model
                                                        .newTextfeildFocusNode,
                                                    autofocus: false,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMediumIsCustom,
                                                              ),
                                                      hintText:
                                                          'send a msg or wave to connect',
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMediumIsCustom,
                                                              ),
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      focusedErrorBorder:
                                                          InputBorder.none,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                                    cursorColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                    validator: _model
                                                        .newTextfeildTextControllerValidator
                                                        .asValidator(context),
                                                  ),
                                                ),
                                              ),
                                              if (!(currentUserDocument
                                                              ?.messageSent
                                                              ?.toList() ??
                                                          [])
                                                      .contains(columnUserRecord
                                                          .reference) &&
                                                  !columnUserRecord.messageSent
                                                      .contains(
                                                          currentUserReference))
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 12.0, 0.0),
                                                  child: AuthUserStreamWidget(
                                                    builder: (context) =>
                                                        FlutterFlowIconButton(
                                                      borderRadius: 30.0,
                                                      buttonSize: 40.0,
                                                      fillColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      icon: Icon(
                                                        Icons.send,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        size: 20.0,
                                                      ),
                                                      onPressed: () async {
                                                        logFirebaseEvent(
                                                            'POTENTIAL_MATCHES_PROFILE_send_ICN_ON_TA');
                                                        if (_model.newTextfeildTextController
                                                                    .text !=
                                                                null &&
                                                            _model.newTextfeildTextController
                                                                    .text !=
                                                                '') {
                                                          logFirebaseEvent(
                                                              'IconButton_backend_call');

                                                          await currentUserReference!
                                                              .update({
                                                            ...mapToFirestore(
                                                              {
                                                                'messageSent':
                                                                    FieldValue
                                                                        .arrayUnion([
                                                                  columnUserRecord
                                                                      .reference
                                                                ]),
                                                              },
                                                            ),
                                                          });
                                                          logFirebaseEvent(
                                                              'IconButton_backend_call');

                                                          var chatRecordReference =
                                                              ChatRecord
                                                                  .collection
                                                                  .doc();
                                                          await chatRecordReference
                                                              .set(
                                                                  createChatRecordData(
                                                            userA:
                                                                currentUserReference,
                                                            userB:
                                                                columnUserRecord
                                                                    .reference,
                                                            lastMessage: _model
                                                                .newTextfeildTextController
                                                                .text,
                                                            lastmessageTime:
                                                                getCurrentTimestamp,
                                                            isRequested: true,
                                                          ));
                                                          _model.chat = ChatRecord
                                                              .getDocumentFromData(
                                                                  createChatRecordData(
                                                                    userA:
                                                                        currentUserReference,
                                                                    userB: columnUserRecord
                                                                        .reference,
                                                                    lastMessage:
                                                                        _model
                                                                            .newTextfeildTextController
                                                                            .text,
                                                                    lastmessageTime:
                                                                        getCurrentTimestamp,
                                                                    isRequested:
                                                                        true,
                                                                  ),
                                                                  chatRecordReference);
                                                          if (columnUserRecord
                                                              .isNotificationEnabled) {
                                                            logFirebaseEvent(
                                                                'IconButton_trigger_push_notification');
                                                            triggerPushNotification(
                                                              notificationTitle:
                                                                  'Someone has reached out',
                                                              notificationText:
                                                                  '${currentUserDisplayName} wants to connect',
                                                              notificationSound:
                                                                  'default',
                                                              userRefs: [
                                                                widget!.userRef!
                                                              ],
                                                              initialPageName:
                                                                  'chatRequest',
                                                              parameterData: {
                                                                'chatRef': _model
                                                                    .chat
                                                                    ?.reference,
                                                              },
                                                            );
                                                          }
                                                          logFirebaseEvent(
                                                              'IconButton_backend_call');

                                                          await NotificationRecord
                                                              .collection
                                                              .doc()
                                                              .set({
                                                            ...createNotificationRecordData(
                                                              title:
                                                                  '${currentUserDisplayName} wants to connect',
                                                              sentBy:
                                                                  currentUserReference,
                                                              user: widget!
                                                                  .userRef,
                                                              notificationType:
                                                                  'request',
                                                              chat: _model.chat
                                                                  ?.reference,
                                                              seen: false,
                                                            ),
                                                            ...mapToFirestore(
                                                              {
                                                                'sent_at':
                                                                    FieldValue
                                                                        .serverTimestamp(),
                                                              },
                                                            ),
                                                          });
                                                          logFirebaseEvent(
                                                              'IconButton_show_snack_bar');
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                'You have sent a message',
                                                                style:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                ),
                                                              ),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      4000),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                            ),
                                                          );
                                                          logFirebaseEvent(
                                                              'IconButton_navigate_to');

                                                          context.pushNamed(
                                                              PotentialConnectionsWidget
                                                                  .routeName);
                                                        } else {
                                                          if (_model.newTextfeildTextController
                                                                      .text ==
                                                                  null ||
                                                              _model.newTextfeildTextController
                                                                      .text ==
                                                                  '') {
                                                            logFirebaseEvent(
                                                                'IconButton_show_snack_bar');
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'Please write a message',
                                                                  style:
                                                                      TextStyle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                  ),
                                                                ),
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        4000),
                                                                backgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                              ),
                                                            );
                                                          } else {
                                                            logFirebaseEvent(
                                                                'IconButton_show_snack_bar');
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'You\'ve already reached out',
                                                                  style:
                                                                      TextStyle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                  ),
                                                                ),
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        4000),
                                                                backgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                              ),
                                                            );
                                                          }
                                                        }

                                                        safeSetState(() {});
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              if ((currentUserDocument
                                                              ?.messageSent
                                                              ?.toList() ??
                                                          [])
                                                      .contains(columnUserRecord
                                                          .reference) ||
                                                  columnUserRecord.messageSent
                                                      .contains(
                                                          currentUserReference))
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 12.0, 0.0),
                                                  child: AuthUserStreamWidget(
                                                    builder: (context) =>
                                                        FlutterFlowIconButton(
                                                      borderRadius: 30.0,
                                                      buttonSize: 40.0,
                                                      fillColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .warning,
                                                      icon: Icon(
                                                        Icons.send,
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        size: 20.0,
                                                      ),
                                                      onPressed: () async {
                                                        logFirebaseEvent(
                                                            'POTENTIAL_MATCHES_PROFILE_send_ICN_ON_TA');
                                                        if ((currentUserDocument
                                                                    ?.messageSent
                                                                    ?.toList() ??
                                                                [])
                                                            .contains(
                                                                columnUserRecord
                                                                    .reference)) {
                                                          logFirebaseEvent(
                                                              'IconButton_show_snack_bar');
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                'You\'ve already reached out to this profile',
                                                                style:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                ),
                                                              ),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      4000),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                            ),
                                                          );
                                                        } else {
                                                          logFirebaseEvent(
                                                              'IconButton_show_snack_bar');
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                'This profile has already reached out to you - check your Chat Requests',
                                                                style:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                ),
                                                              ),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      4000),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      if (!(currentUserDocument?.messageSent
                                                      ?.toList() ??
                                                  [])
                                              .contains(
                                                  columnUserRecord.reference) &&
                                          !columnUserRecord.messageSent
                                              .contains(currentUserReference))
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 0.0, 0.0),
                                          child: AuthUserStreamWidget(
                                            builder: (context) => InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                logFirebaseEvent(
                                                    'POTENTIAL_MATCHES_PROFILE_Container_2phd');
                                                if (!(currentUserDocument
                                                            ?.messageSent
                                                            ?.toList() ??
                                                        [])
                                                    .contains(columnUserRecord
                                                        .reference)) {
                                                  logFirebaseEvent(
                                                      'Container_backend_call');

                                                  await currentUserReference!
                                                      .update({
                                                    ...mapToFirestore(
                                                      {
                                                        'messageSent':
                                                            FieldValue
                                                                .arrayUnion([
                                                          columnUserRecord
                                                              .reference
                                                        ]),
                                                      },
                                                    ),
                                                  });
                                                  logFirebaseEvent(
                                                      'Container_backend_call');

                                                  var chatRecordReference =
                                                      ChatRecord.collection
                                                          .doc();
                                                  await chatRecordReference
                                                      .set(createChatRecordData(
                                                    userA: currentUserReference,
                                                    userB: columnUserRecord
                                                        .reference,
                                                    lastMessage:
                                                        '${currentUserDisplayName} sent you a wave',
                                                    lastmessageTime:
                                                        getCurrentTimestamp,
                                                    isRequested: true,
                                                  ));
                                                  _model.message = ChatRecord
                                                      .getDocumentFromData(
                                                          createChatRecordData(
                                                            userA:
                                                                currentUserReference,
                                                            userB:
                                                                columnUserRecord
                                                                    .reference,
                                                            lastMessage:
                                                                '${currentUserDisplayName} sent you a wave',
                                                            lastmessageTime:
                                                                getCurrentTimestamp,
                                                            isRequested: true,
                                                          ),
                                                          chatRecordReference);
                                                  if (columnUserRecord
                                                      .isNotificationEnabled) {
                                                    logFirebaseEvent(
                                                        'Container_trigger_push_notification');
                                                    triggerPushNotification(
                                                      notificationTitle:
                                                          'Someone has reached out',
                                                      notificationText:
                                                          '${currentUserDisplayName} wants to connect',
                                                      notificationSound:
                                                          'default',
                                                      userRefs: [
                                                        columnUserRecord
                                                            .reference
                                                      ],
                                                      initialPageName:
                                                          'chatRequest',
                                                      parameterData: {
                                                        'chatRef': _model
                                                            .message?.reference,
                                                      },
                                                    );
                                                  }
                                                  logFirebaseEvent(
                                                      'Container_backend_call');

                                                  await NotificationRecord
                                                      .collection
                                                      .doc()
                                                      .set({
                                                    ...createNotificationRecordData(
                                                      title:
                                                          '${currentUserDisplayName} wants to connect',
                                                      sentBy:
                                                          currentUserReference,
                                                      user: widget!.userRef,
                                                      notificationType:
                                                          'request',
                                                      chat: _model
                                                          .message?.reference,
                                                      seen: false,
                                                    ),
                                                    ...mapToFirestore(
                                                      {
                                                        'sent_at': FieldValue
                                                            .serverTimestamp(),
                                                      },
                                                    ),
                                                  });
                                                  logFirebaseEvent(
                                                      'Container_navigate_to');

                                                  context.pushNamed(
                                                    PotentialConnectionsWidget
                                                        .routeName,
                                                    extra: <String, dynamic>{
                                                      '__transition_info__':
                                                          TransitionInfo(
                                                        hasTransition: true,
                                                        transitionType:
                                                            PageTransitionType
                                                                .fade,
                                                        duration: Duration(
                                                            milliseconds: 0),
                                                      ),
                                                    },
                                                  );

                                                  logFirebaseEvent(
                                                      'Container_show_snack_bar');
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'You have waved ',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                        ),
                                                      ),
                                                      duration: Duration(
                                                          milliseconds: 2000),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                    ),
                                                  );
                                                } else {
                                                  logFirebaseEvent(
                                                      'Container_show_snack_bar');
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'You\'ve already reached out to this profile',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                        ),
                                                      ),
                                                      duration: Duration(
                                                          milliseconds: 4000),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                    ),
                                                  );
                                                }

                                                safeSetState(() {});
                                              },
                                              child: Container(
                                                width: 40.0,
                                                height: 40.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondary,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondary,
                                                    width: 2.5,
                                                  ),
                                                ),
                                                child: Icon(
                                                  Icons.waving_hand,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .accent1,
                                                  size: 20.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      if ((currentUserDocument?.messageSent
                                                      ?.toList() ??
                                                  [])
                                              .contains(
                                                  columnUserRecord.reference) ||
                                          columnUserRecord.messageSent
                                              .contains(currentUserReference))
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 0.0, 0.0),
                                          child: AuthUserStreamWidget(
                                            builder: (context) => InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                logFirebaseEvent(
                                                    'POTENTIAL_MATCHES_PROFILE_Container_736o');
                                                if ((currentUserDocument
                                                            ?.messageSent
                                                            ?.toList() ??
                                                        [])
                                                    .contains(columnUserRecord
                                                        .reference)) {
                                                  logFirebaseEvent(
                                                      'Container_show_snack_bar');
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'You\'ve already reached out to this profile',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                        ),
                                                      ),
                                                      duration: Duration(
                                                          milliseconds: 4000),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                    ),
                                                  );
                                                } else {
                                                  logFirebaseEvent(
                                                      'Container_show_snack_bar');
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'This profile has already reached out to you - check your Chat Requests',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                        ),
                                                      ),
                                                      duration: Duration(
                                                          milliseconds: 4000),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                    ),
                                                  );
                                                }
                                              },
                                              child: Container(
                                                width: 40.0,
                                                height: 40.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .warning,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.waving_hand,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  size: 20.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

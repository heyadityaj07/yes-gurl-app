import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/chat/pausealert/pausealert_widget.dart';
import '/components/empty_widget.dart';
import '/components/navbar_widget.dart';
import '/components/no_match_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/link_up/link_up_message/link_up_message_widget.dart';
import 'dart:async';
import 'dart:math';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'potential_connections_model.dart';
export 'potential_connections_model.dart';

class PotentialConnectionsWidget extends StatefulWidget {
  const PotentialConnectionsWidget({super.key});

  static String routeName = 'potentialConnections';
  static String routePath = '/potentialConnections';

  @override
  State<PotentialConnectionsWidget> createState() =>
      _PotentialConnectionsWidgetState();
}

class _PotentialConnectionsWidgetState extends State<PotentialConnectionsWidget>
    with TickerProviderStateMixin {
  late PotentialConnectionsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PotentialConnectionsModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'potentialConnections'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('POTENTIAL_CONNECTIONS_potentialConnectio');
      logFirebaseEvent('potentialConnections_update_app_state');
      FFAppState().isScreenActive = true;
      safeSetState(() {});
      logFirebaseEvent('potentialConnections_custom_action');
      unawaited(
        () async {
          await actions.recordUserActivity();
        }(),
      );
      logFirebaseEvent('potentialConnections_action_block');
      await action_blocks.notificationRequest(context);
      safeSetState(() {});
      if (valueOrDefault<bool>(currentUserDocument?.isDeactivated, false) ==
          false) {
        logFirebaseEvent('potentialConnections_backend_call');
        _model.currentUserDoc =
            await UserRecord.getDocumentOnce(currentUserReference!);
        logFirebaseEvent('potentialConnections_backend_call');

        await currentUserReference!.update({
          ...createUserRecordData(
            potentialProfileRead: false,
          ),
          ...mapToFirestore(
            {
              'offline_user_time': FieldValue.delete(),
            },
          ),
        });
        if (currentUserReference != null) {
          if (valueOrDefault(currentUserDocument?.updatedTime, '') ==
              dateTimeFormat("MMM d, yyyy", getCurrentTimestamp)) {
            logFirebaseEvent('potentialConnections_custom_action');
            _model.todayuserList = await actions.getMatchingTodayUserProfiles(
              (currentUserDocument?.todayUserList?.toList() ?? []).toList(),
              _model.currentUserDoc,
            );
            logFirebaseEvent('potentialConnections_update_page_state');
            _model.userList =
                _model.todayuserList!.toList().cast<DocumentReference>();
            safeSetState(() {});
          } else {
            logFirebaseEvent('potentialConnections_backend_call');
            _model.potentialConnection =
                await FetchUsersPotentialConnectionsCall.call(
              token: currentJwtToken,
            );

            if ((_model.potentialConnection?.succeeded ?? true)) {
              logFirebaseEvent('potentialConnections_update_app_state');

              FFAppState().update(() {});
              logFirebaseEvent('potentialConnections_update_page_state');
              _model.userList =
                  (currentUserDocument?.todayUserList?.toList() ?? [])
                      .toList()
                      .cast<DocumentReference>();
              safeSetState(() {});
            }
          }

          logFirebaseEvent('potentialConnections_rebuild_page');
          safeSetState(() {});
        }
      }
      logFirebaseEvent('potentialConnections_update_page_state');
      _model.isLoading = false;
      safeSetState(() {});
      if ((currentUserDocument?.blockUserList?.toList() ?? []).isNotEmpty) {
        logFirebaseEvent('potentialConnections_backend_call');

        await currentUserReference!.update({
          ...mapToFirestore(
            {
              'blocked_users': functions.mergeBlockdUserList(
                  (currentUserDocument?.blockedUsers?.toList() ?? []).toList(),
                  (currentUserDocument?.blockUserList?.toList() ?? [])
                      .toList()),
              'block_user_list': FieldValue.delete(),
            },
          ),
        });
      }
      logFirebaseEvent('potentialConnections_update_app_state');

      FFAppState().update(() {});
    });

    animationsMap.addAll({
      'textOnPageLoadAnimation': AnimationInfo(
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
            begin: Offset(30.0, 0.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'dividerOnPageLoadAnimation': AnimationInfo(
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
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: Offset(0.0, 40.0),
            end: Offset(0.0, 0.0),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: Offset(0.8, 0.8),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: Offset(0.0, 40.0),
            end: Offset(0.0, 0.0),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: Offset(0.8, 0.8),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: Offset(0.0, 40.0),
            end: Offset(0.0, 0.0),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: Offset(0.8, 0.8),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation4': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: Offset(0.0, 40.0),
            end: Offset(0.0, 0.0),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: Offset(0.8, 0.8),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation5': AnimationInfo(
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
            begin: Offset(90.0, 0.0),
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
      logFirebaseEvent('POTENTIAL_CONNECTIONS_potentialConnectio');
      logFirebaseEvent('potentialConnections_backend_call');

      await currentUserReference!.update(createUserRecordData(
        offlineUserTime: getCurrentTimestamp,
      ));
      logFirebaseEvent('potentialConnections_update_app_state');
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
          automaticallyImplyLeading: false,
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
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
              child: Stack(
                alignment: AlignmentDirectional(1.0, -1.0),
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
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
                            'POTENTIAL_CONNECTIONS_notifications_none');
                        logFirebaseEvent('IconButton_navigate_to');

                        context.pushNamed(NotificationWidget.routeName);
                      },
                    ),
                  ),
                  if (currentUserReference != null)
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
                        List<NotificationRecord>
                            containerNotificationRecordList = snapshot.data!;

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
                                      color:
                                          FlutterFlowTheme.of(context).primary,
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  decoration: BoxDecoration(),
                  child: Builder(
                    builder: (context) {
                      if (valueOrDefault<bool>(
                              currentUserDocument?.isDeactivated, false) ==
                          false) {
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 12.0, 15.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 0.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'potential connections',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .displaySmall
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .displaySmallFamily,
                                                        fontSize: 25.0,
                                                        letterSpacing: 1.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .displaySmallIsCustom,
                                                      ),
                                            ),
                                            Text(
                                              'refreshes everyday so act today',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumIsCustom,
                                                  ),
                                            ).animateOnPageLoad(animationsMap[
                                                'textOnPageLoadAnimation']!),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 8.0),
                                child: Container(
                                  decoration: BoxDecoration(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(),
                                        child: Visibility(
                                          visible: ((currentUserDocument
                                                              ?.todayUserList
                                                              ?.toList() ??
                                                          [])
                                                      .length !=
                                                  0) &&
                                              ((valueOrDefault<bool>(
                                                          currentUserDocument
                                                              ?.hideProfile,
                                                          false) !=
                                                      null) &&
                                                  (valueOrDefault<bool>(
                                                          currentUserDocument
                                                              ?.hideProfile,
                                                          false) ==
                                                      false)),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              if ((valueOrDefault<bool>(
                                                          currentUserDocument
                                                              ?.isPromptPass,
                                                          false) ==
                                                      true) &&
                                                  (valueOrDefault<bool>(
                                                          currentUserDocument
                                                              ?.isInterestPass,
                                                          false) ==
                                                      true))
                                                Divider(
                                                  height: 15.0,
                                                  thickness: 1.0,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                ).animateOnPageLoad(animationsMap[
                                                    'dividerOnPageLoadAnimation']!),
                                              if ((valueOrDefault<bool>(
                                                          currentUserDocument
                                                              ?.isPromptPass,
                                                          false) ==
                                                      true) &&
                                                  (valueOrDefault<bool>(
                                                          currentUserDocument
                                                              ?.isInterestPass,
                                                          false) ==
                                                      true))
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    15.0,
                                                                    5.0,
                                                                    15.0,
                                                                    5.0),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            logFirebaseEvent(
                                                                'POTENTIAL_CONNECTIONS_Container_xgg98mbb');
                                                            logFirebaseEvent(
                                                                'Container_navigate_to');

                                                            context.pushNamed(
                                                                ProfileSettingsReportWidget
                                                                    .routeName);
                                                          },
                                                          child: Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.75,
                                                            height: 150.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondary,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          15.0,
                                                                          20.0,
                                                                          12.0,
                                                                          20.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        AutoSizeText(
                                                                      'experiencing an issue? report it here and we\'ll take care of it',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      minFontSize:
                                                                          10.0,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineSmall
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).headlineSmallFamily,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            useGoogleFonts:
                                                                                !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ).animateOnPageLoad(
                                                            animationsMap[
                                                                'containerOnPageLoadAnimation1']!),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    20.0,
                                                                    5.0,
                                                                    0.0,
                                                                    5.0),
                                                        child: Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.75,
                                                          height: 150.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .tertiary,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        15.0,
                                                                        20.0,
                                                                        12.0,
                                                                        20.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                AutoSizeText(
                                                                  'you will see three new women a day',
                                                                  minFontSize:
                                                                      10.0,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineSmall
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).headlineSmallFamily,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        useGoogleFonts:
                                                                            !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ).animateOnPageLoad(
                                                            animationsMap[
                                                                'containerOnPageLoadAnimation2']!),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    15.0,
                                                                    5.0,
                                                                    15.0,
                                                                    5.0),
                                                        child: Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.75,
                                                          height: 150.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondary,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        15.0,
                                                                        20.0,
                                                                        12.0,
                                                                        20.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      AutoSizeText(
                                                                    'you are most likely to get on with compatible and possible types',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    minFontSize:
                                                                        10.0,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineSmall
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).headlineSmallFamily,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          useGoogleFonts:
                                                                              !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ).animateOnPageLoad(
                                                            animationsMap[
                                                                'containerOnPageLoadAnimation3']!),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    15.0,
                                                                    5.0,
                                                                    15.0,
                                                                    5.0),
                                                        child: Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.75,
                                                          height: 150.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .tertiary,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        15.0,
                                                                        20.0,
                                                                        12.0,
                                                                        20.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      AutoSizeText(
                                                                    'if you see someone you want to connect with, act today',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    minFontSize:
                                                                        10.0,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineSmall
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).headlineSmallFamily,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          useGoogleFonts:
                                                                              !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ).animateOnPageLoad(
                                                            animationsMap[
                                                                'containerOnPageLoadAnimation4']!),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            if (valueOrDefault<bool>(
                                                    currentUserDocument
                                                        ?.hideProfile,
                                                    false) !=
                                                false)
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 15.0, 0.0, 0.0),
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                20.0,
                                                                135.0,
                                                                20.0,
                                                                0.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      30.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Stack(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.1),
                                                                  children: [
                                                                    Opacity(
                                                                      opacity:
                                                                          0.6,
                                                                      child:
                                                                          Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            FaIcon(
                                                                          FontAwesomeIcons
                                                                              .solidCircle,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          size:
                                                                              55.0,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Icon(
                                                                      Icons
                                                                          .do_disturb_sharp,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      size:
                                                                          50.0,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Text(
                                                          'you\'re in hiding',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .displaySmall
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .displaySmallFamily,
                                                                fontSize: 27.0,
                                                                letterSpacing:
                                                                    1.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .displaySmallIsCustom,
                                                              ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      10.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: RichText(
                                                            textScaler:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .textScaler,
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      'you can\'t see any potential connections, and they can\'t see you, because you\'ve hiden your profile',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        useGoogleFonts:
                                                                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                      ),
                                                                )
                                                              ],
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .bodyMediumIsCustom,
                                                                  ),
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      30.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              logFirebaseEvent(
                                                                  'POTENTIAL_CONNECTIONS_showProfile_ON_TAP');
                                                              logFirebaseEvent(
                                                                  'showProfile_backend_call');

                                                              await currentUserReference!
                                                                  .update(
                                                                      createUserRecordData(
                                                                hideProfile:
                                                                    false,
                                                              ));
                                                              logFirebaseEvent(
                                                                  'showProfile_backend_call');
                                                              _model.potentialConnectionshide =
                                                                  await FetchUsersPotentialConnectionsCall
                                                                      .call(
                                                                token:
                                                                    currentJwtToken,
                                                              );

                                                              if ((_model
                                                                      .potentialConnectionshide
                                                                      ?.succeeded ??
                                                                  true)) {
                                                                logFirebaseEvent(
                                                                    'showProfile_update_app_state');

                                                                FFAppState()
                                                                    .update(
                                                                        () {});
                                                                logFirebaseEvent(
                                                                    'showProfile_update_page_state');
                                                                _model
                                                                    .userList = (currentUserDocument
                                                                            ?.todayUserList
                                                                            ?.toList() ??
                                                                        [])
                                                                    .toList()
                                                                    .cast<
                                                                        DocumentReference>();
                                                                safeSetState(
                                                                    () {});
                                                              }
                                                              logFirebaseEvent(
                                                                  'showProfile_update_app_state');

                                                              safeSetState(
                                                                  () {});

                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            text:
                                                                'show my profile',
                                                            options:
                                                                FFButtonOptions(
                                                              width: double
                                                                  .infinity,
                                                              height: 45.0,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(0.0),
                                                              iconPadding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).titleSmallFamily,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        useGoogleFonts:
                                                                            !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                      ),
                                                              elevation: 0.0,
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                width: 2.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            if ((valueOrDefault<bool>(
                                                        currentUserDocument
                                                            ?.isPromptPass,
                                                        false) !=
                                                    true) ||
                                                (valueOrDefault<bool>(
                                                        currentUserDocument
                                                            ?.isInterestPass,
                                                        false) !=
                                                    true))
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 15.0, 0.0, 0.0),
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                20.0,
                                                                135.0,
                                                                20.0,
                                                                0.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      30.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Stack(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.1),
                                                                  children: [
                                                                    Opacity(
                                                                      opacity:
                                                                          0.6,
                                                                      child:
                                                                          Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.49,
                                                                            1.25),
                                                                        child:
                                                                            FaIcon(
                                                                          FontAwesomeIcons
                                                                              .solidCircle,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          size:
                                                                              55.0,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Icon(
                                                                      Icons
                                                                          .error_outline_sharp,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      size:
                                                                          50.0,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Text(
                                                          'you\'re almost there',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .displaySmall
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .displaySmallFamily,
                                                                fontSize: 27.0,
                                                                letterSpacing:
                                                                    1.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .displaySmallIsCustom,
                                                              ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      20.0,
                                                                      10.0,
                                                                      20.0,
                                                                      0.0),
                                                          child: RichText(
                                                            textScaler:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .textScaler,
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      'you can\'t see any potential connections because your profile is incomplete',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        useGoogleFonts:
                                                                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                      ),
                                                                )
                                                              ],
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .bodyMediumIsCustom,
                                                                  ),
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      30.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              logFirebaseEvent(
                                                                  'POTENTIAL_CONNECTIONS_completeProfile_ON');
                                                              logFirebaseEvent(
                                                                  'completeProfile_navigate_to');

                                                              context.pushNamed(
                                                                  ProfileEditWidget
                                                                      .routeName);
                                                            },
                                                            text:
                                                                'complete my profile',
                                                            options:
                                                                FFButtonOptions(
                                                              width: double
                                                                  .infinity,
                                                              height: 45.0,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(0.0),
                                                              iconPadding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).titleSmallFamily,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        useGoogleFonts:
                                                                            !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                      ),
                                                              elevation: 0.0,
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                width: 2.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40.0),
                                                              hoverColor: Color(
                                                                  0xC6FE99AB),
                                                              hoverBorderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    0xC6FE99AB),
                                                                width: 2.0,
                                                              ),
                                                              hoverTextColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .accent1,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            if ((valueOrDefault<bool>(
                                                        currentUserDocument
                                                            ?.hideProfile,
                                                        false) !=
                                                    true) &&
                                                ((valueOrDefault<bool>(
                                                            currentUserDocument
                                                                ?.isPromptPass,
                                                            false) ==
                                                        true) &&
                                                    (valueOrDefault<bool>(
                                                            currentUserDocument
                                                                ?.isInterestPass,
                                                            false) ==
                                                        true)) &&
                                                !_model.isLoading)
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          16.0, 4.0, 16.0, 5.0),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final users = _model
                                                          .userList
                                                          .where((e) =>
                                                              (currentUserDocument
                                                                          ?.blockedUsers
                                                                          ?.toList() ??
                                                                      [])
                                                                  .contains(
                                                                      e) ==
                                                              false)
                                                          .toList();
                                                      if (users.isEmpty) {
                                                        return Center(
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height: 400.0,
                                                            child:
                                                                NoMatchWidget(),
                                                          ),
                                                        );
                                                      }

                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: List.generate(
                                                            users.length,
                                                            (usersIndex) {
                                                          final usersItem =
                                                              users[usersIndex];
                                                          return Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        8.0,
                                                                        0.0,
                                                                        8.0),
                                                            child:
                                                                StreamBuilder<
                                                                    UserRecord>(
                                                              stream: UserRecord
                                                                  .getDocument(
                                                                      usersItem),
                                                              builder: (context,
                                                                  snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width: 50,
                                                                      height:
                                                                          50,
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        valueColor:
                                                                            AlwaysStoppedAnimation<Color>(
                                                                          Colors
                                                                              .transparent,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }

                                                                final containerUserRecord =
                                                                    snapshot
                                                                        .data!;

                                                                return InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    logFirebaseEvent(
                                                                        'POTENTIAL_CONNECTIONS_Container_m4yy73c7');
                                                                    if (containerUserRecord
                                                                            .isDeactivated ==
                                                                        true) {
                                                                      logFirebaseEvent(
                                                                          'Container_bottom_sheet');
                                                                      await showModalBottomSheet(
                                                                        isScrollControlled:
                                                                            true,
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        enableDrag:
                                                                            false,
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              FocusScope.of(context).unfocus();
                                                                              FocusManager.instance.primaryFocus?.unfocus();
                                                                            },
                                                                            child:
                                                                                Padding(
                                                                              padding: MediaQuery.viewInsetsOf(context),
                                                                              child: LinkUpMessageWidget(
                                                                                description: 'They\'ve paused their account',
                                                                                title: '  ',
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ).then((value) =>
                                                                          safeSetState(
                                                                              () {}));
                                                                    } else {
                                                                      if ((currentUserDocument?.messageSent?.toList() ??
                                                                              [])
                                                                          .contains(
                                                                              usersItem)) {
                                                                        logFirebaseEvent(
                                                                            'Container_show_snack_bar');
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          SnackBar(
                                                                            content:
                                                                                Text(
                                                                              'You\'ve already reached out to this profile',
                                                                              style: TextStyle(
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                              ),
                                                                            ),
                                                                            duration:
                                                                                Duration(milliseconds: 4000),
                                                                            backgroundColor:
                                                                                FlutterFlowTheme.of(context).secondary,
                                                                          ),
                                                                        );
                                                                      } else {
                                                                        logFirebaseEvent(
                                                                            'Container_navigate_to');

                                                                        context
                                                                            .pushNamed(
                                                                          PotentialMatchesProfileWidget
                                                                              .routeName,
                                                                          queryParameters:
                                                                              {
                                                                            'userRef':
                                                                                serializeParam(
                                                                              usersItem,
                                                                              ParamType.DocumentReference,
                                                                            ),
                                                                          }.withoutNulls,
                                                                        );
                                                                      }
                                                                    }
                                                                  },
                                                                  child:
                                                                      Material(
                                                                    color: Colors
                                                                        .transparent,
                                                                    elevation:
                                                                        0.0,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              0.0),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          1.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        borderRadius:
                                                                            BorderRadius.circular(0.0),
                                                                      ),
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          if ((functions.getRecommendation(containerUserRecord.personalityType, valueOrDefault(currentUserDocument?.personalityType, '')).toString() == '0') ||
                                                                              (functions.getRecommendation(containerUserRecord.personalityType, valueOrDefault(currentUserDocument?.personalityType, '')).toString() == '1'))
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  if (functions.isValidUrl(containerUserRecord.displayImage) ?? true)
                                                                                    Stack(
                                                                                      children: [
                                                                                        if ((currentUserDocument?.messageSent?.toList() ?? []).contains(usersItem))
                                                                                          Container(
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Visibility(
                                                                                              visible: containerUserRecord.displayImage != null && containerUserRecord.displayImage != '',
                                                                                              child: Opacity(
                                                                                                opacity: 0.6,
                                                                                                child: Container(
                                                                                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                                  height: 200.0,
                                                                                                  child: custom_widgets.ImageView(
                                                                                                    width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                                    height: 200.0,
                                                                                                    imagePath: containerUserRecord.displayImage,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        if (!(currentUserDocument?.messageSent?.toList() ?? []).contains(usersItem))
                                                                                          Align(
                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                            child: Container(
                                                                                              decoration: BoxDecoration(),
                                                                                              child: Container(
                                                                                                width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                                height: 200.0,
                                                                                                child: custom_widgets.ImageView(
                                                                                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                                  height: 200.0,
                                                                                                  imagePath: containerUserRecord.displayImage,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                      ],
                                                                                    ),
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                                                                                    child: Text(
                                                                                      containerUserRecord.displayName,
                                                                                      style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                            fontFamily: FlutterFlowTheme.of(context).headlineSmallFamily,
                                                                                            color: (currentUserDocument?.messageSent?.toList() ?? []).contains(usersItem) ? Color(0x8357636C) : FlutterFlowTheme.of(context).primaryText,
                                                                                            letterSpacing: 0.0,
                                                                                            useGoogleFonts: !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                    child: Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        if (functions.getRecommendation(containerUserRecord.personalityType, valueOrDefault(currentUserDocument?.personalityType, '')).toString() != '0')
                                                                                          Icon(
                                                                                            Icons.favorite_sharp,
                                                                                            color: (currentUserDocument?.messageSent?.toList() ?? []).contains(usersItem) ? Color(0x7EFE99AB) : FlutterFlowTheme.of(context).primary,
                                                                                            size: 15.0,
                                                                                          ),
                                                                                        if (functions.getRecommendation(containerUserRecord.personalityType, valueOrDefault(currentUserDocument?.personalityType, '')).toString() == '0')
                                                                                          FaIcon(
                                                                                            FontAwesomeIcons.leaf,
                                                                                            color: (currentUserDocument?.messageSent?.toList() ?? []).contains(usersItem) ? Color(0x7EFE99AB) : FlutterFlowTheme.of(context).primary,
                                                                                            size: 15.0,
                                                                                          ),
                                                                                        if ((functions.getRecommendation(containerUserRecord.personalityType, valueOrDefault(currentUserDocument?.personalityType, '')).toString() != '1') && (functions.getRecommendation(containerUserRecord.personalityType, valueOrDefault(currentUserDocument?.personalityType, '')).toString() != '0'))
                                                                                          Icon(
                                                                                            Icons.question_mark,
                                                                                            color: (currentUserDocument?.messageSent?.toList() ?? []).contains(usersItem) ? Color(0x7EFE99AB) : FlutterFlowTheme.of(context).primary,
                                                                                            size: 15.0,
                                                                                          ),
                                                                                        Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                                          child: Text(
                                                                                            functions.getRecommendation(containerUserRecord.personalityType, valueOrDefault(currentUserDocument?.personalityType, '')).toString() == '0' ? 'compatible' : 'possible',
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                  color: (currentUserDocument?.messageSent?.toList() ?? []).contains(usersItem) ? Color(0x8357636C) : FlutterFlowTheme.of(context).primaryText,
                                                                                                  letterSpacing: 0.0,
                                                                                                  useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ).animateOnPageLoad(
                                                                    animationsMap[
                                                                        'containerOnPageLoadAnimation5']!);
                                                              },
                                                            ),
                                                          );
                                                        }),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return AuthUserStreamWidget(
                          builder: (context) => wrapWithModel(
                            model: _model.pausealertModel,
                            updateCallback: () => safeSetState(() {}),
                            child: PausealertWidget(
                              name: currentUserDisplayName,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              wrapWithModel(
                model: _model.navbarModel,
                updateCallback: () => safeSetState(() {}),
                child: NavbarWidget(
                  index: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

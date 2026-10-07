import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/loading_questions_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/personality_test2/exit_test/exit_test_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'test_model.dart';
export 'test_model.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  static String routeName = 'test';
  static String routePath = '/test';

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  late TestModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TestModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'test'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('TEST_PAGE_test_ON_INIT_STATE');
      logFirebaseEvent('test_update_page_state');
      _model.loading = true;
      safeSetState(() {});
      logFirebaseEvent('test_firestore_query');
      _model.questions = await queryQuestionsRecordOnce(
        queryBuilder: (questionsRecord) => questionsRecord.orderBy('orderBy'),
      );
      logFirebaseEvent('test_update_page_state');
      _model.index = 0;
      safeSetState(() {});
      logFirebaseEvent('test_update_app_state');
      FFAppState().ecount = 0;
      FFAppState().scount = 0;
      FFAppState().icount = 0;
      FFAppState().ncount = 0;
      FFAppState().tcount = 0;
      FFAppState().fcount = 0;
      FFAppState().jcount = 0;
      FFAppState().pcount = 0;
      FFAppState().personality = '';
      safeSetState(() {});
      logFirebaseEvent('test_update_page_state');
      _model.loading = false;
      safeSetState(() {});
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
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
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
                logFirebaseEvent('TEST_PAGE_arrow_back_ios_new_ICN_ON_TAP');
                logFirebaseEvent('IconButton_bottom_sheet');
                await showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  enableDrag: false,
                  context: context,
                  builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: Padding(
                        padding: MediaQuery.viewInsetsOf(context),
                        child: ExitTestWidget(),
                      ),
                    );
                  },
                ).then((value) => safeSetState(() {}));
              },
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
            elevation: 1.0,
          ),
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Builder(
                  builder: (context) {
                    if (_model.loading == false) {
                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            25.0, 0.0, 25.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            LinearPercentIndicator(
                              percent: valueOrDefault<double>(
                                functions.getProgressValue(
                                    valueOrDefault<int>(
                                      functions
                                          .getLengthByIndex(valueOrDefault<int>(
                                        _model.questions?.length,
                                        0,
                                      )),
                                      0,
                                    ),
                                    valueOrDefault<int>(
                                      _model.index,
                                      0,
                                    )),
                                0.0,
                              ),
                              lineHeight: 12.0,
                              animation: true,
                              animateFromLastPercent: true,
                              progressColor:
                                  FlutterFlowTheme.of(context).primary,
                              backgroundColor:
                                  FlutterFlowTheme.of(context).accent4,
                              padding: EdgeInsets.zero,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 20.0, 0.0, 0.0),
                                  child: Text(
                                    valueOrDefault<String>(
                                      _model.questions
                                          ?.elementAtOrNull(_model.index!)
                                          ?.title,
                                      '[title] ',
                                    ),
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .displaySmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .displaySmallFamily,
                                          fontSize: 20.0,
                                          letterSpacing: 1.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .displaySmallIsCustom,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 20.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 7.0, 0.0, 0.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'TEST_PAGE_Container_d7kql9lh_ON_TAP');
                                            logFirebaseEvent(
                                                'Container_custom_action');
                                            await actions.managePersonality(
                                              _model.index!,
                                              'A',
                                            );
                                            if (functions.getLengthByIndex(
                                                    _model.questions!.length) <=
                                                _model.index!) {
                                              logFirebaseEvent(
                                                  'Container_custom_action');
                                              await actions.setPersonality();
                                              logFirebaseEvent(
                                                  'Container_backend_call');

                                              await currentUserReference!
                                                  .update(createUserRecordData(
                                                relationshipStatus: 'single',
                                                personalityType:
                                                    FFAppState().personality,
                                                nickname: FFAppState().nickname,
                                              ));
                                              logFirebaseEvent(
                                                  'Container_update_page_state');
                                              _model.index = 0;
                                              safeSetState(() {});
                                              logFirebaseEvent(
                                                  'Container_navigate_to');

                                              context.pushNamed(
                                                TestSummaryWidget.routeName,
                                                queryParameters: {
                                                  'userRef': serializeParam(
                                                    currentUserReference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  '__transition_info__':
                                                      TransitionInfo(
                                                    hasTransition: true,
                                                    transitionType:
                                                        PageTransitionType
                                                            .leftToRight,
                                                    duration: Duration(
                                                        milliseconds: 300),
                                                  ),
                                                },
                                              );
                                            } else {
                                              logFirebaseEvent(
                                                  'Container_update_page_state');
                                              _model.index = _model.index! + 1;
                                              safeSetState(() {});
                                            }
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 17.0, 15.0, 17.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    _model.questions
                                                        ?.elementAtOrNull(
                                                            _model.index!)
                                                        ?.a,
                                                    'answer a',
                                                  ),
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          logFirebaseEvent(
                                              'TEST_PAGE_Container_wlxj0f5p_ON_TAP');
                                          logFirebaseEvent(
                                              'Container_custom_action');
                                          await actions.managePersonality(
                                            _model.index!,
                                            'B',
                                          );
                                          if (functions.getLengthByIndex(
                                                  _model.questions!.length) <=
                                              _model.index!) {
                                            logFirebaseEvent(
                                                'Container_custom_action');
                                            await actions.setPersonality();
                                            logFirebaseEvent(
                                                'Container_backend_call');

                                            await currentUserReference!
                                                .update(createUserRecordData(
                                              relationshipStatus: 'single',
                                              personalityType:
                                                  FFAppState().personality,
                                              nickname: FFAppState().nickname,
                                            ));
                                            logFirebaseEvent(
                                                'Container_update_page_state');
                                            _model.index = 0;
                                            safeSetState(() {});
                                            logFirebaseEvent(
                                                'Container_navigate_to');

                                            context.pushNamed(
                                              TestSummaryWidget.routeName,
                                              queryParameters: {
                                                'userRef': serializeParam(
                                                  currentUserReference,
                                                  ParamType.DocumentReference,
                                                ),
                                              }.withoutNulls,
                                              extra: <String, dynamic>{
                                                '__transition_info__':
                                                    TransitionInfo(
                                                  hasTransition: true,
                                                  transitionType:
                                                      PageTransitionType
                                                          .leftToRight,
                                                  duration: Duration(
                                                      milliseconds: 300),
                                                ),
                                              },
                                            );
                                          } else {
                                            logFirebaseEvent(
                                                'Container_update_page_state');
                                            _model.index = _model.index! + 1;
                                            safeSetState(() {});
                                          }
                                        },
                                        child: Container(
                                          width: double.infinity,
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
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      15.0, 17.0, 15.0, 17.0),
                                              child: Text(
                                                valueOrDefault<String>(
                                                  _model.questions
                                                      ?.elementAtOrNull(
                                                          _model.index!)
                                                      ?.b,
                                                  'answer b',
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 20.0)),
                                  ),
                                ),
                                if ((_model.index != null) &&
                                    (_model.index! >= 1))
                                  Align(
                                    alignment: AlignmentDirectional(-1.0, -1.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 30.0, 0.0, 0.0),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          logFirebaseEvent(
                                              'TEST_PAGE_PREVIOUS_QUESTION_BTN_ON_TAP');
                                          logFirebaseEvent(
                                              'Button_update_page_state');
                                          _model.index = _model.index! + -1;
                                          safeSetState(() {});
                                        },
                                        text: 'previous question',
                                        options: FFButtonOptions(
                                          height: 45.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 0.0),
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
                                                        .primaryText,
                                                fontSize: 14.0,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .titleSmallIsCustom,
                                              ),
                                          elevation: 0.0,
                                          borderRadius:
                                              BorderRadius.circular(40.0),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      return wrapWithModel(
                        model: _model.loadingQuestionsModel,
                        updateCallback: () => safeSetState(() {}),
                        child: LoadingQuestionsWidget(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

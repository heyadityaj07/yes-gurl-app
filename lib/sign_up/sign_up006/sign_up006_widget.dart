import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'sign_up006_model.dart';
export 'sign_up006_model.dart';

class SignUp006Widget extends StatefulWidget {
  const SignUp006Widget({super.key});

  static String routeName = 'signUp006';
  static String routePath = '/signUp006';

  @override
  State<SignUp006Widget> createState() => _SignUp006WidgetState();
}

class _SignUp006WidgetState extends State<SignUp006Widget>
    with TickerProviderStateMixin {
  late SignUp006Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignUp006Model());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'signUp006'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('SIGN_UP006_PAGE_signUp006_ON_INIT_STATE');
      await Future.wait([
        Future(() async {
          if (!((currentUserDocument?.selectedAgeRange?.toList() ?? [])
              .isNotEmpty)) {
            logFirebaseEvent('signUp006_backend_call');
            unawaited(
              () async {
                await currentUserReference!.update({
                  ...mapToFirestore(
                    {
                      'selectedAgeRange': [18, 80],
                    },
                  ),
                });
              }(),
            );
          }
        }),
        Future(() async {
          if (((currentUserDocument?.selectedRelationship?.toList() ?? [])
                  .isNotEmpty) ==
              false) {
            logFirebaseEvent('signUp006_backend_call');
            unawaited(
              () async {
                await currentUserReference!.update({
                  ...mapToFirestore(
                    {
                      'selectedRelationship': [
                        'single',
                        'in a relationship',
                        'married'
                      ],
                    },
                  ),
                });
              }(),
            );
          }
        }),
        Future(() async {
          if (((currentUserDocument?.selectedChildren?.toList() ?? [])
                  .isNotEmpty) ==
              false) {
            logFirebaseEvent('signUp006_backend_call');
            unawaited(
              () async {
                await currentUserReference!.update({
                  ...mapToFirestore(
                    {
                      'selectedChildren': [
                        'have children',
                        'do not have children'
                      ],
                    },
                  ),
                });
              }(),
            );
          }
        }),
      ]);
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
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 50.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'iconOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 50.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'buttonOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 150.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'buttonOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 150.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
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
          leading: FlutterFlowIconButton(
            borderRadius: 30.0,
            buttonSize: 40.0,
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),
            onPressed: () async {
              logFirebaseEvent('SIGN_UP006_arrow_back_ios_new_ICN_ON_TAP');
              logFirebaseEvent('IconButton_navigate_to');

              context.pushNamed(
                SignUp005Widget.routeName,
                extra: <String, dynamic>{
                  '__transition_info__': TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.rightToLeft,
                    duration: Duration(milliseconds: 300),
                  ),
                },
              );
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
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional(0.0, -1.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                    child: Text(
                      'do you have children?',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).displaySmall.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).displaySmallFamily,
                            color: FlutterFlowTheme.of(context).accent1,
                            fontSize: 27.0,
                            letterSpacing: 1.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .displaySmallIsCustom,
                          ),
                    ).animateOnPageLoad(
                        animationsMap['textOnPageLoadAnimation']!),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                    child: Icon(
                      Icons.child_friendly_outlined,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 90.0,
                    ).animateOnPageLoad(
                        animationsMap['iconOnPageLoadAnimation']!),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      logFirebaseEvent('SIGN_UP006_PAGE_children_ON_TAP');
                      logFirebaseEvent('children_backend_call');

                      await currentUserReference!.update(createUserRecordData(
                        chldren: 'have children',
                        childrenDone: true,
                      ));
                      logFirebaseEvent('children_navigate_to');

                      context.pushNamed(
                        SignUp007Widget.routeName,
                        extra: <String, dynamic>{
                          '__transition_info__': TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.leftToRight,
                            duration: Duration(milliseconds: 300),
                          ),
                        },
                      );
                    },
                    text: 'yes',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 45.0,
                      padding: EdgeInsets.all(0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleSmallFamily,
                            color: FlutterFlowTheme.of(context).accent1,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .titleSmallIsCustom,
                          ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(40.0),
                      hoverColor: Color(0xC6FE99AB),
                      hoverBorderSide: BorderSide(
                        color: Color(0xC6FE99AB),
                        width: 2.0,
                      ),
                      hoverTextColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                  ).animateOnPageLoad(
                      animationsMap['buttonOnPageLoadAnimation1']!),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      logFirebaseEvent('SIGN_UP006_PAGE_noChildren_ON_TAP');
                      logFirebaseEvent('noChildren_backend_call');

                      await currentUserReference!.update(createUserRecordData(
                        chldren: 'do not have children',
                        childrenDone: true,
                      ));
                      logFirebaseEvent('noChildren_navigate_to');

                      context.pushNamed(
                        SignUp007Widget.routeName,
                        extra: <String, dynamic>{
                          '__transition_info__': TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.leftToRight,
                            duration: Duration(milliseconds: 300),
                          ),
                        },
                      );
                    },
                    text: 'no',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 45.0,
                      padding: EdgeInsets.all(0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleSmallFamily,
                            color: FlutterFlowTheme.of(context).accent1,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .titleSmallIsCustom,
                          ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(40.0),
                      hoverColor: Color(0xC6FE99AB),
                      hoverBorderSide: BorderSide(
                        color: Color(0xC6FE99AB),
                        width: 2.0,
                      ),
                      hoverTextColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                  ).animateOnPageLoad(
                      animationsMap['buttonOnPageLoadAnimation2']!),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'sign_up010_model.dart';
export 'sign_up010_model.dart';

class SignUp010Widget extends StatefulWidget {
  const SignUp010Widget({super.key});

  static String routeName = 'signUp010';
  static String routePath = '/signUp010';

  @override
  State<SignUp010Widget> createState() => _SignUp010WidgetState();
}

class _SignUp010WidgetState extends State<SignUp010Widget>
    with TickerProviderStateMixin {
  late SignUp010Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignUp010Model());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'signUp010'});
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
      'buttonOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 850.0.ms,
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
            borderRadius: 8.0,
            buttonSize: 40.0,
            fillColor: FlutterFlowTheme.of(context).secondaryBackground,
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 28.0,
            ),
            onPressed: () async {
              logFirebaseEvent('SIGN_UP010_arrow_back_ios_new_ICN_ON_TAP');
              logFirebaseEvent('IconButton_navigate_back');
              context.safePop();
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
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 20.0, 0.0, 0.0),
                          child: Text(
                            'select your personality',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .displaySmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .displaySmallFamily,
                                  fontSize: 27.0,
                                  letterSpacing: 1.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .displaySmallIsCustom,
                                ),
                          ).animateOnPageLoad(
                              animationsMap['textOnPageLoadAnimation']!),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 30.0, 0.0, 0.0),
                          child: MasonryGridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                            ),
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 60.0,
                            itemCount: 16,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return [
                                () => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'SIGN_UP010_PAGE_Column_1aggkvvq_ON_TAP');
                                        logFirebaseEvent('Column_backend_call');

                                        await currentUserReference!
                                            .update(createUserRecordData(
                                          personalityType: 'intj',
                                        ));
                                        logFirebaseEvent('Column_navigate_to');

                                        context.pushNamed(
                                          TestSummaryWidget.routeName,
                                          queryParameters: {
                                            'userRef': serializeParam(
                                              currentUserReference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.architecture,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 40.0,
                                          ),
                                          Text(
                                            'intj',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 18.0,
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
                                () => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'SIGN_UP010_PAGE_Column_smdyi6om_ON_TAP');
                                        logFirebaseEvent('Column_backend_call');

                                        await currentUserReference!
                                            .update(createUserRecordData(
                                          personalityType: 'intp',
                                        ));
                                        logFirebaseEvent('Column_navigate_to');

                                        context.pushNamed(
                                          TestSummaryWidget.routeName,
                                          queryParameters: {
                                            'userRef': serializeParam(
                                              currentUserReference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.science_outlined,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 40.0,
                                          ),
                                          Text(
                                            'intp',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 18.0,
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
                                () => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'SIGN_UP010_PAGE_Column_n84edws8_ON_TAP');
                                        logFirebaseEvent('Column_backend_call');

                                        await currentUserReference!
                                            .update(createUserRecordData(
                                          personalityType: 'entj',
                                        ));
                                        logFirebaseEvent('Column_navigate_to');

                                        context.pushNamed(
                                          TestSummaryWidget.routeName,
                                          queryParameters: {
                                            'userRef': serializeParam(
                                              currentUserReference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.handPointLeft,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 40.0,
                                          ),
                                          Text(
                                            'entj',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 18.0,
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
                                () => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'SIGN_UP010_PAGE_Column_2gi090q6_ON_TAP');
                                        logFirebaseEvent('Column_backend_call');

                                        await currentUserReference!
                                            .update(createUserRecordData(
                                          personalityType: 'entp',
                                        ));
                                        logFirebaseEvent('Column_navigate_to');

                                        context.pushNamed(
                                          TestSummaryWidget.routeName,
                                          queryParameters: {
                                            'userRef': serializeParam(
                                              currentUserReference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.microphoneAlt,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 40.0,
                                          ),
                                          Text(
                                            'entp',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 18.0,
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
                                () => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'SIGN_UP010_PAGE_Column_fp9yxoe8_ON_TAP');
                                        logFirebaseEvent('Column_backend_call');

                                        await currentUserReference!
                                            .update(createUserRecordData(
                                          personalityType: 'infj',
                                        ));
                                        logFirebaseEvent('Column_navigate_to');

                                        context.pushNamed(
                                          TestSummaryWidget.routeName,
                                          queryParameters: {
                                            'userRef': serializeParam(
                                              currentUserReference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.tips_and_updates_outlined,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 40.0,
                                          ),
                                          Text(
                                            'infj',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 18.0,
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
                                () => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'SIGN_UP010_PAGE_Column_sut1v30u_ON_TAP');
                                        logFirebaseEvent('Column_backend_call');

                                        await currentUserReference!
                                            .update(createUserRecordData(
                                          personalityType: 'infp',
                                        ));
                                        logFirebaseEvent('Column_navigate_to');

                                        context.pushNamed(
                                          TestSummaryWidget.routeName,
                                          queryParameters: {
                                            'userRef': serializeParam(
                                              currentUserReference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.balance_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 40.0,
                                          ),
                                          Text(
                                            'infp',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 18.0,
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
                                () => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'SIGN_UP010_PAGE_Column_1xr3ddu1_ON_TAP');
                                        logFirebaseEvent('Column_backend_call');

                                        await currentUserReference!
                                            .update(createUserRecordData(
                                          personalityType: 'enfj',
                                        ));
                                        logFirebaseEvent('Column_navigate_to');

                                        context.pushNamed(
                                          TestSummaryWidget.routeName,
                                          queryParameters: {
                                            'userRef': serializeParam(
                                              currentUserReference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.waving_hand_outlined,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 40.0,
                                          ),
                                          Text(
                                            'enfj',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 18.0,
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
                                () => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'SIGN_UP010_PAGE_Column_usywigwr_ON_TAP');
                                        logFirebaseEvent('Column_backend_call');

                                        await currentUserReference!
                                            .update(createUserRecordData(
                                          personalityType: 'enfp',
                                        ));
                                        logFirebaseEvent('Column_navigate_to');

                                        context.pushNamed(
                                          TestSummaryWidget.routeName,
                                          queryParameters: {
                                            'userRef': serializeParam(
                                              currentUserReference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.campaign_outlined,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 40.0,
                                          ),
                                          Text(
                                            'enfp',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 18.0,
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
                                () => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'SIGN_UP010_PAGE_Column_mjibtmun_ON_TAP');
                                        logFirebaseEvent('Column_backend_call');

                                        await currentUserReference!
                                            .update(createUserRecordData(
                                          personalityType: 'istj',
                                        ));
                                        logFirebaseEvent('Column_navigate_to');

                                        context.pushNamed(
                                          TestSummaryWidget.routeName,
                                          queryParameters: {
                                            'userRef': serializeParam(
                                              currentUserReference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.inventory_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 40.0,
                                          ),
                                          Text(
                                            'istj',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 18.0,
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
                                () => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'SIGN_UP010_PAGE_Column_yqa4wgtq_ON_TAP');
                                        logFirebaseEvent('Column_backend_call');

                                        await currentUserReference!
                                            .update(createUserRecordData(
                                          personalityType: 'isfj',
                                        ));
                                        logFirebaseEvent('Column_navigate_to');

                                        context.pushNamed(
                                          TestSummaryWidget.routeName,
                                          queryParameters: {
                                            'userRef': serializeParam(
                                              currentUserReference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.health_and_safety_outlined,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 40.0,
                                          ),
                                          Text(
                                            'isfj',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 18.0,
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
                                () => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'SIGN_UP010_PAGE_Column_wgctdv52_ON_TAP');
                                        logFirebaseEvent('Column_backend_call');

                                        await currentUserReference!
                                            .update(createUserRecordData(
                                          personalityType: 'estj',
                                        ));
                                        logFirebaseEvent('Column_navigate_to');

                                        context.pushNamed(
                                          TestSummaryWidget.routeName,
                                          queryParameters: {
                                            'userRef': serializeParam(
                                              currentUserReference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.calculate_outlined,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 40.0,
                                          ),
                                          Text(
                                            'estj',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 18.0,
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
                                () => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'SIGN_UP010_PAGE_Column_o02mb4fq_ON_TAP');
                                        logFirebaseEvent('Column_backend_call');

                                        await currentUserReference!
                                            .update(createUserRecordData(
                                          personalityType: 'esfj',
                                        ));
                                        logFirebaseEvent('Column_navigate_to');

                                        context.pushNamed(
                                          TestSummaryWidget.routeName,
                                          queryParameters: {
                                            'userRef': serializeParam(
                                              currentUserReference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.handshake_outlined,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 40.0,
                                          ),
                                          Text(
                                            'esfj',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 18.0,
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
                                () => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'SIGN_UP010_PAGE_Column_dd2isv2c_ON_TAP');
                                        logFirebaseEvent('Column_backend_call');

                                        await currentUserReference!
                                            .update(createUserRecordData(
                                          personalityType: 'istp',
                                        ));
                                        logFirebaseEvent('Column_navigate_to');

                                        context.pushNamed(
                                          TestSummaryWidget.routeName,
                                          queryParameters: {
                                            'userRef': serializeParam(
                                              currentUserReference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.build_outlined,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 40.0,
                                          ),
                                          Text(
                                            'istp',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 18.0,
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
                                () => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'SIGN_UP010_PAGE_Column_v75km5ff_ON_TAP');
                                        logFirebaseEvent('Column_backend_call');

                                        await currentUserReference!
                                            .update(createUserRecordData(
                                          personalityType: 'isfp',
                                        ));
                                        logFirebaseEvent('Column_navigate_to');

                                        context.pushNamed(
                                          TestSummaryWidget.routeName,
                                          queryParameters: {
                                            'userRef': serializeParam(
                                              currentUserReference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.format_paint_outlined,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 40.0,
                                          ),
                                          Text(
                                            'isfp',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 18.0,
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
                                () => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'SIGN_UP010_PAGE_Column_20drt68r_ON_TAP');
                                        logFirebaseEvent('Column_backend_call');

                                        await currentUserReference!
                                            .update(createUserRecordData(
                                          personalityType: 'estp',
                                        ));
                                        logFirebaseEvent('Column_navigate_to');

                                        context.pushNamed(
                                          TestSummaryWidget.routeName,
                                          queryParameters: {
                                            'userRef': serializeParam(
                                              currentUserReference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.bolt_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 40.0,
                                          ),
                                          Text(
                                            'estp',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 18.0,
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
                                () => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'SIGN_UP010_PAGE_Column_lt64pj92_ON_TAP');
                                        logFirebaseEvent('Column_backend_call');

                                        await currentUserReference!
                                            .update(createUserRecordData(
                                          personalityType: 'esfp',
                                        ));
                                        logFirebaseEvent('Column_navigate_to');

                                        context.pushNamed(
                                          TestSummaryWidget.routeName,
                                          queryParameters: {
                                            'userRef': serializeParam(
                                              currentUserReference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.celebration_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 40.0,
                                          ),
                                          Text(
                                            'esfp',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 18.0,
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
                              ][index]();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 40.0, 16.0, 16.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent('SIGN_UP010_PAGE_upload_ON_TAP');
                    logFirebaseEvent('upload_navigate_to');

                    context.pushNamed(
                      TestStartWidget.routeName,
                      extra: <String, dynamic>{
                        '__transition_info__': TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.leftToRight,
                          duration: Duration(milliseconds: 300),
                        ),
                      },
                    );
                  },
                  text: 'take test instead (5 minutes)',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 45.0,
                    padding: EdgeInsets.all(0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).titleSmallFamily,
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).titleSmallIsCustom,
                        ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ).animateOnPageLoad(
                    animationsMap['buttonOnPageLoadAnimation']!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

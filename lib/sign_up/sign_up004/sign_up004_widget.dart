import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'sign_up004_model.dart';
export 'sign_up004_model.dart';

class SignUp004Widget extends StatefulWidget {
  const SignUp004Widget({super.key});

  static String routeName = 'signUp004';
  static String routePath = '/signUp004';

  @override
  State<SignUp004Widget> createState() => _SignUp004WidgetState();
}

class _SignUp004WidgetState extends State<SignUp004Widget>
    with TickerProviderStateMixin {
  late SignUp004Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignUp004Model());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'signUp004'});
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
      'dropDownOnPageLoadAnimation1': AnimationInfo(
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
      'dropDownOnPageLoadAnimation2': AnimationInfo(
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
      'richTextOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 250.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'iconButtonOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 250.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
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
          leading: FlutterFlowIconButton(
            borderRadius: 30.0,
            buttonSize: 40.0,
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),
            onPressed: () async {
              logFirebaseEvent('SIGN_UP004_arrow_back_ios_new_ICN_ON_TAP');
              logFirebaseEvent('IconButton_navigate_to');

              context.pushNamed(
                SignUp003Widget.routeName,
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 20.0, 0.0, 0.0),
                          child: Text(
                            'where do you live?',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .displaySmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .displaySmallFamily,
                                  color: FlutterFlowTheme.of(context).accent1,
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
                              0.0, 40.0, 0.0, 0.0),
                          child: Icon(
                            Icons.home_outlined,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 90.0,
                          ).animateOnPageLoad(
                              animationsMap['iconOnPageLoadAnimation']!),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 50.0, 0.0, 0.0),
                          child: Form(
                            key: _model.formKey,
                            autovalidateMode: AutovalidateMode.always,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                AuthUserStreamWidget(
                                  builder: (context) =>
                                      FlutterFlowDropDown<String>(
                                    controller:
                                        _model.selectCountryValueController ??=
                                            FormFieldController<String>(
                                      _model.selectCountryValue ??=
                                          valueOrDefault(
                                              currentUserDocument?.city, ''),
                                    ),
                                    options: [
                                      'london',
                                      'south east england',
                                      'south west england',
                                      'east of england',
                                      'west midlands',
                                      'east midlands',
                                      'north west england',
                                      'yorkshire and the humber',
                                      'north east england'
                                    ],
                                    onChanged: (val) => safeSetState(
                                        () => _model.selectCountryValue = val),
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.87,
                                    height: 45.0,
                                    maxHeight: 400.0,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodyMediumIsCustom,
                                        ),
                                    hintText: 'region',
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 24.0,
                                    ),
                                    fillColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    elevation: 2.0,
                                    borderColor:
                                        FlutterFlowTheme.of(context).alternate,
                                    borderWidth: 2.0,
                                    borderRadius: 40.0,
                                    margin: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 0.0, 15.0, 0.0),
                                    hidesUnderline: true,
                                    isOverButton: false,
                                    isSearchable: false,
                                    isMultiSelect: false,
                                  ).animateOnPageLoad(animationsMap[
                                          'dropDownOnPageLoadAnimation1']!),
                                ),
                                if (_model.selectCountryValue != null &&
                                    _model.selectCountryValue != '')
                                  AuthUserStreamWidget(
                                    builder: (context) =>
                                        FlutterFlowDropDown<String>(
                                      controller: _model
                                              .regioncountryValueController ??=
                                          FormFieldController<String>(
                                        _model.regioncountryValue ??=
                                            valueOrDefault(
                                                currentUserDocument?.subCity,
                                                ''),
                                      ),
                                      options: () {
                                        if (_model.selectCountryValue ==
                                            'london') {
                                          return FFAppState().londonlist;
                                        } else if (_model.selectCountryValue ==
                                            'south east england') {
                                          return FFAppState()
                                              .SouthEastEnglandlist;
                                        } else if (_model.selectCountryValue ==
                                            'south west england') {
                                          return FFAppState()
                                              .SouthWestEnglandlist;
                                        } else if (_model.selectCountryValue ==
                                            'east of england') {
                                          return FFAppState().EastofEnglandlist;
                                        } else if (_model.selectCountryValue ==
                                            'west midlands') {
                                          return FFAppState().WestMidlands;
                                        } else if (_model.selectCountryValue ==
                                            'east midlands') {
                                          return FFAppState().EastMidlands;
                                        } else if (_model.selectCountryValue ==
                                            'north west england') {
                                          return FFAppState()
                                              .NorthWestEnglandlist;
                                        } else if (_model.selectCountryValue ==
                                            'yorkshire and the humber') {
                                          return FFAppState()
                                              .YorkshireandtheHumber;
                                        } else if (_model.selectCountryValue ==
                                            'north east england') {
                                          return FFAppState()
                                              .NorthEastEnglandlist;
                                        } else {
                                          return FFAppState()
                                              .NorthEastEnglandlist;
                                        }
                                      }(),
                                      onChanged: (val) => safeSetState(() =>
                                          _model.regioncountryValue = val),
                                      width: MediaQuery.sizeOf(context).width *
                                          0.87,
                                      height: 45.0,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyMediumIsCustom,
                                          ),
                                      hintText: 'county',
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 24.0,
                                      ),
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      elevation: 2.0,
                                      borderColor: FlutterFlowTheme.of(context)
                                          .alternate,
                                      borderWidth: 2.0,
                                      borderRadius: 40.0,
                                      margin: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 15.0, 0.0),
                                      hidesUnderline: true,
                                      isOverButton: false,
                                      isSearchable: false,
                                      isMultiSelect: false,
                                    ).animateOnPageLoad(animationsMap[
                                            'dropDownOnPageLoadAnimation2']!),
                                  ),
                              ].divide(SizedBox(height: 10.0)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 30.0, 0.0, 0.0),
                          child: RichText(
                            textScaler: MediaQuery.of(context).textScaler,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      'at the moment, this app is for women in england, but drop us an ',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                ),
                                TextSpan(
                                  text: 'email ',
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  mouseCursor: SystemMouseCursors.click,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      logFirebaseEvent(
                                          'SIGN_UP004_RichTextSpan_i4i18sb6_ON_TAP');
                                      logFirebaseEvent(
                                          'RichTextSpan_send_email');
                                      await launchUrl(Uri(
                                          scheme: 'mailto',
                                          path: 'app@yesgurl.co.uk',
                                          query: {
                                            'subject':
                                                'Yes Gurl App - Add My Location',
                                          }
                                              .entries
                                              .map((MapEntry<String, String>
                                                      e) =>
                                                  '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                              .join('&')));
                                    },
                                ),
                                TextSpan(
                                  text:
                                      'if you feel your country should be listed',
                                  style: TextStyle(),
                                )
                              ],
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyMediumIsCustom,
                                  ),
                            ),
                            textAlign: TextAlign.center,
                          ).animateOnPageLoad(
                              animationsMap['richTextOnPageLoadAnimation']!),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(1.0, 1.0),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 16.0, 16.0),
                  child: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30.0,
                    buttonSize: 60.0,
                    fillColor: FlutterFlowTheme.of(context).primary,
                    disabledColor: FlutterFlowTheme.of(context).warning,
                    disabledIconColor:
                        FlutterFlowTheme.of(context).secondaryBackground,
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    showLoadingIndicator: true,
                    onPressed: ((_model.selectCountryValue == null ||
                                _model.selectCountryValue == '') &&
                            (_model.regioncountryValue == null ||
                                _model.regioncountryValue == ''))
                        ? null
                        : () async {
                            logFirebaseEvent(
                                'SIGN_UP004_arrow_forward_ios_ICN_ON_TAP');
                            logFirebaseEvent('IconButton_validate_form');
                            if (_model.formKey.currentState == null ||
                                !_model.formKey.currentState!.validate()) {
                              return;
                            }
                            if (_model.selectCountryValue == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Please select location',
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).secondary,
                                ),
                              );
                              return;
                            }
                            if (_model.regioncountryValue == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Please select sub location',
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).secondary,
                                ),
                              );
                              return;
                            }
                            logFirebaseEvent('IconButton_backend_call');

                            await currentUserReference!
                                .update(createUserRecordData(
                              city: _model.selectCountryValue,
                              subCity: _model.regioncountryValue,
                            ));
                            logFirebaseEvent('IconButton_navigate_to');

                            context.pushNamed(
                              SignUp005Widget.routeName,
                              extra: <String, dynamic>{
                                '__transition_info__': TransitionInfo(
                                  hasTransition: true,
                                  transitionType:
                                      PageTransitionType.leftToRight,
                                  duration: Duration(milliseconds: 300),
                                ),
                              },
                            );
                          },
                  ).animateOnPageLoad(
                      animationsMap['iconButtonOnPageLoadAnimation']!),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

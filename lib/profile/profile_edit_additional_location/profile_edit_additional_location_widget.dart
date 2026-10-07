import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'profile_edit_additional_location_model.dart';
export 'profile_edit_additional_location_model.dart';

class ProfileEditAdditionalLocationWidget extends StatefulWidget {
  const ProfileEditAdditionalLocationWidget({super.key});

  static String routeName = 'profileEditAdditionalLocation';
  static String routePath = '/profileEditAdditionalLocation';

  @override
  State<ProfileEditAdditionalLocationWidget> createState() =>
      _ProfileEditAdditionalLocationWidgetState();
}

class _ProfileEditAdditionalLocationWidgetState
    extends State<ProfileEditAdditionalLocationWidget> {
  late ProfileEditAdditionalLocationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileEditAdditionalLocationModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'profileEditAdditionalLocation'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('PROFILE_EDIT_ADDITIONAL_LOCATION_profile');
      logFirebaseEvent('profileEditAdditionalLocation_set_form_f');
      safeSetState(() {
        _model.selectCountrymenayValueController?.value =
            valueOrDefault(currentUserDocument?.city, '');
        _model.selectCountrymenayValue =
            valueOrDefault(currentUserDocument?.city, '');
      });
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
          leading: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
            child: FlutterFlowIconButton(
              borderRadius: 30.0,
              buttonSize: 40.0,
              icon: Icon(
                Icons.arrow_back_ios,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 30.0,
              ),
              onPressed: () async {
                logFirebaseEvent('PROFILE_EDIT_ADDITIONAL_LOCATION_arrow_b');
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
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: AlignmentDirectional(-1.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(25.0, 18.0, 25.0, 20.0),
                    child: Text(
                      'location',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).displaySmall.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).displaySmallFamily,
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 25.0,
                            letterSpacing: 1.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .displaySmallIsCustom,
                          ),
                    ),
                  ),
                ),
                Form(
                  key: _model.formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      AuthUserStreamWidget(
                        builder: (context) => FlutterFlowDropDown<String>(
                          controller:
                              _model.selectCountrymenayValueController ??=
                                  FormFieldController<String>(
                            _model.selectCountrymenayValue ??=
                                valueOrDefault(currentUserDocument?.city, ''),
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
                              () => _model.selectCountrymenayValue = val),
                          width: MediaQuery.sizeOf(context).width * 0.87,
                          height: 45.0,
                          maxHeight: 400.0,
                          textStyle: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .bodyMediumIsCustom,
                              ),
                          hintText: 'region',
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          elevation: 0.0,
                          borderColor: FlutterFlowTheme.of(context).alternate,
                          borderWidth: 2.0,
                          borderRadius: 40.0,
                          margin: EdgeInsetsDirectional.fromSTEB(
                              15.0, 0.0, 15.0, 0.0),
                          hidesUnderline: true,
                          isOverButton: false,
                          isSearchable: false,
                          isMultiSelect: false,
                        ),
                      ),
                      if (_model.selectCountrymenayValue != null &&
                          _model.selectCountrymenayValue != '')
                        AuthUserStreamWidget(
                          builder: (context) => FlutterFlowDropDown<String>(
                            controller: _model.regioncountryValueController ??=
                                FormFieldController<String>(
                              _model.regioncountryValue ??= valueOrDefault(
                                  currentUserDocument?.subCity, ''),
                            ),
                            options: () {
                              if (_model.selectCountrymenayValue == 'london') {
                                return FFAppState().londonlist;
                              } else if (_model.selectCountrymenayValue ==
                                  'south east england') {
                                return FFAppState().SouthEastEnglandlist;
                              } else if (_model.selectCountrymenayValue ==
                                  'south west england') {
                                return FFAppState().SouthWestEnglandlist;
                              } else if (_model.selectCountrymenayValue ==
                                  'east of england') {
                                return FFAppState().EastofEnglandlist;
                              } else if (_model.selectCountrymenayValue ==
                                  'west midlands') {
                                return FFAppState().WestMidlands;
                              } else if (_model.selectCountrymenayValue ==
                                  'east midlands') {
                                return FFAppState().EastMidlands;
                              } else if (_model.selectCountrymenayValue ==
                                  'north west england') {
                                return FFAppState().NorthWestEnglandlist;
                              } else if (_model.selectCountrymenayValue ==
                                  'yorkshire and the humber') {
                                return FFAppState().YorkshireandtheHumber;
                              } else if (_model.selectCountrymenayValue ==
                                  'north east england') {
                                return FFAppState().NorthEastEnglandlist;
                              } else {
                                return FFAppState().NorthEastEnglandlist;
                              }
                            }(),
                            onChanged: (val) => safeSetState(
                                () => _model.regioncountryValue = val),
                            width: MediaQuery.sizeOf(context).width * 0.87,
                            height: 45.0,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodyMediumIsCustom,
                                ),
                            hintText: 'county',
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: FlutterFlowTheme.of(context).accent1,
                              size: 24.0,
                            ),
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            elevation: 2.0,
                            borderColor: FlutterFlowTheme.of(context).alternate,
                            borderWidth: 2.0,
                            borderRadius: 40.0,
                            margin: EdgeInsetsDirectional.fromSTEB(
                                15.0, 0.0, 15.0, 0.0),
                            hidesUnderline: true,
                            isOverButton: false,
                            isSearchable: false,
                            isMultiSelect: false,
                          ),
                        ),
                    ].divide(SizedBox(height: 10.0)),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(25.0, 30.0, 25.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      logFirebaseEvent(
                          'PROFILE_EDIT_ADDITIONAL_LOCATION_SAVE_BT');
                      logFirebaseEvent('Button_validate_form');
                      if (_model.formKey.currentState == null ||
                          !_model.formKey.currentState!.validate()) {
                        return;
                      }
                      if (_model.selectCountrymenayValue == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Please select location',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
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
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).secondary,
                          ),
                        );
                        return;
                      }
                      logFirebaseEvent('Button_backend_call');

                      await currentUserReference!.update(createUserRecordData(
                        city: _model.selectCountrymenayValue,
                        subCity: _model.regioncountryValue,
                      ));
                      logFirebaseEvent('Button_navigate_back');
                      context.safePop();
                    },
                    text: 'save',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleSmallFamily,
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .titleSmallIsCustom,
                          ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(45.0),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(25.0, 30.0, 25.0, 0.0),
                  child: RichText(
                    textScaler: MediaQuery.of(context).textScaler,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'at the moment, this app is for women in england but drop us an ',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
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
                                  'PROFILE_EDIT_ADDITIONAL_LOCATION_RichTex');
                              logFirebaseEvent('RichTextSpan_send_email');
                              await launchUrl(Uri(
                                  scheme: 'mailto',
                                  path: 'app@yesgurl.co.uk',
                                  query: {
                                    'subject': 'Yes Gurl App - Add My Location',
                                  }
                                      .entries
                                      .map((MapEntry<String, String> e) =>
                                          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                      .join('&')));
                            },
                        ),
                        TextSpan(
                          text: 'if you feel your country should be listed',
                          style: TextStyle(),
                        )
                      ],
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .bodyMediumIsCustom,
                          ),
                    ),
                    textAlign: TextAlign.start,
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

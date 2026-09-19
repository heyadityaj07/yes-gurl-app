import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'profile_preferences_age_model.dart';
export 'profile_preferences_age_model.dart';

class ProfilePreferencesAgeWidget extends StatefulWidget {
  const ProfilePreferencesAgeWidget({super.key});

  static String routeName = 'profilePreferencesAge';
  static String routePath = '/profilePreferencesAge';

  @override
  State<ProfilePreferencesAgeWidget> createState() =>
      _ProfilePreferencesAgeWidgetState();
}

class _ProfilePreferencesAgeWidgetState
    extends State<ProfilePreferencesAgeWidget> {
  late ProfilePreferencesAgeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfilePreferencesAgeModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'profilePreferencesAge'});
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
              borderRadius: 30.0,
              buttonSize: 40.0,
              icon: Icon(
                Icons.arrow_back_ios,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 30.0,
              ),
              onPressed: () async {
                logFirebaseEvent('PROFILE_PREFERENCES_AGE_arrow_back_ios_I');
                logFirebaseEvent('IconButton_navigate_to');

                context.pushNamed(ProfilePreferencesWidget.routeName);
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
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: AutoSizeText(
                                'preferred age',
                                minFontSize: 12.0,
                                style: FlutterFlowTheme.of(context)
                                    .displaySmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .displaySmallFamily,
                                      fontSize: 25.0,
                                      letterSpacing: 1.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .displaySmallIsCustom,
                                    ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(1.0, 0.0),
                              child: AuthUserStreamWidget(
                                builder: (context) => Text(
                                  '${_model.age1 != null ? _model.age1?.toString() : valueOrDefault<String>(
                                      (currentUserDocument?.selectedAgeRange
                                                  ?.toList() ??
                                              [])
                                          .firstOrNull
                                          ?.toString(),
                                      '18',
                                    )}-${_model.age2 != null ? _model.age2?.toString() : valueOrDefault<String>(
                                      (currentUserDocument?.selectedAgeRange
                                                  ?.toList() ??
                                              [])
                                          .lastOrNull
                                          ?.toString(),
                                      '80',
                                    )} years',
                                  style: FlutterFlowTheme.of(context)
                                      .displaySmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .displaySmallFamily,
                                        fontSize: 17.0,
                                        letterSpacing: 1.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .displaySmallIsCustom,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 10.0)),
                      ),
                    ),
                  ),
                  AuthUserStreamWidget(
                    builder: (context) => custom_widgets.RangeSliderWidget(
                      width: double.infinity,
                      height: 50.0,
                      start: (currentUserDocument?.selectedAgeRange?.toList() ??
                              [])
                          .firstOrNull,
                      end: (currentUserDocument?.selectedAgeRange?.toList() ??
                              [])
                          .lastOrNull,
                      onChangedAction: (start, end) async {
                        logFirebaseEvent(
                            'PROFILE_PREFERENCES_AGE_Container_wc83hn');
                        logFirebaseEvent('RangeSliderWidget_update_page_state');
                        _model.age1 = start;
                        _model.age2 = end;
                        safeSetState(() {});
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        logFirebaseEvent(
                            'PROFILE_PREFERENCES_AGE_SAVE_BTN_ON_TAP');
                        logFirebaseEvent('Button_backend_call');

                        await currentUserReference!.update({
                          ...createUserRecordData(
                            profilePrefAgeEdit: true,
                          ),
                          ...mapToFirestore(
                            {
                              'selectedAgeRange': (int start, int end) {
                                return [start, end];
                              }(_model.age1!, _model.age2!),
                            },
                          ),
                        });
                        logFirebaseEvent('Button_navigate_back');
                        context.safePop();
                      },
                      text: 'save',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 45.0,
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
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                  ),
                ].divide(SizedBox(height: 10.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

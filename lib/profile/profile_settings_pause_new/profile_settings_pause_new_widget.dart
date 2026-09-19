import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/link_up/link_up_message/link_up_message_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'profile_settings_pause_new_model.dart';
export 'profile_settings_pause_new_model.dart';

class ProfileSettingsPauseNewWidget extends StatefulWidget {
  const ProfileSettingsPauseNewWidget({super.key});

  @override
  State<ProfileSettingsPauseNewWidget> createState() =>
      _ProfileSettingsPauseNewWidgetState();
}

class _ProfileSettingsPauseNewWidgetState
    extends State<ProfileSettingsPauseNewWidget> {
  late ProfileSettingsPauseNewModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileSettingsPauseNewModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15.0, 30.0, 15.0, 30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'pause account?',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).displaySmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).displaySmallFamily,
                          fontSize: 27.0,
                          letterSpacing: 0.0,
                          useGoogleFonts: !FlutterFlowTheme.of(context)
                              .displaySmallIsCustom,
                        ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                    child: Text(
                      'let your connections know you need a break by pausing your account - your account will resume when you log back in ',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .bodyMediumIsCustom,
                          ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            logFirebaseEvent(
                                'PROFILE_SETTINGS_PAUSE_NEW_CANCEL_BTN_ON');
                            logFirebaseEvent('Button_bottom_sheet');
                            Navigator.pop(context);
                          },
                          text: 'cancel',
                          options: FFButtonOptions(
                            width: 120.0,
                            height: 40.0,
                            padding: EdgeInsets.all(8.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
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
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            logFirebaseEvent(
                                'PROFILE_SETTINGS_PAUSE_NEW_PAUSE__LOG_OU');
                            Function() _navigate = () {};
                            logFirebaseEvent('Button_firestore_query');
                            _model.events = await queryEventsRecordCount(
                              queryBuilder: (eventsRecord) =>
                                  eventsRecord.where(
                                'userRef',
                                isEqualTo: currentUserReference,
                              ),
                            );
                            if (_model.events! > 0) {
                              logFirebaseEvent('Button_bottom_sheet');
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                enableDrag: false,
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: MediaQuery.viewInsetsOf(context),
                                    child: LinkUpMessageWidget(
                                      description:
                                          'you must delete any link ups you\'ve created before you can pause your account',
                                      title: 'you have an active link up',
                                    ),
                                  );
                                },
                              ).then((value) => safeSetState(() {}));
                            } else {
                              logFirebaseEvent('Button_backend_call');

                              await currentUserReference!
                                  .update(createUserRecordData(
                                isDeactivated: true,
                              ));
                              logFirebaseEvent('Button_auth');
                              GoRouter.of(context).prepareAuthEvent();
                              await authManager.signOut();
                              GoRouter.of(context).clearRedirectLocation();

                              _navigate = () => context.goNamedAuth(
                                  LoginWidget.routeName, context.mounted);
                            }

                            _navigate();

                            safeSetState(() {});
                          },
                          text: 'pause + log out',
                          options: FFButtonOptions(
                            width: 120.0,
                            height: 40.0,
                            padding: EdgeInsets.all(8.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
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
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ].divide(SizedBox(width: 16.0)),
                  ),
                ].divide(SizedBox(height: 16.0)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

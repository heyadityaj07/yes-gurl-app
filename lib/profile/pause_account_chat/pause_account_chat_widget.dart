import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pause_account_chat_model.dart';
export 'pause_account_chat_model.dart';

class PauseAccountChatWidget extends StatefulWidget {
  const PauseAccountChatWidget({
    super.key,
    this.userA,
    required this.chatref,
  });

  final DocumentReference? userA;
  final DocumentReference? chatref;

  @override
  State<PauseAccountChatWidget> createState() => _PauseAccountChatWidgetState();
}

class _PauseAccountChatWidgetState extends State<PauseAccountChatWidget> {
  late PauseAccountChatModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PauseAccountChatModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                'decline?',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).displaySmall.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).displaySmallFamily,
                      fontSize: 27.0,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).displaySmallIsCustom,
                    ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                child: Text(
                  'if you decline this request, you won\'t see her again',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
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
                            'PAUSE_ACCOUNT_CHAT_CANCEL_BTN_ON_TAP');
                        logFirebaseEvent('Button_bottom_sheet');
                        Navigator.pop(context);
                      },
                      text: 'cancel',
                      options: FFButtonOptions(
                        width: 120.0,
                        height: 40.0,
                        padding: EdgeInsets.all(8.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        textStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              color: FlutterFlowTheme.of(context).primaryText,
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
                            'PAUSE_ACCOUNT_CHAT_DECLINE_BTN_ON_TAP');
                        logFirebaseEvent('Button_backend_call');

                        await currentUserReference!.update({
                          ...mapToFirestore(
                            {
                              'chatRequestUser':
                                  FieldValue.arrayUnion([widget!.userA]),
                            },
                          ),
                        });
                        logFirebaseEvent('Button_bottom_sheet');
                        Navigator.pop(context);
                        logFirebaseEvent('Button_navigate_to');

                        context.pushNamed(
                          ChatWidget.routeName,
                          queryParameters: {
                            'initialTab': serializeParam(
                              1,
                              ParamType.int,
                            ),
                          }.withoutNulls,
                        );

                        logFirebaseEvent('Button_backend_call');
                        await widget!.chatref!.delete();
                      },
                      text: 'decline',
                      options: FFButtonOptions(
                        width: 120.0,
                        height: 40.0,
                        padding: EdgeInsets.all(8.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              color: FlutterFlowTheme.of(context).primaryText,
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
    );
  }
}

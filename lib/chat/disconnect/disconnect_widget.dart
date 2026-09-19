import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'disconnect_model.dart';
export 'disconnect_model.dart';

class DisconnectWidget extends StatefulWidget {
  const DisconnectWidget({
    super.key,
    required this.chatRef,
    required this.chatDoc,
  });

  final DocumentReference? chatRef;
  final ChatRecord? chatDoc;

  @override
  State<DisconnectWidget> createState() => _DisconnectWidgetState();
}

class _DisconnectWidgetState extends State<DisconnectWidget> {
  late DisconnectModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DisconnectModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('DISCONNECT_COMP_disconnect_ON_INIT_STATE');
      logFirebaseEvent('disconnect_backend_call');
      _model.user = await UserRecord.getDocumentOnce(
          widget!.chatDoc?.userA == currentUserReference
              ? widget!.chatDoc!.userB!
              : widget!.chatDoc!.userA!);
    });

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
            children: [
              Text(
                'disconnect?',
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
                  'you won\'t be able to connect with her again',
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
                        logFirebaseEvent('DISCONNECT_COMP_CANCEL_BTN_ON_TAP');
                        logFirebaseEvent('Button_close_dialog_drawer_etc');
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
                            'DISCONNECT_COMP_DISCONNECT_BTN_ON_TAP');
                        logFirebaseEvent('Button_backend_call');

                        await widget!.chatRef!.update({
                          ...mapToFirestore(
                            {
                              'block_by':
                                  FieldValue.arrayUnion([currentUserReference]),
                            },
                          ),
                        });
                        logFirebaseEvent('Button_backend_call');

                        await currentUserReference!.update({
                          ...mapToFirestore(
                            {
                              'disconnected_users': FieldValue.arrayUnion([
                                widget!.chatDoc?.userA?.id ==
                                        currentUserReference?.id
                                    ? widget!.chatDoc?.userB
                                    : widget!.chatDoc?.userA
                              ]),
                            },
                          ),
                        });
                        logFirebaseEvent('Button_backend_call');

                        await widget!.chatDoc?.userA?.id ==
                                currentUserReference?.id
                            ? widget!.chatDoc!.userB!
                            : widget!.chatDoc!.userA!.update({
                                ...mapToFirestore(
                                  {
                                    'disconnected_users': FieldValue.arrayUnion(
                                        [currentUserReference]),
                                  },
                                ),
                              });
                        logFirebaseEvent('Button_backend_call');

                        await NotificationRecord.collection
                            .doc()
                            .set(createNotificationRecordData(
                              title: 'Disconnect',
                              description:
                                  '${currentUserDisplayName}${' (${currentUserUid})'} disconnected with  ${_model.user?.displayName}${' (${_model.user?.uid})'} through Chat on ${dateTimeFormat("yMMMd", getCurrentTimestamp)}',
                              sentBy: currentUserReference,
                              user: currentUserReference,
                              sentAt: getCurrentTimestamp,
                              notificationType: 'disconnect',
                              forAdmin: true,
                            ));
                        logFirebaseEvent('Button_close_dialog_drawer_etc');
                        Navigator.pop(context);
                        logFirebaseEvent('Button_show_snack_bar');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'You have disconnected from this user',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).secondary,
                          ),
                        );
                        logFirebaseEvent('Button_navigate_back');
                        context.safePop();
                      },
                      text: 'disconnect',
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

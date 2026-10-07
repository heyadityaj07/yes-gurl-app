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
import 'meet_again_model.dart';
export 'meet_again_model.dart';

class MeetAgainWidget extends StatefulWidget {
  const MeetAgainWidget({
    super.key,
    required this.chatDoc,
  });

  final ChatRecord? chatDoc;

  @override
  State<MeetAgainWidget> createState() => _MeetAgainWidgetState();
}

class _MeetAgainWidgetState extends State<MeetAgainWidget> {
  late MeetAgainModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MeetAgainModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('MEET_AGAIN_COMP_meetAgain_ON_INIT_STATE');
      logFirebaseEvent('meetAgain_backend_call');
      _model.userDoc = await UserRecord.getDocumentOnce(
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
                'would you meet again?',
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
                  'she won\'t know you have given feedback',
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
                        logFirebaseEvent('MEET_AGAIN_COMP_NO_BTN_ON_TAP');
                        logFirebaseEvent('Button_backend_call');

                        await NotificationRecord.collection
                            .doc()
                            .set(createNotificationRecordData(
                              title: 'We met again',
                              description:
                                  '${currentUserDisplayName}${' (${currentUserUid})'} does not want to meet again with ${_model.userDoc?.displayName}${' (${_model.userDoc?.reference.id})'} through Chat on ${dateTimeFormat("yMMMd", getCurrentTimestamp)}',
                              sentBy: currentUserReference,
                              user: currentUserReference,
                              sentAt: getCurrentTimestamp,
                              notificationType: 'report',
                              forAdmin: true,
                              chat: widget!.chatDoc?.reference,
                            ));
                        logFirebaseEvent('Button_show_snack_bar');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Thanks for letting us know',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).secondary,
                          ),
                        );
                        logFirebaseEvent('Button_close_dialog_drawer_etc');
                        Navigator.pop(context);
                      },
                      text: 'no',
                      options: FFButtonOptions(
                        width: 90.0,
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
                        logFirebaseEvent('MEET_AGAIN_COMP_NOT_SURE_BTN_ON_TAP');
                        logFirebaseEvent('Button_backend_call');

                        await NotificationRecord.collection
                            .doc()
                            .set(createNotificationRecordData(
                              title: 'We met again',
                              description:
                                  '${currentUserDisplayName}${' (${currentUserUid})'} is not sure if would meet again with ${_model.userDoc?.displayName}${' (${_model.userDoc?.reference.id})'} through Chat on ${dateTimeFormat("yMMMd", getCurrentTimestamp)}',
                              sentBy: currentUserReference,
                              user: currentUserReference,
                              sentAt: getCurrentTimestamp,
                              notificationType: 'report',
                              forAdmin: true,
                              chat: widget!.chatDoc?.reference,
                            ));
                        logFirebaseEvent('Button_show_snack_bar');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Thanks for letting us know',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).secondary,
                          ),
                        );
                        logFirebaseEvent('Button_close_dialog_drawer_etc');
                        Navigator.pop(context);
                      },
                      text: 'not sure',
                      options: FFButtonOptions(
                        width: 90.0,
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
                        logFirebaseEvent('MEET_AGAIN_COMP_YES_BTN_ON_TAP');
                        logFirebaseEvent('Button_backend_call');

                        await NotificationRecord.collection
                            .doc()
                            .set(createNotificationRecordData(
                              title: 'We met again',
                              description:
                                  '${currentUserDisplayName}${' (${currentUserUid})'} ready to meet again with ${_model.userDoc?.displayName}${' (${_model.userDoc?.reference.id})'} through Chat on ${dateTimeFormat("yMMMd", getCurrentTimestamp)}',
                              sentBy: currentUserReference,
                              user: currentUserReference,
                              sentAt: getCurrentTimestamp,
                              notificationType: 'report',
                              forAdmin: true,
                              chat: widget!.chatDoc?.reference,
                            ));
                        logFirebaseEvent('Button_backend_call');

                        await widget!.chatDoc!.reference.update({
                          ...mapToFirestore(
                            {
                              'weMetList':
                                  FieldValue.arrayUnion([currentUserReference]),
                            },
                          ),
                        });
                        logFirebaseEvent('Button_backend_call');

                        await currentUserReference!.update({
                          ...mapToFirestore(
                            {
                              'we_meet_user_list': FieldValue.arrayUnion([
                                widget!.chatDoc?.userA == currentUserReference
                                    ? widget!.chatDoc?.userB
                                    : widget!.chatDoc?.userA
                              ]),
                            },
                          ),
                        });
                        logFirebaseEvent('Button_backend_call');

                        await widget!.chatDoc?.userA == currentUserReference
                            ? widget!.chatDoc!.userB!
                            : widget!.chatDoc!.userA!.update({
                                ...mapToFirestore(
                                  {
                                    'we_meet_user_list': FieldValue.arrayUnion(
                                        [currentUserReference]),
                                  },
                                ),
                              });
                        logFirebaseEvent('Button_show_snack_bar');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Thanks for letting us know',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).secondary,
                          ),
                        );
                        logFirebaseEvent('Button_close_dialog_drawer_etc');
                        Navigator.pop(context);
                      },
                      text: 'yes',
                      options: FFButtonOptions(
                        width: 90.0,
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

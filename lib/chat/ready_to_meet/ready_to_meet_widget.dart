import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/chat/suggest/suggest_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'ready_to_meet_model.dart';
export 'ready_to_meet_model.dart';

class ReadyToMeetWidget extends StatefulWidget {
  const ReadyToMeetWidget({
    super.key,
    required this.chatdocument,
    required this.user,
    required this.username,
  });

  final ChatRecord? chatdocument;
  final UserRecord? user;
  final String? username;

  @override
  State<ReadyToMeetWidget> createState() => _ReadyToMeetWidgetState();
}

class _ReadyToMeetWidgetState extends State<ReadyToMeetWidget> {
  late ReadyToMeetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReadyToMeetModel());

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
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(40.0),
          shape: BoxShape.rectangle,
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(15.0, 30.0, 15.0, 30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'ready to meet?',
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
                  'she won\'t know your response',
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
              Builder(
                builder: (context) => FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent('READY_TO_MEET_COMP_YES_BTN_ON_TAP');
                    logFirebaseEvent('Button_backend_call');

                    await widget!.chatdocument!.reference.update({
                      ...mapToFirestore(
                        {
                          'dialogVisiableUsers':
                              FieldValue.arrayRemove([currentUserReference]),
                          'responseList': FieldValue.arrayUnion([
                            getSelectUserResponseFirestoreData(
                              updateSelectUserResponseStruct(
                                SelectUserResponseStruct(
                                  userReference: currentUserReference,
                                  responseCreatedTime: getCurrentTimestamp,
                                  responseType: 'Ready to meet',
                                ),
                                clearUnsetFields: false,
                              ),
                              true,
                            )
                          ]),
                        },
                      ),
                    });
                    logFirebaseEvent('Button_backend_call');

                    await NotificationRecord.collection
                        .doc()
                        .set(createNotificationRecordData(
                          title: 'Ready to meet',
                          description:
                              '${currentUserDisplayName}${' (${currentUserUid})'} is ready to meet with ${widget!.user?.displayName}${' (${widget!.user?.uid})'} through Chat on ${dateTimeFormat("yMMMd", getCurrentTimestamp)}',
                          sentBy: currentUserReference,
                          user: currentUserReference,
                          sentAt: getCurrentTimestamp,
                          notificationType: 'ready to meet',
                          forAdmin: true,
                          chat: widget!.chatdocument?.reference,
                        ));
                    logFirebaseEvent('Button_close_dialog_drawer_etc');
                    Navigator.pop(context);
                    logFirebaseEvent('Button_alert_dialog');
                    await showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return Dialog(
                          elevation: 0,
                          insetPadding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          alignment: AlignmentDirectional(0.0, 0.0)
                              .resolve(Directionality.of(context)),
                          child: SuggestWidget(),
                        );
                      },
                    );
                  },
                  text: 'yes',
                  options: FFButtonOptions(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: 40.0,
                    padding: EdgeInsets.all(8.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                        ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  logFirebaseEvent('READY_TO_MEET_COMP_NOT_YET_BTN_ON_TAP');
                  logFirebaseEvent('Button_backend_call');

                  await widget!.chatdocument!.reference.update({
                    ...mapToFirestore(
                      {
                        'dialogVisiableUsers':
                            FieldValue.arrayRemove([currentUserReference]),
                        'responseList': FieldValue.arrayUnion([
                          getSelectUserResponseFirestoreData(
                            updateSelectUserResponseStruct(
                              SelectUserResponseStruct(
                                userReference: currentUserReference,
                                responseCreatedTime: getCurrentTimestamp,
                                responseType: 'Not Ready',
                              ),
                              clearUnsetFields: false,
                            ),
                            true,
                          )
                        ]),
                      },
                    ),
                  });
                  logFirebaseEvent('Button_backend_call');

                  await NotificationRecord.collection
                      .doc()
                      .set(createNotificationRecordData(
                        title: 'Ready to meet',
                        description:
                            '${currentUserDisplayName}${' (${currentUserUid})'} is not ready to meet with ${widget!.user?.displayName}${' (${widget!.user?.uid})'} through Chat on ${dateTimeFormat("yMMMd", getCurrentTimestamp)}',
                        sentBy: currentUserReference,
                        user: currentUserReference,
                        sentAt: getCurrentTimestamp,
                        notificationType: 'ready to meet',
                        forAdmin: true,
                        chat: widget!.chatdocument?.reference,
                      ));
                  logFirebaseEvent('Button_close_dialog_drawer_etc');
                  Navigator.pop(context);
                  logFirebaseEvent('Button_show_snack_bar');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Thanks for letting us know',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      duration: Duration(milliseconds: 4000),
                      backgroundColor: FlutterFlowTheme.of(context).primary,
                    ),
                  );
                },
                text: 'not yet',
                options: FFButtonOptions(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: 40.0,
                  padding: EdgeInsets.all(8.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                      ),
                  elevation: 0.0,
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primary,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  logFirebaseEvent('READY_TO_MEET_WE_HAVE_ALREADY_MET_BTN_ON');
                  logFirebaseEvent('Button_backend_call');

                  await widget!.chatdocument!.reference.update({
                    ...mapToFirestore(
                      {
                        'dialogVisiableUsers':
                            FieldValue.arrayRemove([currentUserReference]),
                        'responseList': FieldValue.arrayUnion([
                          getSelectUserResponseFirestoreData(
                            updateSelectUserResponseStruct(
                              SelectUserResponseStruct(
                                userReference: currentUserReference,
                                responseCreatedTime: getCurrentTimestamp,
                                responseType: 'Already Met',
                              ),
                              clearUnsetFields: false,
                            ),
                            true,
                          )
                        ]),
                      },
                    ),
                  });
                  logFirebaseEvent('Button_backend_call');

                  await NotificationRecord.collection
                      .doc()
                      .set(createNotificationRecordData(
                        title: 'Ready to meet',
                        description:
                            '${currentUserDisplayName}${' (${currentUserUid})'} is already meet with ${widget!.user?.displayName}${' (${widget!.user?.uid})'} through Chat on ${dateTimeFormat("yMMMd", getCurrentTimestamp)}',
                        sentBy: currentUserReference,
                        user: currentUserReference,
                        sentAt: getCurrentTimestamp,
                        notificationType: 'ready to meet',
                        forAdmin: true,
                        chat: widget!.chatdocument?.reference,
                      ));
                  logFirebaseEvent('Button_close_dialog_drawer_etc');
                  Navigator.pop(context);
                  logFirebaseEvent('Button_show_snack_bar');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Thanks for letting us know',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      duration: Duration(milliseconds: 4000),
                      backgroundColor: FlutterFlowTheme.of(context).primary,
                    ),
                  );
                },
                text: 'we have already met',
                options: FFButtonOptions(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: 40.0,
                  padding: EdgeInsets.all(8.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                      ),
                  elevation: 0.0,
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primary,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  logFirebaseEvent('READY_TO_MEET_I_DONT_WANT_TO_EVER_MEET_B');
                  logFirebaseEvent('Button_backend_call');

                  await widget!.chatdocument!.reference.update({
                    ...mapToFirestore(
                      {
                        'dialogVisiableUsers':
                            FieldValue.arrayRemove([currentUserReference]),
                        'responseList': FieldValue.arrayUnion([
                          getSelectUserResponseFirestoreData(
                            updateSelectUserResponseStruct(
                              SelectUserResponseStruct(
                                userReference: currentUserReference,
                                responseCreatedTime: getCurrentTimestamp,
                                responseType: 'Don\'t want to ever meet',
                              ),
                              clearUnsetFields: false,
                            ),
                            true,
                          )
                        ]),
                      },
                    ),
                  });
                  logFirebaseEvent('Button_backend_call');

                  await NotificationRecord.collection
                      .doc()
                      .set(createNotificationRecordData(
                        title: 'Ready to meet',
                        description:
                            '${currentUserDisplayName}${' (${currentUserUid})'} is not ready to meet with ${widget!.user?.displayName}${' (${widget!.user?.uid})'} through Chat on ${dateTimeFormat("yMMMd", getCurrentTimestamp)}',
                        sentBy: currentUserReference,
                        user: currentUserReference,
                        sentAt: getCurrentTimestamp,
                        notificationType: 'ready to meet',
                        forAdmin: true,
                        chat: widget!.chatdocument?.reference,
                      ));
                  logFirebaseEvent('Button_close_dialog_drawer_etc');
                  Navigator.pop(context);
                  logFirebaseEvent('Button_show_snack_bar');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Thanks for letting us know',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      duration: Duration(milliseconds: 4000),
                      backgroundColor: FlutterFlowTheme.of(context).primary,
                    ),
                  );
                },
                text: 'i don\'t want to ever meet',
                options: FFButtonOptions(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: 40.0,
                  padding: EdgeInsets.all(8.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                      ),
                  elevation: 0.0,
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primary,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ].divide(SizedBox(height: 16.0)),
          ),
        ),
      ),
    );
  }
}

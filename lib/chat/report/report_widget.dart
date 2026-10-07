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
import 'report_model.dart';
export 'report_model.dart';

class ReportWidget extends StatefulWidget {
  const ReportWidget({
    super.key,
    this.chatRef,
    required this.chatDoc,
    required this.user,
  });

  final DocumentReference? chatRef;
  final ChatRecord? chatDoc;
  final DocumentReference? user;

  @override
  State<ReportWidget> createState() => _ReportWidgetState();
}

class _ReportWidgetState extends State<ReportWidget> {
  late ReportModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReportModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('REPORT_COMP_report_ON_INIT_STATE');
      logFirebaseEvent('report_backend_call');
      _model.userDocument = await UserRecord.getDocumentOnce(
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
                'report?',
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
                  'she won\'t know she\'s been reported and blocked ',
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
              FFButtonWidget(
                onPressed: () async {
                  logFirebaseEvent('REPORT_COMP_FAKE_PROFILE_BTN_ON_TAP');
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

                  await widget!.chatDoc!.userA!.update({
                    ...mapToFirestore(
                      {
                        'blocked_users':
                            FieldValue.arrayUnion([widget!.chatDoc?.userB]),
                      },
                    ),
                  });
                  logFirebaseEvent('Button_backend_call');

                  await widget!.chatDoc!.userB!.update({
                    ...mapToFirestore(
                      {
                        'blocked_users':
                            FieldValue.arrayUnion([widget!.chatDoc?.userA]),
                      },
                    ),
                  });
                  logFirebaseEvent('Button_backend_call');

                  await ReportRecord.collection
                      .doc()
                      .set(createReportRecordData(
                        userReference: currentUserReference,
                        title: 'fake profile',
                        createdTime: getCurrentTimestamp,
                        chatRef: widget!.chatRef,
                        reportUser: widget!.user,
                      ));
                  logFirebaseEvent('Button_backend_call');

                  await NotificationRecord.collection
                      .doc()
                      .set(createNotificationRecordData(
                        title: 'Report',
                        description:
                            '${currentUserDisplayName}${' (${currentUserUid})'} reported ${_model.userDocument?.displayName}${' (${_model.userDocument?.uid})'} through ${widget!.chatDoc?.isRequested == true ? 'Chat Request' : 'chat'} (fake profile) on ${dateTimeFormat("yMMMd", getCurrentTimestamp)}',
                        sentBy: currentUserReference,
                        user: currentUserReference,
                        sentAt: getCurrentTimestamp,
                        notificationType: 'report',
                        chat: widget!.chatRef,
                        forAdmin: true,
                      ));
                  logFirebaseEvent('Button_close_dialog_drawer_etc');
                  Navigator.pop(context);
                  logFirebaseEvent('Button_show_snack_bar');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'You have reported and blocked this user.  We will review this within 24 hours and take action if necessary.',
                        style: TextStyle(
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                      ),
                      duration: Duration(milliseconds: 4000),
                      backgroundColor: FlutterFlowTheme.of(context).secondary,
                    ),
                  );
                  logFirebaseEvent('Button_navigate_back');
                  context.safePop();
                },
                text: 'fake profile',
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
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  logFirebaseEvent('REPORT_INAPPROPRIATE_CONTENT_BTN_ON_TAP');
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

                  await widget!.chatDoc!.userA!.update({
                    ...mapToFirestore(
                      {
                        'blocked_users':
                            FieldValue.arrayUnion([widget!.chatDoc?.userB]),
                      },
                    ),
                  });
                  logFirebaseEvent('Button_backend_call');

                  await widget!.chatDoc!.userB!.update({
                    ...mapToFirestore(
                      {
                        'blocked_users':
                            FieldValue.arrayUnion([widget!.chatDoc?.userA]),
                      },
                    ),
                  });
                  logFirebaseEvent('Button_backend_call');

                  await ReportRecord.collection
                      .doc()
                      .set(createReportRecordData(
                        userReference: currentUserReference,
                        title: 'inappropriate content',
                        createdTime: getCurrentTimestamp,
                        chatRef: widget!.chatRef,
                        reportUser: widget!.user,
                      ));
                  logFirebaseEvent('Button_backend_call');

                  await NotificationRecord.collection
                      .doc()
                      .set(createNotificationRecordData(
                        title: 'Report',
                        description:
                            '${currentUserDisplayName}${' (${currentUserUid})'} reported ${_model.userDocument?.displayName}${' (${_model.userDocument?.uid})'} through ${widget!.chatDoc?.isRequested == true ? 'Chat Request' : 'Chat'} (inappropriate content) on ${dateTimeFormat("yMMMd", getCurrentTimestamp)}',
                        sentBy: currentUserReference,
                        user: currentUserReference,
                        sentAt: getCurrentTimestamp,
                        notificationType: 'report',
                        chat: widget!.chatRef,
                        forAdmin: true,
                      ));
                  logFirebaseEvent('Button_close_dialog_drawer_etc');
                  Navigator.pop(context);
                  logFirebaseEvent('Button_show_snack_bar');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'You have reported and blocked this user.  We will review this within 24 hours and take action if necessary.',
                        style: TextStyle(
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                      ),
                      duration: Duration(milliseconds: 4000),
                      backgroundColor: FlutterFlowTheme.of(context).secondary,
                    ),
                  );
                  logFirebaseEvent('Button_navigate_back');
                  context.safePop();
                },
                text: 'inappropriate content',
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
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  logFirebaseEvent('REPORT_SPAM_SCAM_OR_ADVERTISING_BTN_ON_T');
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

                  await widget!.chatDoc!.userA!.update({
                    ...mapToFirestore(
                      {
                        'blocked_users':
                            FieldValue.arrayUnion([widget!.chatDoc?.userB]),
                      },
                    ),
                  });
                  logFirebaseEvent('Button_backend_call');

                  await widget!.chatDoc!.userB!.update({
                    ...mapToFirestore(
                      {
                        'blocked_users':
                            FieldValue.arrayUnion([widget!.chatDoc?.userA]),
                      },
                    ),
                  });
                  logFirebaseEvent('Button_backend_call');

                  await ReportRecord.collection
                      .doc()
                      .set(createReportRecordData(
                        userReference: currentUserReference,
                        title: 'spam, scam or advertising',
                        createdTime: getCurrentTimestamp,
                        chatRef: widget!.chatRef,
                        reportUser: widget!.user,
                      ));
                  logFirebaseEvent('Button_backend_call');

                  await NotificationRecord.collection
                      .doc()
                      .set(createNotificationRecordData(
                        title: 'Report',
                        description:
                            '${currentUserDisplayName}${' (${currentUserUid})'} reported ${_model.userDocument?.displayName}${' (${_model.userDocument?.uid})'} through ${widget!.chatDoc?.isRequested == true ? 'Chat Request' : 'Chat'} (spam, scam or advertising) on ${dateTimeFormat("yMMMd", getCurrentTimestamp)}',
                        sentBy: currentUserReference,
                        user: currentUserReference,
                        sentAt: getCurrentTimestamp,
                        notificationType: 'report',
                        chat: widget!.chatRef,
                        forAdmin: true,
                      ));
                  logFirebaseEvent('Button_close_dialog_drawer_etc');
                  Navigator.pop(context);
                  logFirebaseEvent('Button_show_snack_bar');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'You have reported and blocked this user.  We will review this within 24 hours and take action if necessary.',
                        style: TextStyle(
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                      ),
                      duration: Duration(milliseconds: 4000),
                      backgroundColor: FlutterFlowTheme.of(context).secondary,
                    ),
                  );
                  logFirebaseEvent('Button_navigate_back');
                  context.safePop();
                },
                text: 'spam, scam or advertising',
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
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  logFirebaseEvent('REPORT_COMP_UNDERAGE_BTN_ON_TAP');
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

                  await widget!.chatDoc!.userA!.update({
                    ...mapToFirestore(
                      {
                        'blocked_users':
                            FieldValue.arrayUnion([widget!.chatDoc?.userB]),
                      },
                    ),
                  });
                  logFirebaseEvent('Button_backend_call');

                  await widget!.chatDoc!.userB!.update({
                    ...mapToFirestore(
                      {
                        'blocked_users':
                            FieldValue.arrayUnion([widget!.chatDoc?.userA]),
                      },
                    ),
                  });
                  logFirebaseEvent('Button_backend_call');

                  await ReportRecord.collection
                      .doc()
                      .set(createReportRecordData(
                        userReference: currentUserReference,
                        title: 'underage',
                        createdTime: getCurrentTimestamp,
                        chatRef: widget!.chatRef,
                        reportUser: widget!.user,
                      ));
                  logFirebaseEvent('Button_backend_call');

                  await NotificationRecord.collection
                      .doc()
                      .set(createNotificationRecordData(
                        title: 'Report',
                        description:
                            '${currentUserDisplayName}${' (${currentUserUid})'} reported ${_model.userDocument?.displayName}${' (${_model.userDocument?.uid})'} through ${widget!.chatDoc?.isRequested == true ? 'Chat Request' : 'Chat'} (underage) on ${dateTimeFormat("yMMMd", getCurrentTimestamp)}',
                        sentBy: currentUserReference,
                        user: currentUserReference,
                        sentAt: getCurrentTimestamp,
                        notificationType: 'report',
                        chat: widget!.chatRef,
                        forAdmin: true,
                      ));
                  logFirebaseEvent('Button_close_dialog_drawer_etc');
                  Navigator.pop(context);
                  logFirebaseEvent('Button_show_snack_bar');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'You have reported and blocked this user.  We will review this within 24 hours and take action if necessary.',
                        style: TextStyle(
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                      ),
                      duration: Duration(milliseconds: 4000),
                      backgroundColor: FlutterFlowTheme.of(context).secondary,
                    ),
                  );
                  logFirebaseEvent('Button_navigate_back');
                  context.safePop();
                },
                text: 'underage',
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
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  logFirebaseEvent('REPORT_COMP_ABUSIVE_BEHAVIOR_BTN_ON_TAP');
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

                  await widget!.chatDoc!.userA!.update({
                    ...mapToFirestore(
                      {
                        'blocked_users':
                            FieldValue.arrayUnion([widget!.chatDoc?.userB]),
                      },
                    ),
                  });
                  logFirebaseEvent('Button_backend_call');

                  await widget!.chatDoc!.userB!.update({
                    ...mapToFirestore(
                      {
                        'blocked_users':
                            FieldValue.arrayUnion([widget!.chatDoc?.userA]),
                      },
                    ),
                  });
                  logFirebaseEvent('Button_backend_call');

                  await ReportRecord.collection
                      .doc()
                      .set(createReportRecordData(
                        userReference: currentUserReference,
                        title: 'abusive behavior',
                        createdTime: getCurrentTimestamp,
                        chatRef: widget!.chatRef,
                        reportUser: widget!.user,
                      ));
                  logFirebaseEvent('Button_backend_call');

                  await NotificationRecord.collection
                      .doc()
                      .set(createNotificationRecordData(
                        title: 'Report',
                        description:
                            '${currentUserDisplayName}${' (${currentUserUid})'} reported ${_model.userDocument?.displayName}${' (${_model.userDocument?.uid})'} through ${widget!.chatDoc?.isRequested == true ? 'Chat Request' : 'Chat'} (abusive behavior) on ${dateTimeFormat("yMMMd", getCurrentTimestamp)}',
                        sentBy: currentUserReference,
                        user: currentUserReference,
                        sentAt: getCurrentTimestamp,
                        notificationType: 'report',
                        chat: widget!.chatRef,
                        forAdmin: true,
                      ));
                  logFirebaseEvent('Button_close_dialog_drawer_etc');
                  Navigator.pop(context);
                  logFirebaseEvent('Button_show_snack_bar');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'You have reported and blocked this user.  We will review this within 24 hours and take action if necessary.',
                        style: TextStyle(
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                      ),
                      duration: Duration(milliseconds: 4000),
                      backgroundColor: FlutterFlowTheme.of(context).secondary,
                    ),
                  );
                  logFirebaseEvent('Button_navigate_back');
                  context.safePop();
                },
                text: 'abusive behavior',
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
                    color: FlutterFlowTheme.of(context).alternate,
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

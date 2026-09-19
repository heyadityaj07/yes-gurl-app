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
import 'commentreport_model.dart';
export 'commentreport_model.dart';

class CommentreportWidget extends StatefulWidget {
  const CommentreportWidget({
    super.key,
    this.commentevent,
    this.linkupName,
    required this.commentName,
    required this.reportuser,
  });

  final DocumentReference? commentevent;
  final String? linkupName;
  final String? commentName;
  final UserRecord? reportuser;

  @override
  State<CommentreportWidget> createState() => _CommentreportWidgetState();
}

class _CommentreportWidgetState extends State<CommentreportWidget> {
  late CommentreportModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CommentreportModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('COMMENTREPORT_commentreport_ON_INIT_STAT');
      logFirebaseEvent('commentreport_backend_call');
      _model.eventDocument =
          await EventsCommentRecord.getDocumentOnce(widget!.commentevent!);
      logFirebaseEvent('commentreport_backend_call');
      _model.userevent = await UserRecord.getDocumentOnce(
          _model.eventDocument!.commentUserRef!);
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
                  logFirebaseEvent('COMMENTREPORT_FAKE_PROFILE_BTN_ON_TAP');
                  logFirebaseEvent('Button_backend_call');

                  await widget!.commentevent!.update({
                    ...mapToFirestore(
                      {
                        'comment_report':
                            FieldValue.arrayUnion([currentUserReference]),
                      },
                    ),
                  });
                  logFirebaseEvent('Button_backend_call');

                  await currentUserReference!.update({
                    ...mapToFirestore(
                      {
                        'comment_repor_list':
                            FieldValue.arrayUnion([widget!.commentevent]),
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
                        eventCommentReference: widget!.commentevent,
                        reportUser: widget!.reportuser?.reference,
                      ));
                  logFirebaseEvent('Button_backend_call');

                  await NotificationRecord.collection
                      .doc()
                      .set(createNotificationRecordData(
                        title: 'Report: Comment',
                        description:
                            '${currentUserDisplayName}${' (${currentUserUid})'} reported ${_model.userevent?.displayName}${' (${_model.userevent?.uid})'} through Link Up Comment \"${widget!.commentName}\"  (fake profile) on ${widget!.linkupName} ${dateTimeFormat("yMMMd", getCurrentTimestamp)}',
                        sentBy: currentUserReference,
                        user: currentUserReference,
                        sentAt: getCurrentTimestamp,
                        notificationType: 'report',
                        forAdmin: true,
                      ));
                  logFirebaseEvent('Button_close_dialog_drawer_etc');
                  Navigator.pop(context);
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
                  logFirebaseEvent('COMMENTREPORT_INAPPROPRIATE_CONTENT_BTN_');
                  logFirebaseEvent('Button_backend_call');

                  await widget!.commentevent!.update({
                    ...mapToFirestore(
                      {
                        'comment_report':
                            FieldValue.arrayUnion([currentUserReference]),
                      },
                    ),
                  });
                  logFirebaseEvent('Button_backend_call');

                  await currentUserReference!.update({
                    ...mapToFirestore(
                      {
                        'comment_repor_list':
                            FieldValue.arrayUnion([widget!.commentevent]),
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
                        eventCommentReference: widget!.commentevent,
                        reportUser: widget!.reportuser?.reference,
                      ));
                  logFirebaseEvent('Button_backend_call');

                  await NotificationRecord.collection
                      .doc()
                      .set(createNotificationRecordData(
                        title: 'Report: Comment',
                        description:
                            '${currentUserDisplayName}${' (${currentUserUid})'} reported ${_model.userevent?.displayName}${' (${_model.userevent?.uid})'} through Link Up Comment \"${widget!.commentName}\" (inappropriate content) on ${widget!.linkupName} ${dateTimeFormat("yMMMd", getCurrentTimestamp)}',
                        sentBy: currentUserReference,
                        user: currentUserReference,
                        sentAt: getCurrentTimestamp,
                        notificationType: 'report',
                        forAdmin: true,
                      ));
                  logFirebaseEvent('Button_close_dialog_drawer_etc');
                  Navigator.pop(context);
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
                  logFirebaseEvent('COMMENTREPORT_SPAM_SCAM_OR_ADVERTISING_B');
                  logFirebaseEvent('Button_backend_call');

                  await widget!.commentevent!.update({
                    ...mapToFirestore(
                      {
                        'comment_report':
                            FieldValue.arrayUnion([currentUserReference]),
                      },
                    ),
                  });
                  logFirebaseEvent('Button_backend_call');

                  await currentUserReference!.update({
                    ...mapToFirestore(
                      {
                        'comment_repor_list':
                            FieldValue.arrayUnion([widget!.commentevent]),
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
                        eventCommentReference: widget!.commentevent,
                        reportUser: widget!.reportuser?.reference,
                      ));
                  logFirebaseEvent('Button_backend_call');

                  await NotificationRecord.collection
                      .doc()
                      .set(createNotificationRecordData(
                        title: 'Report: Comment',
                        description:
                            '${currentUserDisplayName}${' (${currentUserUid})'} reported ${_model.userevent?.displayName}${' (${_model.userevent?.uid})'} through Link Up Comment \"${widget!.commentName}\" (spam, scam or advertising) on ${widget!.linkupName} ${dateTimeFormat("yMMMd", getCurrentTimestamp)}',
                        sentBy: currentUserReference,
                        user: currentUserReference,
                        sentAt: getCurrentTimestamp,
                        notificationType: 'report',
                        forAdmin: true,
                      ));
                  logFirebaseEvent('Button_close_dialog_drawer_etc');
                  Navigator.pop(context);
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
                  logFirebaseEvent('COMMENTREPORT_COMP_UNDERAGE_BTN_ON_TAP');
                  logFirebaseEvent('Button_backend_call');

                  await widget!.commentevent!.update({
                    ...mapToFirestore(
                      {
                        'comment_report':
                            FieldValue.arrayUnion([currentUserReference]),
                      },
                    ),
                  });
                  logFirebaseEvent('Button_backend_call');

                  await currentUserReference!.update({
                    ...mapToFirestore(
                      {
                        'comment_repor_list':
                            FieldValue.arrayUnion([widget!.commentevent]),
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
                        eventCommentReference: widget!.commentevent,
                        reportUser: widget!.reportuser?.reference,
                      ));
                  logFirebaseEvent('Button_backend_call');

                  await NotificationRecord.collection
                      .doc()
                      .set(createNotificationRecordData(
                        title: 'Report: Comment',
                        description:
                            '${currentUserDisplayName}${' (${currentUserUid})'} reported ${_model.userevent?.displayName}${' (${_model.userevent?.uid})'} through Link Up Comment \"${widget!.commentName}\" (underage) on ${widget!.linkupName} ${dateTimeFormat("yMMMd", getCurrentTimestamp)}',
                        sentBy: currentUserReference,
                        user: currentUserReference,
                        sentAt: getCurrentTimestamp,
                        notificationType: 'report',
                        forAdmin: true,
                      ));
                  logFirebaseEvent('Button_close_dialog_drawer_etc');
                  Navigator.pop(context);
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
                  logFirebaseEvent('COMMENTREPORT_ABUSIVE_BEHAVIOR_BTN_ON_TA');
                  logFirebaseEvent('Button_backend_call');

                  await widget!.commentevent!.update({
                    ...mapToFirestore(
                      {
                        'comment_report':
                            FieldValue.arrayUnion([currentUserReference]),
                      },
                    ),
                  });
                  logFirebaseEvent('Button_backend_call');

                  await currentUserReference!.update({
                    ...mapToFirestore(
                      {
                        'comment_repor_list':
                            FieldValue.arrayUnion([widget!.commentevent]),
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
                        eventCommentReference: widget!.commentevent,
                        reportUser: widget!.reportuser?.reference,
                      ));
                  logFirebaseEvent('Button_backend_call');

                  await NotificationRecord.collection
                      .doc()
                      .set(createNotificationRecordData(
                        title: 'Report: Comment',
                        description:
                            '${currentUserDisplayName}${' (${currentUserUid})'} reported ${_model.userevent?.displayName}${' (${_model.userevent?.uid})'} through Link Up Comment \"${widget!.commentName}\" (abusive behavior) on ${widget!.linkupName} ${dateTimeFormat("yMMMd", getCurrentTimestamp)}',
                        sentBy: currentUserReference,
                        user: currentUserReference,
                        sentAt: getCurrentTimestamp,
                        notificationType: 'report',
                        forAdmin: true,
                      ));
                  logFirebaseEvent('Button_close_dialog_drawer_etc');
                  Navigator.pop(context);
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

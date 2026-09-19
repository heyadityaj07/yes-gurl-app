import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'delete_link_up_model.dart';
export 'delete_link_up_model.dart';

class DeleteLinkUpWidget extends StatefulWidget {
  const DeleteLinkUpWidget({
    super.key,
    required this.eventDocument,
  });

  final DocumentReference? eventDocument;

  @override
  State<DeleteLinkUpWidget> createState() => _DeleteLinkUpWidgetState();
}

class _DeleteLinkUpWidgetState extends State<DeleteLinkUpWidget> {
  late DeleteLinkUpModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DeleteLinkUpModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EventsRecord>(
      stream: EventsRecord.getDocument(widget!.eventDocument!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: LinearProgressIndicator(
              color: Color(0xFFFE99AB),
            ),
          );
        }

        final containerEventsRecord = snapshot.data!;

        return Container(
          decoration: BoxDecoration(),
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(15.0, 30.0, 15.0, 30.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'delete?',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .displaySmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .displaySmallFamily,
                                  fontSize: 27.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .displaySmallIsCustom,
                                ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 15.0, 0.0, 15.0),
                            child: Text(
                              'your link up will be permanently deleted',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyMediumIsCustom,
                                  ),
                            ),
                          ),
                        ].divide(SizedBox(height: 7.0)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: FFButtonWidget(
                              onPressed: () async {
                                logFirebaseEvent(
                                    'DELETE_LINK_UP_COMP_CANCEL_BTN_ON_TAP');
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
                                    .titleSmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleSmallFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .titleSmallIsCustom,
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
                                    'DELETE_LINK_UP_COMP_DELETE_BTN_ON_TAP');
                                while (containerEventsRecord.attending.length >
                                    _model.deleteIndex) {
                                  logFirebaseEvent('Button_backend_call');
                                  _model.user =
                                      await UserRecord.getDocumentOnce(
                                          containerEventsRecord.attending
                                              .elementAtOrNull(
                                                  _model.deleteIndex)!);
                                  if (_model.user!.isNotificationEnabled) {
                                    logFirebaseEvent(
                                        'Button_trigger_push_notification');
                                    triggerPushNotification(
                                      notificationTitle: 'Link up deleted',
                                      notificationText:
                                          '${containerEventsRecord.name} has been deleted',
                                      notificationSound: 'default',
                                      userRefs: containerEventsRecord
                                          .invitedUser
                                          .where((e) => e.id != currentUserUid)
                                          .toList(),
                                      initialPageName: 'LinkUp',
                                      parameterData: {},
                                    );
                                  }
                                  logFirebaseEvent(
                                      'Button_update_component_state');
                                  _model.userindex =
                                      containerEventsRecord.invitedUser.length;
                                  safeSetState(() {});
                                  while (_model.userindex != 0) {
                                    logFirebaseEvent(
                                        'Button_update_component_state');
                                    _model.userindex = _model.userindex + -1;
                                    safeSetState(() {});
                                    logFirebaseEvent('Button_backend_call');

                                    await NotificationRecord.collection
                                        .doc()
                                        .set({
                                      ...createNotificationRecordData(
                                        title:
                                            '${containerEventsRecord.name} has been deleted',
                                        sentBy: currentUserReference,
                                        user: containerEventsRecord.invitedUser
                                            .elementAtOrNull(_model.userindex),
                                        notificationType: 'delete Linkup',
                                        linkup: widget!.eventDocument,
                                        seen: false,
                                        forAdmin: false,
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'sent_at':
                                              FieldValue.serverTimestamp(),
                                        },
                                      ),
                                    });
                                  }
                                  logFirebaseEvent(
                                      'Button_update_component_state');
                                  _model.deleteIndex = _model.deleteIndex + 1;
                                  safeSetState(() {});
                                }
                                logFirebaseEvent('Button_backend_call');
                                await widget!.eventDocument!.delete();
                                logFirebaseEvent('Button_show_snack_bar');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'You have deleted this Link Up',
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
                                logFirebaseEvent('Button_bottom_sheet');
                                Navigator.pop(context);

                                safeSetState(() {});
                              },
                              text: 'delete',
                              options: FFButtonOptions(
                                width: 120.0,
                                height: 40.0,
                                padding: EdgeInsets.all(8.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleSmallFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .titleSmallIsCustom,
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 10.0)),
                      ),
                    ].divide(SizedBox(height: 20.0)),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

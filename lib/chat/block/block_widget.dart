import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'block_model.dart';
export 'block_model.dart';

class BlockWidget extends StatefulWidget {
  const BlockWidget({
    super.key,
    this.chatRef,
    required this.chatDoc,
    required this.isRequest,
  });

  final DocumentReference? chatRef;
  final ChatRecord? chatDoc;
  final bool? isRequest;

  @override
  State<BlockWidget> createState() => _BlockWidgetState();
}

class _BlockWidgetState extends State<BlockWidget>
    with TickerProviderStateMixin {
  late BlockModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BlockModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('BLOCK_COMP_block_ON_INIT_STATE');
      logFirebaseEvent('block_backend_call');
      _model.userDocument = await UserRecord.getDocumentOnce(
          widget!.chatDoc?.userA == currentUserReference
              ? widget!.chatDoc!.userB!
              : widget!.chatDoc!.userA!);
    });

    animationsMap.addAll({
      'textOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'textOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 50.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'buttonOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'buttonOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 150.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
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
                'block?',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).displaySmall.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).displaySmallFamily,
                      fontSize: 27.0,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).displaySmallIsCustom,
                    ),
              ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation1']!),
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
                ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation2']!),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: FFButtonWidget(
                      onPressed: () async {
                        logFirebaseEvent('BLOCK_COMP_CANCEL_BTN_ON_TAP');
                        logFirebaseEvent('Button_navigate_back');
                        context.safePop();
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
                    ).animateOnPageLoad(
                        animationsMap['buttonOnPageLoadAnimation1']!),
                  ),
                  Expanded(
                    child: FFButtonWidget(
                      onPressed: () async {
                        logFirebaseEvent('BLOCK_COMP_BLOCK_BTN_ON_TAP');
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

                        await _model.userDocument!.reference.update({
                          ...mapToFirestore(
                            {
                              'blocked_users':
                                  FieldValue.arrayUnion([currentUserReference]),
                            },
                          ),
                        });
                        logFirebaseEvent('Button_backend_call');

                        await currentUserReference!.update({
                          ...mapToFirestore(
                            {
                              'blocked_users': FieldValue.arrayUnion(
                                  [_model.userDocument?.reference]),
                            },
                          ),
                        });
                        logFirebaseEvent('Button_backend_call');

                        await NotificationRecord.collection
                            .doc()
                            .set(createNotificationRecordData(
                              title: 'Block',
                              description: widget!.isRequest!
                                  ? '${currentUserDisplayName}${' (${currentUserUid})'} blocked ${_model.userDocument?.displayName}${' (${_model.userDocument?.uid})'}   through Chat Request on ${dateTimeFormat("yMMMd", getCurrentTimestamp)}'
                                  : '${currentUserDisplayName}${' (${currentUserUid})'} blocked ${_model.userDocument?.displayName}${' (${_model.userDocument?.uid})'} through Chat on ${dateTimeFormat("yMMMd", getCurrentTimestamp)}',
                              sentBy: currentUserReference,
                              user: currentUserReference,
                              sentAt: getCurrentTimestamp,
                              notificationType: 'report',
                              forAdmin: true,
                            ));
                        logFirebaseEvent('Button_show_snack_bar');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'You have blocked this user.',
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
                      text: 'block',
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
                    ).animateOnPageLoad(
                        animationsMap['buttonOnPageLoadAnimation2']!),
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

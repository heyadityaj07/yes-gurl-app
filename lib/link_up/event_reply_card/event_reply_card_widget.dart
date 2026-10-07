import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'event_reply_card_model.dart';
export 'event_reply_card_model.dart';

class EventReplyCardWidget extends StatefulWidget {
  const EventReplyCardWidget({
    super.key,
    this.comment,
    required this.dismisAction,
  });

  final EventsCommentRecord? comment;
  final Future Function()? dismisAction;

  @override
  State<EventReplyCardWidget> createState() => _EventReplyCardWidgetState();
}

class _EventReplyCardWidgetState extends State<EventReplyCardWidget>
    with TickerProviderStateMixin {
  late EventReplyCardModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventReplyCardModel());

    _model.replyComponentTextController ??= TextEditingController();
    _model.replyComponentFocusNode ??= FocusNode();
    _model.replyComponentFocusNode!.addListener(
      () async {
        logFirebaseEvent('EVENT_REPLY_CARD_replyComponent_ON_FOCUS');
        logFirebaseEvent('replyComponent_rebuild_component');
        safeSetState(() {});
      },
    );
    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 200.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 60.0),
            end: Offset(0.0, 0.0),
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
    return Container(
      decoration: BoxDecoration(
        color: Color(0x19FE99AB),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Reply',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).headlineSmallFamily,
                        fontSize: 20.0,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                      ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    logFirebaseEvent('EVENT_REPLY_CARD_Icon_vccxt93u_ON_TAP');
                    logFirebaseEvent('Icon_execute_callback');
                    await widget.dismisAction?.call();
                  },
                  child: Icon(
                    Icons.close,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 24.0,
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(40.0),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).alternate,
                  width: 2.0,
                ),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 3.0, 4.0, 3.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _model.replyComponentTextController,
                        focusNode: _model.replyComponentFocusNode,
                        onChanged: (_) => EasyDebounce.debounce(
                          '_model.replyComponentTextController',
                          Duration(milliseconds: 0),
                          () async {
                            logFirebaseEvent(
                                'EVENT_REPLY_CARD_replyComponent_ON_TEXTF');
                            logFirebaseEvent(
                                'replyComponent_rebuild_component');
                            safeSetState(() {});
                          },
                        ),
                        autofocus: false,
                        obscureText: false,
                        decoration: InputDecoration(
                          isDense: true,
                          labelStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelMediumFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelMediumIsCustom,
                              ),
                          hintText: 'Write a reply...',
                          hintStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelMediumFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelMediumIsCustom,
                              ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyMediumIsCustom,
                            ),
                        maxLines: 3,
                        minLines: 1,
                        cursorColor: FlutterFlowTheme.of(context).primaryText,
                        enableInteractiveSelection: true,
                        validator: _model.replyComponentTextControllerValidator
                            .asValidator(context),
                      ),
                    ),
                    FlutterFlowIconButton(
                      borderRadius: 30.0,
                      buttonSize: 40.0,
                      fillColor: FlutterFlowTheme.of(context).primary,
                      icon: Icon(
                        Icons.send,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 20.0,
                      ),
                      onPressed: () async {
                        logFirebaseEvent(
                            'EVENT_REPLY_CARD_COMP_send_ICN_ON_TAP');
                        if (_model.replyComponentTextController.text != null &&
                            _model.replyComponentTextController.text != '') {
                          if (_model.comment) {
                            return;
                          }

                          logFirebaseEvent('IconButton_update_component_state');
                          _model.comment = true;
                          safeSetState(() {});
                          logFirebaseEvent('IconButton_backend_call');

                          await EventsCommentRecord.collection
                              .doc()
                              .set(createEventsCommentRecordData(
                                commentTitle:
                                    _model.replyComponentTextController.text,
                                commentTime: getCurrentTimestamp,
                                commentUserRef: currentUserReference,
                                commentEventRef:
                                    widget!.comment?.commentEventRef,
                                notificationSend: true,
                                replyComment: widget!.comment?.reference,
                              ));
                          logFirebaseEvent(
                              'IconButton_clear_text_fields_pin_codes');
                          safeSetState(() {
                            _model.replyComponentTextController?.clear();
                          });
                          logFirebaseEvent('IconButton_update_component_state');
                          _model.comment = false;
                          safeSetState(() {});
                          logFirebaseEvent('IconButton_execute_callback');
                          await widget.dismisAction?.call();
                        } else {
                          logFirebaseEvent('IconButton_show_snack_bar');
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'please write a message first',
                                style: TextStyle(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                              duration: Duration(milliseconds: 4000),
                              backgroundColor:
                                  FlutterFlowTheme.of(context).secondary,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ].divide(SizedBox(height: 8.0)),
        ),
      ),
    ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!);
  }
}

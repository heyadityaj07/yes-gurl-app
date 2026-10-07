import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/chat/pausealert/pausealert_widget.dart';
import '/communities/community_message_option/community_message_option_widget.dart';
import '/communities/confirmation_dialogue/confirmation_dialogue_widget.dart';
import '/communities/messagereport/messagereport_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';
import 'package:provider/provider.dart';
import 'message_card_model.dart';
export 'message_card_model.dart';

class MessageCardWidget extends StatefulWidget {
  const MessageCardWidget({
    super.key,
    required this.message,
    required this.member,
    required this.communty,
    this.onReply,
  });

  final MessagesRecord? message;
  final MembersRecord? member;
  final CommunityRecord? communty;
  final Future Function()? onReply;

  @override
  State<MessageCardWidget> createState() => _MessageCardWidgetState();
}

class _MessageCardWidgetState extends State<MessageCardWidget> {
  late MessageCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MessageCardModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserRecord>>(
      stream: queryUserRecord(
        queryBuilder: (userRecord) => userRecord.where(
          'uid',
          isEqualTo: widget!.message?.userRef?.id,
        ),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.transparent,
                ),
              ),
            ),
          );
        }
        List<UserRecord> columnUserRecordList = snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final columnUserRecord =
            columnUserRecordList.isNotEmpty ? columnUserRecordList.first : null;

        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Builder(
                    builder: (context) => InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent(
                            'MESSAGE_CARD_Container_fqdexlqx_ON_TAP');
                        if (columnUserRecord?.isDeactivated == true) {
                          logFirebaseEvent('Container_alert_dialog');
                          await showDialog(
                            context: context,
                            builder: (dialogContext) {
                              return Dialog(
                                elevation: 0,
                                insetPadding: EdgeInsets.zero,
                                backgroundColor: Colors.transparent,
                                alignment: AlignmentDirectional(0.0, 0.0)
                                    .resolve(Directionality.of(context)),
                                child: PausealertWidget(
                                  name: columnUserRecord!.displayName,
                                ),
                              );
                            },
                          );
                        } else {
                          logFirebaseEvent('Container_navigate_to');

                          context.pushNamed(
                            PotentialMatchesProfileWidget.routeName,
                            queryParameters: {
                              'userRef': serializeParam(
                                columnUserRecord?.reference,
                                ParamType.DocumentReference,
                              ),
                              'throughUserProfile': serializeParam(
                                'yes',
                                ParamType.String,
                              ),
                            }.withoutNulls,
                          );
                        }
                      },
                      child: Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Visibility(
                          visible: columnUserRecord?.displayImage != null &&
                              columnUserRecord?.displayImage != '',
                          child: Builder(
                            builder: (context) => Padding(
                              padding: EdgeInsets.all(2.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  logFirebaseEvent(
                                      'MESSAGE_CARD_COMP_Image_0zzeocak_ON_TAP');
                                  if (columnUserRecord?.isDeactivated == true) {
                                    logFirebaseEvent('Image_alert_dialog');
                                    await showDialog(
                                      context: context,
                                      builder: (dialogContext) {
                                        return Dialog(
                                          elevation: 0,
                                          insetPadding: EdgeInsets.zero,
                                          backgroundColor: Colors.transparent,
                                          alignment: AlignmentDirectional(
                                                  0.0, 0.0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          child: PausealertWidget(
                                            name: columnUserRecord!.displayName,
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    logFirebaseEvent('Image_navigate_to');

                                    context.pushNamed(
                                      PotentialMatchesProfileWidget.routeName,
                                      queryParameters: {
                                        'userRef': serializeParam(
                                          columnUserRecord?.reference,
                                          ParamType.DocumentReference,
                                        ),
                                        'throughUserProfile': serializeParam(
                                          'yes',
                                          ParamType.String,
                                        ),
                                      }.withoutNulls,
                                    );
                                  }
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60.0),
                                  child: OctoImage(
                                    placeholderBuilder: (_) {
                                      final blurHash =
                                          'LEHV6nWB2yk8pyo0adR*.7kCMdnj';

                                      if (!validateBlurhash(blurHash)) {
                                        return const SizedBox.shrink();
                                      }
                                      return SizedBox.expand(
                                        child: Image(
                                          image: BlurHashImage(blurHash),
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                    image: CachedNetworkImageProvider(
                                      columnUserRecord!.displayImage,
                                    ),
                                    width: 70.0,
                                    height: 60.0,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                      'assets/images/error_image.png',
                                      width: 70.0,
                                      height: 60.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 0.0, 0.0),
                            child: Text(
                              '${columnUserRecord?.displayName}${columnUserRecord?.reference == currentUserReference ? ' (you)' : ''}',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyMediumIsCustom,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 0.0, 0.0),
                            child: Text(
                              dateTimeFormat(
                                  "relative", widget!.message!.createdAt!),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyMediumIsCustom,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (widget!.message?.deletedBy == null)
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Builder(
                        builder: (context) => FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 20.0,
                          buttonSize: 40.0,
                          icon: Icon(
                            Icons.more_vert_rounded,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                          onPressed: () async {
                            logFirebaseEvent(
                                'MESSAGE_CARD_more_vert_rounded_ICN_ON_TA');
                            logFirebaseEvent('IconButton_alert_dialog');
                            await showDialog(
                              context: context,
                              builder: (dialogContext) {
                                return Dialog(
                                  elevation: 0,
                                  insetPadding: EdgeInsets.zero,
                                  backgroundColor: Colors.transparent,
                                  alignment: AlignmentDirectional(0.0, 0.0)
                                      .resolve(Directionality.of(context)),
                                  child: CommunityMessageOptionWidget(
                                    message: widget!.message!,
                                    community: widget!.communty!,
                                  ),
                                );
                              },
                            ).then((value) =>
                                safeSetState(() => _model.option = value));

                            if (_model.option == 'report') {
                              logFirebaseEvent('IconButton_alert_dialog');
                              await showDialog(
                                context: context,
                                builder: (dialogContext) {
                                  return Dialog(
                                    elevation: 0,
                                    insetPadding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
                                    alignment: AlignmentDirectional(0.0, 0.0)
                                        .resolve(Directionality.of(context)),
                                    child: MessagereportWidget(
                                      commentName: widget!.message!.text,
                                      reportuser: columnUserRecord!,
                                      commentevent: widget!.message?.reference,
                                      linkupName: widget!.communty?.name,
                                    ),
                                  );
                                },
                              );
                            } else if (_model.option == 'delete') {
                              logFirebaseEvent('IconButton_alert_dialog');
                              await showDialog(
                                context: context,
                                builder: (dialogContext) {
                                  return Dialog(
                                    elevation: 0,
                                    insetPadding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
                                    alignment: AlignmentDirectional(0.0, 0.0)
                                        .resolve(Directionality.of(context)),
                                    child: ConfirmationDialogueWidget(
                                      title: 'delete?',
                                      message:
                                          'If you delete your message, the message box will show ${widget!.communty?.createdBy == currentUserReference ? 'The host' : currentUserDisplayName} has deleted a message.',
                                      buttonText: 'delete',
                                      action: () async {
                                        logFirebaseEvent('_backend_call');

                                        await widget!.message!.reference
                                            .update(createMessagesRecordData(
                                          deletedAt: getCurrentTimestamp,
                                          deletedBy: currentUserReference,
                                          text:
                                              '${widget!.communty?.createdBy == currentUserReference ? 'The host' : currentUserDisplayName} has deleted a message.',
                                        ));
                                      },
                                    ),
                                  );
                                },
                              );
                            } else if (_model.option == 'remove') {
                              logFirebaseEvent('IconButton_alert_dialog');
                              await showDialog(
                                context: context,
                                builder: (dialogContext) {
                                  return Dialog(
                                    elevation: 0,
                                    insetPadding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
                                    alignment: AlignmentDirectional(0.0, 0.0)
                                        .resolve(Directionality.of(context)),
                                    child: ConfirmationDialogueWidget(
                                      title: 'Remove?',
                                      message:
                                          'Are you sure you want to remove this member?',
                                      buttonText: 'Remove',
                                      action: () async {
                                        logFirebaseEvent('_backend_call');

                                        await widget!.communty!.reference
                                            .update({
                                          ...mapToFirestore(
                                            {
                                              'removed_members':
                                                  FieldValue.arrayUnion([
                                                columnUserRecord?.reference
                                              ]),
                                              'members':
                                                  FieldValue.increment(-(1)),
                                            },
                                          ),
                                        });
                                        logFirebaseEvent('_firestore_query');
                                        _model.memberData =
                                            await queryMembersRecordOnce(
                                          parent: widget!.communty?.reference,
                                          queryBuilder: (membersRecord) =>
                                              membersRecord.where(
                                            'user_ref',
                                            isEqualTo:
                                                columnUserRecord?.reference,
                                          ),
                                          singleRecord: true,
                                        ).then((s) => s.firstOrNull);
                                        logFirebaseEvent('_backend_call');
                                        await _model.memberData!.reference
                                            .delete();
                                        logFirebaseEvent('_show_snack_bar');
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'You removed this member from community',
                                              style: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                            ),
                                            duration:
                                                Duration(milliseconds: 4000),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            }

                            safeSetState(() {});
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 3.0),
                      child: Text(
                        widget!.message!.text,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyMediumIsCustom,
                            ),
                      ),
                    ),
                  ),
                  if ((widget!.onReply != null) &&
                      !widget!.message!.isReply &&
                      (widget!.member != null))
                    FlutterFlowIconButton(
                      borderRadius: 8.0,
                      buttonSize: 40.0,
                      icon: Icon(
                        Icons.reply_sharp,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        logFirebaseEvent(
                            'MESSAGE_CARD_COMP_reply_sharp_ICN_ON_TAP');
                        logFirebaseEvent('IconButton_execute_callback');
                        await widget.onReply?.call();
                      },
                    ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent('MESSAGE_CARD_COMP_Row_13ogfkk4_ON_TAP');
                      if (widget!.member != null) {
                        if (widget!.message!.likedBy.isNotEmpty) {
                          logFirebaseEvent('Row_backend_call');

                          await widget!.message!.reference.update({
                            ...mapToFirestore(
                              {
                                'liked_by': FieldValue.arrayRemove(
                                    [currentUserReference]),
                              },
                            ),
                          });
                        } else {
                          logFirebaseEvent('Row_backend_call');

                          await widget!.message!.reference.update({
                            ...mapToFirestore(
                              {
                                'liked_by': FieldValue.arrayUnion(
                                    [currentUserReference]),
                              },
                            ),
                          });
                          if (columnUserRecord?.reference !=
                              currentUserReference) {
                            if (columnUserRecord!.isNotificationEnabled) {
                              logFirebaseEvent('Row_trigger_push_notification');
                              triggerPushNotification(
                                notificationTitle:
                                    '${currentUserDisplayName} liked your message',
                                notificationText:
                                    '${currentUserDisplayName} liked your message for ${widget!.communty?.name}',
                                notificationSound: 'default',
                                userRefs: [columnUserRecord!.reference],
                                initialPageName: 'communityDetail',
                                parameterData: {
                                  'communityRef': widget!.communty?.reference,
                                },
                              );
                            }
                            logFirebaseEvent('Row_backend_call');

                            await NotificationRecord.collection
                                .doc()
                                .set(createNotificationRecordData(
                                  title:
                                      '${currentUserDisplayName} liked your message for ${widget!.communty?.name}',
                                  sentBy: currentUserReference,
                                  user: columnUserRecord?.reference,
                                  notificationType: 'community',
                                  sentAt: getCurrentTimestamp,
                                  forAdmin: false,
                                  seen: false,
                                  community: widget!.communty?.reference,
                                ));
                          }
                        }
                      } else {
                        logFirebaseEvent('Row_show_snack_bar');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Please join the community to like this message.',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).secondary,
                          ),
                        );
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 4.0, 0.0),
                          child: Builder(
                            builder: (context) {
                              if (widget!.message?.likedBy
                                      ?.contains(currentUserReference) ??
                                  false) {
                                return Icon(
                                  Icons.favorite_sharp,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 24.0,
                                );
                              } else {
                                return Icon(
                                  Icons.favorite_border_outlined,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 24.0,
                                );
                              }
                            },
                          ),
                        ),
                        if (widget!.message?.likedBy != null &&
                            (widget!.message?.likedBy)!.isNotEmpty)
                          Text(
                            valueOrDefault<String>(
                              widget!.message?.likedBy?.length?.toString(),
                              '0',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodyMediumIsCustom,
                                ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

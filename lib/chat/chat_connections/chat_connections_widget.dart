import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/chat/block/block_widget.dart';
import '/chat/chat_dropdown/chat_dropdown_widget.dart';
import '/chat/disconnect/disconnect_widget.dart';
import '/chat/pausealert/pausealert_widget.dart';
import '/chat/ready_to_meet/ready_to_meet_widget.dart';
import '/chat/report/report_widget.dart';
import '/chat/we_met/we_met_widget.dart';
import '/components/message_box_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';
import 'package:provider/provider.dart';
import 'chat_connections_model.dart';
export 'chat_connections_model.dart';

class ChatConnectionsWidget extends StatefulWidget {
  const ChatConnectionsWidget({
    super.key,
    required this.chatRef,
  });

  final DocumentReference? chatRef;

  static String routeName = 'chatConnections';
  static String routePath = '/chatConnections';

  @override
  State<ChatConnectionsWidget> createState() => _ChatConnectionsWidgetState();
}

class _ChatConnectionsWidgetState extends State<ChatConnectionsWidget> {
  late ChatConnectionsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatConnectionsModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'chatConnections'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('CHAT_CONNECTIONS_chatConnections_ON_INIT');
      logFirebaseEvent('chatConnections_update_app_state');
      FFAppState().sharabelImage = '';
      FFAppState().sharedEvent = null;
      FFAppState().currentChat = widget!.chatRef;
      safeSetState(() {});
      logFirebaseEvent('chatConnections_backend_call');
      _model.isChatDocument =
          await ChatRecord.getDocumentOnce(widget!.chatRef!);
      logFirebaseEvent('chatConnections_firestore_query');
      _model.messages = await queryChatMessageRecordOnce(
        queryBuilder: (chatMessageRecord) => chatMessageRecord.where(
          'chatRef',
          isEqualTo: widget!.chatRef,
        ),
      );
      if (currentUserReference == null) {
        logFirebaseEvent('chatConnections_wait__delay');
        await Future.delayed(
          Duration(
            milliseconds: 500,
          ),
        );
      }
      if ((_model.isChatDocument?.userA == currentUserReference) ||
          (_model.isChatDocument?.userB == currentUserReference)) {
        if (_model.isChatDocument?.displayDialogCount == 0) {
          logFirebaseEvent('chatConnections_backend_call');
          unawaited(
            () async {
              await widget!.chatRef!.update({
                ...createChatRecordData(
                  displayDialogCount: 20,
                ),
                ...mapToFirestore(
                  {
                    'dialogVisiableUsers': functions.createChatUserList(
                        _model.isChatDocument!.userA!,
                        _model.isChatDocument!.userB!),
                  },
                ),
              });
            }(),
          );
        }
      } else {
        logFirebaseEvent('chatConnections_navigate_to');

        context.goNamed(ProfileWidget.routeName);
      }
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
    _model.textFieldFocusNode!.addListener(() => safeSetState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    // On page dispose action.
    () async {
      logFirebaseEvent('CHAT_CONNECTIONS_chatConnections_ON_DISP');
      logFirebaseEvent('chatConnections_update_app_state');
      FFAppState().currentChat = null;
    }();

    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<ChatRecord>(
      stream: ChatRecord.getDocument(widget!.chatRef!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: Center(
              child: SizedBox(
                width: 40.0,
                height: 40.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0x00FE99AB),
                  ),
                ),
              ),
            ),
          );
        }

        final chatConnectionsChatRecord = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              automaticallyImplyLeading: false,
              leading: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                child: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30.0,
                  buttonSize: 40.0,
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 30.0,
                  ),
                  onPressed: () async {
                    logFirebaseEvent(
                        'CHAT_CONNECTIONS_arrow_back_ios_ICN_ON_T');
                    logFirebaseEvent('IconButton_navigate_back');
                    context.safePop();
                  },
                ),
              ),
              title: Text(
                'yes gurl',
                style: FlutterFlowTheme.of(context).displaySmall.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).displaySmallFamily,
                      fontSize: 25.0,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).displaySmallIsCustom,
                    ),
              ),
              actions: [],
              centerTitle: true,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: StreamBuilder<UserRecord>(
                stream: UserRecord.getDocument(
                    chatConnectionsChatRecord.userA == currentUserReference
                        ? chatConnectionsChatRecord.userB!
                        : chatConnectionsChatRecord.userA!),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 40.0,
                        height: 40.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0x00FE99AB),
                          ),
                        ),
                      ),
                    );
                  }

                  final columnUserRecord = snapshot.data!;

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 12.0, 16.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (functions.isValidUrl(
                                          columnUserRecord.displayImage) ??
                                      true)
                                    Builder(
                                      builder: (context) => InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          logFirebaseEvent(
                                              'CHAT_CONNECTIONS_Image_14ab0cuk_ON_TAP');
                                          if (columnUserRecord.isDeactivated ==
                                              true) {
                                            logFirebaseEvent(
                                                'Image_alert_dialog');
                                            await showDialog(
                                              context: context,
                                              builder: (dialogContext) {
                                                return Dialog(
                                                  elevation: 0,
                                                  insetPadding: EdgeInsets.zero,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  alignment:
                                                      AlignmentDirectional(
                                                              0.0, 0.0)
                                                          .resolve(
                                                              Directionality.of(
                                                                  context)),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      FocusScope.of(
                                                              dialogContext)
                                                          .unfocus();
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                    },
                                                    child: PausealertWidget(
                                                      name: columnUserRecord
                                                          .displayName,
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          } else {
                                            logFirebaseEvent(
                                                'Image_navigate_to');

                                            context.pushNamed(
                                              PotentialMatchesProfileWidget
                                                  .routeName,
                                              queryParameters: {
                                                'userRef': serializeParam(
                                                  columnUserRecord.reference,
                                                  ParamType.DocumentReference,
                                                ),
                                                'throughUserProfile':
                                                    serializeParam(
                                                  'yes',
                                                  ParamType.String,
                                                ),
                                              }.withoutNulls,
                                            );
                                          }
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(999.0),
                                          child: OctoImage(
                                            placeholderBuilder: (_) {
                                              final blurHash =
                                                  'LEHV6nWB2yk8pyo0adR*.7kCMdnj';

                                              if (!validateBlurhash(blurHash)) {
                                                return const SizedBox.shrink();
                                              }
                                              return SizedBox.expand(
                                                child: Image(
                                                  image:
                                                      BlurHashImage(blurHash),
                                                  fit: BoxFit.cover,
                                                ),
                                              );
                                            },
                                            image: CachedNetworkImageProvider(
                                              columnUserRecord.displayImage,
                                            ),
                                            width: 50.0,
                                            height: 50.0,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Image.asset(
                                              'assets/images/error_image.png',
                                              width: 50.0,
                                              height: 50.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        columnUserRecord.displayName,
                                        style: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineSmallFamily,
                                              fontSize: 24.0,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .headlineSmallIsCustom,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Stack(
                              alignment: AlignmentDirectional(1.0, -1.0),
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Builder(
                                    builder: (context) => FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 20.0,
                                      buttonSize: 40.0,
                                      icon: Icon(
                                        Icons.more_vert_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 24.0,
                                      ),
                                      onPressed: () async {
                                        logFirebaseEvent(
                                            'CHAT_CONNECTIONS_more_vert_rounded_ICN_O');
                                        logFirebaseEvent(
                                            'IconButton_alert_dialog');
                                        await showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return Dialog(
                                              elevation: 0,
                                              insetPadding: EdgeInsets.zero,
                                              backgroundColor:
                                                  Colors.transparent,
                                              alignment:
                                                  AlignmentDirectional(0.0, 0.0)
                                                      .resolve(
                                                          Directionality.of(
                                                              context)),
                                              child: GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(dialogContext)
                                                      .unfocus();
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                child: ChatDropdownWidget(
                                                  charDoc:
                                                      chatConnectionsChatRecord,
                                                  user: chatConnectionsChatRecord
                                                              .userA ==
                                                          currentUserReference
                                                      ? chatConnectionsChatRecord
                                                          .userB!
                                                      : chatConnectionsChatRecord
                                                          .userA!,
                                                  isRequest: false,
                                                ),
                                              ),
                                            );
                                          },
                                        ).then((value) => safeSetState(
                                            () => _model.chatOptions = value));

                                        if (_model.chatOptions == 'met') {
                                          logFirebaseEvent(
                                              'IconButton_alert_dialog');
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(dialogContext)
                                                        .unfocus();
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus();
                                                  },
                                                  child: WeMetWidget(
                                                    chatDoc:
                                                        chatConnectionsChatRecord,
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        } else if (_model.chatOptions ==
                                            'disconnect') {
                                          logFirebaseEvent(
                                              'IconButton_alert_dialog');
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(dialogContext)
                                                        .unfocus();
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus();
                                                  },
                                                  child: DisconnectWidget(
                                                    chatRef: widget!.chatRef!,
                                                    chatDoc:
                                                        chatConnectionsChatRecord,
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        } else if (_model.chatOptions ==
                                            'block') {
                                          logFirebaseEvent(
                                              'IconButton_alert_dialog');
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(dialogContext)
                                                        .unfocus();
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus();
                                                  },
                                                  child: BlockWidget(
                                                    chatDoc:
                                                        chatConnectionsChatRecord,
                                                    isRequest: false,
                                                    chatRef: widget!.chatRef,
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        } else if (_model.chatOptions ==
                                            'report') {
                                          logFirebaseEvent(
                                              'IconButton_alert_dialog');
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(dialogContext)
                                                        .unfocus();
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus();
                                                  },
                                                  child: ReportWidget(
                                                    chatDoc:
                                                        chatConnectionsChatRecord,
                                                    user: columnUserRecord
                                                        .reference,
                                                    chatRef:
                                                        chatConnectionsChatRecord
                                                            .reference,
                                                  ),
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
                                if ((functions.checkDate(
                                            chatConnectionsChatRecord
                                                .responseList
                                                .toList(),
                                            currentUserReference) ==
                                        true) &&
                                    false)
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 5.0, 8.0, 0.0),
                                    child: Container(
                                      width: 10.0,
                                      height: 10.0,
                                      decoration: BoxDecoration(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                if (chatConnectionsChatRecord.weMetList
                                        .contains(currentUserReference) ==
                                    false)
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 5.0, 8.0, 0.0),
                                    child: Container(
                                      width: 10.0,
                                      height: 10.0,
                                      decoration: BoxDecoration(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 2.0,
                        color: FlutterFlowTheme.of(context).alternate,
                      ),
                      Expanded(
                        child: Align(
                          alignment: AlignmentDirectional(0.0, -1.0),
                          child: Builder(
                            builder: (context) =>
                                StreamBuilder<List<ChatMessageRecord>>(
                              stream: queryChatMessageRecord(
                                queryBuilder: (chatMessageRecord) =>
                                    chatMessageRecord
                                        .where(
                                          'chatRef',
                                          isEqualTo: widget!.chatRef,
                                        )
                                        .orderBy('text_time', descending: true),
                                singleRecord: true,
                              )..listen((snapshot) {
                                  List<ChatMessageRecord>
                                      containerChatMessageRecordList = snapshot;
                                  final containerChatMessageRecord =
                                      containerChatMessageRecordList.isNotEmpty
                                          ? containerChatMessageRecordList.first
                                          : null;
                                  if (_model.containerPreviousSnapshot !=
                                          null &&
                                      !const ListEquality(
                                              ChatMessageRecordDocumentEquality())
                                          .equals(
                                              containerChatMessageRecordList,
                                              _model
                                                  .containerPreviousSnapshot)) {
                                    () async {
                                      logFirebaseEvent(
                                          'CHAT_CONNECTIONS_Container_8wswbxj5_ON_D');
                                      logFirebaseEvent(
                                          'Container_firestore_query');
                                      _model.chatCount =
                                          await queryChatMessageRecordCount(
                                        queryBuilder: (chatMessageRecord) =>
                                            chatMessageRecord.where(
                                          'chatRef',
                                          isEqualTo: widget!.chatRef,
                                        ),
                                      );
                                      if (chatConnectionsChatRecord
                                              .displayDialogCount ==
                                          _model.chatCount) {
                                        logFirebaseEvent(
                                            'Container_wait__delay');
                                        await Future.delayed(
                                          Duration(
                                            milliseconds: 250,
                                          ),
                                        );
                                        if (_model.isDialogOpen == false) {
                                          logFirebaseEvent(
                                              'Container_update_page_state');
                                          _model.isDialogOpen = true;
                                          if (chatConnectionsChatRecord
                                              .dialogVisiableUsers
                                              .contains(currentUserReference)) {
                                            logFirebaseEvent(
                                                'Container_alert_dialog');
                                            await showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (dialogContext) {
                                                return Dialog(
                                                  elevation: 0,
                                                  insetPadding: EdgeInsets.zero,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  alignment:
                                                      AlignmentDirectional(
                                                              0.0, 0.0)
                                                          .resolve(
                                                              Directionality.of(
                                                                  context)),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      FocusScope.of(
                                                              dialogContext)
                                                          .unfocus();
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                    },
                                                    child: ReadyToMeetWidget(
                                                      chatdocument:
                                                          chatConnectionsChatRecord,
                                                      user: columnUserRecord,
                                                      username: columnUserRecord
                                                          .displayName,
                                                    ),
                                                  ),
                                                );
                                              },
                                            );

                                            if (functions.checkcountfunction(
                                                    chatConnectionsChatRecord
                                                        .displayDialogCount,
                                                    _model.chatCount!) ==
                                                false) {
                                              logFirebaseEvent(
                                                  'Container_backend_call');

                                              await widget!.chatRef!.update({
                                                ...mapToFirestore(
                                                  {
                                                    'displayDialogCount':
                                                        FieldValue.increment(
                                                            12),
                                                  },
                                                ),
                                              });
                                            }
                                            logFirebaseEvent(
                                                'Container_update_page_state');
                                            _model.isDialogOpen = false;
                                          }
                                        }
                                      }

                                      safeSetState(() {});
                                    }();
                                  }
                                  _model.containerPreviousSnapshot = snapshot;
                                }),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 40.0,
                                      height: 40.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Color(0x00FE99AB),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                List<ChatMessageRecord>
                                    containerChatMessageRecordList =
                                    snapshot.data!;
                                final containerChatMessageRecord =
                                    containerChatMessageRecordList.isNotEmpty
                                        ? containerChatMessageRecordList.first
                                        : null;

                                return Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(),
                                  child: custom_widgets.ChatMessagesWidget(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    height:
                                        MediaQuery.sizeOf(context).height * 1.0,
                                    chatRef: widget!.chatRef!,
                                    messageBox: (ChatMessageRecord message) =>
                                        MessageBoxWidget(
                                      message: message,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            15.0, 10.0, 15.0, 10.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(40.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 2.0,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15.0, 0.0, 8.0, 0.0),
                                  child: Container(
                                    width: 200.0,
                                    child: TextFormField(
                                      controller: _model.textController,
                                      focusNode: _model.textFieldFocusNode,
                                      onChanged: (_) => EasyDebounce.debounce(
                                        '_model.textController',
                                        Duration(milliseconds: 10),
                                        () => safeSetState(() {}),
                                      ),
                                      autofocus: false,
                                      enabled: true,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      textInputAction: TextInputAction.done,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: false,
                                        hintText: 'send a message',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMediumFamily,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .labelMediumIsCustom,
                                            ),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyMediumIsCustom,
                                          ),
                                      minLines: 1,
                                      cursorColor: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      enableInteractiveSelection: false,
                                      validator: _model.textControllerValidator
                                          .asValidator(context),
                                      inputFormatters: [
                                        if (!isAndroid && !isiOS)
                                          TextInputFormatter.withFunction(
                                              (oldValue, newValue) {
                                            return TextEditingValue(
                                              selection: newValue.selection,
                                              text: newValue.text
                                                  .toCapitalization(
                                                      TextCapitalization
                                                          .sentences),
                                            );
                                          }),
                                        FilteringTextInputFormatter.allow(
                                            RegExp('^[^\\s].*'))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 4.0, 0.0),
                                child: FlutterFlowIconButton(
                                  borderColor:
                                      FlutterFlowTheme.of(context).primary,
                                  borderRadius: 30.0,
                                  buttonSize: 40.0,
                                  fillColor:
                                      FlutterFlowTheme.of(context).primary,
                                  icon: Icon(
                                    Icons.send,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 20.0,
                                  ),
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'CHAT_CONNECTIONS_PAGE_send_ICN_ON_TAP');
                                    if (_model.textController.text != null &&
                                        _model.textController.text != '') {
                                      logFirebaseEvent(
                                          'IconButton_update_page_state');
                                      _model.messageText =
                                          _model.textController.text;
                                      safeSetState(() {});
                                      logFirebaseEvent(
                                          'IconButton_clear_text_fields_pin_codes');
                                      safeSetState(() {
                                        _model.textController?.clear();
                                      });
                                      logFirebaseEvent(
                                          'IconButton_backend_call');

                                      var chatMessageRecordReference =
                                          ChatMessageRecord.collection.doc();
                                      await chatMessageRecordReference
                                          .set(createChatMessageRecordData(
                                        chatText: _model.messageText,
                                        textTime: getCurrentTimestamp,
                                        userRef: currentUserReference,
                                        chatRef:
                                            chatConnectionsChatRecord.reference,
                                        isseen: false,
                                        recieverRef: columnUserRecord.reference,
                                      ));
                                      _model.sentedmessage =
                                          ChatMessageRecord.getDocumentFromData(
                                              createChatMessageRecordData(
                                                chatText: _model.messageText,
                                                textTime: getCurrentTimestamp,
                                                userRef: currentUserReference,
                                                chatRef:
                                                    chatConnectionsChatRecord
                                                        .reference,
                                                isseen: false,
                                                recieverRef:
                                                    columnUserRecord.reference,
                                              ),
                                              chatMessageRecordReference);
                                      // Created one cloud function onchatmessagecreated for send notifications and push notifications
                                      //
                                      logFirebaseEvent(
                                          'IconButton_backend_call');
                                      unawaited(
                                        () async {
                                          await widget!.chatRef!
                                              .update(createChatRecordData(
                                            lastMessage:
                                                _model.sentedmessage?.chatText,
                                            lastmessageTime:
                                                getCurrentTimestamp,
                                            lastMessageuserRef:
                                                currentUserReference,
                                          ));
                                        }(),
                                      );
                                    } else {
                                      logFirebaseEvent(
                                          'IconButton_show_snack_bar');
                                      ScaffoldMessenger.of(context)
                                          .clearSnackBars();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Please write a message first',
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
                                    }

                                    safeSetState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

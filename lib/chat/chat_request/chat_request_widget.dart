import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/chat/chat_dropdown/chat_dropdown_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/profile/pause_account_chat/pause_account_chat_widget.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';
import 'package:provider/provider.dart';
import 'chat_request_model.dart';
export 'chat_request_model.dart';

class ChatRequestWidget extends StatefulWidget {
  const ChatRequestWidget({
    super.key,
    this.chatRef,
  });

  final DocumentReference? chatRef;

  static String routeName = 'chatRequest';
  static String routePath = '/chatRequest';

  @override
  State<ChatRequestWidget> createState() => _ChatRequestWidgetState();
}

class _ChatRequestWidgetState extends State<ChatRequestWidget>
    with TickerProviderStateMixin {
  late ChatRequestModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatRequestModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'chatRequest'});
    _model.newTextfeildTextController ??= TextEditingController();
    _model.newTextfeildFocusNode ??= FocusNode();

    animationsMap.addAll({
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 1000.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 1000.0.ms,
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
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChatRecord>(
      stream: ChatRecord.getDocument(widget!.chatRef!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: Center(
              child: LinearProgressIndicator(
                color: Color(0xFFFE99AB),
              ),
            ),
          );
        }

        final chatRequestChatRecord = snapshot.data!;

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
                  borderRadius: 30.0,
                  buttonSize: 60.0,
                  hoverColor: Color(0xFFFE99AB),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 27.0,
                  ),
                  onPressed: () async {
                    logFirebaseEvent('CHAT_REQUEST_arrow_back_ios_ICN_ON_TAP');
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
              child: StreamBuilder<ChatRecord>(
                stream: ChatRecord.getDocument(widget!.chatRef!),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: LinearProgressIndicator(
                        color: Color(0xFFFE99AB),
                      ),
                    );
                  }

                  final columnChatRecord = snapshot.data!;

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 12.0, 16.0, 0.0),
                        child: StreamBuilder<UserRecord>(
                          stream:
                              UserRecord.getDocument(columnChatRecord.userA!),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: LinearProgressIndicator(
                                  color: Color(0xFFFE99AB),
                                ),
                              );
                            }

                            final rowUserRecord = snapshot.data!;

                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Visibility(
                                    visible:
                                        rowUserRecord.displayImage != null &&
                                            rowUserRecord.displayImage != '',
                                    child: Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          logFirebaseEvent(
                                              'CHAT_REQUEST_PAGE_Image_dh7xw4le_ON_TAP');
                                          logFirebaseEvent('Image_navigate_to');

                                          context.pushNamed(
                                            PotentialMatchesProfileWidget
                                                .routeName,
                                            queryParameters: {
                                              'userRef': serializeParam(
                                                rowUserRecord.reference,
                                                ParamType.DocumentReference,
                                              ),
                                              'throughUserProfile':
                                                  serializeParam(
                                                'yes',
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(60.0),
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
                                              rowUserRecord.displayImage,
                                            ),
                                            width: 100.0,
                                            height: 100.0,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Image.asset(
                                              'assets/images/error_image.png',
                                              width: 100.0,
                                              height: 100.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
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
                                      valueOrDefault<String>(
                                        rowUserRecord.displayName,
                                        'Yes Gurl User',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .headlineSmallFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .headlineSmallIsCustom,
                                          ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(1.0, 0.0),
                                  child: Builder(
                                    builder: (context) => FlutterFlowIconButton(
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
                                            'CHAT_REQUEST_more_vert_rounded_ICN_ON_TA');
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
                                                  charDoc: columnChatRecord,
                                                  isRequest: true,
                                                  user: columnChatRecord
                                                              .userA ==
                                                          currentUserReference
                                                      ? columnChatRecord.userB!
                                                      : columnChatRecord.userA!,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Divider(
                        thickness: 2.0,
                        color: FlutterFlowTheme.of(context).alternate,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 0.0, 15.0, 0.0),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 15.0, 15.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(3.0),
                                      topRight: Radius.circular(40.0),
                                      bottomLeft: Radius.circular(40.0),
                                      bottomRight: Radius.circular(40.0),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0x80424242),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 6.0, 12.0, 6.0),
                                          child: Text(
                                            functions.getChatTimeText(
                                                columnChatRecord
                                                    .lastmessageTime!),
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  color: Color(0xE6FFFFFF),
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 20.0, 0.0, 0.0),
                                        child: StreamBuilder<UserRecord>(
                                          stream: UserRecord.getDocument(
                                              columnChatRecord.userA!),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: LinearProgressIndicator(
                                                  color: Color(0xFFFE99AB),
                                                ),
                                              );
                                            }

                                            final textUserRecord =
                                                snapshot.data!;

                                            return Text(
                                              '${textUserRecord.displayName} wants to form a connection',
                                              textAlign: TextAlign.center,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumIsCustom,
                                                  ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 20.0, 20.0, 20.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.sizeOf(context).width *
                                                0.8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xF0E4E4E4),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(3.0),
                                          topRight: Radius.circular(40.0),
                                          bottomLeft: Radius.circular(40.0),
                                          bottomRight: Radius.circular(40.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 13.0, 8.0, 13.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      12.0, 0.0, 12.0, 0.0),
                                              child: Text(
                                                columnChatRecord.lastMessage,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          color: Colors.black,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ).animateOnPageLoad(animationsMap[
                                        'containerOnPageLoadAnimation1']!),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        dateTimeFormat("jm",
                                            columnChatRecord.lastmessageTime!),
                                        textAlign: TextAlign.end,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .bodyMediumIsCustom,
                                            ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 5.0)),
                                ),
                              ),
                              if (columnChatRecord.requestReply != null &&
                                  columnChatRecord.requestReply != '')
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 0.0, 0.0, 0.0),
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxWidth:
                                              MediaQuery.sizeOf(context).width *
                                                  0.8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Color(0xF0E4E4E4),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(40.0),
                                            topRight: Radius.circular(3.0),
                                            bottomLeft: Radius.circular(40.0),
                                            bottomRight: Radius.circular(40.0),
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 13.0, 8.0, 13.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 0.0, 12.0, 0.0),
                                                child: Text(
                                                  columnChatRecord.requestReply,
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            color: Colors.black,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ).animateOnPageLoad(animationsMap[
                                          'containerOnPageLoadAnimation2']!),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(1.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 0.0, 12.0, 0.0),
                                          child: Text(
                                            dateTimeFormat(
                                                "jm",
                                                columnChatRecord
                                                    .requestReplyTime!),
                                            textAlign: TextAlign.end,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 12.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            15.0, 20.0, 20.0, 30.0),
                        child: StreamBuilder<ChatRecord>(
                          stream: ChatRecord.getDocument(widget!.chatRef!),
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

                            final rowChatRecord = snapshot.data!;

                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 55.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(40.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  15.0, 0.0, 8.0, 0.0),
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.62,
                                            child: TextFormField(
                                              controller: _model
                                                  .newTextfeildTextController,
                                              focusNode:
                                                  _model.newTextfeildFocusNode,
                                              autofocus: false,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumFamily,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      fontSize: 12.0,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumIsCustom,
                                                    ),
                                                hintText:
                                                    'send a message to accept ',
                                                hintStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumFamily,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumIsCustom,
                                                    ),
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                focusedErrorBorder:
                                                    InputBorder.none,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumIsCustom,
                                                  ),
                                              cursorColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              validator: _model
                                                  .newTextfeildTextControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 12.0, 0.0),
                                          child: StreamBuilder<UserRecord>(
                                            stream: UserRecord.getDocument(
                                                rowChatRecord.userA!),
                                            builder: (context, snapshot) {
                                              // Customize what your widget looks like when it's loading.
                                              if (!snapshot.hasData) {
                                                return Center(
                                                  child:
                                                      LinearProgressIndicator(
                                                    color: Color(0xFFFE99AB),
                                                  ),
                                                );
                                              }

                                              final iconButtonUserRecord =
                                                  snapshot.data!;

                                              return FlutterFlowIconButton(
                                                borderColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                borderRadius: 30.0,
                                                buttonSize: 40.0,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                icon: Icon(
                                                  Icons.check,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  size: 20.0,
                                                ),
                                                onPressed: () async {
                                                  logFirebaseEvent(
                                                      'CHAT_REQUEST_PAGE_check_ICN_ON_TAP');
                                                  if ((_model.newTextfeildTextController
                                                                  .text !=
                                                              null &&
                                                          _model.newTextfeildTextController
                                                                  .text !=
                                                              '') &&
                                                      (columnChatRecord
                                                              .isRequested ==
                                                          true)) {
                                                    logFirebaseEvent(
                                                        'IconButton_backend_call');

                                                    await ChatMessageRecord
                                                        .collection
                                                        .doc()
                                                        .set(
                                                            createChatMessageRecordData(
                                                          chatText: _model
                                                              .newTextfeildTextController
                                                              .text,
                                                          textTime:
                                                              getCurrentTimestamp,
                                                          userRef:
                                                              currentUserReference,
                                                          chatRef:
                                                              widget!.chatRef,
                                                        ));
                                                    logFirebaseEvent(
                                                        'IconButton_backend_call');

                                                    await ChatMessageRecord
                                                        .collection
                                                        .doc()
                                                        .set(
                                                            createChatMessageRecordData(
                                                          chatText:
                                                              columnChatRecord
                                                                  .lastMessage,
                                                          textTime:
                                                              columnChatRecord
                                                                  .lastmessageTime,
                                                          userRef:
                                                              columnChatRecord
                                                                  .userA,
                                                          chatRef:
                                                              columnChatRecord
                                                                  .reference,
                                                        ));
                                                    logFirebaseEvent(
                                                        'IconButton_backend_call');

                                                    await widget!.chatRef!
                                                        .update(
                                                            createChatRecordData(
                                                      requestReply: _model
                                                          .newTextfeildTextController
                                                          .text,
                                                      requestReplyTime:
                                                          getCurrentTimestamp,
                                                    ));
                                                    logFirebaseEvent(
                                                        'IconButton_backend_call');

                                                    await columnChatRecord
                                                        .reference
                                                        .update(
                                                            createChatRecordData(
                                                      isRequested: false,
                                                      lastMessage: _model
                                                          .newTextfeildTextController
                                                          .text,
                                                      lastmessageTime:
                                                          getCurrentTimestamp,
                                                      lastMessageuserRef:
                                                          currentUserReference,
                                                    ));
                                                    logFirebaseEvent(
                                                        'IconButton_backend_call');

                                                    await currentUserReference!
                                                        .update({
                                                      ...mapToFirestore(
                                                        {
                                                          'chatRequestUser':
                                                              FieldValue
                                                                  .arrayUnion([
                                                            columnChatRecord
                                                                .userA
                                                          ]),
                                                        },
                                                      ),
                                                    });
                                                    logFirebaseEvent(
                                                        'IconButton_backend_call');

                                                    await NotificationRecord
                                                        .collection
                                                        .doc()
                                                        .set(
                                                            createNotificationRecordData(
                                                          title:
                                                              '${currentUserDisplayName} accepted your chat request',
                                                          description: _model
                                                              .newTextfeildTextController
                                                              .text,
                                                          sentBy:
                                                              currentUserReference,
                                                          user:
                                                              iconButtonUserRecord
                                                                  .reference,
                                                          sentAt:
                                                              getCurrentTimestamp,
                                                          notificationType:
                                                              'chat',
                                                          chat: widget!.chatRef,
                                                          seen: false,
                                                          manage: 'user',
                                                        ));
                                                    logFirebaseEvent(
                                                        'IconButton_trigger_push_notification');
                                                    triggerPushNotification(
                                                      notificationTitle:
                                                          '${currentUserDisplayName} accepted your chat request',
                                                      notificationText: _model
                                                          .newTextfeildTextController
                                                          .text,
                                                      userRefs: [
                                                        rowChatRecord.userA!
                                                      ],
                                                      initialPageName:
                                                          'chatConnections',
                                                      parameterData: {
                                                        'chatRef':
                                                            widget!.chatRef,
                                                      },
                                                    );
                                                    logFirebaseEvent(
                                                        'IconButton_navigate_to');

                                                    context.goNamed(
                                                      ChatConnectionsWidget
                                                          .routeName,
                                                      queryParameters: {
                                                        'chatRef':
                                                            serializeParam(
                                                          widget!.chatRef,
                                                          ParamType
                                                              .DocumentReference,
                                                        ),
                                                      }.withoutNulls,
                                                    );
                                                  } else {
                                                    logFirebaseEvent(
                                                        'IconButton_show_snack_bar');
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'Please write a message first ',
                                                          style: TextStyle(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                          ),
                                                        ),
                                                        duration: Duration(
                                                            milliseconds: 4000),
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondary,
                                                      ),
                                                    );
                                                  }
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                FlutterFlowIconButton(
                                  borderRadius: 30.0,
                                  buttonSize: 40.0,
                                  fillColor:
                                      FlutterFlowTheme.of(context).warning,
                                  icon: Icon(
                                    Icons.close,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 20.0,
                                  ),
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'CHAT_REQUEST_PAGE_close_ICN_ON_TAP');
                                    logFirebaseEvent('IconButton_bottom_sheet');
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      enableDrag: false,
                                      context: context,
                                      builder: (context) {
                                        return GestureDetector(
                                          onTap: () {
                                            FocusScope.of(context).unfocus();
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          child: Padding(
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: PauseAccountChatWidget(
                                              userA: columnChatRecord.userA,
                                              chatref: widget!.chatRef!,
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));
                                  },
                                ),
                              ],
                            );
                          },
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

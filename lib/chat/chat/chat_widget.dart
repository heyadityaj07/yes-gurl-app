import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/chat/no_chat_connection/no_chat_connection_widget.dart';
import '/chat/no_request_chat/no_request_chat_widget.dart';
import '/chat/pausealert/pausealert_widget.dart';
import '/components/empty_widget.dart';
import '/components/navbar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';
import 'package:provider/provider.dart';
import 'chat_model.dart';
export 'chat_model.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({
    super.key,
    int? initialTab,
  }) : this.initialTab = initialTab ?? 0;

  final int initialTab;

  static String routeName = 'chat';
  static String routePath = '/chat';

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> with TickerProviderStateMixin {
  late ChatModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'chat'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('CHAT_PAGE_chat_ON_INIT_STATE');
      logFirebaseEvent('chat_update_app_state');
      FFAppState().chatseen = true;
      safeSetState(() {});
      logFirebaseEvent('chat_custom_action');
      unawaited(
        () async {
          await actions.recordUserActivity();
        }(),
      );
      if (FFAppState().sharedEvent?.id != null &&
          FFAppState().sharedEvent?.id != '') {
        logFirebaseEvent('chat_backend_call');
        _model.sharedEventRead =
            await EventsRecord.getDocumentOnce(FFAppState().sharedEvent!);
        logFirebaseEvent('chat_update_page_state');
        _model.sharedEvent = _model.sharedEventRead;
        safeSetState(() {});
      }
      logFirebaseEvent('chat_request_permissions');
      await requestPermission(notificationsPermission);
      logFirebaseEvent('chat_backend_call');

      await currentUserReference!.update({
        ...mapToFirestore(
          {
            'offline_user_time': FieldValue.delete(),
          },
        ),
      });
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: min(
          valueOrDefault<int>(
            widget!.initialTab,
            0,
          ),
          1),
    )..addListener(() => safeSetState(() {}));

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    _model.searchRequestUserTextController ??= TextEditingController();
    _model.searchRequestUserFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    // On page dispose action.
    () async {
      logFirebaseEvent('CHAT_PAGE_chat_ON_DISPOSE');
      logFirebaseEvent('chat_backend_call');

      await currentUserReference!.update(createUserRecordData(
        offlineUserTime: getCurrentTimestamp,
      ));
      logFirebaseEvent('chat_update_app_state');
      FFAppState().chatseen = false;
      safeSetState(() {});
    }();

    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

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
          title: Text(
            'yes gurl',
            style: FlutterFlowTheme.of(context).displaySmall.override(
                  fontFamily: FlutterFlowTheme.of(context).displaySmallFamily,
                  fontSize: 25.0,
                  letterSpacing: 0.0,
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).displaySmallIsCustom,
                ),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
              child: Stack(
                alignment: AlignmentDirectional(1.0, -1.0),
                children: [
                  Align(
                    alignment: AlignmentDirectional(1.0, 0.0),
                    child: FlutterFlowIconButton(
                      borderRadius: 40.0,
                      buttonSize: 40.0,
                      icon: Icon(
                        Icons.notifications_none,
                        color: FlutterFlowTheme.of(context).accent1,
                        size: 30.0,
                      ),
                      onPressed: () async {
                        logFirebaseEvent(
                            'CHAT_PAGE_notifications_none_ICN_ON_TAP');
                        logFirebaseEvent('IconButton_navigate_to');

                        context.pushNamed(NotificationWidget.routeName);
                      },
                    ),
                  ),
                  StreamBuilder<List<NotificationRecord>>(
                    stream: queryNotificationRecord(
                      queryBuilder: (notificationRecord) =>
                          notificationRecord.where(Filter.or(
                        Filter(
                          'user',
                          isEqualTo: currentUserReference,
                        ),
                        Filter(
                          'manage',
                          isEqualTo: 'admin',
                        ),
                      )),
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Container(
                          width: 0.0,
                          height: 0.0,
                          child: EmptyWidget(),
                        );
                      }
                      List<NotificationRecord> containerNotificationRecordList =
                          snapshot.data!;

                      return Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        alignment: AlignmentDirectional(1.0, -1.0),
                        child: Visibility(
                          visible: functions.getNotificationCount(
                                  containerNotificationRecordList.toList(),
                                  currentUserReference,
                                  currentUserDocument?.createdTime) !=
                              0,
                          child: Align(
                            alignment: AlignmentDirectional(1.0, -0.6),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 2.0, 0.0),
                              child: AuthUserStreamWidget(
                                builder: (context) => Container(
                                  width: 18.0,
                                  height: 18.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).primary,
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: AlignmentDirectional(1.0, -1.0),
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        functions
                                            .getNotificationCount(
                                                containerNotificationRecordList
                                                    .toList(),
                                                currentUserReference,
                                                currentUserDocument
                                                    ?.createdTime)
                                            .toString(),
                                        '0',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .displaySmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .displaySmallFamily,
                                            fontSize: 10.0,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .displaySmallIsCustom,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(15.0, 12.0, 15.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 8.0, 0.0, 0.0),
                            child: Text(
                              'chat',
                              style: FlutterFlowTheme.of(context)
                                  .displaySmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .displaySmallFamily,
                                    fontSize: 27.0,
                                    letterSpacing: 1.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .displaySmallIsCustom,
                                  ),
                            ),
                          ),
                          Flexible(
                            child: Align(
                              alignment: AlignmentDirectional(1.0, 1.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (_model.isSearch == true)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 5.0, 0.0),
                                      child: FlutterFlowIconButton(
                                        borderRadius: 20.0,
                                        borderWidth: 1.0,
                                        buttonSize: 40.0,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .primary,
                                        icon: Icon(
                                          Icons.close_sharp,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 24.0,
                                        ),
                                        onPressed: () async {
                                          logFirebaseEvent(
                                              'CHAT_PAGE_close_sharp_ICN_ON_TAP');
                                          logFirebaseEvent(
                                              'IconButton_update_page_state');
                                          _model.isSearch = false;
                                          safeSetState(() {});
                                        },
                                      ),
                                    ),
                                  if (_model.isSearch == false)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 5.0, 0.0),
                                      child: FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius: 20.0,
                                        borderWidth: 1.0,
                                        buttonSize: 40.0,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .primary,
                                        icon: Icon(
                                          Icons.search_sharp,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 24.0,
                                        ),
                                        onPressed: () async {
                                          logFirebaseEvent(
                                              'CHAT_PAGE_search_sharp_ICN_ON_TAP');
                                          logFirebaseEvent(
                                              'IconButton_update_page_state');
                                          _model.isSearch = true;
                                          safeSetState(() {});
                                        },
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                        child: StreamBuilder<List<ChatRecord>>(
                          stream: queryChatRecord(
                            queryBuilder: (chatRecord) => chatRecord
                                .where(Filter.or(
                                  Filter(
                                    'userA',
                                    isEqualTo: currentUserReference,
                                  ),
                                  Filter(
                                    'userB',
                                    isEqualTo: currentUserReference,
                                  ),
                                ))
                                .orderBy('lastmessage_time', descending: true),
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  child: LinearProgressIndicator(
                                    color: Color(0xFFFE99AB),
                                  ),
                                ),
                              );
                            }
                            List<ChatRecord> containerChatRecordList =
                                snapshot.data!;

                            return Container(
                              decoration: BoxDecoration(),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment(0.0, 0),
                                    child: TabBar(
                                      labelColor: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      unselectedLabelColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryText,
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmallFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelSmallIsCustom,
                                          ),
                                      unselectedLabelStyle: TextStyle(),
                                      indicatorColor:
                                          FlutterFlowTheme.of(context).primary,
                                      padding: EdgeInsets.all(4.0),
                                      tabs: [
                                        Tab(
                                          text: 'connections ',
                                        ),
                                        Tab(
                                          text: 'requests',
                                        ),
                                      ],
                                      controller: _model.tabBarController,
                                      onTap: (i) async {
                                        [() async {}, () async {}][i]();
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                      controller: _model.tabBarController,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if ((containerChatRecordList
                                                    .where((e) =>
                                                        ((e.userA ==
                                                                currentUserReference) ||
                                                            (e.userB ==
                                                                currentUserReference)) &&
                                                        (e.isRequested ==
                                                            false))
                                                    .toList()
                                                    .isNotEmpty) &&
                                                (_model.isSearch == true))
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 20.0, 16.0, 0.0),
                                                child: Container(
                                                  width: double.infinity,
                                                  child: TextFormField(
                                                    controller:
                                                        _model.textController1,
                                                    focusNode: _model
                                                        .textFieldFocusNode,
                                                    onChanged: (_) =>
                                                        EasyDebounce.debounce(
                                                      '_model.textController1',
                                                      Duration(milliseconds: 0),
                                                      () async {
                                                        logFirebaseEvent(
                                                            'CHAT_TextField_eeh8e2xl_ON_TEXTFIELD_CHA');
                                                        logFirebaseEvent(
                                                            'TextField_update_page_state');

                                                        safeSetState(() {});
                                                      },
                                                    ),
                                                    autofocus: false,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      isDense: false,
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMediumIsCustom,
                                                              ),
                                                      hintText: 'search',
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMediumIsCustom,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40.0),
                                                      ),
                                                      filled: true,
                                                      fillColor: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                                    cursorColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    validator: _model
                                                        .textController1Validator
                                                        .asValidator(context),
                                                  ),
                                                ),
                                              ),
                                            Expanded(
                                              child: Builder(
                                                builder: (context) {
                                                  if (functions.newCustomFunction(
                                                          containerChatRecordList
                                                              .toList()) ==
                                                      true) {
                                                    return Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  20.0,
                                                                  0.0,
                                                                  0.0),
                                                      child:
                                                          AuthUserStreamWidget(
                                                        builder: (context) =>
                                                            Builder(
                                                          builder: (context) {
                                                            final containerVar = containerChatRecordList
                                                                .where((e) =>
                                                                    (e.isRequested ==
                                                                        false) &&
                                                                    (!(e.blockBy
                                                                            .isNotEmpty) &&
                                                                        (e.blockBy.length <=
                                                                            0)) &&
                                                                    ((currentUserDocument?.blockedUsers?.toList() ?? []).contains(e.userA ==
                                                                                currentUserReference
                                                                            ? e.userB
                                                                            : e.userA) ==
                                                                        false))
                                                                .toList();
                                                            if (containerVar
                                                                .isEmpty) {
                                                              return NoChatConnectionWidget();
                                                            }

                                                            return SingleChildScrollView(
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: List.generate(
                                                                    containerVar
                                                                        .length,
                                                                    (containerVarIndex) {
                                                                  final containerVarItem =
                                                                      containerVar[
                                                                          containerVarIndex];
                                                                  return Visibility(
                                                                    visible: (containerVarItem.userA ==
                                                                                currentUserReference
                                                                            ? containerVarItem.userB
                                                                            : containerVarItem.userA) !=
                                                                        null,
                                                                    child: StreamBuilder<
                                                                        List<
                                                                            UserRecord>>(
                                                                      stream:
                                                                          queryUserRecord(
                                                                        queryBuilder:
                                                                            (userRecord) =>
                                                                                userRecord.where(
                                                                          'uid',
                                                                          isEqualTo:
                                                                              (containerVarItem.userA == currentUserReference ? containerVarItem.userB : containerVarItem.userA)?.id,
                                                                        ),
                                                                        singleRecord:
                                                                            true,
                                                                      ),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        // Customize what your widget looks like when it's loading.
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          return Center(
                                                                            child:
                                                                                SizedBox(
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
                                                                        List<UserRecord>
                                                                            columnUserRecordList =
                                                                            snapshot.data!;
                                                                        // Return an empty Container when the item does not exist.
                                                                        if (snapshot
                                                                            .data!
                                                                            .isEmpty) {
                                                                          return Container();
                                                                        }
                                                                        final columnUserRecord = columnUserRecordList.isNotEmpty
                                                                            ? columnUserRecordList.first
                                                                            : null;

                                                                        return Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            if ((functions.searchUserfunction(_model.textController1.text, columnUserRecord!.displayName) == true) &&
                                                                                !columnUserRecord!.banned)
                                                                              Builder(
                                                                                builder: (context) => InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    logFirebaseEvent('CHAT_PAGE_Container_tcm49mhf_ON_TAP');
                                                                                    if (columnUserRecord?.isDeactivated == true) {
                                                                                      logFirebaseEvent('Container_alert_dialog');
                                                                                      await showDialog(
                                                                                        context: context,
                                                                                        builder: (dialogContext) {
                                                                                          return Dialog(
                                                                                            elevation: 0,
                                                                                            insetPadding: EdgeInsets.zero,
                                                                                            backgroundColor: Colors.transparent,
                                                                                            alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                                            child: GestureDetector(
                                                                                              onTap: () {
                                                                                                FocusScope.of(dialogContext).unfocus();
                                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                                              },
                                                                                              child: PausealertWidget(
                                                                                                name: columnUserRecord!.displayName,
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        },
                                                                                      );
                                                                                    } else {
                                                                                      logFirebaseEvent('Container_navigate_to');

                                                                                      context.pushNamed(
                                                                                        ChatConnectionsWidget.routeName,
                                                                                        queryParameters: {
                                                                                          'chatRef': serializeParam(
                                                                                            containerVarItem.reference,
                                                                                            ParamType.DocumentReference,
                                                                                          ),
                                                                                        }.withoutNulls,
                                                                                      );
                                                                                    }
                                                                                  },
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                                                                                      child: Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        children: [
                                                                                          if (functions.isValidUrl(columnUserRecord?.displayImage) ?? true)
                                                                                            Builder(
                                                                                              builder: (context) => InkWell(
                                                                                                splashColor: Colors.transparent,
                                                                                                focusColor: Colors.transparent,
                                                                                                hoverColor: Colors.transparent,
                                                                                                highlightColor: Colors.transparent,
                                                                                                onTap: () async {
                                                                                                  logFirebaseEvent('CHAT_PAGE_Image_m54f4yw8_ON_TAP');
                                                                                                  if (columnUserRecord?.isDeactivated == true) {
                                                                                                    logFirebaseEvent('Image_alert_dialog');
                                                                                                    await showDialog(
                                                                                                      context: context,
                                                                                                      builder: (dialogContext) {
                                                                                                        return Dialog(
                                                                                                          elevation: 0,
                                                                                                          insetPadding: EdgeInsets.zero,
                                                                                                          backgroundColor: Colors.transparent,
                                                                                                          alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                                                          child: GestureDetector(
                                                                                                            onTap: () {
                                                                                                              FocusScope.of(dialogContext).unfocus();
                                                                                                              FocusManager.instance.primaryFocus?.unfocus();
                                                                                                            },
                                                                                                            child: PausealertWidget(
                                                                                                              name: columnUserRecord!.displayName,
                                                                                                            ),
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
                                                                                                  borderRadius: BorderRadius.circular(999.0),
                                                                                                  child: OctoImage(
                                                                                                    placeholderBuilder: (_) {
                                                                                                      final blurHash = 'LEHV6nWB2yk8pyo0adR*.7kCMdnj';

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
                                                                                                    width: 60.0,
                                                                                                    height: 60.0,
                                                                                                    fit: BoxFit.cover,
                                                                                                    errorBuilder: (context, error, stackTrace) => Image.asset(
                                                                                                      'assets/images/error_image.png',
                                                                                                      width: 60.0,
                                                                                                      height: 60.0,
                                                                                                      fit: BoxFit.cover,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          Expanded(
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                                                                                              child: Column(
                                                                                                mainAxisSize: MainAxisSize.min,
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
                                                                                                  Align(
                                                                                                    alignment: AlignmentDirectional(-1.0, -1.0),
                                                                                                    child: Text(
                                                                                                      columnUserRecord!.displayName.maybeHandleOverflow(
                                                                                                        maxChars: 15,
                                                                                                        replacement: '…',
                                                                                                      ),
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                            fontSize: 18.0,
                                                                                                            letterSpacing: 0.0,
                                                                                                            useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Align(
                                                                                                    alignment: AlignmentDirectional(-1.0, 1.0),
                                                                                                    child: Text(
                                                                                                      containerVarItem.lastMessage.maybeHandleOverflow(
                                                                                                        maxChars: 18,
                                                                                                        replacement: '…',
                                                                                                      ),
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                            fontSize: 14.0,
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FontWeight.w600,
                                                                                                            useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ].divide(SizedBox(height: 7.0)),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          StreamBuilder<List<ChatMessageRecord>>(
                                                                                            stream: queryChatMessageRecord(
                                                                                              queryBuilder: (chatMessageRecord) => chatMessageRecord
                                                                                                  .where(
                                                                                                    'chatRef',
                                                                                                    isEqualTo: containerVarItem.reference,
                                                                                                  )
                                                                                                  .orderBy('text_time', descending: true),
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
                                                                                              List<ChatMessageRecord> columnChatMessageRecordList = snapshot.data!;
                                                                                              final columnChatMessageRecord = columnChatMessageRecordList.isNotEmpty ? columnChatMessageRecordList.first : null;

                                                                                              return Column(
                                                                                                mainAxisSize: MainAxisSize.min,
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                                                children: [
                                                                                                  if (false ? (containerVarItem.lastMessageuserRef != currentUserReference) : (columnChatMessageRecord?.userRef != currentUserReference))
                                                                                                    Container(
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                                        borderRadius: BorderRadius.circular(40.0),
                                                                                                      ),
                                                                                                      child: Padding(
                                                                                                        padding: EdgeInsets.all(5.0),
                                                                                                        child: Text(
                                                                                                          'your go',
                                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                                fontSize: 12.0,
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  Text(
                                                                                                    valueOrDefault<String>(
                                                                                                      functions.messageTimeDateCalculator(containerVarItem.lastmessageTime!),
                                                                                                      '6:36 PM',
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                          letterSpacing: 0.0,
                                                                                                          useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                                        ),
                                                                                                  ),
                                                                                                  if ((_model.sharedEventRead?.reference != null) && !(containerVarItem.blockBy.isNotEmpty))
                                                                                                    FFButtonWidget(
                                                                                                      onPressed: () async {
                                                                                                        logFirebaseEvent('CHAT_PAGE_Button_d8qc9ark_ON_TAP');
                                                                                                        if (!_model.sharedEventRead!.invitedUser.contains(containerVarItem.userA == currentUserReference ? containerVarItem.userB : containerVarItem.userA)) {
                                                                                                          logFirebaseEvent('Button_backend_call');

                                                                                                          var chatMessageRecordReference = ChatMessageRecord.collection.doc();
                                                                                                          await chatMessageRecordReference.set(createChatMessageRecordData(
                                                                                                            textTime: getCurrentTimestamp,
                                                                                                            userRef: currentUserReference,
                                                                                                            chatRef: containerVarItem.reference,
                                                                                                            eventImage: FFAppState().sharabelImage,
                                                                                                            chatText: FFAppState().invitationText,
                                                                                                            eventReference: FFAppState().sharedEvent,
                                                                                                          ));
                                                                                                          _model.eventImageChat = ChatMessageRecord.getDocumentFromData(
                                                                                                              createChatMessageRecordData(
                                                                                                                textTime: getCurrentTimestamp,
                                                                                                                userRef: currentUserReference,
                                                                                                                chatRef: containerVarItem.reference,
                                                                                                                eventImage: FFAppState().sharabelImage,
                                                                                                                chatText: FFAppState().invitationText,
                                                                                                                eventReference: FFAppState().sharedEvent,
                                                                                                              ),
                                                                                                              chatMessageRecordReference);
                                                                                                          logFirebaseEvent('Button_backend_call');

                                                                                                          await containerVarItem.reference.update(createChatRecordData(
                                                                                                            lastMessage: 'Sent Invitation',
                                                                                                            lastmessageTime: getCurrentTimestamp,
                                                                                                            lastMessageuserRef: currentUserReference,
                                                                                                          ));
                                                                                                          logFirebaseEvent('Button_backend_call');

                                                                                                          await FFAppState().sharedEvent!.update({
                                                                                                            ...mapToFirestore(
                                                                                                              {
                                                                                                                'invited_user': FieldValue.arrayUnion([
                                                                                                                  containerVarItem.userA == currentUserReference ? containerVarItem.userB : containerVarItem.userA
                                                                                                                ]),
                                                                                                              },
                                                                                                            ),
                                                                                                          });
                                                                                                          logFirebaseEvent('Button_backend_call');
                                                                                                          _model.event = await EventsRecord.getDocumentOnce(FFAppState().sharedEvent!);
                                                                                                          logFirebaseEvent('Button_update_page_state');
                                                                                                          _model.sharedEvent = _model.event;
                                                                                                          safeSetState(() {});
                                                                                                        }

                                                                                                        safeSetState(() {});
                                                                                                      },
                                                                                                      text: !_model.sharedEvent!.invitedUser.contains(containerVarItem.userA == currentUserReference ? containerVarItem.userB : containerVarItem.userA) ? 'Send' : 'Sent',
                                                                                                      options: FFButtonOptions(
                                                                                                        height: 20.0,
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(5.0, 2.0, 5.0, 2.0),
                                                                                                        iconPadding: EdgeInsets.all(0.0),
                                                                                                        color: !_model.sharedEvent!.invitedUser.contains(containerVarItem.userA == currentUserReference ? containerVarItem.userB : containerVarItem.userA) ? FlutterFlowTheme.of(context).primary : Color(0xFFE6E6E6),
                                                                                                        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                              fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                                              fontSize: 10.0,
                                                                                                              letterSpacing: 0.0,
                                                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                                                            ),
                                                                                                        borderSide: BorderSide(
                                                                                                          color: Colors.transparent,
                                                                                                        ),
                                                                                                        borderRadius: BorderRadius.circular(14.0),
                                                                                                      ),
                                                                                                    ),
                                                                                                ].divide(SizedBox(height: 7.0)),
                                                                                              );
                                                                                            },
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            if ((functions.searchUserfunction(_model.textController1.text, columnUserRecord!.displayName) == true) &&
                                                                                !columnUserRecord!.banned)
                                                                              Divider(
                                                                                thickness: 2.0,
                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                              ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    ),
                                                                  );
                                                                }).divide(
                                                                  SizedBox(
                                                                      height:
                                                                          8.0),
                                                                  filterFn:
                                                                      (containerVarIndex) {
                                                                    final containerVarItem =
                                                                        containerVar[
                                                                            containerVarIndex];
                                                                    return (containerVarItem.userA ==
                                                                                currentUserReference
                                                                            ? containerVarItem.userB
                                                                            : containerVarItem.userA) !=
                                                                        null;
                                                                  },
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return wrapWithModel(
                                                      model: _model
                                                          .noChatConnectionModel,
                                                      updateCallback: () =>
                                                          safeSetState(() {}),
                                                      child:
                                                          NoChatConnectionWidget(),
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 20.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              if ((containerChatRecordList
                                                      .where((e) =>
                                                          (e.userB ==
                                                              currentUserReference) &&
                                                          (e.isRequested ==
                                                              true))
                                                      .toList()
                                                      .isNotEmpty) &&
                                                  (_model.isSearch == true))
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16.0, 20.0,
                                                          16.0, 0.0),
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        1.0,
                                                    child: TextFormField(
                                                      controller: _model
                                                          .searchRequestUserTextController,
                                                      focusNode: _model
                                                          .searchRequestUserFocusNode,
                                                      onChanged: (_) =>
                                                          EasyDebounce.debounce(
                                                        '_model.searchRequestUserTextController',
                                                        Duration(
                                                            milliseconds: 0),
                                                        () async {
                                                          logFirebaseEvent(
                                                              'CHAT_SearchRequestUser_ON_TEXTFIELD_CHAN');
                                                          logFirebaseEvent(
                                                              'SearchRequestUser_update_page_state');

                                                          safeSetState(() {});
                                                        },
                                                      ),
                                                      autofocus: false,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: false,
                                                        labelStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMediumFamily,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMediumIsCustom,
                                                                ),
                                                        hintText: 'search',
                                                        hintStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMediumFamily,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMediumIsCustom,
                                                                ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .alternate,
                                                            width: 1.5,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      40.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .alternate,
                                                            width: 1.5,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      40.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.5,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      40.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.5,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      40.0),
                                                        ),
                                                        filled: true,
                                                        fillColor: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                      cursorColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      validator: _model
                                                          .searchRequestUserTextControllerValidator
                                                          .asValidator(context),
                                                    ),
                                                  ),
                                                ),
                                              Expanded(
                                                child: Builder(
                                                  builder: (context) {
                                                    if (functions.newCustomFunction(containerChatRecordList
                                                            .where((e) =>
                                                                (e.userB ==
                                                                    currentUserReference) &&
                                                                (e.isRequested ==
                                                                    true) &&
                                                                !e.blockBy
                                                                    .contains(e
                                                                        .userA) &&
                                                                !e.blockBy
                                                                    .contains(e
                                                                        .userB))
                                                            .toList()) ==
                                                        true) {
                                                      return Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    20.0,
                                                                    0.0,
                                                                    0.0),
                                                        child:
                                                            AuthUserStreamWidget(
                                                          builder: (context) =>
                                                              Builder(
                                                            builder: (context) {
                                                              final userChat = containerChatRecordList
                                                                  .where((e) =>
                                                                      (e.userB == currentUserReference) &&
                                                                      (e.isRequested ==
                                                                          true) &&
                                                                      !(e.blockBy
                                                                          .isNotEmpty) &&
                                                                      !e.blockBy
                                                                          .contains(e
                                                                              .userA) &&
                                                                      !(currentUserDocument?.blockedUsers?.toList() ??
                                                                              [])
                                                                          .contains(
                                                                              e.userA))
                                                                  .toList();
                                                              if (userChat
                                                                  .isEmpty) {
                                                                return Center(
                                                                  child:
                                                                      NoRequestChatWidget(),
                                                                );
                                                              }

                                                              return SingleChildScrollView(
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: List.generate(
                                                                      userChat
                                                                          .length,
                                                                      (userChatIndex) {
                                                                    final userChatItem =
                                                                        userChat[
                                                                            userChatIndex];
                                                                    return StreamBuilder<
                                                                        List<
                                                                            UserRecord>>(
                                                                      stream:
                                                                          queryUserRecord(
                                                                        queryBuilder:
                                                                            (userRecord) =>
                                                                                userRecord.where(
                                                                          'uid',
                                                                          isEqualTo: userChatItem
                                                                              .userA
                                                                              ?.id,
                                                                        ),
                                                                        singleRecord:
                                                                            true,
                                                                      ),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        // Customize what your widget looks like when it's loading.
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          return Center(
                                                                            child:
                                                                                SizedBox(
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
                                                                        List<UserRecord>
                                                                            columnUserRecordList =
                                                                            snapshot.data!;
                                                                        // Return an empty Container when the item does not exist.
                                                                        if (snapshot
                                                                            .data!
                                                                            .isEmpty) {
                                                                          return Container();
                                                                        }
                                                                        final columnUserRecord = columnUserRecordList.isNotEmpty
                                                                            ? columnUserRecordList.first
                                                                            : null;

                                                                        return InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            logFirebaseEvent('CHAT_PAGE_Column_0053bx54_ON_TAP');
                                                                            logFirebaseEvent('Column_navigate_to');

                                                                            context.pushNamed(
                                                                              ChatRequestWidget.routeName,
                                                                              queryParameters: {
                                                                                'chatRef': serializeParam(
                                                                                  userChatItem.reference,
                                                                                  ParamType.DocumentReference,
                                                                                ),
                                                                              }.withoutNulls,
                                                                            );
                                                                          },
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              if ((functions.searchUser(_model.searchRequestUserTextController.text, columnUserRecord!.displayName) == true) && (columnUserRecord?.banned == false))
                                                                                Container(
                                                                                  width: double.infinity,
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(0.0),
                                                                                  ),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
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
                                                                                                  logFirebaseEvent('CHAT_PAGE_Image_fzjhbp36_ON_TAP');
                                                                                                  if (columnUserRecord?.hasIsDeactivated() == true) {
                                                                                                    logFirebaseEvent('Image_alert_dialog');
                                                                                                    await showDialog(
                                                                                                      context: context,
                                                                                                      builder: (dialogContext) {
                                                                                                        return Dialog(
                                                                                                          elevation: 0,
                                                                                                          insetPadding: EdgeInsets.zero,
                                                                                                          backgroundColor: Colors.transparent,
                                                                                                          alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                                                          child: GestureDetector(
                                                                                                            onTap: () {
                                                                                                              FocusScope.of(dialogContext).unfocus();
                                                                                                              FocusManager.instance.primaryFocus?.unfocus();
                                                                                                            },
                                                                                                            child: PausealertWidget(
                                                                                                              name: columnUserRecord!.displayName,
                                                                                                            ),
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
                                                                                                  borderRadius: BorderRadius.circular(999.0),
                                                                                                  child: OctoImage(
                                                                                                    placeholderBuilder: (_) {
                                                                                                      final blurHash = 'LEHV6nWB2yk8pyo0adR*.7kCMdnj';

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
                                                                                                    width: 60.0,
                                                                                                    height: 60.0,
                                                                                                    fit: BoxFit.cover,
                                                                                                    errorBuilder: (context, error, stackTrace) => Image.asset(
                                                                                                      'assets/images/error_image.png',
                                                                                                      width: 60.0,
                                                                                                      height: 60.0,
                                                                                                      fit: BoxFit.cover,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Expanded(
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                                                                                                child: Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                  children: [
                                                                                                    Align(
                                                                                                      alignment: AlignmentDirectional(-1.0, -1.0),
                                                                                                      child: Text(
                                                                                                        columnUserRecord!.displayName,
                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                              fontSize: 18.0,
                                                                                                              letterSpacing: 0.0,
                                                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Align(
                                                                                                      alignment: AlignmentDirectional(-1.0, 1.0),
                                                                                                      child: Text(
                                                                                                        userChatItem.lastMessage.maybeHandleOverflow(
                                                                                                          maxChars: 18,
                                                                                                        ),
                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                              fontSize: 14.0,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FontWeight.w600,
                                                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ].divide(SizedBox(height: 4.0)),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 20.0),
                                                                                              child: Column(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                                                children: [
                                                                                                  if (userChatItem.lastMessageuserRef != currentUserReference)
                                                                                                    Container(
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                                        borderRadius: BorderRadius.circular(40.0),
                                                                                                      ),
                                                                                                      child: Padding(
                                                                                                        padding: EdgeInsets.all(5.0),
                                                                                                        child: Text(
                                                                                                          'respond',
                                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                                fontSize: 12.0,
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  if (false && (userChatItem.lastMessageuserRef != currentUserReference))
                                                                                                    Align(
                                                                                                      alignment: AlignmentDirectional(1.0, -1.0),
                                                                                                      child: FFButtonWidget(
                                                                                                        onPressed: () {
                                                                                                          print('Button pressed ...');
                                                                                                        },
                                                                                                        text: 'respond',
                                                                                                        options: FFButtonOptions(
                                                                                                          height: 20.0,
                                                                                                          padding: EdgeInsets.all(10.0),
                                                                                                          iconPadding: EdgeInsets.all(0.0),
                                                                                                          color: Color(0xFFFE99AB),
                                                                                                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                                fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                                                                                                color: Colors.black,
                                                                                                                fontSize: 10.0,
                                                                                                                letterSpacing: 0.0,
                                                                                                                useGoogleFonts: !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                                                              ),
                                                                                                          borderSide: BorderSide(
                                                                                                            color: Colors.transparent,
                                                                                                          ),
                                                                                                          borderRadius: BorderRadius.circular(40.0),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  Align(
                                                                                                    alignment: AlignmentDirectional(1.0, 0.0),
                                                                                                    child: Text(
                                                                                                      valueOrDefault<String>(
                                                                                                        functions.messageTimeDateCalculator(userChatItem.lastmessageTime!),
                                                                                                        '6:36 PM',
                                                                                                      ),
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                            letterSpacing: 0.0,
                                                                                                            useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ].divide(SizedBox(height: 4.0)),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      if (_model.searchRequestUserTextController.text == null || _model.searchRequestUserTextController.text == '' ? true : functions.searchUser(_model.searchRequestUserTextController.text, columnUserRecord!.displayName))
                                                                                        Divider(
                                                                                          thickness: 2.0,
                                                                                          color: FlutterFlowTheme.of(context).alternate,
                                                                                        ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      },
                                                                    );
                                                                  }).divide(SizedBox(
                                                                      height:
                                                                          8.0)),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      return wrapWithModel(
                                                        model: _model
                                                            .noRequestChatModel,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child:
                                                            NoRequestChatWidget(),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              wrapWithModel(
                model: _model.navbarModel,
                updateCallback: () => safeSetState(() {}),
                updateOnChange: true,
                child: NavbarWidget(
                  index: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/chat/pausealert/pausealert_widget.dart';
import '/components/empty_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/link_up/no_share_connection/no_share_connection_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';
import 'package:provider/provider.dart';
import 'share_community_model.dart';
export 'share_community_model.dart';

class ShareCommunityWidget extends StatefulWidget {
  const ShareCommunityWidget({
    super.key,
    required this.community,
  });

  final DocumentReference? community;

  static String routeName = 'shareCommunity';
  static String routePath = '/shareCommunity';

  @override
  State<ShareCommunityWidget> createState() => _ShareCommunityWidgetState();
}

class _ShareCommunityWidgetState extends State<ShareCommunityWidget> {
  late ShareCommunityModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ShareCommunityModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'shareCommunity'});
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
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
          leading: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
            child: FlutterFlowIconButton(
              borderRadius: 30.0,
              buttonSize: 40.0,
              hoverIconColor: FlutterFlowTheme.of(context).primary,
              icon: Icon(
                Icons.arrow_back_ios,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 30.0,
              ),
              onPressed: () async {
                logFirebaseEvent('SHARE_COMMUNITY_arrow_back_ios_ICN_ON_TA');
                logFirebaseEvent('IconButton_navigate_back');
                context.safePop();
              },
            ),
          ),
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
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 12.0, 15.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                      child: Text(
                        'share',
                        style:
                            FlutterFlowTheme.of(context).displaySmall.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .displaySmallFamily,
                                  fontSize: 27.0,
                                  letterSpacing: 1.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
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
                                  fillColor:
                                      FlutterFlowTheme.of(context).primary,
                                  icon: Icon(
                                    Icons.close_sharp,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 24.0,
                                  ),
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'SHARE_COMMUNITY_close_sharp_ICN_ON_TAP');
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
                                  fillColor:
                                      FlutterFlowTheme.of(context).primary,
                                  icon: Icon(
                                    Icons.search_sharp,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 24.0,
                                  ),
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'SHARE_COMMUNITY_search_sharp_ICN_ON_TAP');
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
              Divider(
                thickness: 2.0,
                color: FlutterFlowTheme.of(context).alternate,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                  child: StreamBuilder<CommunityRecord>(
                    stream: CommunityRecord.getDocument(widget!.community!),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: LinearProgressIndicator(
                            color: Color(0xFFFE99AB),
                          ),
                        );
                      }

                      final columnCommunityRecord = snapshot.data!;

                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            StreamBuilder<List<ChatRecord>>(
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
                                    .orderBy('lastmessage_time',
                                        descending: true),
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: LinearProgressIndicator(
                                      color: Color(0xFFFE99AB),
                                    ),
                                  );
                                }
                                List<ChatRecord> containerChatRecordList =
                                    snapshot.data!;

                                return Container(
                                  height:
                                      MediaQuery.sizeOf(context).height * 1.0,
                                  decoration: BoxDecoration(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if ((containerChatRecordList
                                              .where((e) =>
                                                  ((e.userA ==
                                                          currentUserReference) ||
                                                      (e.userB ==
                                                          currentUserReference)) &&
                                                  (e.isRequested == false))
                                              .toList()
                                              .isNotEmpty) &&
                                          (_model.isSearch == true))
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 20.0, 16.0, 0.0),
                                          child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                              controller: _model.textController,
                                              focusNode:
                                                  _model.textFieldFocusNode,
                                              onChanged: (_) =>
                                                  EasyDebounce.debounce(
                                                '_model.textController',
                                                Duration(milliseconds: 0),
                                                () async {
                                                  logFirebaseEvent(
                                                      'SHARE_COMMUNITY_TextField_tapx863y_ON_TE');
                                                  logFirebaseEvent(
                                                      'TextField_update_page_state');

                                                  safeSetState(() {});
                                                },
                                              ),
                                              autofocus: false,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMediumIsCustom,
                                                        ),
                                                hintText: 'search',
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMediumIsCustom,
                                                        ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40.0),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40.0),
                                                ),
                                                filled: true,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
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
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              validator: _model
                                                  .textControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                      Builder(
                                        builder: (context) {
                                          if (functions.newCustomFunction(
                                                  containerChatRecordList
                                                      .toList()) ==
                                              true) {
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 20.0, 0.0, 0.0),
                                              child: Builder(
                                                builder: (context) {
                                                  final containerVar =
                                                      containerChatRecordList
                                                          .where((e) =>
                                                              ((e.userA ==
                                                                      currentUserReference) ||
                                                                  (e.userB ==
                                                                      currentUserReference)) &&
                                                              (e.isRequested ==
                                                                  false))
                                                          .toList();
                                                  if (containerVar.isEmpty) {
                                                    return NoShareConnectionWidget();
                                                  }

                                                  return SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: List.generate(
                                                          containerVar.length,
                                                          (containerVarIndex) {
                                                        final containerVarItem =
                                                            containerVar[
                                                                containerVarIndex];
                                                        return Visibility(
                                                          visible: !containerVarItem
                                                                  .blockBy
                                                                  .contains(
                                                                      containerVarItem
                                                                          .userA) &&
                                                              !containerVarItem
                                                                  .blockBy
                                                                  .contains(
                                                                      containerVarItem
                                                                          .userB),
                                                          child: StreamBuilder<
                                                              UserRecord>(
                                                            stream: UserRecord.getDocument(containerVarItem
                                                                        .userA ==
                                                                    currentUserReference
                                                                ? containerVarItem
                                                                    .userB!
                                                                : containerVarItem
                                                                    .userA!),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return EmptyWidget();
                                                              }

                                                              final columnUserRecord =
                                                                  snapshot
                                                                      .data!;

                                                              return InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  logFirebaseEvent(
                                                                      'SHARE_COMMUNITY_Column_fqt4xu60_ON_TAP');
                                                                  if (columnCommunityRecord.invitedUsers.contains(containerVarItem
                                                                              .userA ==
                                                                          currentUserReference
                                                                      ? containerVarItem
                                                                          .userB
                                                                      : containerVarItem
                                                                          .userA)) {
                                                                    logFirebaseEvent(
                                                                        'Column_backend_call');

                                                                    var chatMessageRecordReference =
                                                                        ChatMessageRecord
                                                                            .collection
                                                                            .doc();
                                                                    await chatMessageRecordReference
                                                                        .set(
                                                                            createChatMessageRecordData(
                                                                      textTime:
                                                                          getCurrentTimestamp,
                                                                      userRef:
                                                                          currentUserReference,
                                                                      chatRef:
                                                                          containerVarItem
                                                                              .reference,
                                                                      eventImage:
                                                                          columnCommunityRecord
                                                                              .communityImage,
                                                                      chatText:
                                                                          'Join ${columnCommunityRecord.name}',
                                                                      community:
                                                                          widget!
                                                                              .community,
                                                                      isseen:
                                                                          false,
                                                                      recieverRef: containerVarItem.userA ==
                                                                              currentUserReference
                                                                          ? containerVarItem
                                                                              .userB
                                                                          : containerVarItem
                                                                              .userA,
                                                                    ));
                                                                    _model.eventImageChats =
                                                                        ChatMessageRecord.getDocumentFromData(
                                                                            createChatMessageRecordData(
                                                                              textTime: getCurrentTimestamp,
                                                                              userRef: currentUserReference,
                                                                              chatRef: containerVarItem.reference,
                                                                              eventImage: columnCommunityRecord.communityImage,
                                                                              chatText: 'Join ${columnCommunityRecord.name}',
                                                                              community: widget!.community,
                                                                              isseen: false,
                                                                              recieverRef: containerVarItem.userA == currentUserReference ? containerVarItem.userB : containerVarItem.userA,
                                                                            ),
                                                                            chatMessageRecordReference);
                                                                    logFirebaseEvent(
                                                                        'Column_backend_call');

                                                                    await containerVarItem
                                                                        .reference
                                                                        .update(
                                                                            createChatRecordData(
                                                                      lastMessage:
                                                                          'sent invitation',
                                                                      lastmessageTime:
                                                                          getCurrentTimestamp,
                                                                      lastMessageuserRef:
                                                                          currentUserReference,
                                                                    ));
                                                                    logFirebaseEvent(
                                                                        'Column_backend_call');

                                                                    await widget!
                                                                        .community!
                                                                        .update({
                                                                      ...mapToFirestore(
                                                                        {
                                                                          'invited_users':
                                                                              FieldValue.arrayUnion([
                                                                            containerVarItem.userA == currentUserReference
                                                                                ? containerVarItem.userB
                                                                                : containerVarItem.userA
                                                                          ]),
                                                                        },
                                                                      ),
                                                                    });
                                                                    logFirebaseEvent(
                                                                        'Column_show_snack_bar');
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      SnackBar(
                                                                        content:
                                                                            Text(
                                                                          'community sent successfully',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                          ),
                                                                        ),
                                                                        duration:
                                                                            Duration(milliseconds: 4000),
                                                                        backgroundColor:
                                                                            FlutterFlowTheme.of(context).primary,
                                                                      ),
                                                                    );
                                                                  }

                                                                  safeSetState(
                                                                      () {});
                                                                },
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    if (_model.textController.text ==
                                                                                null ||
                                                                            _model.textController.text ==
                                                                                ''
                                                                        ? true
                                                                        : functions.searchUser(
                                                                            _model.textController.text,
                                                                            columnUserRecord.displayName))
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            15.0,
                                                                            0.0,
                                                                            15.0,
                                                                            0.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 1.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(0.0),
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                8.0,
                                                                                0.0,
                                                                                8.0,
                                                                                0.0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Container(
                                                                                  width: 80.0,
                                                                                  height: 80.0,
                                                                                  decoration: BoxDecoration(
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsets.all(4.0),
                                                                                    child: InkWell(
                                                                                      splashColor: Colors.transparent,
                                                                                      focusColor: Colors.transparent,
                                                                                      hoverColor: Colors.transparent,
                                                                                      highlightColor: Colors.transparent,
                                                                                      onTap: () async {
                                                                                        logFirebaseEvent('SHARE_COMMUNITY_Image_22ggqwna_ON_TAP');
                                                                                        logFirebaseEvent('Image_navigate_to');

                                                                                        context.pushNamed(
                                                                                          PotentialMatchesProfileWidget.routeName,
                                                                                          queryParameters: {
                                                                                            'userRef': serializeParam(
                                                                                              columnUserRecord.reference,
                                                                                              ParamType.DocumentReference,
                                                                                            ),
                                                                                            'throughUserProfile': serializeParam(
                                                                                              'yes',
                                                                                              ParamType.String,
                                                                                            ),
                                                                                          }.withoutNulls,
                                                                                        );
                                                                                      },
                                                                                      child: ClipRRect(
                                                                                        borderRadius: BorderRadius.circular(60.0),
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
                                                                                            columnUserRecord.displayImage,
                                                                                          ),
                                                                                          width: 70.0,
                                                                                          height: 60.0,
                                                                                          fit: BoxFit.cover,
                                                                                          alignment: Alignment(0.0, -1.0),
                                                                                          errorBuilder: (context, error, stackTrace) => Image.asset(
                                                                                            'assets/images/error_image.png',
                                                                                            width: 70.0,
                                                                                            height: 60.0,
                                                                                            fit: BoxFit.cover,
                                                                                            alignment: Alignment(0.0, -1.0),
                                                                                          ),
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
                                                                                            columnUserRecord.displayName.maybeHandleOverflow(
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
                                                                                                  fontSize: 12.0,
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
                                                                                Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                                  children: [
                                                                                    if (false && (containerVarItem.lastMessageuserRef != currentUserReference))
                                                                                      Align(
                                                                                        alignment: AlignmentDirectional(1.0, -1.0),
                                                                                        child: FFButtonWidget(
                                                                                          onPressed: () {
                                                                                            print('Button pressed ...');
                                                                                          },
                                                                                          text: 'your go',
                                                                                          options: FFButtonOptions(
                                                                                            height: 20.0,
                                                                                            padding: EdgeInsets.all(10.0),
                                                                                            iconPadding: EdgeInsets.all(0.0),
                                                                                            color: FlutterFlowTheme.of(context).primary,
                                                                                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                  fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                                  fontSize: 10.0,
                                                                                                  letterSpacing: 0.0,
                                                                                                  useGoogleFonts: !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                                                ),
                                                                                            borderRadius: BorderRadius.circular(40.0),
                                                                                          ),
                                                                                          showLoadingIndicator: false,
                                                                                        ),
                                                                                      ),
                                                                                    if ((columnCommunityRecord.reference != null) && !(containerVarItem.blockBy.isNotEmpty))
                                                                                      Align(
                                                                                        alignment: AlignmentDirectional(1.0, -1.0),
                                                                                        child: Builder(
                                                                                          builder: (context) => FFButtonWidget(
                                                                                            onPressed: () async {
                                                                                              logFirebaseEvent('SHARE_COMMUNITY_Button_b08zxfg7_ON_TAP');
                                                                                              if ((columnUserRecord.isDeactivated == false) && !columnCommunityRecord.invitedUsers.contains(containerVarItem.userA == currentUserReference ? containerVarItem.userB : containerVarItem.userA)) {
                                                                                                logFirebaseEvent('Button_backend_call');

                                                                                                await ChatMessageRecord.collection.doc().set(createChatMessageRecordData(
                                                                                                      textTime: getCurrentTimestamp,
                                                                                                      userRef: currentUserReference,
                                                                                                      chatRef: containerVarItem.reference,
                                                                                                      eventImage: columnCommunityRecord.communityImage,
                                                                                                      chatText: 'Join ${columnCommunityRecord.name}',
                                                                                                      community: widget!.community,
                                                                                                      isseen: false,
                                                                                                      recieverRef: containerVarItem.userA == currentUserReference ? containerVarItem.userB : containerVarItem.userA,
                                                                                                    ));
                                                                                                logFirebaseEvent('Button_backend_call');

                                                                                                await containerVarItem.reference.update(createChatRecordData(
                                                                                                  lastMessage: 'sent invitation',
                                                                                                  lastmessageTime: getCurrentTimestamp,
                                                                                                  lastMessageuserRef: currentUserReference,
                                                                                                ));
                                                                                                logFirebaseEvent('Button_backend_call');

                                                                                                await widget!.community!.update({
                                                                                                  ...mapToFirestore(
                                                                                                    {
                                                                                                      'invited_users': FieldValue.arrayUnion([
                                                                                                        containerVarItem.userA == currentUserReference ? containerVarItem.userB : containerVarItem.userA
                                                                                                      ]),
                                                                                                    },
                                                                                                  ),
                                                                                                });
                                                                                                logFirebaseEvent('Button_show_snack_bar');
                                                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                                                  SnackBar(
                                                                                                    content: Text(
                                                                                                      'community sent successfully',
                                                                                                      style: TextStyle(
                                                                                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                      ),
                                                                                                    ),
                                                                                                    duration: Duration(milliseconds: 4000),
                                                                                                    backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                                                  ),
                                                                                                );
                                                                                              } else {
                                                                                                if (columnUserRecord.isDeactivated == true) {
                                                                                                  logFirebaseEvent('Button_alert_dialog');
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
                                                                                                            name: columnUserRecord.displayName,
                                                                                                          ),
                                                                                                        ),
                                                                                                      );
                                                                                                    },
                                                                                                  );
                                                                                                }
                                                                                              }
                                                                                            },
                                                                                            text: !columnCommunityRecord.invitedUsers.contains(containerVarItem.userA == currentUserReference ? containerVarItem.userB : containerVarItem.userA) ? 'send' : 'sent',
                                                                                            options: FFButtonOptions(
                                                                                              height: 20.0,
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(5.0, 2.0, 5.0, 2.0),
                                                                                              iconPadding: EdgeInsets.all(0.0),
                                                                                              color: !columnCommunityRecord.invitedUsers.contains(containerVarItem.userA == currentUserReference ? containerVarItem.userB : containerVarItem.userA) ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).warning,
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
                                                                                        ),
                                                                                      ),
                                                                                  ].divide(SizedBox(height: 7.0)),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    if (_model.textController.text ==
                                                                                null ||
                                                                            _model.textController.text ==
                                                                                ''
                                                                        ? true
                                                                        : functions.searchUser(
                                                                            _model.textController.text,
                                                                            columnUserRecord.displayName))
                                                                      Divider(
                                                                        thickness:
                                                                            2.0,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .alternate,
                                                                      ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          } else {
                                            return wrapWithModel(
                                              model:
                                                  _model.noShareConnectionModel,
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child: NoShareConnectionWidget(),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
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
      ),
    );
  }
}

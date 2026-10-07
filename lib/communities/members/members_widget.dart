import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/enums/enums.dart';
import '/communities/confirmation_dialogue/confirmation_dialogue_widget.dart';
import '/components/empty_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';
import 'package:provider/provider.dart';
import 'members_model.dart';
export 'members_model.dart';

class MembersWidget extends StatefulWidget {
  const MembersWidget({
    super.key,
    required this.community,
  });

  final CommunityRecord? community;

  static String routeName = 'members';
  static String routePath = '/members';

  @override
  State<MembersWidget> createState() => _MembersWidgetState();
}

class _MembersWidgetState extends State<MembersWidget> {
  late MembersModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MembersModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'members'});
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                logFirebaseEvent('MEMBERS_PAGE_arrow_back_ios_ICN_ON_TAP');
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
                        'Members',
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
                  ],
                ),
              ),
              Divider(
                thickness: 2.0,
                color: FlutterFlowTheme.of(context).alternate,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (widget!.community?.createdBy == currentUserReference)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 8.0, 0.0, 8.0),
                          child: StreamBuilder<List<JoinRequestsRecord>>(
                            stream: queryJoinRequestsRecord(
                              parent: widget!.community?.reference,
                              queryBuilder: (joinRequestsRecord) =>
                                  joinRequestsRecord
                                      .where(
                                        'status',
                                        isEqualTo: InvitationStatus.pending
                                            .serialize(),
                                      )
                                      .orderBy('created_at', descending: true),
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return EmptyWidget();
                              }
                              List<JoinRequestsRecord>
                                  columnJoinRequestsRecordList = snapshot.data!;

                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: List.generate(
                                    columnJoinRequestsRecordList.length,
                                    (columnIndex) {
                                  final columnJoinRequestsRecord =
                                      columnJoinRequestsRecordList[columnIndex];
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 20.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          (FFCrossAxisAlignment.start)
                                              .flutterValue,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        if (columnIndex == 0)
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'Requests',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .displaySmall
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .displaySmallFamily,
                                                        fontSize: 18.0,
                                                        letterSpacing: 1.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .displaySmallIsCustom,
                                                      ),
                                            ),
                                          ),
                                        StreamBuilder<UserRecord>(
                                          stream: UserRecord.getDocument(
                                              columnJoinRequestsRecord
                                                  .userRef!),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return EmptyWidget();
                                            }

                                            final columnUserRecord =
                                                snapshot.data!;

                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          15.0, 0.0, 15.0, 0.0),
                                                  child: InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      logFirebaseEvent(
                                                          'MEMBERS_PAGE_Container_p4bk0cs5_ON_TAP');
                                                      logFirebaseEvent(
                                                          'Container_navigate_to');

                                                      context.pushNamed(
                                                        PotentialMatchesProfileWidget
                                                            .routeName,
                                                        queryParameters: {
                                                          'userRef':
                                                              serializeParam(
                                                            columnUserRecord
                                                                .reference,
                                                            ParamType
                                                                .DocumentReference,
                                                          ),
                                                          'throughUserProfile':
                                                              serializeParam(
                                                            'yes',
                                                            ParamType.String,
                                                          ),
                                                        }.withoutNulls,
                                                      );
                                                    },
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          1.0,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(0.0),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            (FFMainAxisAlignment
                                                                    .start)
                                                                .flutterValue,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            width: 80.0,
                                                            height: 80.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(4.0),
                                                              child: InkWell(
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
                                                                      'MEMBERS_PAGE_Image_37d9ysdn_ON_TAP');
                                                                  logFirebaseEvent(
                                                                      'Image_navigate_to');

                                                                  context
                                                                      .pushNamed(
                                                                    PotentialMatchesProfileWidget
                                                                        .routeName,
                                                                    queryParameters:
                                                                        {
                                                                      'userRef':
                                                                          serializeParam(
                                                                        columnUserRecord
                                                                            .reference,
                                                                        ParamType
                                                                            .DocumentReference,
                                                                      ),
                                                                      'throughUserProfile':
                                                                          serializeParam(
                                                                        'yes',
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                    }.withoutNulls,
                                                                  );
                                                                },
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              60.0),
                                                                  child:
                                                                      OctoImage(
                                                                    placeholderBuilder:
                                                                        (_) {
                                                                      final blurHash =
                                                                          'LEHV6nWB2yk8pyo0adR*.7kCMdnj';

                                                                      if (!validateBlurhash(
                                                                          blurHash)) {
                                                                        return const SizedBox
                                                                            .shrink();
                                                                      }
                                                                      return SizedBox
                                                                          .expand(
                                                                        child:
                                                                            Image(
                                                                          image:
                                                                              BlurHashImage(blurHash),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      );
                                                                    },
                                                                    image:
                                                                        CachedNetworkImageProvider(
                                                                      columnUserRecord
                                                                          .displayImage,
                                                                    ),
                                                                    width: 70.0,
                                                                    height:
                                                                        60.0,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    alignment:
                                                                        Alignment(
                                                                            0.0,
                                                                            -1.0),
                                                                    errorBuilder: (context,
                                                                            error,
                                                                            stackTrace) =>
                                                                        Image
                                                                            .asset(
                                                                      'assets/images/error_image.png',
                                                                      width:
                                                                          70.0,
                                                                      height:
                                                                          60.0,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      alignment:
                                                                          Alignment(
                                                                              0.0,
                                                                              -1.0),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      -1.0,
                                                                      -1.0),
                                                              child: Text(
                                                                columnUserRecord
                                                                    .displayName
                                                                    .maybeHandleOverflow(
                                                                  maxChars: 15,
                                                                  replacement:
                                                                      '…',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily,
                                                                      fontSize:
                                                                          18.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .bodyMediumIsCustom,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        1.0,
                                                                        -1.0),
                                                                child: Builder(
                                                                  builder:
                                                                      (context) =>
                                                                          Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            16.0,
                                                                            16.0,
                                                                            0.0),
                                                                    child:
                                                                        InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        logFirebaseEvent(
                                                                            'MEMBERS_PAGE_Container_bk550bit_ON_TAP');
                                                                        logFirebaseEvent(
                                                                            'Container_alert_dialog');
                                                                        await showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (dialogContext) {
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
                                                                                child: ConfirmationDialogueWidget(
                                                                                  title: 'Accept?',
                                                                                  message: 'Are you sure you want to accept this request?',
                                                                                  buttonText: 'Accept',
                                                                                  action: () async {
                                                                                    logFirebaseEvent('_backend_call');

                                                                                    await columnJoinRequestsRecord.reference.update(createJoinRequestsRecordData(
                                                                                      status: InvitationStatus.accepted,
                                                                                    ));
                                                                                    logFirebaseEvent('_backend_call');

                                                                                    await MembersRecord.createDoc(widget!.community!.reference).set(createMembersRecordData(
                                                                                      userRef: columnUserRecord.reference,
                                                                                      joinedAt: getCurrentTimestamp,
                                                                                      role: 'member',
                                                                                      notificationsEnabled: true,
                                                                                    ));
                                                                                    if (columnUserRecord.isNotificationEnabled) {
                                                                                      logFirebaseEvent('_trigger_push_notification');
                                                                                      triggerPushNotification(
                                                                                        notificationTitle: 'Request accepted',
                                                                                        notificationText: 'Host accepted your join request for ${widget!.community?.name}',
                                                                                        notificationSound: 'default',
                                                                                        userRefs: [
                                                                                          columnUserRecord.reference
                                                                                        ],
                                                                                        initialPageName: 'communityDetail',
                                                                                        parameterData: {
                                                                                          'communityRef': widget!.community?.reference,
                                                                                        },
                                                                                      );
                                                                                    }
                                                                                    logFirebaseEvent('_backend_call');

                                                                                    await NotificationRecord.collection.doc().set(createNotificationRecordData(
                                                                                          title: 'Request accepted',
                                                                                          description: 'Host accepted your join request for ${widget!.community?.name}',
                                                                                          sentBy: currentUserReference,
                                                                                          user: columnUserRecord.reference,
                                                                                          sentAt: getCurrentTimestamp,
                                                                                          notificationType: 'accept community',
                                                                                          seen: false,
                                                                                          community: widget!.community?.reference,
                                                                                          forAdmin: false,
                                                                                        ));
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        );
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            35.0,
                                                                        height:
                                                                            35.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.all(2.0),
                                                                          child:
                                                                              Icon(
                                                                            Icons.check_sharp,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            size:
                                                                                24.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        1.0,
                                                                        -1.0),
                                                                child: Builder(
                                                                  builder:
                                                                      (context) =>
                                                                          Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            16.0,
                                                                            16.0,
                                                                            0.0),
                                                                    child:
                                                                        InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        logFirebaseEvent(
                                                                            'MEMBERS_PAGE_Container_z5yb76sr_ON_TAP');
                                                                        logFirebaseEvent(
                                                                            'Container_alert_dialog');
                                                                        await showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (dialogContext) {
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
                                                                                child: ConfirmationDialogueWidget(
                                                                                  title: 'Decline?',
                                                                                  message: 'Are you sure you want to decline this request?',
                                                                                  buttonText: 'Decline',
                                                                                  action: () async {
                                                                                    logFirebaseEvent('_backend_call');

                                                                                    await columnJoinRequestsRecord.reference.update(createJoinRequestsRecordData(
                                                                                      status: InvitationStatus.declined,
                                                                                    ));
                                                                                    if (columnUserRecord.isNotificationEnabled) {
                                                                                      logFirebaseEvent('_trigger_push_notification');
                                                                                      triggerPushNotification(
                                                                                        notificationTitle: 'Request declined',
                                                                                        notificationText: 'Host declined your join request for ${widget!.community?.name}',
                                                                                        notificationSound: 'default',
                                                                                        userRefs: [
                                                                                          columnUserRecord.reference
                                                                                        ],
                                                                                        initialPageName: 'communityDetail',
                                                                                        parameterData: {
                                                                                          'communityRef': widget!.community?.reference,
                                                                                        },
                                                                                      );
                                                                                    }
                                                                                    logFirebaseEvent('_backend_call');

                                                                                    await NotificationRecord.collection.doc().set(createNotificationRecordData(
                                                                                          title: 'Request declined',
                                                                                          description: 'Host declined your join request for ${widget!.community?.name}',
                                                                                          sentBy: currentUserReference,
                                                                                          user: columnUserRecord.reference,
                                                                                          sentAt: getCurrentTimestamp,
                                                                                          notificationType: 'accept community',
                                                                                          seen: false,
                                                                                          community: widget!.community?.reference,
                                                                                          forAdmin: false,
                                                                                        ));
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        );
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            35.0,
                                                                        height:
                                                                            35.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.all(2.0),
                                                                          child:
                                                                              Icon(
                                                                            Icons.close_rounded,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            size:
                                                                                24.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ].divide(SizedBox(
                                                            width: 15.0)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Divider(
                                                  thickness: 2.0,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              );
                            },
                          ),
                        ),
                      StreamBuilder<UserRecord>(
                        stream: UserRecord.getDocument(
                            widget!.community!.createdBy!),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return EmptyWidget();
                          }

                          final columnUserRecord = snapshot.data!;

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 0.0, 15.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'MEMBERS_PAGE_Container_njzpp4rl_ON_TAP');
                                    logFirebaseEvent('Container_navigate_to');

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
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          (FFMainAxisAlignment.start)
                                              .flutterValue,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                logFirebaseEvent(
                                                    'MEMBERS_PAGE_Image_8gwkyyq6_ON_TAP');
                                                logFirebaseEvent(
                                                    'Image_navigate_to');

                                                context.pushNamed(
                                                  PotentialMatchesProfileWidget
                                                      .routeName,
                                                  queryParameters: {
                                                    'userRef': serializeParam(
                                                      columnUserRecord
                                                          .reference,
                                                      ParamType
                                                          .DocumentReference,
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

                                                    if (!validateBlurhash(
                                                        blurHash)) {
                                                      return const SizedBox
                                                          .shrink();
                                                    }
                                                    return SizedBox.expand(
                                                      child: Image(
                                                        image: BlurHashImage(
                                                            blurHash),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    );
                                                  },
                                                  image:
                                                      CachedNetworkImageProvider(
                                                    columnUserRecord
                                                        .displayImage,
                                                  ),
                                                  width: 70.0,
                                                  height: 60.0,
                                                  fit: BoxFit.cover,
                                                  alignment:
                                                      Alignment(0.0, -1.0),
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      Image.asset(
                                                    'assets/images/error_image.png',
                                                    width: 70.0,
                                                    height: 60.0,
                                                    fit: BoxFit.cover,
                                                    alignment:
                                                        Alignment(0.0, -1.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional(
                                                -1.0, -1.0),
                                            child: Text(
                                              columnUserRecord.displayName
                                                  .maybeHandleOverflow(
                                                maxChars: 15,
                                                replacement: '…',
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        fontSize: 18.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMediumIsCustom,
                                                      ),
                                            ),
                                          ),
                                        ),
                                        FFButtonWidget(
                                          onPressed: () {
                                            print('Button pressed ...');
                                          },
                                          text: 'host',
                                          options: FFButtonOptions(
                                            height: 20.0,
                                            padding: EdgeInsets.all(0.0),
                                            iconPadding: EdgeInsets.all(0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmallFamily,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      fontSize: 10.0,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmallIsCustom,
                                                    ),
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                          ),
                                          showLoadingIndicator: false,
                                        ),
                                      ].divide(SizedBox(width: 15.0)),
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 2.0,
                                color: FlutterFlowTheme.of(context).alternate,
                              ),
                            ],
                          );
                        },
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                        child: StreamBuilder<List<MembersRecord>>(
                          stream: queryMembersRecord(
                            parent: widget!.community?.reference,
                            queryBuilder: (membersRecord) =>
                                membersRecord.where(
                              'user_ref',
                              isNotEqualTo: widget!.community?.createdBy,
                            ),
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
                            List<MembersRecord> columnMembersRecordList =
                                snapshot.data!;

                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:
                                  List.generate(columnMembersRecordList.length,
                                      (columnIndex) {
                                final columnMembersRecord =
                                    columnMembersRecordList[columnIndex];
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 20.0, 0.0, 0.0),
                                  child: StreamBuilder<UserRecord>(
                                    stream: UserRecord.getDocument(
                                        columnMembersRecord.userRef!),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return EmptyWidget();
                                      }

                                      final columnUserRecord = snapshot.data!;

                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    15.0, 0.0, 15.0, 0.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                logFirebaseEvent(
                                                    'MEMBERS_PAGE_Container_shqf8ack_ON_TAP');
                                                logFirebaseEvent(
                                                    'Container_navigate_to');

                                                context.pushNamed(
                                                  PotentialMatchesProfileWidget
                                                      .routeName,
                                                  queryParameters: {
                                                    'userRef': serializeParam(
                                                      columnUserRecord
                                                          .reference,
                                                      ParamType
                                                          .DocumentReference,
                                                    ),
                                                    'throughUserProfile':
                                                        serializeParam(
                                                      'yes',
                                                      ParamType.String,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              },
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        1.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      (FFMainAxisAlignment
                                                              .start)
                                                          .flutterValue,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 80.0,
                                                      height: 80.0,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(4.0),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            logFirebaseEvent(
                                                                'MEMBERS_PAGE_Image_odyj3dn8_ON_TAP');
                                                            logFirebaseEvent(
                                                                'Image_navigate_to');

                                                            context.pushNamed(
                                                              PotentialMatchesProfileWidget
                                                                  .routeName,
                                                              queryParameters: {
                                                                'userRef':
                                                                    serializeParam(
                                                                  columnUserRecord
                                                                      .reference,
                                                                  ParamType
                                                                      .DocumentReference,
                                                                ),
                                                                'throughUserProfile':
                                                                    serializeParam(
                                                                  'yes',
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                              }.withoutNulls,
                                                            );
                                                          },
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        60.0),
                                                            child: OctoImage(
                                                              placeholderBuilder:
                                                                  (_) {
                                                                final blurHash =
                                                                    'LEHV6nWB2yk8pyo0adR*.7kCMdnj';

                                                                if (!validateBlurhash(
                                                                    blurHash)) {
                                                                  return const SizedBox
                                                                      .shrink();
                                                                }
                                                                return SizedBox
                                                                    .expand(
                                                                  child: Image(
                                                                    image: BlurHashImage(
                                                                        blurHash),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                );
                                                              },
                                                              image:
                                                                  CachedNetworkImageProvider(
                                                                columnUserRecord
                                                                    .displayImage,
                                                              ),
                                                              width: 70.0,
                                                              height: 60.0,
                                                              fit: BoxFit.cover,
                                                              alignment:
                                                                  Alignment(0.0,
                                                                      -1.0),
                                                              errorBuilder: (context,
                                                                      error,
                                                                      stackTrace) =>
                                                                  Image.asset(
                                                                'assets/images/error_image.png',
                                                                width: 70.0,
                                                                height: 60.0,
                                                                fit: BoxFit
                                                                    .cover,
                                                                alignment:
                                                                    Alignment(
                                                                        0.0,
                                                                        -1.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, -1.0),
                                                        child: Text(
                                                          columnUserRecord
                                                              .displayName
                                                              .maybeHandleOverflow(
                                                            maxChars: 15,
                                                            replacement: '…',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                                fontSize: 18.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMediumIsCustom,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    if (widget!.community
                                                            ?.createdBy ==
                                                        currentUserReference)
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                1.0, -1.0),
                                                        child: Builder(
                                                          builder: (context) =>
                                                              FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              logFirebaseEvent(
                                                                  'MEMBERS_PAGE_REMOVE_BTN_ON_TAP');
                                                              logFirebaseEvent(
                                                                  'Button_alert_dialog');
                                                              await showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (dialogContext) {
                                                                  return Dialog(
                                                                    elevation:
                                                                        0,
                                                                    insetPadding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0)
                                                                        .resolve(
                                                                            Directionality.of(context)),
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        FocusScope.of(dialogContext)
                                                                            .unfocus();
                                                                        FocusManager
                                                                            .instance
                                                                            .primaryFocus
                                                                            ?.unfocus();
                                                                      },
                                                                      child:
                                                                          ConfirmationDialogueWidget(
                                                                        title:
                                                                            'Remove?',
                                                                        message:
                                                                            'Are you sure you want to remove this member?',
                                                                        buttonText:
                                                                            'Remove',
                                                                        action:
                                                                            () async {
                                                                          logFirebaseEvent(
                                                                              '_backend_call');

                                                                          await widget!
                                                                              .community!
                                                                              .reference
                                                                              .update({
                                                                            ...mapToFirestore(
                                                                              {
                                                                                'removed_members': FieldValue.arrayRemove([
                                                                                  columnUserRecord.reference
                                                                                ]),
                                                                                'members': FieldValue.increment(-(1)),
                                                                              },
                                                                            ),
                                                                          });
                                                                          logFirebaseEvent(
                                                                              '_backend_call');
                                                                          await columnMembersRecord
                                                                              .reference
                                                                              .delete();
                                                                          logFirebaseEvent(
                                                                              '_show_snack_bar');
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(
                                                                            SnackBar(
                                                                              content: Text(
                                                                                'You removed this member from community',
                                                                                style: TextStyle(
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                ),
                                                                              ),
                                                                              duration: Duration(milliseconds: 4000),
                                                                              backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            text: 'Remove',
                                                            options:
                                                                FFButtonOptions(
                                                              height: 20.0,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          10.0),
                                                              iconPadding:
                                                                  EdgeInsets
                                                                      .all(0.0),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).titleSmallFamily,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        fontSize:
                                                                            10.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        useGoogleFonts:
                                                                            !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                      ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40.0),
                                                            ),
                                                            showLoadingIndicator:
                                                                false,
                                                          ),
                                                        ),
                                                      ),
                                                  ].divide(
                                                      SizedBox(width: 15.0)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            thickness: 2.0,
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                );
                              }),
                            );
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
      ),
    );
  }
}

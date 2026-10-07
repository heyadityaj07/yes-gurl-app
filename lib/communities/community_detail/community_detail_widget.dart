import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/enums/enums.dart';
import '/chat/pausealert/pausealert_widget.dart';
import '/communities/community_option/community_option_widget.dart';
import '/communities/confirmation_dialogue/confirmation_dialogue_widget.dart';
import '/communities/delete_community/delete_community_widget.dart';
import '/components/empty_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/link_up/community_report/community_report_widget.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';
import 'package:provider/provider.dart';
import 'community_detail_model.dart';
export 'community_detail_model.dart';

class CommunityDetailWidget extends StatefulWidget {
  const CommunityDetailWidget({
    super.key,
    required this.communityRef,
  });

  final DocumentReference? communityRef;

  static String routeName = 'communityDetail';
  static String routePath = '/communityDetail';

  @override
  State<CommunityDetailWidget> createState() => _CommunityDetailWidgetState();
}

class _CommunityDetailWidgetState extends State<CommunityDetailWidget>
    with TickerProviderStateMixin {
  late CommunityDetailModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CommunityDetailModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'communityDetail'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('COMMUNITY_DETAIL_communityDetail_ON_INIT');
      logFirebaseEvent('communityDetail_custom_action');
      await actions.getCommunityMessage(
        widget!.communityRef!,
        currentUserReference,
      );
    });

    _model.leaveComponentTextController ??= TextEditingController();
    _model.leaveComponentFocusNode ??= FocusNode();
    _model.leaveComponentFocusNode!.addListener(
      () async {
        logFirebaseEvent('COMMUNITY_DETAIL_leaveComponent_ON_FOCUS');
        logFirebaseEvent('leaveComponent_rebuild_page');
        safeSetState(() {});
      },
    );
    animationsMap.addAll({
      'buttonOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.bounceOut,
            delay: 1000.0.ms,
            duration: 1000.0.ms,
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
    return StreamBuilder<CommunityRecord>(
      stream: CommunityRecord.getDocument(widget!.communityRef!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: EmptyWidget(),
          );
        }

        final communityDetailCommunityRecord = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            floatingActionButton: Visibility(
              visible: _model.scrollingColumnScrollOffset != 0.0,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 40.0),
                child: FloatingActionButton(
                  onPressed: () async {
                    logFirebaseEvent(
                        'COMMUNITY_DETAIL_FloatingActionButton_97');
                    logFirebaseEvent('FloatingActionButton_scroll_to');
                    await _model.scrollingColumnScrollController?.animateTo(
                      0,
                      duration: Duration(milliseconds: 100),
                      curve: Curves.ease,
                    );
                  },
                  backgroundColor: FlutterFlowTheme.of(context).primary,
                  elevation: 8.0,
                  child: Icon(
                    Icons.arrow_upward_sharp,
                    color: FlutterFlowTheme.of(context).info,
                    size: 24.0,
                  ),
                ),
              ),
            ),
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderRadius: 8.0,
                buttonSize: 40.0,
                fillColor: Color(0x00FE99AB),
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
                onPressed: () async {
                  logFirebaseEvent('COMMUNITY_DETAIL_arrow_back_ios_rounded_');
                  logFirebaseEvent('IconButton_navigate_to');

                  context.goNamed(CommunitiesWidget.routeName);
                },
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
              child: StreamBuilder<List<MembersRecord>>(
                stream: queryMembersRecord(
                  parent: widget!.communityRef,
                  queryBuilder: (membersRecord) => membersRecord.where(
                    'user_ref',
                    isEqualTo: currentUserReference,
                  ),
                  singleRecord: true,
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
                  List<MembersRecord> parentColumnMembersRecordList =
                      snapshot.data!;
                  final parentColumnMembersRecord =
                      parentColumnMembersRecordList.isNotEmpty
                          ? parentColumnMembersRecordList.first
                          : null;

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: NotificationListener<ScrollMetricsNotification>(
                          onNotification: (notification) {
                            if (notification.depth == 0 &&
                                (_model.scrollingColumnScrollOffset !=
                                        notification.metrics.pixels ||
                                    _model.scrollingColumnScrollMaxExtent !=
                                        notification.metrics.maxScrollExtent)) {
                              _model.scrollingColumnScrollOffset =
                                  notification.metrics.pixels;
                              _model.scrollingColumnScrollMaxExtent =
                                  notification.metrics.maxScrollExtent;
                              _model.scrollingColumnScrollOffsetLastRebuilt =
                                  _model.scrollingColumnScrollOffset;
                              safeSetState(() {});
                            }
                            return false;
                          },
                          child: NotificationListener<ScrollNotification>(
                            onNotification: (notification) {
                              if (notification is ScrollUpdateNotification &&
                                  notification.depth == 0) {
                                _model.scrollingColumnScrollOffset =
                                    notification.metrics.pixels;
                                _model.scrollingColumnScrollMaxExtent =
                                    notification.metrics.maxScrollExtent;
                                if ((_model.scrollingColumnScrollOffset -
                                            _model
                                                .scrollingColumnScrollOffsetLastRebuilt)
                                        .abs() >=
                                    120.0) {
                                  _model.scrollingColumnScrollOffsetLastRebuilt =
                                      _model.scrollingColumnScrollOffset;
                                  safeSetState(() {});
                                }
                              }
                              if (notification is ScrollEndNotification &&
                                  notification.depth == 0) {
                                _model.scrollingColumnScrollOffset =
                                    notification.metrics.pixels;
                                _model.scrollingColumnScrollMaxExtent =
                                    notification.metrics.maxScrollExtent;
                                _model.scrollingColumnScrollOffsetLastRebuilt =
                                    _model.scrollingColumnScrollOffset;
                                safeSetState(() {});
                              }
                              return false;
                            },
                            child: ListView(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 12.0, 16.0, 0.0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
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
                                              communityDetailCommunityRecord
                                                  .communityImage,
                                            ),
                                            width: double.infinity,
                                            height: 230.0,
                                            fit: BoxFit.fill,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Image.asset(
                                              'assets/images/error_image.png',
                                              width: double.infinity,
                                              height: 230.0,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if (parentColumnMembersRecord !=
                                                null)
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    1.0, -1.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 16.0, 16.0, 0.0),
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
                                                          'COMMUNITY_DETAIL_Container_yc1ul3nz_ON_T');
                                                      logFirebaseEvent(
                                                          'Container_navigate_to');

                                                      context.pushNamed(
                                                        ShareCommunityWidget
                                                            .routeName,
                                                        queryParameters: {
                                                          'community':
                                                              serializeParam(
                                                            widget!
                                                                .communityRef,
                                                            ParamType
                                                                .DocumentReference,
                                                          ),
                                                        }.withoutNulls,
                                                      );
                                                    },
                                                    child: Container(
                                                      width: 35.0,
                                                      height: 35.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(2.0),
                                                        child: Icon(
                                                          Icons.share_sharp,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 24.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            if (communityDetailCommunityRecord
                                                    .createdBy ==
                                                currentUserReference)
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    1.0, -1.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 15.0, 16.0, 0.0),
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
                                                          'COMMUNITY_DETAIL_Container_9dyc2i2o_ON_T');
                                                      logFirebaseEvent(
                                                          'Container_navigate_to');

                                                      context.pushNamed(
                                                        CommunitiesEditWidget
                                                            .routeName,
                                                        queryParameters: {
                                                          'community':
                                                              serializeParam(
                                                            communityDetailCommunityRecord,
                                                            ParamType.Document,
                                                          ),
                                                        }.withoutNulls,
                                                        extra: <String,
                                                            dynamic>{
                                                          'community':
                                                              communityDetailCommunityRecord,
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      width: 35.0,
                                                      height: 35.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondary,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(2.0),
                                                        child: Icon(
                                                          Icons.edit_sharp,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 24.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            if (communityDetailCommunityRecord
                                                    .createdBy ==
                                                currentUserReference)
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    1.0, -1.0),
                                                child: Builder(
                                                  builder: (context) => Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 15.0,
                                                                16.0, 0.0),
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
                                                            'COMMUNITY_DETAIL_Container_rr4uz4vo_ON_T');
                                                        logFirebaseEvent(
                                                            'Container_alert_dialog');
                                                        await showDialog(
                                                          context: context,
                                                          builder:
                                                              (dialogContext) {
                                                            return Dialog(
                                                              elevation: 0,
                                                              insetPadding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              alignment: AlignmentDirectional(
                                                                      0.0, 0.0)
                                                                  .resolve(
                                                                      Directionality.of(
                                                                          context)),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  FocusScope.of(
                                                                          dialogContext)
                                                                      .unfocus();
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      ?.unfocus();
                                                                },
                                                                child:
                                                                    DeleteCommunityWidget(
                                                                  community: widget!
                                                                      .communityRef,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 35.0,
                                                        height: 35.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFD94A56),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  2.0),
                                                          child: Icon(
                                                            Icons.delete_sharp,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 24.0,
                                                          ),
                                                        ),
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
                                      16.0, 10.0, 16.0, 20.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              communityDetailCommunityRecord
                                                  .name,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineSmall
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineSmallFamily,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .headlineSmallIsCustom,
                                                      ),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Builder(
                                              builder: (context) =>
                                                  FlutterFlowIconButton(
                                                borderColor: Colors.transparent,
                                                borderRadius: 20.0,
                                                buttonSize: 40.0,
                                                icon: Icon(
                                                  Icons.more_vert_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  size: 24.0,
                                                ),
                                                onPressed: () async {
                                                  logFirebaseEvent(
                                                      'COMMUNITY_DETAIL_more_vert_rounded_ICN_O');
                                                  logFirebaseEvent(
                                                      'IconButton_alert_dialog');
                                                  await showDialog(
                                                    context: context,
                                                    builder: (dialogContext) {
                                                      return Dialog(
                                                        elevation: 0,
                                                        insetPadding:
                                                            EdgeInsets.zero,
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
                                                                .instance
                                                                .primaryFocus
                                                                ?.unfocus();
                                                          },
                                                          child:
                                                              CommunityOptionWidget(
                                                            member: (parentColumnMembersRecord !=
                                                                    null) &&
                                                                (communityDetailCommunityRecord
                                                                        .createdBy !=
                                                                    currentUserReference),
                                                            memberDoc:
                                                                parentColumnMembersRecord,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ).then((value) =>
                                                      safeSetState(() => _model
                                                              .communityOption =
                                                          value));

                                                  if (_model.communityOption ==
                                                      'about') {
                                                    logFirebaseEvent(
                                                        'IconButton_update_page_state');
                                                    _model.about = true;
                                                    safeSetState(() {});
                                                  } else if (_model
                                                          .communityOption ==
                                                      'report') {
                                                    logFirebaseEvent(
                                                        'IconButton_alert_dialog');
                                                    await showDialog(
                                                      context: context,
                                                      builder: (dialogContext) {
                                                        return Dialog(
                                                          elevation: 0,
                                                          insetPadding:
                                                              EdgeInsets.zero,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          alignment: AlignmentDirectional(
                                                                  0.0, 0.0)
                                                              .resolve(
                                                                  Directionality.of(
                                                                      context)),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              FocusScope.of(
                                                                      dialogContext)
                                                                  .unfocus();
                                                              FocusManager
                                                                  .instance
                                                                  .primaryFocus
                                                                  ?.unfocus();
                                                            },
                                                            child:
                                                                CommunityReportWidget(
                                                              eventdoc: widget!
                                                                  .communityRef!,
                                                              name:
                                                                  communityDetailCommunityRecord
                                                                      .name,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  } else if (_model
                                                          .communityOption ==
                                                      'leave') {
                                                    logFirebaseEvent(
                                                        'IconButton_alert_dialog');
                                                    await showDialog(
                                                      context: context,
                                                      builder: (dialogContext) {
                                                        return Dialog(
                                                          elevation: 0,
                                                          insetPadding:
                                                              EdgeInsets.zero,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          alignment: AlignmentDirectional(
                                                                  0.0, 0.0)
                                                              .resolve(
                                                                  Directionality.of(
                                                                      context)),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              FocusScope.of(
                                                                      dialogContext)
                                                                  .unfocus();
                                                              FocusManager
                                                                  .instance
                                                                  .primaryFocus
                                                                  ?.unfocus();
                                                            },
                                                            child:
                                                                ConfirmationDialogueWidget(
                                                              title: 'leave?',
                                                              message:
                                                                  'Are you sure you want to leave this community?',
                                                              buttonText:
                                                                  'leave',
                                                              action: () async {
                                                                logFirebaseEvent(
                                                                    '_backend_call');

                                                                await widget!
                                                                    .communityRef!
                                                                    .update({
                                                                  ...mapToFirestore(
                                                                    {
                                                                      'removed_members':
                                                                          FieldValue
                                                                              .arrayUnion([
                                                                        currentUserReference
                                                                      ]),
                                                                    },
                                                                  ),
                                                                });
                                                                logFirebaseEvent(
                                                                    '_backend_call');
                                                                await parentColumnMembersRecord!
                                                                    .reference
                                                                    .delete();
                                                                logFirebaseEvent(
                                                                    '_navigate_to');

                                                                context.goNamed(
                                                                    CommunitiesWidget
                                                                        .routeName);
                                                              },
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  } else if (_model
                                                          .communityOption ==
                                                      'disable') {
                                                    logFirebaseEvent(
                                                        'IconButton_alert_dialog');
                                                    await showDialog(
                                                      context: context,
                                                      builder: (dialogContext) {
                                                        return Dialog(
                                                          elevation: 0,
                                                          insetPadding:
                                                              EdgeInsets.zero,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          alignment: AlignmentDirectional(
                                                                  0.0, 0.0)
                                                              .resolve(
                                                                  Directionality.of(
                                                                      context)),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              FocusScope.of(
                                                                      dialogContext)
                                                                  .unfocus();
                                                              FocusManager
                                                                  .instance
                                                                  .primaryFocus
                                                                  ?.unfocus();
                                                            },
                                                            child:
                                                                ConfirmationDialogueWidget(
                                                              title:
                                                                  'disable notification?',
                                                              message:
                                                                  'Are you sure you want to disable notifications for this community?',
                                                              buttonText:
                                                                  'disable',
                                                              action: () async {
                                                                logFirebaseEvent(
                                                                    '_backend_call');

                                                                await parentColumnMembersRecord!
                                                                    .reference
                                                                    .update(
                                                                        createMembersRecordData(
                                                                  notificationsEnabled:
                                                                      false,
                                                                ));
                                                              },
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  } else if (_model
                                                          .communityOption ==
                                                      'enable') {
                                                    logFirebaseEvent(
                                                        'IconButton_alert_dialog');
                                                    await showDialog(
                                                      context: context,
                                                      builder: (dialogContext) {
                                                        return Dialog(
                                                          elevation: 0,
                                                          insetPadding:
                                                              EdgeInsets.zero,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          alignment: AlignmentDirectional(
                                                                  0.0, 0.0)
                                                              .resolve(
                                                                  Directionality.of(
                                                                      context)),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              FocusScope.of(
                                                                      dialogContext)
                                                                  .unfocus();
                                                              FocusManager
                                                                  .instance
                                                                  .primaryFocus
                                                                  ?.unfocus();
                                                            },
                                                            child:
                                                                ConfirmationDialogueWidget(
                                                              title:
                                                                  'enable notification?',
                                                              message:
                                                                  'Are you sure you want to enable notifications for this community?',
                                                              buttonText:
                                                                  'enable',
                                                              action: () async {
                                                                logFirebaseEvent(
                                                                    '_backend_call');

                                                                await parentColumnMembersRecord!
                                                                    .reference
                                                                    .update(
                                                                        createMembersRecordData(
                                                                  notificationsEnabled:
                                                                      true,
                                                                ));
                                                              },
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
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 10.0, 16.0, 10.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 10.0),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          controller: _model.rowController1,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              if (communityDetailCommunityRecord
                                                      .createdBy ==
                                                  currentUserReference)
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Icon(
                                                      Icons.star_sharp,
                                                      color: Color(0xFFFE99AB),
                                                      size: 24.0,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  0.0,
                                                                  10.0,
                                                                  0.0),
                                                      child: Text(
                                                        'admin',
                                                        style:
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
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              if ((communityDetailCommunityRecord
                                                          .createdBy !=
                                                      currentUserReference) &&
                                                  (parentColumnMembersRecord !=
                                                      null))
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Icon(
                                                      Icons.verified_rounded,
                                                      color: Color(0xFFFE99AB),
                                                      size: 24.0,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  0.0,
                                                                  10.0,
                                                                  0.0),
                                                      child: Text(
                                                        'member',
                                                        style:
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
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              if (communityDetailCommunityRecord
                                                      .communityType ==
                                                  CommunityType.open)
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Icon(
                                                      Icons.public_sharp,
                                                      color: Color(0xFFFE99AB),
                                                      size: 24.0,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  0.0,
                                                                  10.0,
                                                                  0.0),
                                                      child: Text(
                                                        'open',
                                                        style:
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
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              if (communityDetailCommunityRecord
                                                      .communityType ==
                                                  CommunityType.closed)
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Icon(
                                                      Icons.lock,
                                                      color: Color(0xFFFE99AB),
                                                      size: 24.0,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  0.0,
                                                                  10.0,
                                                                  0.0),
                                                      child: Text(
                                                        'closed',
                                                        style:
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
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              if (communityDetailCommunityRecord
                                                      .communityType ==
                                                  CommunityType.invite)
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Icon(
                                                      Icons.link,
                                                      color: Color(0xFFFE99AB),
                                                      size: 24.0,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  0.0,
                                                                  10.0,
                                                                  0.0),
                                                      child: Text(
                                                        'invite only',
                                                        style:
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
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              Icon(
                                                Icons.groups_sharp,
                                                color: Color(0xFFFE99AB),
                                                size: 24.0,
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 10.0, 0.0),
                                                child: Text(
                                                  '${valueOrDefault<String>(
                                                    communityDetailCommunityRecord
                                                        .members
                                                        .toString(),
                                                    '0',
                                                  )} members',
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                  height: 12.0,
                                  thickness: 1.0,
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 12.0, 16.0, 12.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${valueOrDefault<String>(
                                              communityDetailCommunityRecord
                                                  .members
                                                  .toString(),
                                              '0',
                                            )} members',
                                            style: FlutterFlowTheme.of(context)
                                                .headlineSmall
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineSmallFamily,
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .headlineSmallIsCustom,
                                                ),
                                          ),
                                          if ((communityDetailCommunityRecord
                                                      .members >
                                                  5) ||
                                              (communityDetailCommunityRecord
                                                      .createdBy ==
                                                  currentUserReference))
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                logFirebaseEvent(
                                                    'COMMUNITY_DETAIL_Text_b0rjk2xn_ON_TAP');
                                                logFirebaseEvent(
                                                    'Text_navigate_to');

                                                context.pushNamed(
                                                  MembersWidget.routeName,
                                                  queryParameters: {
                                                    'community': serializeParam(
                                                      communityDetailCommunityRecord,
                                                      ParamType.Document,
                                                    ),
                                                  }.withoutNulls,
                                                  extra: <String, dynamic>{
                                                    'community':
                                                        communityDetailCommunityRecord,
                                                  },
                                                );
                                              },
                                              child: Text(
                                                'view all',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 12.0),
                                      child: StreamBuilder<List<MembersRecord>>(
                                        stream: queryMembersRecord(
                                          parent: widget!.communityRef,
                                          queryBuilder: (membersRecord) =>
                                              membersRecord
                                                  .orderBy('joined_at'),
                                          limit: 5,
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return EmptyWidget();
                                          }
                                          List<MembersRecord>
                                              rowMembersRecordList =
                                              snapshot.data!;

                                          return SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            controller: _model.rowController2,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  (FFCrossAxisAlignment.start)
                                                      .flutterValue,
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              children: List.generate(
                                                  rowMembersRecordList.length,
                                                  (rowIndex) {
                                                final rowMembersRecord =
                                                    rowMembersRecordList[
                                                        rowIndex];
                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    StreamBuilder<UserRecord>(
                                                      stream: UserRecord
                                                          .getDocument(
                                                              rowMembersRecord
                                                                  .userRef!),
                                                      builder:
                                                          (context, snapshot) {
                                                        // Customize what your widget looks like when it's loading.
                                                        if (!snapshot.hasData) {
                                                          return Center(
                                                            child: SizedBox(
                                                              width: 50,
                                                              height: 50,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                valueColor:
                                                                    AlwaysStoppedAnimation<
                                                                        Color>(
                                                                  Colors
                                                                      .transparent,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }

                                                        final containerUserRecord =
                                                            snapshot.data!;

                                                        return Container(
                                                          width: 70.0,
                                                          height: 70.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Visibility(
                                                            visible: containerUserRecord
                                                                        .displayImage !=
                                                                    null &&
                                                                containerUserRecord
                                                                        .displayImage !=
                                                                    '',
                                                            child: Builder(
                                                              builder:
                                                                  (context) =>
                                                                      Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            2.0),
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors
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
                                                                        'COMMUNITY_DETAIL_Image_ewsjqjj7_ON_TAP');
                                                                    if (containerUserRecord
                                                                        .isDeactivated) {
                                                                      logFirebaseEvent(
                                                                          'Image_alert_dialog');
                                                                      await showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (dialogContext) {
                                                                          return Dialog(
                                                                            elevation:
                                                                                0,
                                                                            insetPadding:
                                                                                EdgeInsets.zero,
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () {
                                                                                FocusScope.of(dialogContext).unfocus();
                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                              },
                                                                              child: PausealertWidget(
                                                                                name: containerUserRecord.displayName,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      );
                                                                    } else {
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
                                                                            containerUserRecord.reference,
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
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
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
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        );
                                                                      },
                                                                      image:
                                                                          CachedNetworkImageProvider(
                                                                        containerUserRecord
                                                                            .displayImage,
                                                                      ),
                                                                      width:
                                                                          70.0,
                                                                      height:
                                                                          60.0,
                                                                      fit: BoxFit
                                                                          .cover,
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
                                                    if (rowMembersRecord
                                                            .userRef ==
                                                        communityDetailCommunityRecord
                                                            .createdBy)
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                1.0, -1.0),
                                                        child: FFButtonWidget(
                                                          onPressed: () {
                                                            print(
                                                                'Button pressed ...');
                                                          },
                                                          text: 'host',
                                                          options:
                                                              FFButtonOptions(
                                                            height: 20.0,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    0.0),
                                                            iconPadding:
                                                                EdgeInsets.all(
                                                                    0.0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleSmallFamily,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      fontSize:
                                                                          10.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .titleSmallIsCustom,
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
                                                  ],
                                                );
                                              }).divide(SizedBox(width: 15.0)),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Divider(
                                      height: 12.0,
                                      thickness: 1.0,
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                    ),
                                    if (_model.about)
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            (FFCrossAxisAlignment.start)
                                                .flutterValue,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 12.0, 0.0, 0.0),
                                            child: Text(
                                              'about',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineSmall
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineSmallFamily,
                                                        fontSize: 20.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .headlineSmallIsCustom,
                                                      ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 8.0, 0.0, 12.0),
                                            child: Text(
                                              communityDetailCommunityRecord
                                                  .description,
                                              style:
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
                                            ),
                                          ),
                                          Divider(
                                            height: 12.0,
                                            thickness: 1.0,
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 20.0, 0.0, 0.0),
                                  child: Text(
                                    'join the conversation',
                                    style: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .headlineSmallFamily,
                                          fontSize: 20.0,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .headlineSmallIsCustom,
                                        ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 12.0, 16.0, 12.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                            border: Border.all(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              width: 2.0,
                                            ),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    8.0, 3.0, 4.0, 3.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: _model
                                                        .leaveComponentTextController,
                                                    focusNode: _model
                                                        .leaveComponentFocusNode,
                                                    onChanged: (_) =>
                                                        EasyDebounce.debounce(
                                                      '_model.leaveComponentTextController',
                                                      Duration(milliseconds: 0),
                                                      () async {
                                                        logFirebaseEvent(
                                                            'COMMUNITY_DETAIL_leaveComponent_ON_TEXTF');
                                                        logFirebaseEvent(
                                                            'leaveComponent_rebuild_page');
                                                        safeSetState(() {});
                                                      },
                                                    ),
                                                    autofocus: false,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      isDense: true,
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
                                                      hintText:
                                                          'leave a comment',
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
                                                          color:
                                                              Color(0x00000000),
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0x00000000),
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
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
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
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
                                                        .leaveComponentTextControllerValidator
                                                        .asValidator(context),
                                                  ),
                                                ),
                                                Builder(
                                                  builder: (context) {
                                                    if (!(parentColumnMembersRecord !=
                                                        null)) {
                                                      return FlutterFlowIconButton(
                                                        borderRadius: 30.0,
                                                        buttonSize: 40.0,
                                                        fillColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .warning,
                                                        icon: Icon(
                                                          Icons.send,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 20.0,
                                                        ),
                                                        onPressed: () async {
                                                          logFirebaseEvent(
                                                              'COMMUNITY_DETAIL_PAGE_send_ICN_ON_TAP');
                                                          logFirebaseEvent(
                                                              'IconButton_show_snack_bar');
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .clearSnackBars();
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                'Please join the community to send messages.',
                                                                style:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                ),
                                                              ),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      4000),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    } else {
                                                      return FlutterFlowIconButton(
                                                        borderRadius: 30.0,
                                                        buttonSize: 40.0,
                                                        fillColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        disabledColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .warning,
                                                        icon: Icon(
                                                          Icons.send,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 20.0,
                                                        ),
                                                        showLoadingIndicator:
                                                            true,
                                                        onPressed: (_model
                                                                        .leaveComponentTextController
                                                                        .text ==
                                                                    null ||
                                                                _model.leaveComponentTextController
                                                                        .text ==
                                                                    '')
                                                            ? null
                                                            : () async {
                                                                logFirebaseEvent(
                                                                    'COMMUNITY_DETAIL_PAGE_send_ICN_ON_TAP');
                                                                if (_model.leaveComponentTextController
                                                                            .text !=
                                                                        null &&
                                                                    _model.leaveComponentTextController
                                                                            .text !=
                                                                        '') {
                                                                  if (_model
                                                                      .comment) {
                                                                    return;
                                                                  }

                                                                  logFirebaseEvent(
                                                                      'IconButton_update_page_state');
                                                                  _model.comment =
                                                                      true;
                                                                  safeSetState(
                                                                      () {});
                                                                  logFirebaseEvent(
                                                                      'IconButton_backend_call');

                                                                  await MessagesRecord.createDoc(
                                                                          widget!
                                                                              .communityRef!)
                                                                      .set({
                                                                    ...createMessagesRecordData(
                                                                      text: _model
                                                                          .leaveComponentTextController
                                                                          .text,
                                                                      createdAt:
                                                                          getCurrentTimestamp,
                                                                      userRef:
                                                                          currentUserReference,
                                                                      isReply:
                                                                          false,
                                                                      communityRef:
                                                                          widget!
                                                                              .communityRef,
                                                                    ),
                                                                    ...mapToFirestore(
                                                                      {
                                                                        'message_seen_by':
                                                                            [
                                                                          currentUserReference
                                                                        ],
                                                                      },
                                                                    ),
                                                                  });
                                                                  logFirebaseEvent(
                                                                      'IconButton_clear_text_fields_pin_codes');
                                                                  safeSetState(
                                                                      () {
                                                                    _model
                                                                        .leaveComponentTextController
                                                                        ?.clear();
                                                                  });
                                                                  logFirebaseEvent(
                                                                      'IconButton_update_page_state');
                                                                  _model.comment =
                                                                      false;
                                                                  safeSetState(
                                                                      () {});
                                                                } else {
                                                                  logFirebaseEvent(
                                                                      'IconButton_show_snack_bar');
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .clearSnackBars();
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content:
                                                                          Text(
                                                                        'please write a message first',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                        ),
                                                                      ),
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              4000),
                                                                      backgroundColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .secondary,
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                      );
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        height: 12.0,
                                        thickness: 1.0,
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                      ),
                                      custom_widgets.CommunityMessages(
                                        width: double.infinity,
                                        height: 500.0,
                                        community:
                                            communityDetailCommunityRecord,
                                        isMember:
                                            parentColumnMembersRecord != null,
                                        member: parentColumnMembersRecord,
                                      ),
                                      if (!(parentColumnMembersRecord != null))
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Text(
                                            ' join the group to view the rest of the messages.',
                                            style: FlutterFlowTheme.of(context)
                                                .headlineSmall
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineSmallFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .headlineSmallIsCustom,
                                                ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 20.0,
                                  thickness: 1.0,
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ],
                              controller:
                                  _model.scrollingColumnScrollController,
                            ),
                          ),
                        ),
                      ),
                      if ((_model.leaveComponentFocusNode?.hasFocus ?? false) ==
                          false)
                        StreamBuilder<List<JoinRequestsRecord>>(
                          stream: queryJoinRequestsRecord(
                            parent: widget!.communityRef,
                            queryBuilder: (joinRequestsRecord) =>
                                joinRequestsRecord
                                    .where(
                                      'status',
                                      isEqualTo:
                                          InvitationStatus.pending.serialize(),
                                    )
                                    .where(
                                      'user_ref',
                                      isEqualTo: currentUserReference,
                                    ),
                            singleRecord: true,
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return EmptyWidget();
                            }
                            List<JoinRequestsRecord>
                                columnJoinRequestsRecordList = snapshot.data!;
                            final columnJoinRequestsRecord =
                                columnJoinRequestsRecordList.isNotEmpty
                                    ? columnJoinRequestsRecordList.first
                                    : null;

                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                if (!(parentColumnMembersRecord != null) &&
                                    (communityDetailCommunityRecord.createdBy !=
                                        parentColumnMembersRecord?.userRef) &&
                                    (communityDetailCommunityRecord
                                                .communityType ==
                                            CommunityType.invite
                                        ? communityDetailCommunityRecord
                                            .invitedUsers
                                            .contains(currentUserReference)
                                        : true))
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 8.0, 16.0, 12.0),
                                    child: FFButtonWidget(
                                      onPressed: (communityDetailCommunityRecord
                                                      .communityType ==
                                                  CommunityType.closed
                                              ? (columnJoinRequestsRecord !=
                                                  null)
                                              : false)
                                          ? null
                                          : () async {
                                              logFirebaseEvent(
                                                  'COMMUNITY_DETAIL_PAGE_JOIN_BTN_ON_TAP');
                                              logFirebaseEvent(
                                                  'Button_backend_call');
                                              _model.host = await UserRecord
                                                  .getDocumentOnce(
                                                      communityDetailCommunityRecord
                                                          .createdBy!);
                                              if (communityDetailCommunityRecord
                                                      .communityType ==
                                                  CommunityType.open) {
                                                logFirebaseEvent(
                                                    'Button_backend_call');

                                                await MembersRecord.createDoc(
                                                        widget!.communityRef!)
                                                    .set(
                                                        createMembersRecordData(
                                                  userRef: currentUserReference,
                                                  joinedAt: getCurrentTimestamp,
                                                  role: 'member',
                                                  notificationsEnabled: true,
                                                ));
                                                logFirebaseEvent(
                                                    'Button_backend_call');

                                                await widget!.communityRef!
                                                    .update({
                                                  ...mapToFirestore(
                                                    {
                                                      'members':
                                                          FieldValue.increment(
                                                              1),
                                                    },
                                                  ),
                                                });
                                                if (_model.host!
                                                    .isNotificationEnabled) {
                                                  logFirebaseEvent(
                                                      'Button_trigger_push_notification');
                                                  triggerPushNotification(
                                                    notificationTitle:
                                                        'Congratulations!',
                                                    notificationText:
                                                        '${currentUserDisplayName} has joined ${communityDetailCommunityRecord.name}',
                                                    notificationSound:
                                                        'default',
                                                    userRefs: [
                                                      communityDetailCommunityRecord
                                                          .createdBy!
                                                    ],
                                                    initialPageName:
                                                        'communityDetail',
                                                    parameterData: {
                                                      'communityRef':
                                                          widget!.communityRef,
                                                    },
                                                  );
                                                }
                                                logFirebaseEvent(
                                                    'Button_backend_call');

                                                await NotificationRecord
                                                    .collection
                                                    .doc()
                                                    .set({
                                                  ...createNotificationRecordData(
                                                    title:
                                                        '${currentUserDisplayName} has joined ${communityDetailCommunityRecord.name}',
                                                    sentBy:
                                                        currentUserReference,
                                                    user:
                                                        communityDetailCommunityRecord
                                                            .createdBy,
                                                    notificationType:
                                                        'join Community',
                                                    seen: false,
                                                    community:
                                                        widget!.communityRef,
                                                  ),
                                                  ...mapToFirestore(
                                                    {
                                                      'sent_at': FieldValue
                                                          .serverTimestamp(),
                                                    },
                                                  ),
                                                });
                                                logFirebaseEvent(
                                                    'Button_show_snack_bar');
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'You’ve joined ${communityDetailCommunityRecord.name} successfully!',
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                              } else if (communityDetailCommunityRecord
                                                      .communityType ==
                                                  CommunityType.closed) {
                                                logFirebaseEvent(
                                                    'Button_backend_call');

                                                await JoinRequestsRecord
                                                        .createDoc(widget!
                                                            .communityRef!)
                                                    .set(
                                                        createJoinRequestsRecordData(
                                                  userRef: currentUserReference,
                                                  hostRef:
                                                      communityDetailCommunityRecord
                                                          .createdBy,
                                                  createdAt:
                                                      getCurrentTimestamp,
                                                  status:
                                                      InvitationStatus.pending,
                                                ));
                                                if (_model.host!
                                                    .isNotificationEnabled) {
                                                  logFirebaseEvent(
                                                      'Button_trigger_push_notification');
                                                  triggerPushNotification(
                                                    notificationTitle:
                                                        'Join request',
                                                    notificationText:
                                                        '${currentUserDisplayName} sent request to join ${communityDetailCommunityRecord.name}',
                                                    notificationSound:
                                                        'default',
                                                    userRefs: [
                                                      communityDetailCommunityRecord
                                                          .createdBy!
                                                    ],
                                                    initialPageName:
                                                        'communityDetail',
                                                    parameterData: {
                                                      'communityRef':
                                                          widget!.communityRef,
                                                    },
                                                  );
                                                }
                                                logFirebaseEvent(
                                                    'Button_backend_call');

                                                await NotificationRecord
                                                    .collection
                                                    .doc()
                                                    .set({
                                                  ...createNotificationRecordData(
                                                    title:
                                                        '${currentUserDisplayName} sent request to join ${communityDetailCommunityRecord.name}',
                                                    sentBy:
                                                        currentUserReference,
                                                    user:
                                                        communityDetailCommunityRecord
                                                            .createdBy,
                                                    notificationType:
                                                        'join request Community',
                                                    seen: false,
                                                    community:
                                                        widget!.communityRef,
                                                  ),
                                                  ...mapToFirestore(
                                                    {
                                                      'sent_at': FieldValue
                                                          .serverTimestamp(),
                                                    },
                                                  ),
                                                });
                                                logFirebaseEvent(
                                                    'Button_show_snack_bar');
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Request sent to ${communityDetailCommunityRecord.name} host',
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                              } else if (communityDetailCommunityRecord
                                                      .communityType ==
                                                  CommunityType.invite) {
                                                logFirebaseEvent(
                                                    'Button_backend_call');

                                                await MembersRecord.createDoc(
                                                        widget!.communityRef!)
                                                    .set(
                                                        createMembersRecordData(
                                                  userRef: currentUserReference,
                                                  joinedAt: getCurrentTimestamp,
                                                  role: 'member',
                                                  notificationsEnabled: true,
                                                ));
                                                logFirebaseEvent(
                                                    'Button_backend_call');

                                                await widget!.communityRef!
                                                    .update({
                                                  ...mapToFirestore(
                                                    {
                                                      'members':
                                                          FieldValue.increment(
                                                              1),
                                                      'invited_users':
                                                          FieldValue
                                                              .arrayRemove([
                                                        currentUserReference
                                                      ]),
                                                    },
                                                  ),
                                                });
                                                if (_model.host!
                                                    .isNotificationEnabled) {
                                                  logFirebaseEvent(
                                                      'Button_trigger_push_notification');
                                                  triggerPushNotification(
                                                    notificationTitle:
                                                        'Congratulations!',
                                                    notificationText:
                                                        '${currentUserDisplayName} has joined ${communityDetailCommunityRecord.name} from your invitation',
                                                    notificationSound:
                                                        'default',
                                                    userRefs: [
                                                      communityDetailCommunityRecord
                                                          .createdBy!
                                                    ],
                                                    initialPageName:
                                                        'communityDetail',
                                                    parameterData: {
                                                      'communityRef':
                                                          widget!.communityRef,
                                                    },
                                                  );
                                                }
                                                logFirebaseEvent(
                                                    'Button_backend_call');

                                                await NotificationRecord
                                                    .collection
                                                    .doc()
                                                    .set({
                                                  ...createNotificationRecordData(
                                                    title:
                                                        '${currentUserDisplayName} has joined ${communityDetailCommunityRecord.name} from your invitation',
                                                    sentBy:
                                                        currentUserReference,
                                                    user:
                                                        communityDetailCommunityRecord
                                                            .createdBy,
                                                    notificationType:
                                                        'join Community',
                                                    seen: false,
                                                    community:
                                                        widget!.communityRef,
                                                  ),
                                                  ...mapToFirestore(
                                                    {
                                                      'sent_at': FieldValue
                                                          .serverTimestamp(),
                                                    },
                                                  ),
                                                });
                                                logFirebaseEvent(
                                                    'Button_show_snack_bar');
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'You’ve joined ${communityDetailCommunityRecord.name} successfully!',
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
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

                                              safeSetState(() {});
                                            },
                                      text: 'join',
                                      options: FFButtonOptions(
                                        width: double.infinity,
                                        height: 45.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmallFamily,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .titleSmallIsCustom,
                                            ),
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        disabledColor:
                                            FlutterFlowTheme.of(context)
                                                .warning,
                                      ),
                                    ).animateOnPageLoad(animationsMap[
                                        'buttonOnPageLoadAnimation']!),
                                  ),
                              ],
                            );
                          },
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

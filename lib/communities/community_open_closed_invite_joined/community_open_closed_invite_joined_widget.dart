import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/chat/chat_dropdown_comment/chat_dropdown_comment_widget.dart';
import '/chat/chat_dropdown_event/chat_dropdown_event_widget.dart';
import '/chat/pausealert/pausealert_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/link_up/delete_link_up/delete_link_up_widget.dart';
import '/link_up/link_up_report/link_up_report_widget.dart';
import '/link_up/no_comment_data/no_comment_data_widget.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';
import 'package:provider/provider.dart';
import 'community_open_closed_invite_joined_model.dart';
export 'community_open_closed_invite_joined_model.dart';

class CommunityOpenClosedInviteJoinedWidget extends StatefulWidget {
  const CommunityOpenClosedInviteJoinedWidget({
    super.key,
    required this.eventRef,
  });

  final EventsRecord? eventRef;

  static String routeName = 'communityOpenClosedInviteJoined';
  static String routePath = '/communityOpenClosedInviteJoined';

  @override
  State<CommunityOpenClosedInviteJoinedWidget> createState() =>
      _CommunityOpenClosedInviteJoinedWidgetState();
}

class _CommunityOpenClosedInviteJoinedWidgetState
    extends State<CommunityOpenClosedInviteJoinedWidget>
    with TickerProviderStateMixin {
  late CommunityOpenClosedInviteJoinedModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CommunityOpenClosedInviteJoinedModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'communityOpenClosedInviteJoined'});
    _model.leaveComponentTextController ??= TextEditingController();
    _model.leaveComponentFocusNode ??= FocusNode();
    _model.leaveComponentFocusNode!.addListener(
      () async {
        logFirebaseEvent('COMMUNITY_OPEN_CLOSED_INVITE_JOINED_leav');
        logFirebaseEvent('leaveComponent_rebuild_page');
        safeSetState(() {});
      },
    );
    animationsMap.addAll({
      'textOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
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
      'buttonOnPageLoadAnimation1': AnimationInfo(
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
      'buttonOnPageLoadAnimation2': AnimationInfo(
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
      'buttonOnPageLoadAnimation3': AnimationInfo(
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
      'buttonOnPageLoadAnimation4': AnimationInfo(
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
      'buttonOnPageLoadAnimation5': AnimationInfo(
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
              logFirebaseEvent('COMMUNITY_OPEN_CLOSED_INVITE_JOINED_arro');
              logFirebaseEvent('IconButton_navigate_back');
              context.safePop();
            },
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
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                    borderRadius: BorderRadius.circular(16.0),
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
                                        widget!.eventRef!.coverImage,
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
                                  Align(
                                    alignment: AlignmentDirectional(1.0, -1.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 16.0, 16.0, 0.0),
                                      child: Container(
                                        width: 35.0,
                                        height: 35.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Icon(
                                            Icons.share_sharp,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 24.0,
                                          ),
                                        ),
                                      ),
                                    ),
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '[community name]',
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
                                    if (widget!.eventRef?.userRef !=
                                        currentUserReference)
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
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 24.0,
                                            ),
                                            onPressed: () async {
                                              logFirebaseEvent(
                                                  'COMMUNITY_OPEN_CLOSED_INVITE_JOINED_more');
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
                                                        FocusManager.instance
                                                            .primaryFocus
                                                            ?.unfocus();
                                                      },
                                                      child:
                                                          ChatDropdownEventWidget(
                                                        eventDoc:
                                                            widget!.eventRef!,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ).then((value) => safeSetState(
                                                  () => _model.dialoguereturn =
                                                      value));

                                              if (_model.dialoguereturn ==
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
                                                          FocusManager.instance
                                                              .primaryFocus
                                                              ?.unfocus();
                                                        },
                                                        child:
                                                            LinkUpReportWidget(
                                                          eventdoc:
                                                              widget!.eventRef!,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 10.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.shield_sharp,
                                          color: Color(0xFFFE99AB),
                                          size: 24.0,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 10.0, 0.0),
                                          child: Text(
                                            'member',
                                            style: FlutterFlowTheme.of(context)
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
                                        Icon(
                                          Icons.public_sharp,
                                          color: Color(0xFFFE99AB),
                                          size: 24.0,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 10.0, 0.0),
                                          child: Text(
                                            'open',
                                            style: FlutterFlowTheme.of(context)
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
                                        Icon(
                                          Icons.groups_sharp,
                                          color: Color(0xFFFE99AB),
                                          size: 24.0,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 10.0, 0.0),
                                          child: Text(
                                            '[50] babes',
                                            style: FlutterFlowTheme.of(context)
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
                                      '[50] babes',
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
                                    if (getCurrentTimestamp >
                                        widget!.eventRef!.startTime!)
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          'attended',
                                          style: FlutterFlowTheme.of(context)
                                              .headlineSmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineSmallFamily,
                                                fontSize: 24.0,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .headlineSmallIsCustom,
                                              ),
                                        ),
                                      ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'COMMUNITY_OPEN_CLOSED_INVITE_JOINED_Text');
                                        logFirebaseEvent('Text_navigate_to');

                                        context.pushNamed(
                                          ProfileEditMyPhotoWidget.routeName,
                                          extra: <String, dynamic>{
                                            '__transition_info__':
                                                TransitionInfo(
                                              hasTransition: true,
                                              transitionType:
                                                  PageTransitionType.fade,
                                              duration:
                                                  Duration(milliseconds: 0),
                                            ),
                                          },
                                        );
                                      },
                                      child: Text(
                                        'view all',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .bodyMediumIsCustom,
                                            ),
                                      ),
                                    ).animateOnPageLoad(animationsMap[
                                        'textOnPageLoadAnimation']!),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 12.0),
                                child: Builder(
                                  builder: (context) {
                                    final attendingUsers =
                                        widget!.eventRef?.attending?.toList() ??
                                            [];

                                    return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children:
                                            List.generate(attendingUsers.length,
                                                (attendingUsersIndex) {
                                          final attendingUsersItem =
                                              attendingUsers[
                                                  attendingUsersIndex];
                                          return StreamBuilder<UserRecord>(
                                            stream: UserRecord.getDocument(
                                                attendingUsersItem),
                                            builder: (context, snapshot) {
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
                                                        Colors.black,
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
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Visibility(
                                                  visible: containerUserRecord
                                                              .displayImage !=
                                                          null &&
                                                      containerUserRecord
                                                              .displayImage !=
                                                          '',
                                                  child: Builder(
                                                    builder: (context) =>
                                                        Padding(
                                                      padding:
                                                          EdgeInsets.all(2.0),
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
                                                              'COMMUNITY_OPEN_CLOSED_INVITE_JOINED_Imag');
                                                          if (containerUserRecord
                                                              .isDeactivated) {
                                                            logFirebaseEvent(
                                                                'Image_alert_dialog');
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
                                                                          0.0,
                                                                          0.0)
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
                                                                        PausealertWidget(
                                                                      name: containerUserRecord
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
                                                                'userRef':
                                                                    serializeParam(
                                                                  attendingUsersItem,
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
                                                          }
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
                                                              containerUserRecord
                                                                  .displayImage,
                                                            ),
                                                            width: 70.0,
                                                            height: 60.0,
                                                            fit: BoxFit.cover,
                                                            errorBuilder: (context,
                                                                    error,
                                                                    stackTrace) =>
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
                                              );
                                            },
                                          );
                                        }).divide(SizedBox(width: 15.0)),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            height: 12.0,
                            thickness: 1.0,
                            color: FlutterFlowTheme.of(context).alternate,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 20.0, 0.0, 0.0),
                            child: Text(
                              'join the conversation',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
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
                            height: 340.0,
                            decoration: BoxDecoration(),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 3.0, 4.0, 3.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                                        'COMMUNITY_OPEN_CLOSED_INVITE_JOINED_leav');
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
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumIsCustom,
                                                          ),
                                                  hintText: 'leave a comment',
                                                  hintStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumIsCustom,
                                                          ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  filled: true,
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumIsCustom,
                                                    ),
                                                cursorColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                validator: _model
                                                    .leaveComponentTextControllerValidator
                                                    .asValidator(context),
                                              ),
                                            ),
                                            FlutterFlowIconButton(
                                              borderRadius: 30.0,
                                              buttonSize: 40.0,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              icon: Icon(
                                                Icons.send,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 20.0,
                                              ),
                                              onPressed: () async {
                                                logFirebaseEvent(
                                                    'COMMUNITY_OPEN_CLOSED_INVITE_JOINED_send');
                                                var _shouldSetState = false;
                                                if (_model.leaveComponentTextController
                                                            .text !=
                                                        null &&
                                                    _model.leaveComponentTextController
                                                            .text !=
                                                        '') {
                                                  if (_model.comment) {
                                                    if (_shouldSetState)
                                                      safeSetState(() {});
                                                    return;
                                                  }

                                                  logFirebaseEvent(
                                                      'IconButton_update_page_state');
                                                  _model.comment = true;
                                                  safeSetState(() {});
                                                  logFirebaseEvent(
                                                      'IconButton_backend_call');

                                                  await EventsCommentRecord
                                                      .collection
                                                      .doc()
                                                      .set(
                                                          createEventsCommentRecordData(
                                                        commentTitle: _model
                                                            .leaveComponentTextController
                                                            .text,
                                                        commentTime:
                                                            getCurrentTimestamp,
                                                        commentUserRef:
                                                            currentUserReference,
                                                        commentEventRef: widget!
                                                            .eventRef
                                                            ?.reference,
                                                      ));
                                                  logFirebaseEvent(
                                                      'IconButton_trigger_push_notification');
                                                  triggerPushNotification(
                                                    notificationTitle:
                                                        '${currentUserDisplayName} has commented on  ${widget!.eventRef?.name}',
                                                    notificationText: _model
                                                        .leaveComponentTextController
                                                        .text,
                                                    notificationSound:
                                                        'default',
                                                    userRefs: [
                                                      widget!.eventRef!.userRef!
                                                    ],
                                                    initialPageName:
                                                        'communityOpenClosedInviteJoined',
                                                    parameterData: {
                                                      'eventRef':
                                                          widget!.eventRef,
                                                    },
                                                  );
                                                  while (_model.commentIndex <
                                                      widget!.eventRef!
                                                          .attending.length) {
                                                    logFirebaseEvent(
                                                        'IconButton_backend_call');
                                                    _model.users = await UserRecord
                                                        .getDocumentOnce(widget!
                                                            .eventRef!.attending
                                                            .where((e) =>
                                                                e !=
                                                                currentUserReference)
                                                            .toList()
                                                            .elementAtOrNull(_model
                                                                .commentIndex)!);
                                                    _shouldSetState = true;
                                                    if (_model.users!
                                                        .isNotificationEnabled) {
                                                      logFirebaseEvent(
                                                          'IconButton_firestore_query');
                                                      _model.managetodaynotificationlist =
                                                          await queryEventsCommentRecordOnce(
                                                        queryBuilder:
                                                            (eventsCommentRecord) =>
                                                                eventsCommentRecord
                                                                    .where(
                                                          'comment_userRef',
                                                          isEqualTo: widget!
                                                              .eventRef
                                                              ?.userRef,
                                                        ),
                                                      );
                                                      _shouldSetState = true;
                                                      if (functions.managedatetimefunction(_model
                                                              .managetodaynotificationlist
                                                              ?.map((e) =>
                                                                  e.commentTime)
                                                              .withoutNulls
                                                              .toList()
                                                              ?.toList())! <=
                                                          2) {
                                                        if (_model.users
                                                                ?.reference !=
                                                            currentUserReference) {
                                                          logFirebaseEvent(
                                                              'IconButton_backend_call');
                                                          _model.userdocument =
                                                              await UserRecord
                                                                  .getDocumentOnce(widget!
                                                                      .eventRef!
                                                                      .userRef!);
                                                          _shouldSetState =
                                                              true;
                                                          if (_model
                                                                  .userdocument
                                                                  ?.offlineUserTime ==
                                                              null) {
                                                            logFirebaseEvent(
                                                                'IconButton_trigger_push_notification');
                                                            triggerPushNotification(
                                                              notificationTitle:
                                                                  '${currentUserDisplayName} has commented on  ${widget!.eventRef?.name}',
                                                              notificationText:
                                                                  _model
                                                                      .leaveComponentTextController
                                                                      .text,
                                                              notificationSound:
                                                                  'default',
                                                              userRefs: [
                                                                _model.users!
                                                                    .reference
                                                              ],
                                                              initialPageName:
                                                                  'communityOpenClosedInviteJoined',
                                                              parameterData: {
                                                                'eventRef':
                                                                    widget!
                                                                        .eventRef,
                                                              },
                                                            );
                                                          }
                                                        }
                                                      }
                                                    }
                                                    logFirebaseEvent(
                                                        'IconButton_backend_call');

                                                    await NotificationRecord
                                                        .collection
                                                        .doc()
                                                        .set({
                                                      ...createNotificationRecordData(
                                                        title:
                                                            '${currentUserDisplayName} has commented in ${widget!.eventRef?.name}',
                                                        sentBy:
                                                            currentUserReference,
                                                        user: _model
                                                            .users?.reference,
                                                        notificationType:
                                                            'comment Linkup',
                                                        description: _model
                                                            .leaveComponentTextController
                                                            .text,
                                                        linkup: widget!.eventRef
                                                            ?.reference,
                                                        seen: false,
                                                        forAdmin: false,
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'sent_at': FieldValue
                                                              .serverTimestamp(),
                                                        },
                                                      ),
                                                    });
                                                    logFirebaseEvent(
                                                        'IconButton_update_page_state');
                                                    _model.commentIndex =
                                                        _model.commentIndex + 1;
                                                    safeSetState(() {});
                                                  }
                                                  logFirebaseEvent(
                                                      'IconButton_clear_text_fields_pin_codes');
                                                  safeSetState(() {
                                                    _model
                                                        .leaveComponentTextController
                                                        ?.clear();
                                                  });
                                                  logFirebaseEvent(
                                                      'IconButton_wait__delay');
                                                  await Future.delayed(
                                                    Duration(
                                                      milliseconds: 1000,
                                                    ),
                                                  );
                                                  logFirebaseEvent(
                                                      'IconButton_update_page_state');
                                                  _model.comment = false;
                                                  safeSetState(() {});
                                                } else {
                                                  logFirebaseEvent(
                                                      'IconButton_show_snack_bar');
                                                  ScaffoldMessenger.of(context)
                                                      .clearSnackBars();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'please write a message first',
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

                                                if (_shouldSetState)
                                                  safeSetState(() {});
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ).animateOnPageLoad(animationsMap[
                                        'containerOnPageLoadAnimation']!),
                                  ),
                                  Divider(
                                    height: 12.0,
                                    thickness: 1.0,
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                  ),
                                  StreamBuilder<List<EventsCommentRecord>>(
                                    stream: queryEventsCommentRecord(
                                      queryBuilder: (eventsCommentRecord) =>
                                          eventsCommentRecord
                                              .where(
                                                'comment_eventRef',
                                                isEqualTo:
                                                    widget!.eventRef?.reference,
                                              )
                                              .orderBy('comment_time',
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
                                      List<EventsCommentRecord>
                                          containerEventsCommentRecordList =
                                          snapshot.data!;

                                      return Container(
                                        decoration: BoxDecoration(),
                                        child: AuthUserStreamWidget(
                                          builder: (context) => Builder(
                                            builder: (context) {
                                              final containerVar =
                                                  containerEventsCommentRecordList
                                                      .where((e) =>
                                                          !(currentUserDocument
                                                                      ?.commentReporList
                                                                      ?.toList() ??
                                                                  [])
                                                              .contains(
                                                                  e.reference))
                                                      .toList();
                                              if (containerVar.isEmpty) {
                                                return Center(
                                                  child: NoCommentDataWidget(),
                                                );
                                              }

                                              return ListView.builder(
                                                padding: EdgeInsets.zero,
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount: containerVar.length,
                                                itemBuilder: (context,
                                                    containerVarIndex) {
                                                  final containerVarItem =
                                                      containerVar[
                                                          containerVarIndex];
                                                  return StreamBuilder<
                                                      List<UserRecord>>(
                                                    stream: queryUserRecord(
                                                      queryBuilder:
                                                          (userRecord) =>
                                                              userRecord.where(
                                                        'uid',
                                                        isEqualTo:
                                                            containerVarItem
                                                                .commentUserRef
                                                                ?.id,
                                                      ),
                                                      singleRecord: true,
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Center(
                                                          child:
                                                              LinearProgressIndicator(
                                                            color: Color(
                                                                0xFFFE99AB),
                                                          ),
                                                        );
                                                      }
                                                      List<UserRecord>
                                                          containerUserRecordList =
                                                          snapshot.data!;
                                                      final containerUserRecord =
                                                          containerUserRecordList
                                                                  .isNotEmpty
                                                              ? containerUserRecordList
                                                                  .first
                                                              : null;

                                                      return Container(
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Visibility(
                                                          visible: (containerUserRecord
                                                                      ?.reference !=
                                                                  null) &&
                                                              (containerUserRecord
                                                                      ?.banned ==
                                                                  false),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        15.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          10.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Builder(
                                                                        builder:
                                                                            (context) =>
                                                                                InkWell(
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
                                                                            logFirebaseEvent('COMMUNITY_OPEN_CLOSED_INVITE_JOINED_Cont');
                                                                            if (containerUserRecord!.isDeactivated) {
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
                                                                                        name: containerUserRecord!.displayName,
                                                                                      ),
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
                                                                                    containerUserRecord?.reference,
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
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                50.0,
                                                                            height:
                                                                                50.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                            ),
                                                                            child:
                                                                                Visibility(
                                                                              visible: containerUserRecord?.displayImage != null && containerUserRecord?.displayImage != '',
                                                                              child: Builder(
                                                                                builder: (context) => Padding(
                                                                                  padding: EdgeInsets.all(2.0),
                                                                                  child: InkWell(
                                                                                    splashColor: Colors.transparent,
                                                                                    focusColor: Colors.transparent,
                                                                                    hoverColor: Colors.transparent,
                                                                                    highlightColor: Colors.transparent,
                                                                                    onTap: () async {
                                                                                      logFirebaseEvent('COMMUNITY_OPEN_CLOSED_INVITE_JOINED_Imag');
                                                                                      if (containerUserRecord?.isDeactivated == true) {
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
                                                                                                  name: containerUserRecord!.displayName,
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
                                                                                              containerUserRecord?.reference,
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
                                                                                          containerUserRecord!.displayImage,
                                                                                        ),
                                                                                        width: 70.0,
                                                                                        height: 60.0,
                                                                                        fit: BoxFit.cover,
                                                                                        errorBuilder: (context, error, stackTrace) => Image.asset(
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
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              16.0,
                                                                              0.0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                                child: Text(
                                                                                  containerUserRecord!.displayName,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                                child: Text(
                                                                                  dateTimeFormat("relative", containerVarItem.commentTime!),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                        letterSpacing: 0.0,
                                                                                        useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      if (containerVarItem
                                                                              .commentUserRef !=
                                                                          currentUserReference)
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Builder(
                                                                            builder: (context) =>
                                                                                FlutterFlowIconButton(
                                                                              borderColor: Colors.transparent,
                                                                              borderRadius: 20.0,
                                                                              buttonSize: 40.0,
                                                                              icon: Icon(
                                                                                Icons.more_vert_rounded,
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                size: 24.0,
                                                                              ),
                                                                              onPressed: () async {
                                                                                logFirebaseEvent('COMMUNITY_OPEN_CLOSED_INVITE_JOINED_more');
                                                                                logFirebaseEvent('IconButton_alert_dialog');
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
                                                                                        child: ChatDropdownCommentWidget(
                                                                                          chatreference: containerVarItem,
                                                                                          linkupName: widget!.eventRef!.name,
                                                                                          commentName: containerVarItem.commentTitle,
                                                                                          reportuser: containerUserRecord!,
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
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            16.0,
                                                                            3.0),
                                                                        child:
                                                                            Text(
                                                                          containerVarItem
                                                                              .commentTitle,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                letterSpacing: 0.0,
                                                                                useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    FlutterFlowIconButton(
                                                                      borderRadius:
                                                                          8.0,
                                                                      buttonSize:
                                                                          40.0,
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .reply_sharp,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        size:
                                                                            24.0,
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        print(
                                                                            'IconButton pressed ...');
                                                                      },
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                                      child:
                                                                          ToggleIcon(
                                                                        onPressed:
                                                                            () async {
                                                                          safeSetState(() =>
                                                                              _model.comment = !_model.comment);
                                                                        },
                                                                        value: _model
                                                                            .comment,
                                                                        onIcon:
                                                                            Icon(
                                                                          Icons
                                                                              .favorite_sharp,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          size:
                                                                              24.0,
                                                                        ),
                                                                        offIcon:
                                                                            Icon(
                                                                          Icons
                                                                              .favorite_border_outlined,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryText,
                                                                          size:
                                                                              24.0,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Divider(
                                                                  thickness:
                                                                      2.0,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if ((_model.leaveComponentFocusNode?.hasFocus ?? false) ==
                          false)
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            if (widget!.eventRef?.userRef ==
                                currentUserReference)
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 8.0, 16.0, 12.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'COMMUNITY_OPEN_CLOSED_INVITE_JOINED_EDIT');
                                    logFirebaseEvent('Button_navigate_to');

                                    context.pushNamed(
                                      LinkUpEditWidget.routeName,
                                      queryParameters: {
                                        'event': serializeParam(
                                          widget!.eventRef,
                                          ParamType.Document,
                                        ),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        'event': widget!.eventRef,
                                      },
                                    );
                                  },
                                  text: 'edit',
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 45.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .titleSmallIsCustom,
                                        ),
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                ).animateOnPageLoad(animationsMap[
                                    'buttonOnPageLoadAnimation1']!),
                              ),
                            if (widget!.eventRef?.userRef ==
                                currentUserReference)
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 8.0, 16.0, 12.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'COMMUNITY_OPEN_CLOSED_INVITE_JOINED_DELE');
                                    logFirebaseEvent('Button_bottom_sheet');
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
                                            child: DeleteLinkUpWidget(
                                              eventDocument:
                                                  widget!.eventRef!.reference,
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));

                                    logFirebaseEvent('Button_navigate_back');
                                    context.safePop();
                                  },
                                  text: 'delete',
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 45.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: Color(0x00FE99AB),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .titleSmallIsCustom,
                                        ),
                                    elevation: 0.0,
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                ).animateOnPageLoad(animationsMap[
                                    'buttonOnPageLoadAnimation2']!),
                              ),
                            if (!widget!.eventRef!.attending
                                    .contains(currentUserReference) &&
                                (widget!.eventRef?.userRef !=
                                    currentUserReference) &&
                                (widget!.eventRef!.startTime! >=
                                    getCurrentTimestamp))
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 8.0, 16.0, 12.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'COMMUNITY_OPEN_CLOSED_INVITE_JOINED_JOIN');
                                    logFirebaseEvent('Button_backend_call');

                                    await widget!.eventRef!.reference.update({
                                      ...mapToFirestore(
                                        {
                                          'attending': FieldValue.arrayUnion(
                                              [currentUserReference]),
                                        },
                                      ),
                                    });
                                    logFirebaseEvent('Button_backend_call');
                                    _model.user =
                                        await UserRecord.getDocumentOnce(
                                            widget!.eventRef!.userRef!);
                                    if (_model.user!.isNotificationEnabled) {
                                      logFirebaseEvent(
                                          'Button_trigger_push_notification');
                                      triggerPushNotification(
                                        notificationTitle: 'Congratulations!',
                                        notificationText:
                                            '${currentUserDisplayName} has joined ${widget!.eventRef?.name}',
                                        notificationSound: 'default',
                                        userRefs: [widget!.eventRef!.userRef!],
                                        initialPageName:
                                            'communityOpenClosedInviteJoined',
                                        parameterData: {
                                          'eventRef': widget!.eventRef,
                                        },
                                      );
                                    }
                                    logFirebaseEvent('Button_backend_call');

                                    await NotificationRecord.collection
                                        .doc()
                                        .set({
                                      ...createNotificationRecordData(
                                        title:
                                            '${currentUserDisplayName} has joined ${widget!.eventRef?.name}',
                                        sentBy: currentUserReference,
                                        user: _model.user?.reference,
                                        notificationType: 'join Linkup',
                                        linkup: widget!.eventRef?.reference,
                                        seen: false,
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'sent_at':
                                              FieldValue.serverTimestamp(),
                                        },
                                      ),
                                    });
                                    logFirebaseEvent('Button_navigate_back');
                                    context.safePop();
                                    logFirebaseEvent('Button_show_snack_bar');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'You are attending: ${widget!.eventRef?.name}',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondary,
                                      ),
                                    );

                                    safeSetState(() {});
                                  },
                                  text: 'join',
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 45.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .titleSmallIsCustom,
                                        ),
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                ).animateOnPageLoad(animationsMap[
                                    'buttonOnPageLoadAnimation3']!),
                              ),
                            if (widget!.eventRef!.attending
                                    .contains(currentUserReference) &&
                                (widget!.eventRef?.userRef !=
                                    currentUserReference) &&
                                (widget!.eventRef!.startTime! >=
                                    getCurrentTimestamp))
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 8.0, 16.0, 12.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'COMMUNITY_OPEN_CLOSED_INVITE_JOINED_LEAV');
                                    logFirebaseEvent('Button_backend_call');

                                    await widget!.eventRef!.reference.update({
                                      ...mapToFirestore(
                                        {
                                          'attending': FieldValue.arrayRemove(
                                              [currentUserReference]),
                                        },
                                      ),
                                    });
                                    logFirebaseEvent('Button_show_snack_bar');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'You are no longer attending: ${widget!.eventRef?.name}',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondary,
                                      ),
                                    );
                                    logFirebaseEvent('Button_navigate_back');
                                    context.safePop();
                                  },
                                  text: 'leave',
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 45.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: Color(0x00FE99AB),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .titleSmallIsCustom,
                                        ),
                                    elevation: 0.0,
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                ).animateOnPageLoad(animationsMap[
                                    'buttonOnPageLoadAnimation4']!),
                              ),
                          ],
                        ),
                      if (widget!.eventRef?.role == 'admin')
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 8.0, 16.0, 18.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              logFirebaseEvent(
                                  'COMMUNITY_OPEN_CLOSED_INVITE_JOINED_GET_');
                              logFirebaseEvent('Button_launch_u_r_l');
                              await launchURL(
                                  'https://www.yesgurl.co.uk/events');
                              if (!widget!.eventRef!.getTicketList
                                  .contains(currentUserReference)) {
                                logFirebaseEvent('Button_backend_call');

                                await widget!.eventRef!.reference.update({
                                  ...mapToFirestore(
                                    {
                                      'get_ticket_list': FieldValue.arrayUnion(
                                          [currentUserReference]),
                                    },
                                  ),
                                });
                              }
                            },
                            text: 'get tickets',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 45.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
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
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .titleSmallIsCustom,
                                  ),
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ).animateOnPageLoad(
                              animationsMap['buttonOnPageLoadAnimation5']!),
                        ),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional(1.0, -1.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 16.0, 0.0),
                  child: Container(
                    width: 35.0,
                    height: 35.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primary,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Icon(
                        Icons.share_sharp,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                    ),
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

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/chat/chat_dropdown_event/chat_dropdown_event_widget.dart';
import '/chat/pausealert/pausealert_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/link_up/chat_dropdown_comment/chat_dropdown_comment_widget.dart';
import '/link_up/event_reply_card/event_reply_card_widget.dart';
import '/link_up/no_comment_data/no_comment_data_widget.dart';
import 'dart:async';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';
import 'package:provider/provider.dart';
import 'admin_link_up_details_model.dart';
export 'admin_link_up_details_model.dart';

class AdminLinkUpDetailsWidget extends StatefulWidget {
  const AdminLinkUpDetailsWidget({
    super.key,
    required this.eventDoc,
  });

  final EventsRecord? eventDoc;

  static String routeName = 'adminLinkUpDetails';
  static String routePath = '/adminLinkUpDetails';

  @override
  State<AdminLinkUpDetailsWidget> createState() =>
      _AdminLinkUpDetailsWidgetState();
}

class _AdminLinkUpDetailsWidgetState extends State<AdminLinkUpDetailsWidget>
    with TickerProviderStateMixin {
  late AdminLinkUpDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdminLinkUpDetailsModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'adminLinkUpDetails'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('ADMIN_LINK_UP_DETAILS_adminLinkUpDetails');
      if ((widget!.eventDoc?.createdBy == currentUserReference) ||
          widget!.eventDoc!.attending.contains(currentUserReference)) {
        logFirebaseEvent('adminLinkUpDetails_custom_action');
        await actions.getEventComments(
          widget!.eventDoc!.reference,
          currentUserReference!,
        );
      }
    });

    if (!isWeb) {
      _keyboardVisibilitySubscription =
          KeyboardVisibilityController().onChange.listen((bool visible) {
        safeSetState(() {
          _isKeyboardVisible = visible;
        });
      });
    }

    _model.leaveComponentTextController ??= TextEditingController();
    _model.leaveComponentFocusNode ??= FocusNode();
    _model.leaveComponentFocusNode!.addListener(
      () async {
        logFirebaseEvent('ADMIN_LINK_UP_DETAILS_leaveComponent_ON_');
        logFirebaseEvent('leaveComponent_rebuild_page');
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
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    if (!isWeb) {
      _keyboardVisibilitySubscription.cancel();
    }
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
              Icons.arrow_back_ios_new,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            onPressed: () async {
              logFirebaseEvent('ADMIN_LINK_UP_DETAILS_arrow_back_ios_new');
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
          child: Container(
            height: MediaQuery.sizeOf(context).height * 1.0,
            decoration: BoxDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
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
                                child: Visibility(
                                  visible:
                                      widget!.eventDoc?.coverImage != null &&
                                          widget!.eventDoc?.coverImage != '',
                                  child: ClipRRect(
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
                                        widget!.eventDoc!.coverImage,
                                      ),
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      height: 230.0,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Image.asset(
                                        'assets/images/error_image.png',
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        height: 230.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 10.0, 16.0, 20.0),
                              child: Container(
                                width: double.infinity,
                                height: 110.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              valueOrDefault<String>(
                                                widget!.eventDoc?.name,
                                                'Event name',
                                              ),
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
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 5.0, 0.0, 0.0),
                                        child: StreamBuilder<UserRecord>(
                                          stream: UserRecord.getDocument(
                                              widget!.eventDoc!.userRef!),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: LinearProgressIndicator(
                                                  color: Color(0xFFFE99AB),
                                                ),
                                              );
                                            }

                                            final rowUserRecord =
                                                snapshot.data!;

                                            return Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60.0),
                                                    child: Image.asset(
                                                      'assets/images/yes_gurl_logo_socials_(3).png',
                                                      width: 70.0,
                                                      height: 60.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -1.0, 0.0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              'Yes Gurl',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .headlineSmallFamily,
                                                                    fontSize:
                                                                        18.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .headlineSmallIsCustom,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            'host',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
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
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Builder(
                                                    builder: (context) =>
                                                        FlutterFlowIconButton(
                                                      borderColor:
                                                          Colors.transparent,
                                                      borderRadius: 20.0,
                                                      buttonSize: 40.0,
                                                      icon: Icon(
                                                        Icons.more_vert_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        size: 24.0,
                                                      ),
                                                      onPressed: () async {
                                                        logFirebaseEvent(
                                                            'ADMIN_LINK_UP_DETAILS_more_vert_rounded_');
                                                        logFirebaseEvent(
                                                            'IconButton_alert_dialog');
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
                                                                    ChatDropdownEventWidget(
                                                                  eventDoc: widget!
                                                                      .eventDoc!,
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 12.0,
                              thickness: 1.0,
                              color: FlutterFlowTheme.of(context).alternate,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 10.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.date_range_sharp,
                                              color: Color(0xFFFE99AB),
                                              size: 24.0,
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 10.0, 0.0),
                                                child: Text(
                                                  functions
                                                      .generateDateFormateForLinkup(
                                                          widget!.eventDoc!
                                                              .startTime!),
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
                                            ),
                                            Icon(
                                              Icons.access_time_sharp,
                                              color: Color(0xFFFE99AB),
                                              size: 24.0,
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  dateTimeFormat(
                                                      "jm",
                                                      widget!.eventDoc!
                                                          .startTime!),
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
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              color: Color(0xFFFE99AB),
                                              size: 24.0,
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    widget!.eventDoc?.address,
                                                    'Event address',
                                                  ),
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
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              height: 12.0,
                              thickness: 1.0,
                              color: FlutterFlowTheme.of(context).alternate,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 0.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 8.0, 0.0, 0.0),
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
                                                    0.0, 8.0, 0.0, 12.0),
                                            child: Text(
                                              valueOrDefault<String>(
                                                widget!.eventDoc?.description,
                                                '-',
                                              ),
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
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(
                                  height: 12.0,
                                  thickness: 1.0,
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 12.0, 16.0, 12.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        valueOrDefault<String>(
                                          widget!.eventDoc?.attending?.length
                                              ?.toString(),
                                          '10',
                                        ),
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
                                      if (widget!.eventDoc!.startTime! >=
                                          getCurrentTimestamp)
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            'attending',
                                            style: FlutterFlowTheme.of(context)
                                                .headlineSmall
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                      if (getCurrentTimestamp >
                                          widget!.eventDoc!.startTime!)
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            'attended',
                                            style: FlutterFlowTheme.of(context)
                                                .headlineSmall
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 12.0),
                                  child: Builder(
                                    builder: (context) {
                                      final attendingUsers = widget!
                                              .eventDoc?.attending
                                              ?.toList() ??
                                          [];

                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: List.generate(
                                              attendingUsers.length,
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
                                                                'ADMIN_LINK_UP_DETAILS_Image_n4z81jru_ON_');
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
                                                                queryParameters:
                                                                    {
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
                                            );
                                          }).divide(SizedBox(width: 15.0)),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
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
                            'comment',
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .headlineSmallFamily,
                                  fontSize: 24.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .headlineSmallIsCustom,
                                ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 340.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
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
                                      borderRadius: BorderRadius.circular(40.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 3.0, 8.0, 3.0),
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
                                                      'ADMIN_LINK_UP_DETAILS_leaveComponent_ON_');
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
                                                hintText: 'leave a comment',
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
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
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
                                                    color: FlutterFlowTheme.of(
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
                                                    FlutterFlowTheme.of(context)
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
                                                    color: FlutterFlowTheme.of(
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
                                                  'ADMIN_LINK_UP_DETAILS_send_ICN_ON_TAP');
                                              if (_model.leaveComponentTextController
                                                          .text !=
                                                      null &&
                                                  _model.leaveComponentTextController
                                                          .text !=
                                                      '') {
                                                if (_model.comment) {
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
                                                          .eventDoc?.reference,
                                                      notificationSend: true,
                                                    ));
                                                logFirebaseEvent(
                                                    'IconButton_clear_text_fields_pin_codes');
                                                safeSetState(() {
                                                  _model
                                                      .leaveComponentTextController
                                                      ?.clear();
                                                });
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
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                                if (false)
                                  Expanded(
                                    child: StreamBuilder<
                                        List<EventsCommentRecord>>(
                                      stream: queryEventsCommentRecord(
                                        queryBuilder: (eventsCommentRecord) =>
                                            eventsCommentRecord
                                                .where(
                                                  'comment_eventRef',
                                                  isEqualTo: widget!
                                                      .eventDoc?.reference,
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
                                                                .contains(e
                                                                    .reference))
                                                        .toList();
                                                if (containerVar.isEmpty) {
                                                  return Center(
                                                    child:
                                                        NoCommentDataWidget(),
                                                  );
                                                }

                                                return ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  primary: false,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount:
                                                      containerVar.length,
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
                                                                userRecord
                                                                    .where(
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
                                                                        ?.isDeactivated ==
                                                                    false) &&
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
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              16.0,
                                                                              0.0,
                                                                              16.0,
                                                                              10.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children:
                                                                                [
                                                                              Expanded(
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    InkWell(
                                                                                      splashColor: Colors.transparent,
                                                                                      focusColor: Colors.transparent,
                                                                                      hoverColor: Colors.transparent,
                                                                                      highlightColor: Colors.transparent,
                                                                                      onTap: () async {
                                                                                        logFirebaseEvent('ADMIN_LINK_UP_DETAILS_Container_3jl70hkb');
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
                                                                                      },
                                                                                      child: Container(
                                                                                        width: 50.0,
                                                                                        height: 50.0,
                                                                                        decoration: BoxDecoration(
                                                                                          shape: BoxShape.circle,
                                                                                        ),
                                                                                        child: Visibility(
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
                                                                                                  logFirebaseEvent('ADMIN_LINK_UP_DETAILS_Image_0t233v01_ON_');
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
                                                                                    Expanded(
                                                                                      child: Column(
                                                                                        mainAxisSize: MainAxisSize.min,
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Row(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              Expanded(
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                                                  child: Text(
                                                                                                    valueOrDefault<String>(
                                                                                                      containerUserRecord?.displayName,
                                                                                                      '-',
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                                            child: Text(
                                                                                              valueOrDefault<String>(
                                                                                                dateTimeFormat("relative", containerVarItem.commentTime),
                                                                                                '-',
                                                                                              ),
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
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ].divide(SizedBox(width: 20.0)),
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
                                                                                logFirebaseEvent('ADMIN_LINK_UP_DETAILS_more_vert_rounded_');
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
                                                                                        child: Container(
                                                                                          width: 100.0,
                                                                                          child: ChatDropdownCommentWidget(
                                                                                            chatreference: containerVarItem,
                                                                                            linkupName: widget!.eventDoc!.name,
                                                                                            commentName: containerVarItem.commentTitle,
                                                                                            reportuser: containerUserRecord!,
                                                                                            event: widget!.eventDoc,
                                                                                          ),
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
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            16.0,
                                                                            3.0),
                                                                    child: Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        containerVarItem
                                                                            .commentTitle,
                                                                        '-',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            useGoogleFonts:
                                                                                !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                          ),
                                                                    ),
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
                                  ),
                                StreamBuilder<List<EventsCommentRecord>>(
                                  stream: queryEventsCommentRecord(
                                    queryBuilder: (eventsCommentRecord) =>
                                        eventsCommentRecord
                                            .where(
                                              'comment_eventRef',
                                              isEqualTo:
                                                  widget!.eventDoc?.reference,
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
                                                                e.reference) &&
                                                        (e.replyComment ==
                                                            null))
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
                                              itemBuilder:
                                                  (context, containerVarIndex) {
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
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child:
                                                            LinearProgressIndicator(
                                                          color:
                                                              Color(0xFFFE99AB),
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
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            0.0,
                                                                            10.0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Builder(
                                                                          builder: (context) =>
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
                                                                              logFirebaseEvent('ADMIN_LINK_UP_DETAILS_Container_h1g7u4zx');
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
                                                                              width: 50.0,
                                                                              height: 50.0,
                                                                              decoration: BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                              ),
                                                                              child: Visibility(
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
                                                                                        logFirebaseEvent('ADMIN_LINK_UP_DETAILS_Image_demu0wo9_ON_');
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
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                                                                logFirebaseEvent('ADMIN_LINK_UP_DETAILS_more_vert_rounded_');
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
                                                                                          linkupName: widget!.eventDoc!.name,
                                                                                          commentName: containerVarItem.commentTitle,
                                                                                          reportuser: containerUserRecord!,
                                                                                          event: widget!.eventDoc,
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
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            16.0,
                                                                            0.0),
                                                                    child: Row(
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
                                                                              containerVarItem.commentTitle,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                                                                            Icons.reply_sharp,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            size:
                                                                                24.0,
                                                                          ),
                                                                          onPressed:
                                                                              () async {
                                                                            logFirebaseEvent('ADMIN_LINK_UP_DETAILS_reply_sharp_ICN_ON');
                                                                            logFirebaseEvent('IconButton_update_page_state');
                                                                            _model.replyMessage =
                                                                                containerVarItem.reference;
                                                                            safeSetState(() {});
                                                                          },
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              4.0,
                                                                              0.0),
                                                                          child:
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
                                                                              logFirebaseEvent('ADMIN_LINK_UP_DETAILS_ConditionalBuilder');
                                                                              if (containerVarItem.eventLikes.contains(currentUserReference)) {
                                                                                logFirebaseEvent('ConditionalBuilder_backend_call');

                                                                                await containerVarItem.reference.update({
                                                                                  ...mapToFirestore(
                                                                                    {
                                                                                      'event_likes': FieldValue.arrayRemove([
                                                                                        currentUserReference
                                                                                      ]),
                                                                                    },
                                                                                  ),
                                                                                });
                                                                              } else {
                                                                                logFirebaseEvent('ConditionalBuilder_backend_call');

                                                                                await containerVarItem.reference.update({
                                                                                  ...mapToFirestore(
                                                                                    {
                                                                                      'event_likes': FieldValue.arrayUnion([
                                                                                        currentUserReference
                                                                                      ]),
                                                                                    },
                                                                                  ),
                                                                                });
                                                                                if (containerUserRecord!.isNotificationEnabled) {
                                                                                  logFirebaseEvent('ConditionalBuilder_trigger_push_notifica');
                                                                                  triggerPushNotification(
                                                                                    notificationTitle: '${currentUserDisplayName} liked your comment',
                                                                                    notificationText: '${currentUserDisplayName} liked your comment for ${widget!.eventDoc?.name}',
                                                                                    notificationSound: 'default',
                                                                                    userRefs: [
                                                                                      containerUserRecord!.reference
                                                                                    ],
                                                                                    initialPageName: 'adminLinkUpDetails',
                                                                                    parameterData: {
                                                                                      'eventDoc': widget!.eventDoc,
                                                                                    },
                                                                                  );
                                                                                }
                                                                                logFirebaseEvent('ConditionalBuilder_backend_call');

                                                                                await NotificationRecord.collection.doc().set(createNotificationRecordData(
                                                                                      title: '${currentUserDisplayName} liked your comment for ${widget!.eventDoc?.name}',
                                                                                      sentBy: currentUserReference,
                                                                                      user: containerUserRecord?.reference,
                                                                                      notificationType: 'comment Linkup',
                                                                                      sentAt: getCurrentTimestamp,
                                                                                      forAdmin: false,
                                                                                      linkup: widget!.eventDoc?.reference,
                                                                                      seen: false,
                                                                                    ));
                                                                              }
                                                                            },
                                                                            child:
                                                                                Builder(
                                                                              builder: (context) {
                                                                                if (containerVarItem.eventLikes.contains(currentUserReference)) {
                                                                                  return Icon(
                                                                                    Icons.favorite_sharp,
                                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                                    size: 24.0,
                                                                                  );
                                                                                } else {
                                                                                  return Icon(
                                                                                    Icons.favorite_border_outlined,
                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                    size: 24.0,
                                                                                  );
                                                                                }
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        if (containerVarItem
                                                                            .eventLikes
                                                                            .isNotEmpty)
                                                                          Text(
                                                                            valueOrDefault<String>(
                                                                              containerVarItem.eventLikes.length.toString(),
                                                                              '0',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                ),
                                                                          ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Builder(
                                                                builder:
                                                                    (context) {
                                                                  final commentReplies = containerEventsCommentRecordList
                                                                      .where((e) =>
                                                                          (e.replyComment !=
                                                                              null) &&
                                                                          (e.replyComment ==
                                                                              containerVarItem
                                                                                  .reference))
                                                                      .toList()
                                                                      .sortedList(
                                                                          keyOf: (e) => e
                                                                              .commentTime!,
                                                                          desc:
                                                                              false)
                                                                      .toList();

                                                                  return ListView
                                                                      .separated(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    primary:
                                                                        false,
                                                                    shrinkWrap:
                                                                        true,
                                                                    scrollDirection:
                                                                        Axis.vertical,
                                                                    itemCount:
                                                                        commentReplies
                                                                            .length,
                                                                    separatorBuilder: (_,
                                                                            __) =>
                                                                        SizedBox(
                                                                            height:
                                                                                4.0),
                                                                    itemBuilder:
                                                                        (context,
                                                                            commentRepliesIndex) {
                                                                      final commentRepliesItem =
                                                                          commentReplies[
                                                                              commentRepliesIndex];
                                                                      return Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            18.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child: StreamBuilder<
                                                                            List<UserRecord>>(
                                                                          stream:
                                                                              queryUserRecord(
                                                                            queryBuilder: (userRecord) =>
                                                                                userRecord.where(
                                                                              'uid',
                                                                              isEqualTo: commentRepliesItem.commentUserRef?.id,
                                                                            ),
                                                                            singleRecord:
                                                                                true,
                                                                          ),
                                                                          builder:
                                                                              (context, snapshot) {
                                                                            // Customize what your widget looks like when it's loading.
                                                                            if (!snapshot.hasData) {
                                                                              return Center(
                                                                                child: LinearProgressIndicator(
                                                                                  color: Color(0xFFFE99AB),
                                                                                ),
                                                                              );
                                                                            }
                                                                            List<UserRecord>
                                                                                columnUserRecordList =
                                                                                snapshot.data!;
                                                                            final columnUserRecord = columnUserRecordList.isNotEmpty
                                                                                ? columnUserRecordList.first
                                                                                : null;

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
                                                                                            logFirebaseEvent('ADMIN_LINK_UP_DETAILS_Container_tlmysuxl');
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
                                                                                                      logFirebaseEvent('ADMIN_LINK_UP_DETAILS_Image_1h2vs0ja_ON_');
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
                                                                                                          columnUserRecord!.displayImage,
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
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.min,
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                                                child: Text(
                                                                                                  columnUserRecord!.displayName,
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
                                                                                                  dateTimeFormat("relative", commentRepliesItem.commentTime!),
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
                                                                                              logFirebaseEvent('ADMIN_LINK_UP_DETAILS_more_vert_rounded_');
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
                                                                                                        chatreference: commentRepliesItem,
                                                                                                        linkupName: widget!.eventDoc!.name,
                                                                                                        commentName: commentRepliesItem.commentTitle,
                                                                                                        reportuser: columnUserRecord!,
                                                                                                        event: widget!.eventDoc,
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
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Expanded(
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 3.0),
                                                                                          child: Text(
                                                                                            commentRepliesItem.commentTitle,
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                  letterSpacing: 0.0,
                                                                                                  useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 0.0),
                                                                                        child: InkWell(
                                                                                          splashColor: Colors.transparent,
                                                                                          focusColor: Colors.transparent,
                                                                                          hoverColor: Colors.transparent,
                                                                                          highlightColor: Colors.transparent,
                                                                                          onTap: () async {
                                                                                            logFirebaseEvent('ADMIN_LINK_UP_DETAILS_ConditionalBuilder');
                                                                                            if (commentRepliesItem.eventLikes.contains(currentUserReference)) {
                                                                                              logFirebaseEvent('ConditionalBuilder_backend_call');

                                                                                              await commentRepliesItem.reference.update({
                                                                                                ...mapToFirestore(
                                                                                                  {
                                                                                                    'event_likes': FieldValue.arrayRemove([currentUserReference]),
                                                                                                  },
                                                                                                ),
                                                                                              });
                                                                                            } else {
                                                                                              logFirebaseEvent('ConditionalBuilder_backend_call');

                                                                                              await commentRepliesItem.reference.update({
                                                                                                ...mapToFirestore(
                                                                                                  {
                                                                                                    'event_likes': FieldValue.arrayUnion([currentUserReference]),
                                                                                                  },
                                                                                                ),
                                                                                              });
                                                                                              if (columnUserRecord!.isNotificationEnabled) {
                                                                                                logFirebaseEvent('ConditionalBuilder_trigger_push_notifica');
                                                                                                triggerPushNotification(
                                                                                                  notificationTitle: '${currentUserDisplayName} liked your comment',
                                                                                                  notificationText: '${currentUserDisplayName} liked your comment for ${widget!.eventDoc?.name}',
                                                                                                  notificationSound: 'default',
                                                                                                  userRefs: [
                                                                                                    columnUserRecord!.reference
                                                                                                  ],
                                                                                                  initialPageName: 'adminLinkUpDetails',
                                                                                                  parameterData: {
                                                                                                    'eventDoc': widget!.eventDoc,
                                                                                                  },
                                                                                                );
                                                                                              }
                                                                                              logFirebaseEvent('ConditionalBuilder_backend_call');

                                                                                              await NotificationRecord.collection.doc().set(createNotificationRecordData(
                                                                                                    title: '${currentUserDisplayName} liked your comment for ${widget!.eventDoc?.name}',
                                                                                                    sentBy: currentUserReference,
                                                                                                    user: columnUserRecord?.reference,
                                                                                                    notificationType: 'comment Linkup',
                                                                                                    sentAt: getCurrentTimestamp,
                                                                                                    forAdmin: false,
                                                                                                    linkup: widget!.eventDoc?.reference,
                                                                                                    seen: false,
                                                                                                  ));
                                                                                            }
                                                                                          },
                                                                                          child: Builder(
                                                                                            builder: (context) {
                                                                                              if (commentRepliesItem.eventLikes.contains(currentUserReference)) {
                                                                                                return Icon(
                                                                                                  Icons.favorite_sharp,
                                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                                  size: 24.0,
                                                                                                );
                                                                                              } else {
                                                                                                return Icon(
                                                                                                  Icons.favorite_border_outlined,
                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                  size: 24.0,
                                                                                                );
                                                                                              }
                                                                                            },
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      if (commentRepliesItem.eventLikes.isNotEmpty)
                                                                                        Text(
                                                                                          valueOrDefault<String>(
                                                                                            commentRepliesItem.eventLikes.length.toString(),
                                                                                            '0',
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.bold,
                                                                                                useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                              ),
                                                                                        ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            );
                                                                          },
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                              ),
                                                              if (containerVarItem
                                                                      .reference ==
                                                                  _model
                                                                      .replyMessage)
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          10.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      wrapWithModel(
                                                                    model: _model
                                                                        .eventReplyCardModels
                                                                        .getModel(
                                                                      containerVarItem
                                                                          .reference
                                                                          .id,
                                                                      containerVarIndex,
                                                                    ),
                                                                    updateCallback: () =>
                                                                        safeSetState(
                                                                            () {}),
                                                                    child:
                                                                        EventReplyCardWidget(
                                                                      key: Key(
                                                                        'Keypu0_${containerVarItem.reference.id}',
                                                                      ),
                                                                      comment:
                                                                          containerVarItem,
                                                                      dismisAction:
                                                                          () async {
                                                                        logFirebaseEvent(
                                                                            'ADMIN_LINK_UP_DETAILS_Container_pu0e2f9o');
                                                                        logFirebaseEvent(
                                                                            'eventReplyCard_update_page_state');
                                                                        _model.replyMessage =
                                                                            null;
                                                                        safeSetState(
                                                                            () {});
                                                                      },
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
                        Divider(
                          height: 20.0,
                          thickness: 1.0,
                          color: FlutterFlowTheme.of(context).alternate,
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (!(isWeb
                        ? MediaQuery.viewInsetsOf(context).bottom > 0
                        : _isKeyboardVisible))
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 8.0, 16.0, 8.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            logFirebaseEvent(
                                'ADMIN_LINK_UP_DETAILS_GET_TICKETS_BTN_ON');
                            logFirebaseEvent('Button_launch_u_r_l');
                            await launchURL('https://www.yesgurl.co.uk/events');
                            if (!widget!.eventDoc!.getTicketList
                                .contains(currentUserReference)) {
                              logFirebaseEvent('Button_backend_call');

                              await widget!.eventDoc!.reference.update({
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
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .titleSmallIsCustom,
                                ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                    if ((_model.leaveComponentFocusNode?.hasFocus ?? false) ==
                        false)
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (!widget!.eventDoc!.attending
                              .contains(currentUserReference))
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 8.0, 16.0, 8.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  logFirebaseEvent(
                                      'ADMIN_LINK_UP_DETAILS_GOT_MY_TICKET_BTN_');
                                  logFirebaseEvent('Button_backend_call');

                                  await widget!.eventDoc!.reference.update({
                                    ...mapToFirestore(
                                      {
                                        'attending': FieldValue.arrayUnion(
                                            [currentUserReference]),
                                      },
                                    ),
                                  });
                                  logFirebaseEvent('Button_backend_call');

                                  await NotificationRecord.collection
                                      .doc()
                                      .set({
                                    ...createNotificationRecordData(
                                      title:
                                          '${currentUserDisplayName} has joined ${widget!.eventDoc?.name}',
                                      sentBy: currentUserReference,
                                      notificationType: 'join Linkup',
                                      linkup: widget!.eventDoc?.reference,
                                      seen: false,
                                      forAdmin: true,
                                      user: currentUserReference,
                                    ),
                                    ...mapToFirestore(
                                      {
                                        'sent_at': FieldValue.serverTimestamp(),
                                      },
                                    ),
                                  });
                                  logFirebaseEvent('Button_navigate_back');
                                  context.safePop();
                                  logFirebaseEvent('Button_show_snack_bar');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'You are attending: ${widget!.eventDoc?.name}',
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
                                },
                                text: 'got my ticket',
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
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                              ),
                            ),
                          if (widget!.eventDoc?.attending
                                  ?.contains(currentUserReference) ??
                              true)
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 8.0, 16.0, 12.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  logFirebaseEvent(
                                      'ADMIN_LINK_UP_DETAILS_NOT_GOING_BTN_ON_T');
                                  logFirebaseEvent('Button_backend_call');

                                  await widget!.eventDoc!.reference.update({
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
                                        'You are no longer attending: ${widget!.eventDoc?.name}',
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
                                text: 'not going',
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
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

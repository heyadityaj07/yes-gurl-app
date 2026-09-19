import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_widget.dart';
import '/components/navbar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/link_up/delete_link_up/delete_link_up_widget.dart';
import '/link_up/no_data/no_data_widget.dart';
import '/link_up/no_data_copy/no_data_copy_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';
import 'package:provider/provider.dart';
import 'link_up_model.dart';
export 'link_up_model.dart';

class LinkUpWidget extends StatefulWidget {
  const LinkUpWidget({
    super.key,
    int? tabIndex,
  }) : this.tabIndex = tabIndex ?? 0;

  final int tabIndex;

  static String routeName = 'LinkUp';
  static String routePath = '/linkUp';

  @override
  State<LinkUpWidget> createState() => _LinkUpWidgetState();
}

class _LinkUpWidgetState extends State<LinkUpWidget>
    with TickerProviderStateMixin {
  late LinkUpModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LinkUpModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'LinkUp'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('LINK_UP_PAGE_LinkUp_ON_INIT_STATE');
      logFirebaseEvent('LinkUp_update_app_state');
      FFAppState().sharabelImage = '';
      FFAppState().sharedEvent = null;
      FFAppState().invitationText = '';
      safeSetState(() {});
      logFirebaseEvent('LinkUp_backend_call');

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
      length: 4,
      initialIndex: min(
          valueOrDefault<int>(
            widget!.tabIndex,
            0,
          ),
          3),
    )..addListener(() => safeSetState(() {}));

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    // On page dispose action.
    () async {
      logFirebaseEvent('LINK_UP_PAGE_LinkUp_ON_DISPOSE');
      logFirebaseEvent('LinkUp_backend_call');

      await currentUserReference!.update(createUserRecordData(
        offlineUserTime: getCurrentTimestamp,
      ));
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
                alignment: AlignmentDirectional(1.3, -0.7),
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
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
                            'LINK_UP_notifications_none_ICN_ON_TAP');
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
                        child: Visibility(
                          visible: functions.getNotificationCount(
                                  containerNotificationRecordList.toList(),
                                  currentUserReference,
                                  currentUserDocument?.createdTime) !=
                              0,
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
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Text(
                                    valueOrDefault<String>(
                                      functions
                                          .getNotificationCount(
                                              containerNotificationRecordList
                                                  .toList(),
                                              currentUserReference,
                                              currentUserDocument?.createdTime)
                                          .toString(),
                                      '0',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .displaySmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .displaySmallFamily,
                                          fontSize: 12.0,
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
                child: Container(
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            25.0, 12.0, 16.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 8.0, 0.0, 0.0),
                              child: Text(
                                'link up',
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
                            if ((valueOrDefault<bool>(
                                        currentUserDocument?.isPromptPass,
                                        false) ==
                                    true) &&
                                (valueOrDefault<bool>(
                                        currentUserDocument?.isInterestPass,
                                        false) ==
                                    true))
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 5.0, 0.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => FlutterFlowIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: 20.0,
                                    buttonSize: 40.0,
                                    fillColor: (valueOrDefault<bool>(
                                                    currentUserDocument
                                                        ?.isPromptPass,
                                                    false) ==
                                                true) &&
                                            (valueOrDefault<bool>(
                                                    currentUserDocument
                                                        ?.isInterestPass,
                                                    false) ==
                                                true)
                                        ? FlutterFlowTheme.of(context).primary
                                        : FlutterFlowTheme.of(context)
                                            .secondaryText,
                                    icon: Icon(
                                      Icons.create_outlined,
                                      color: (valueOrDefault<bool>(
                                                      currentUserDocument
                                                          ?.isPromptPass,
                                                      false) ==
                                                  true) &&
                                              (valueOrDefault<bool>(
                                                      currentUserDocument
                                                          ?.isInterestPass,
                                                      false) ==
                                                  true)
                                          ? FlutterFlowTheme.of(context)
                                              .primaryText
                                          : Colors.white,
                                      size: 24.0,
                                    ),
                                    onPressed: () async {
                                      logFirebaseEvent(
                                          'LINK_UP_PAGE_create_outlined_ICN_ON_TAP');
                                      if ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isPromptPass,
                                                  false) ==
                                              true) &&
                                          (valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isInterestPass,
                                                  false) ==
                                              true)) {
                                        logFirebaseEvent(
                                            'IconButton_navigate_to');

                                        context.pushNamed(
                                            LinkUpCreateWidget.routeName);
                                      } else {
                                        logFirebaseEvent(
                                            'IconButton_show_snack_bar');
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'you must complete your profile before you can create a link up',
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

                                      logFirebaseEvent(
                                          'IconButton_custom_action');
                                      unawaited(
                                        () async {
                                          await actions.recordUserActivity();
                                        }(),
                                      );
                                    },
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: MediaQuery.sizeOf(context).height * 0.8,
                          decoration: BoxDecoration(),
                          child: Builder(
                            builder: (context) {
                              if ((valueOrDefault<bool>(
                                          currentUserDocument?.isPromptPass,
                                          false) ==
                                      true) &&
                                  (valueOrDefault<bool>(
                                          currentUserDocument?.isInterestPass,
                                          false) ==
                                      true)) {
                                return Column(
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
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                        padding: EdgeInsets.all(4.0),
                                        tabs: [
                                          Tab(
                                            text: 'all',
                                          ),
                                          Tab(
                                            text: 'attending',
                                          ),
                                          Tab(
                                            text: 'mine',
                                          ),
                                          Tab(
                                            text: 'yes gurl',
                                          ),
                                        ],
                                        controller: _model.tabBarController,
                                        onTap: (i) async {
                                          [
                                            () async {},
                                            () async {},
                                            () async {},
                                            () async {}
                                          ][i]();
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: TabBarView(
                                        controller: _model.tabBarController,
                                        children: [
                                          StreamBuilder<List<EventsRecord>>(
                                            stream: queryEventsRecord(
                                              queryBuilder: (eventsRecord) =>
                                                  eventsRecord.where(
                                                'start_time',
                                                isGreaterThanOrEqualTo:
                                                    getCurrentTimestamp,
                                              ),
                                            ),
                                            builder: (context, snapshot) {
                                              // Customize what your widget looks like when it's loading.
                                              if (!snapshot.hasData) {
                                                return Center(
                                                  child: SizedBox(
                                                    width: 40.0,
                                                    height: 40.0,
                                                    child:
                                                        CircularProgressIndicator(
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                              Color>(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                              List<EventsRecord>
                                                  containerEventsRecordList =
                                                  snapshot.data!;

                                              return Container(
                                                decoration: BoxDecoration(),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 20.0, 0.0, 0.0),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final list = containerEventsRecordList
                                                          .map((e) => e)
                                                          .toList()
                                                          .where((e) => !(currentUserDocument
                                                                      ?.reporteventlist
                                                                      ?.toList() ??
                                                                  [])
                                                              .contains(
                                                                  e.reference))
                                                          .toList();
                                                      if (list.isEmpty) {
                                                        return NoDataWidget();
                                                      }

                                                      return ListView.builder(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemCount: list.length,
                                                        itemBuilder: (context,
                                                            listIndex) {
                                                          final listItem =
                                                              list[listIndex];
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
                                                            onTap: () async {
                                                              logFirebaseEvent(
                                                                  'LINK_UP_PAGE_Container_5vuxhk4t_ON_TAP');
                                                              if (listItem
                                                                      .role ==
                                                                  'admin') {
                                                                logFirebaseEvent(
                                                                    'Container_navigate_to');

                                                                context
                                                                    .pushNamed(
                                                                  AdminLinkUpDetailsWidget
                                                                      .routeName,
                                                                  queryParameters:
                                                                      {
                                                                    'eventDoc':
                                                                        serializeParam(
                                                                      listItem,
                                                                      ParamType
                                                                          .Document,
                                                                    ),
                                                                  }.withoutNulls,
                                                                  extra: <String,
                                                                      dynamic>{
                                                                    'eventDoc':
                                                                        listItem,
                                                                  },
                                                                );
                                                              } else {
                                                                logFirebaseEvent(
                                                                    'Container_navigate_to');

                                                                context
                                                                    .pushNamed(
                                                                  LinkUpDetailsWidget
                                                                      .routeName,
                                                                  queryParameters:
                                                                      {
                                                                    'eventRef':
                                                                        serializeParam(
                                                                      listItem,
                                                                      ParamType
                                                                          .Document,
                                                                    ),
                                                                  }.withoutNulls,
                                                                  extra: <String,
                                                                      dynamic>{
                                                                    'eventRef':
                                                                        listItem,
                                                                  },
                                                                );
                                                              }
                                                            },
                                                            child: Container(
                                                              width: double
                                                                  .infinity,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            12.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          165.0,
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 0.0),
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.only(
                                                                                  topLeft: Radius.circular(16.0),
                                                                                  topRight: Radius.circular(16.0),
                                                                                ),
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
                                                                                    listItem.coverImage,
                                                                                  ),
                                                                                  width: double.infinity,
                                                                                  height: MediaQuery.sizeOf(context).height * 0.2,
                                                                                  fit: BoxFit.cover,
                                                                                  errorBuilder: (context, error, stackTrace) => Image.asset(
                                                                                    'assets/images/error_image.png',
                                                                                    width: double.infinity,
                                                                                    height: MediaQuery.sizeOf(context).height * 0.2,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                16.0,
                                                                                0.0,
                                                                                16.0,
                                                                                0.0),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              children: [
                                                                                if (listItem.attending.contains(currentUserReference))
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
                                                                                          child: InkWell(
                                                                                            splashColor: Colors.transparent,
                                                                                            focusColor: Colors.transparent,
                                                                                            hoverColor: Colors.transparent,
                                                                                            highlightColor: Colors.transparent,
                                                                                            onTap: () async {
                                                                                              logFirebaseEvent('LINK_UP_PAGE_Icon_6i89tih0_ON_TAP');
                                                                                              logFirebaseEvent('Icon_update_app_state');
                                                                                              FFAppState().sharabelImage = valueOrDefault<String>(
                                                                                                listItem.coverImage,
                                                                                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdkxaQMX4NW8V5JvJ1hV1laDEmbgbPNvNEUA&s',
                                                                                              );
                                                                                              FFAppState().sharedEvent = listItem.reference;
                                                                                              FFAppState().invitationText = 'Come to ${listItem.name}';
                                                                                              safeSetState(() {});
                                                                                              logFirebaseEvent('Icon_navigate_to');

                                                                                              context.pushNamed(ShareWidget.routeName);
                                                                                            },
                                                                                            child: Icon(
                                                                                              Icons.share_sharp,
                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                              size: 24.0,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                if ((listItem.role != 'admin') && (listItem.createdBy == currentUserReference))
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(1.0, -1.0),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 16.0, 0.0),
                                                                                      child: Container(
                                                                                        width: 35.0,
                                                                                        height: 35.0,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).secondary,
                                                                                          shape: BoxShape.circle,
                                                                                        ),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsets.all(2.0),
                                                                                          child: InkWell(
                                                                                            splashColor: Colors.transparent,
                                                                                            focusColor: Colors.transparent,
                                                                                            hoverColor: Colors.transparent,
                                                                                            highlightColor: Colors.transparent,
                                                                                            onTap: () async {
                                                                                              logFirebaseEvent('LINK_UP_PAGE_Icon_htsn7szb_ON_TAP');
                                                                                              logFirebaseEvent('Icon_navigate_to');

                                                                                              context.pushNamed(
                                                                                                LinkUpEditWidget.routeName,
                                                                                                queryParameters: {
                                                                                                  'event': serializeParam(
                                                                                                    listItem,
                                                                                                    ParamType.Document,
                                                                                                  ),
                                                                                                }.withoutNulls,
                                                                                                extra: <String, dynamic>{
                                                                                                  'event': listItem,
                                                                                                },
                                                                                              );
                                                                                            },
                                                                                            child: Icon(
                                                                                              Icons.edit_sharp,
                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                              size: 24.0,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                if ((listItem.role != 'admin') && (listItem.createdBy == currentUserReference))
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(1.0, -1.0),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 16.0, 0.0),
                                                                                      child: Container(
                                                                                        width: 35.0,
                                                                                        height: 35.0,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Color(0xFFD94A56),
                                                                                          shape: BoxShape.circle,
                                                                                        ),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsets.all(2.0),
                                                                                          child: InkWell(
                                                                                            splashColor: Colors.transparent,
                                                                                            focusColor: Colors.transparent,
                                                                                            hoverColor: Colors.transparent,
                                                                                            highlightColor: Colors.transparent,
                                                                                            onTap: () async {
                                                                                              logFirebaseEvent('LINK_UP_PAGE_Icon_f96idado_ON_TAP');
                                                                                              logFirebaseEvent('Icon_bottom_sheet');
                                                                                              await showModalBottomSheet(
                                                                                                isScrollControlled: true,
                                                                                                backgroundColor: Colors.transparent,
                                                                                                enableDrag: false,
                                                                                                context: context,
                                                                                                builder: (context) {
                                                                                                  return GestureDetector(
                                                                                                    onTap: () {
                                                                                                      FocusScope.of(context).unfocus();
                                                                                                      FocusManager.instance.primaryFocus?.unfocus();
                                                                                                    },
                                                                                                    child: Padding(
                                                                                                      padding: MediaQuery.viewInsetsOf(context),
                                                                                                      child: DeleteLinkUpWidget(
                                                                                                        eventDocument: listItem.reference,
                                                                                                      ),
                                                                                                    ),
                                                                                                  );
                                                                                                },
                                                                                              ).then((value) => safeSetState(() {}));
                                                                                            },
                                                                                            child: Icon(
                                                                                              Icons.delete_sharp,
                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                              size: 24.0,
                                                                                            ),
                                                                                          ),
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
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            16.0,
                                                                            0.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).accent3,
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              bottomLeft: Radius.circular(12.0),
                                                                              bottomRight: Radius.circular(12.0),
                                                                            ),
                                                                          ),
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Expanded(
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.all(12.0),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                        child: Text(
                                                                                          '${listItem.name}',
                                                                                          textAlign: TextAlign.start,
                                                                                          maxLines: 1,
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                                fontSize: 16.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                        child: Text(
                                                                                          '${functions.generateDateFormateForLinkup(listItem.startTime!)} | ${dateTimeFormat("jm", listItem.startTime)}',
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                                letterSpacing: 0.0,
                                                                                                useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      if (listItem.role == 'user')
                                                                                        Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                          child: Text(
                                                                                            '${listItem.attending.length.toString()} attending',
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
                                                                              if (listItem.role == 'user')
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                                                                                  child: ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(100.0),
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
                                                                                      image: NetworkImage(
                                                                                        listItem.userPic,
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
                                                                              if (listItem.role != 'user')
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                                                                                  child: ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(100.0),
                                                                                    child: Image.asset(
                                                                                      'assets/images/yes_gurl_logo_socials_(3).png',
                                                                                      width: 60.0,
                                                                                      height: 60.0,
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          StreamBuilder<List<EventsRecord>>(
                                            stream: queryEventsRecord(
                                              queryBuilder: (eventsRecord) =>
                                                  eventsRecord
                                                      .where(
                                                        'attending',
                                                        arrayContains:
                                                            currentUserReference,
                                                      )
                                                      .where(
                                                        'start_time',
                                                        isGreaterThanOrEqualTo:
                                                            getCurrentTimestamp,
                                                      ),
                                            ),
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
                                              List<EventsRecord>
                                                  containerEventsRecordList =
                                                  snapshot.data!;

                                              return Container(
                                                decoration: BoxDecoration(),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 20.0, 0.0, 0.0),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final containerVar =
                                                          containerEventsRecordList
                                                              .where((e) =>
                                                                  e.role !=
                                                                  'admin')
                                                              .toList()
                                                              .sortedList(
                                                                  keyOf: (e) =>
                                                                      e.startTime!,
                                                                  desc: false)
                                                              .toList();
                                                      if (containerVar
                                                          .isEmpty) {
                                                        return NoDataWidget();
                                                      }

                                                      return ListView.builder(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                          0,
                                                          0,
                                                          0,
                                                          16.0,
                                                        ),
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
                                                              UserRecord>(
                                                            stream: UserRecord
                                                                .getDocument(
                                                                    containerVarItem
                                                                        .userRef!),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return Center(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 40.0,
                                                                    height:
                                                                        40.0,
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      valueColor:
                                                                          AlwaysStoppedAnimation<
                                                                              Color>(
                                                                        Color(
                                                                            0x01FE99AB),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }

                                                              final containerUserRecord =
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
                                                                      'LINK_UP_PAGE_Container_0kjcd1uc_ON_TAP');
                                                                  logFirebaseEvent(
                                                                      'Container_navigate_to');

                                                                  context
                                                                      .pushNamed(
                                                                    LinkUpDetailsWidget
                                                                        .routeName,
                                                                    queryParameters:
                                                                        {
                                                                      'eventRef':
                                                                          serializeParam(
                                                                        containerVarItem,
                                                                        ParamType
                                                                            .Document,
                                                                      ),
                                                                    }.withoutNulls,
                                                                    extra: <String,
                                                                        dynamic>{
                                                                      'eventRef':
                                                                          containerVarItem,
                                                                    },
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                  ),
                                                                  child:
                                                                      Visibility(
                                                                    visible: !containerUserRecord
                                                                            .blockedUsers
                                                                            .contains(
                                                                                currentUserReference) &&
                                                                        !(currentUserDocument?.blockedUsers?.toList() ??
                                                                                [])
                                                                            .contains(containerVarItem
                                                                                .createdBy) &&
                                                                        !(currentUserDocument?.reporteventlist?.toList() ??
                                                                                [])
                                                                            .contains(containerVarItem.reference),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          12.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Stack(
                                                                            children: [
                                                                              Align(
                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 0.0),
                                                                                  child: ClipRRect(
                                                                                    borderRadius: BorderRadius.only(
                                                                                      topLeft: Radius.circular(16.0),
                                                                                      topRight: Radius.circular(16.0),
                                                                                    ),
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
                                                                                        containerVarItem.coverImage,
                                                                                      ),
                                                                                      width: double.infinity,
                                                                                      height: MediaQuery.sizeOf(context).height * 0.2,
                                                                                      fit: BoxFit.cover,
                                                                                      errorBuilder: (context, error, stackTrace) => Image.asset(
                                                                                        'assets/images/error_image.png',
                                                                                        width: double.infinity,
                                                                                        height: MediaQuery.sizeOf(context).height * 0.2,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  if (containerVarItem.attending.contains(currentUserReference))
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(1.0, -1.0),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 25.0, 0.0),
                                                                                        child: Container(
                                                                                          width: 35.0,
                                                                                          height: 35.0,
                                                                                          decoration: BoxDecoration(
                                                                                            color: FlutterFlowTheme.of(context).primary,
                                                                                            shape: BoxShape.circle,
                                                                                          ),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsets.all(2.0),
                                                                                            child: InkWell(
                                                                                              splashColor: Colors.transparent,
                                                                                              focusColor: Colors.transparent,
                                                                                              hoverColor: Colors.transparent,
                                                                                              highlightColor: Colors.transparent,
                                                                                              onTap: () async {
                                                                                                logFirebaseEvent('LINK_UP_PAGE_Icon_gamf95ol_ON_TAP');
                                                                                                logFirebaseEvent('Icon_update_app_state');
                                                                                                FFAppState().sharabelImage = containerVarItem.coverImage;
                                                                                                FFAppState().sharedEvent = containerVarItem.reference;
                                                                                                FFAppState().invitationText = 'Come to ${containerVarItem.name}';
                                                                                                safeSetState(() {});
                                                                                                logFirebaseEvent('Icon_navigate_to');

                                                                                                context.pushNamed(ShareWidget.routeName);
                                                                                              },
                                                                                              child: Icon(
                                                                                                Icons.share,
                                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                                size: 24.0,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  if ((containerVarItem.role != 'admin') && (containerVarItem.createdBy == currentUserReference))
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(1.0, -1.0),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 25.0, 0.0),
                                                                                        child: Container(
                                                                                          width: 35.0,
                                                                                          height: 35.0,
                                                                                          decoration: BoxDecoration(
                                                                                            color: FlutterFlowTheme.of(context).secondary,
                                                                                            shape: BoxShape.circle,
                                                                                          ),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsets.all(2.0),
                                                                                            child: InkWell(
                                                                                              splashColor: Colors.transparent,
                                                                                              focusColor: Colors.transparent,
                                                                                              hoverColor: Colors.transparent,
                                                                                              highlightColor: Colors.transparent,
                                                                                              onTap: () async {
                                                                                                logFirebaseEvent('LINK_UP_PAGE_Icon_iz0gu0ig_ON_TAP');
                                                                                                logFirebaseEvent('Icon_navigate_to');

                                                                                                context.pushNamed(
                                                                                                  LinkUpEditWidget.routeName,
                                                                                                  queryParameters: {
                                                                                                    'event': serializeParam(
                                                                                                      containerVarItem,
                                                                                                      ParamType.Document,
                                                                                                    ),
                                                                                                  }.withoutNulls,
                                                                                                  extra: <String, dynamic>{
                                                                                                    'event': containerVarItem,
                                                                                                  },
                                                                                                );
                                                                                              },
                                                                                              child: Icon(
                                                                                                Icons.edit_sharp,
                                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                                size: 24.0,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  if ((containerVarItem.role != 'admin') && (containerVarItem.createdBy == currentUserReference))
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(1.0, -1.0),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 25.0, 0.0),
                                                                                        child: Container(
                                                                                          width: 35.0,
                                                                                          height: 35.0,
                                                                                          decoration: BoxDecoration(
                                                                                            color: Color(0xFFD94A56),
                                                                                            shape: BoxShape.circle,
                                                                                          ),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsets.all(2.0),
                                                                                            child: InkWell(
                                                                                              splashColor: Colors.transparent,
                                                                                              focusColor: Colors.transparent,
                                                                                              hoverColor: Colors.transparent,
                                                                                              highlightColor: Colors.transparent,
                                                                                              onTap: () async {
                                                                                                logFirebaseEvent('LINK_UP_PAGE_Icon_t3rqyara_ON_TAP');
                                                                                                logFirebaseEvent('Icon_bottom_sheet');
                                                                                                await showModalBottomSheet(
                                                                                                  isScrollControlled: true,
                                                                                                  backgroundColor: Colors.transparent,
                                                                                                  enableDrag: false,
                                                                                                  context: context,
                                                                                                  builder: (context) {
                                                                                                    return GestureDetector(
                                                                                                      onTap: () {
                                                                                                        FocusScope.of(context).unfocus();
                                                                                                        FocusManager.instance.primaryFocus?.unfocus();
                                                                                                      },
                                                                                                      child: Padding(
                                                                                                        padding: MediaQuery.viewInsetsOf(context),
                                                                                                        child: DeleteLinkUpWidget(
                                                                                                          eventDocument: containerVarItem.reference,
                                                                                                        ),
                                                                                                      ),
                                                                                                    );
                                                                                                  },
                                                                                                ).then((value) => safeSetState(() {}));
                                                                                              },
                                                                                              child: Icon(
                                                                                                Icons.delete_sharp,
                                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                                size: 24.0,
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
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).accent3,
                                                                                  borderRadius: BorderRadius.only(
                                                                                    bottomLeft: Radius.circular(12.0),
                                                                                    bottomRight: Radius.circular(12.0),
                                                                                  ),
                                                                                ),
                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Expanded(
                                                                                      child: Padding(
                                                                                        padding: EdgeInsets.all(12.0),
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                              child: Text(
                                                                                                '${containerVarItem.name}',
                                                                                                maxLines: 1,
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                      fontSize: 16.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                              child: Text(
                                                                                                '${functions.generateDateFormateForLinkup(containerVarItem.startTime!)} | ${dateTimeFormat("jm", containerVarItem.startTime)}',
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                      letterSpacing: 0.0,
                                                                                                      useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                              child: Text(
                                                                                                '${containerVarItem.attending.length.toString()} attending',
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
                                                                                    if (containerVarItem.role != 'user')
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                                                                                        child: ClipRRect(
                                                                                          borderRadius: BorderRadius.circular(100.0),
                                                                                          child: Image.asset(
                                                                                            'assets/images/yes_gurl_logo_socials_(3).png',
                                                                                            width: 60.0,
                                                                                            height: 60.0,
                                                                                            fit: BoxFit.cover,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    if (containerVarItem.role == 'user')
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                                                                                        child: ClipRRect(
                                                                                          borderRadius: BorderRadius.circular(100.0),
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
                                                                                            image: NetworkImage(
                                                                                              containerVarItem.userPic,
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
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
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
                                          StreamBuilder<List<EventsRecord>>(
                                            stream: queryEventsRecord(
                                              queryBuilder: (eventsRecord) =>
                                                  eventsRecord
                                                      .where(
                                                        'created_by',
                                                        isEqualTo:
                                                            currentUserReference,
                                                      )
                                                      .where(
                                                        'date',
                                                        isGreaterThanOrEqualTo:
                                                            getCurrentTimestamp,
                                                      )
                                                      .orderBy('date'),
                                            ),
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
                                              List<EventsRecord>
                                                  containerEventsRecordList =
                                                  snapshot.data!;

                                              return Container(
                                                decoration: BoxDecoration(),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 20.0, 0.0, 0.0),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final containerVar =
                                                          containerEventsRecordList
                                                              .where((e) =>
                                                                  e.role !=
                                                                  'admin')
                                                              .toList();
                                                      if (containerVar
                                                          .isEmpty) {
                                                        return NoDataWidget();
                                                      }

                                                      return ListView.builder(
                                                        padding:
                                                            EdgeInsets.zero,
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
                                                              UserRecord>(
                                                            stream: UserRecord
                                                                .getDocument(
                                                                    containerVarItem
                                                                        .createdBy!),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return Center(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 40.0,
                                                                    height:
                                                                        40.0,
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      valueColor:
                                                                          AlwaysStoppedAnimation<
                                                                              Color>(
                                                                        Color(
                                                                            0x00FE99AB),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }

                                                              final containerUserRecord =
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
                                                                      'LINK_UP_PAGE_Container_f4dh7hxx_ON_TAP');
                                                                  logFirebaseEvent(
                                                                      'Container_navigate_to');

                                                                  context
                                                                      .pushNamed(
                                                                    LinkUpDetailsWidget
                                                                        .routeName,
                                                                    queryParameters:
                                                                        {
                                                                      'eventRef':
                                                                          serializeParam(
                                                                        containerVarItem,
                                                                        ParamType
                                                                            .Document,
                                                                      ),
                                                                    }.withoutNulls,
                                                                    extra: <String,
                                                                        dynamic>{
                                                                      'eventRef':
                                                                          containerVarItem,
                                                                    },
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            12.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Stack(
                                                                          children: [
                                                                            Align(
                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 0.0),
                                                                                child: ClipRRect(
                                                                                  borderRadius: BorderRadius.only(
                                                                                    topLeft: Radius.circular(16.0),
                                                                                    topRight: Radius.circular(16.0),
                                                                                  ),
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
                                                                                      containerVarItem.coverImage,
                                                                                    ),
                                                                                    width: double.infinity,
                                                                                    height: MediaQuery.sizeOf(context).height * 0.2,
                                                                                    fit: BoxFit.cover,
                                                                                    errorBuilder: (context, error, stackTrace) => Image.asset(
                                                                                      'assets/images/error_image.png',
                                                                                      width: double.infinity,
                                                                                      height: MediaQuery.sizeOf(context).height * 0.2,
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                if (containerVarItem.attending.contains(currentUserReference))
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(1.0, -1.0),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 25.0, 0.0),
                                                                                      child: Container(
                                                                                        width: 35.0,
                                                                                        height: 35.0,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).primary,
                                                                                          shape: BoxShape.circle,
                                                                                        ),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsets.all(2.0),
                                                                                          child: InkWell(
                                                                                            splashColor: Colors.transparent,
                                                                                            focusColor: Colors.transparent,
                                                                                            hoverColor: Colors.transparent,
                                                                                            highlightColor: Colors.transparent,
                                                                                            onTap: () async {
                                                                                              logFirebaseEvent('LINK_UP_PAGE_Icon_gw4rbsxx_ON_TAP');
                                                                                              logFirebaseEvent('Icon_update_app_state');
                                                                                              FFAppState().sharabelImage = containerVarItem.coverImage;
                                                                                              FFAppState().sharedEvent = containerVarItem.reference;
                                                                                              FFAppState().invitationText = 'Come to ${containerVarItem.name}';
                                                                                              safeSetState(() {});
                                                                                              logFirebaseEvent('Icon_navigate_to');

                                                                                              context.pushNamed(ShareWidget.routeName);
                                                                                            },
                                                                                            child: Icon(
                                                                                              Icons.share,
                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                              size: 24.0,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                if ((containerVarItem.createdBy == currentUserReference) && (functions.canEditEvent(containerVarItem.startTime!) == true))
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(1.0, -1.0),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 25.0, 0.0),
                                                                                      child: Container(
                                                                                        width: 35.0,
                                                                                        height: 35.0,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).secondary,
                                                                                          shape: BoxShape.circle,
                                                                                        ),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsets.all(2.0),
                                                                                          child: InkWell(
                                                                                            splashColor: Colors.transparent,
                                                                                            focusColor: Colors.transparent,
                                                                                            hoverColor: Colors.transparent,
                                                                                            highlightColor: Colors.transparent,
                                                                                            onTap: () async {
                                                                                              logFirebaseEvent('LINK_UP_PAGE_Icon_ukqba4mb_ON_TAP');
                                                                                              logFirebaseEvent('Icon_navigate_to');

                                                                                              context.pushNamed(
                                                                                                LinkUpEditWidget.routeName,
                                                                                                queryParameters: {
                                                                                                  'event': serializeParam(
                                                                                                    containerVarItem,
                                                                                                    ParamType.Document,
                                                                                                  ),
                                                                                                }.withoutNulls,
                                                                                                extra: <String, dynamic>{
                                                                                                  'event': containerVarItem,
                                                                                                },
                                                                                              );
                                                                                            },
                                                                                            child: Icon(
                                                                                              Icons.edit_sharp,
                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                              size: 24.0,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                if (containerVarItem.createdBy == currentUserReference)
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(1.0, -1.0),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 25.0, 0.0),
                                                                                      child: Container(
                                                                                        width: 35.0,
                                                                                        height: 35.0,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Color(0xFFD94A56),
                                                                                          shape: BoxShape.circle,
                                                                                        ),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsets.all(2.0),
                                                                                          child: InkWell(
                                                                                            splashColor: Colors.transparent,
                                                                                            focusColor: Colors.transparent,
                                                                                            hoverColor: Colors.transparent,
                                                                                            highlightColor: Colors.transparent,
                                                                                            onTap: () async {
                                                                                              logFirebaseEvent('LINK_UP_PAGE_Icon_4xgpuuuc_ON_TAP');
                                                                                              logFirebaseEvent('Icon_bottom_sheet');
                                                                                              await showModalBottomSheet(
                                                                                                isScrollControlled: true,
                                                                                                backgroundColor: Colors.transparent,
                                                                                                enableDrag: false,
                                                                                                context: context,
                                                                                                builder: (context) {
                                                                                                  return GestureDetector(
                                                                                                    onTap: () {
                                                                                                      FocusScope.of(context).unfocus();
                                                                                                      FocusManager.instance.primaryFocus?.unfocus();
                                                                                                    },
                                                                                                    child: Padding(
                                                                                                      padding: MediaQuery.viewInsetsOf(context),
                                                                                                      child: DeleteLinkUpWidget(
                                                                                                        eventDocument: containerVarItem.reference,
                                                                                                      ),
                                                                                                    ),
                                                                                                  );
                                                                                                },
                                                                                              ).then((value) => safeSetState(() {}));
                                                                                            },
                                                                                            child: Icon(
                                                                                              Icons.delete_sharp,
                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                              size: 24.0,
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
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                16.0,
                                                                                0.0,
                                                                                16.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: double.infinity,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).accent3,
                                                                                borderRadius: BorderRadius.only(
                                                                                  bottomLeft: Radius.circular(12.0),
                                                                                  bottomRight: Radius.circular(12.0),
                                                                                ),
                                                                              ),
                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets.all(12.0),
                                                                                      child: Column(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                            child: Text(
                                                                                              '${containerVarItem.name}',
                                                                                              maxLines: 1,
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                    fontSize: 16.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                            child: Text(
                                                                                              '${functions.generateDateFormateForLinkup(containerVarItem.startTime!)} | ${dateTimeFormat("jm", containerVarItem.startTime)}',
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                    letterSpacing: 0.0,
                                                                                                    useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                          if (containerVarItem.date! >= getCurrentTimestamp)
                                                                                            Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                              child: Text(
                                                                                                '${containerVarItem.attending.length.toString()} attending',
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                      letterSpacing: 0.0,
                                                                                                      useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                          if (containerVarItem.date! < getCurrentTimestamp)
                                                                                            Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                              child: Text(
                                                                                                '${containerVarItem.attending.length.toString()} attended',
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
                                                                                  if (containerVarItem.role == 'user')
                                                                                    Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                                                                                      child: ClipRRect(
                                                                                        borderRadius: BorderRadius.circular(100.0),
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
                                                                                          image: NetworkImage(
                                                                                            containerVarItem.userPic,
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
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
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
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 20.0, 0.0, 0.0),
                                            child: StreamBuilder<
                                                List<EventsRecord>>(
                                              stream: queryEventsRecord(
                                                queryBuilder: (eventsRecord) =>
                                                    eventsRecord
                                                        .where(
                                                          'role',
                                                          isEqualTo: 'admin',
                                                        )
                                                        .where(
                                                          'start_time',
                                                          isGreaterThanOrEqualTo:
                                                              getCurrentTimestamp,
                                                        ),
                                              ),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 40.0,
                                                      height: 40.0,
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                Color>(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                                List<EventsRecord>
                                                    listViewEventsRecordList =
                                                    snapshot.data!;
                                                if (listViewEventsRecordList
                                                    .isEmpty) {
                                                  return NoDataCopyWidget();
                                                }

                                                return ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount:
                                                      listViewEventsRecordList
                                                          .length,
                                                  itemBuilder:
                                                      (context, listViewIndex) {
                                                    final listViewEventsRecord =
                                                        listViewEventsRecordList[
                                                            listViewIndex];
                                                    return Visibility(
                                                      visible: !(currentUserDocument
                                                                  ?.reporteventlist
                                                                  ?.toList() ??
                                                              [])
                                                          .contains(
                                                              listViewEventsRecord
                                                                  .reference),
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
                                                              'LINK_UP_PAGE_Container_om0rdkto_ON_TAP');
                                                          logFirebaseEvent(
                                                              'Container_navigate_to');

                                                          context.pushNamed(
                                                            AdminLinkUpDetailsWidget
                                                                .routeName,
                                                            queryParameters: {
                                                              'eventDoc':
                                                                  serializeParam(
                                                                listViewEventsRecord,
                                                                ParamType
                                                                    .Document,
                                                              ),
                                                            }.withoutNulls,
                                                            extra: <String,
                                                                dynamic>{
                                                              'eventDoc':
                                                                  listViewEventsRecord,
                                                            },
                                                          );
                                                        },
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        12.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            8.0,
                                                                            16.0,
                                                                            0.0),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(16.0),
                                                                        topRight:
                                                                            Radius.circular(16.0),
                                                                      ),
                                                                      child:
                                                                          OctoImage(
                                                                        placeholderBuilder:
                                                                            (_) {
                                                                          final blurHash =
                                                                              'LEHV6nWB2yk8pyo0adR*.7kCMdnj';

                                                                          if (!validateBlurhash(
                                                                              blurHash)) {
                                                                            return const SizedBox.shrink();
                                                                          }
                                                                          return SizedBox
                                                                              .expand(
                                                                            child:
                                                                                Image(
                                                                              image: BlurHashImage(blurHash),
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          );
                                                                        },
                                                                        image:
                                                                            CachedNetworkImageProvider(
                                                                          listViewEventsRecord
                                                                              .coverImage,
                                                                        ),
                                                                        width: double
                                                                            .infinity,
                                                                        height: MediaQuery.sizeOf(context).height *
                                                                            0.2,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        errorBuilder: (context,
                                                                                error,
                                                                                stackTrace) =>
                                                                            Image.asset(
                                                                          'assets/images/error_image.png',
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              MediaQuery.sizeOf(context).height * 0.2,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            16.0,
                                                                            0.0),
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .accent3,
                                                                        borderRadius:
                                                                            BorderRadius.only(
                                                                          bottomLeft:
                                                                              Radius.circular(12.0),
                                                                          bottomRight:
                                                                              Radius.circular(12.0),
                                                                        ),
                                                                      ),
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.all(12.0),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                    child: Text(
                                                                                      '${listViewEventsRecord.name}',
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                            fontSize: 16.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                    child: Text(
                                                                                      '${functions.generateDateFormateForLinkup(listViewEventsRecord.startTime!)} | ${dateTimeFormat("jm", listViewEventsRecord.startTime)}',
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
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                12.0,
                                                                                0.0),
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(100.0),
                                                                              child: Image.asset(
                                                                                'assets/images/yes_gurl_logo_socials_(3).png',
                                                                                width: 60.0,
                                                                                height: 60.0,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 157.0, 20.0, 0.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 30.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Stack(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.1),
                                                  children: [
                                                    Opacity(
                                                      opacity: 0.6,
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.49, 1.25),
                                                        child: FaIcon(
                                                          FontAwesomeIcons
                                                              .solidCircle,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          size: 55.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.error_outline_sharp,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      size: 50.0,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          'you\'re almost there',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .displaySmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .displaySmallFamily,
                                                fontSize: 27.0,
                                                letterSpacing: 1.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .displaySmallIsCustom,
                                              ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 10.0, 20.0, 0.0),
                                          child: RichText(
                                            textScaler: MediaQuery.of(context)
                                                .textScaler,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      'you can\'t see any link ups because your profile is incomplete',
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
                                                )
                                              ],
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
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 30.0, 0.0, 0.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              logFirebaseEvent(
                                                  'LINK_UP_PAGE_completeProfile_ON_TAP');
                                              logFirebaseEvent(
                                                  'completeProfile_navigate_to');

                                              context.pushNamed(
                                                  ProfileEditWidget.routeName);
                                            },
                                            text: 'complete my profile',
                                            options: FFButtonOptions(
                                              width: double.infinity,
                                              height: 45.0,
                                              padding: EdgeInsets.all(0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmallFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmallIsCustom,
                                                  ),
                                              elevation: 0.0,
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40.0),
                                              hoverColor: Color(0xC6FE99AB),
                                              hoverBorderSide: BorderSide(
                                                color: Color(0xC6FE99AB),
                                              ),
                                              hoverTextColor:
                                                  FlutterFlowTheme.of(context)
                                                      .accent1,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              wrapWithModel(
                model: _model.navbarModel,
                updateCallback: () => safeSetState(() {}),
                child: NavbarWidget(
                  index: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/delete_notifications_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/link_up/no_data_copy/no_data_copy_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'notification_model.dart';
export 'notification_model.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  static String routeName = 'notification';
  static String routePath = '/notification';

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  late NotificationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'notification'});
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<NotificationRecord>>(
      stream: queryNotificationRecord(
        queryBuilder: (notificationRecord) => notificationRecord
            .where(Filter.or(
              Filter(
                'user',
                isEqualTo: currentUserReference,
              ),
              Filter(
                'manage',
                isEqualTo: 'admin',
              ),
            ))
            .orderBy('sent_at', descending: true),
      ),
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
        List<NotificationRecord> notificationNotificationRecordList =
            snapshot.data!;

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
                    logFirebaseEvent('NOTIFICATION_arrow_back_ios_ICN_ON_TAP');
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
              actions: [
                Visibility(
                  visible: (functions.managenotificationtime(notificationNotificationRecordList.where((e) => (e.sentAt! > currentUserDocument!.createdTime!) && !e.deleteList.contains(currentUserReference)).toList(), 'today')?.length != 0) ||
                      (functions
                              .managenotificationtime(
                                  notificationNotificationRecordList
                                      .where((e) =>
                                          (e.sentAt! > currentUserDocument!.createdTime!) &&
                                          !e.deleteList
                                              .contains(currentUserReference))
                                      .toList(),
                                  'yesterday')
                              ?.sortedList(keyOf: (e) => e.sentAt!, desc: true)
                              ?.length
                              .toString() !=
                          '0') ||
                      (functions
                              .managenotificationtime(
                                  notificationNotificationRecordList
                                      .where((e) =>
                                          (e.sentAt! > currentUserDocument!.createdTime!) &&
                                          !e.deleteList
                                              .contains(currentUserReference))
                                      .toList(),
                                  'last 7 days')
                              ?.sortedList(keyOf: (e) => e.sentAt!, desc: true)
                              ?.length !=
                          0) ||
                      (functions
                              .managenotificationtime(
                                  notificationNotificationRecordList
                                      .where((e) => (e.sentAt! > currentUserDocument!.createdTime!) && !e.deleteList.contains(currentUserReference))
                                      .toList(),
                                  'last 30 days')
                              ?.sortedList(keyOf: (e) => e.sentAt!, desc: true)
                              ?.length
                              .toString() !=
                          '0') ||
                      (functions.managenotificationtime(notificationNotificationRecordList.where((e) => (e.sentAt! > currentUserDocument!.createdTime!) && !e.deleteList.contains(currentUserReference)).toList(), 'older')?.sortedList(keyOf: (e) => e.sentAt!, desc: true)?.length.toString() != '0'),
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Builder(
                      builder: (context) => Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
                        child: AuthUserStreamWidget(
                          builder: (context) => FlutterFlowIconButton(
                            borderRadius: 30.0,
                            fillColor: Color(0xFFD94A56),
                            hoverIconColor:
                                FlutterFlowTheme.of(context).primary,
                            icon: Icon(
                              Icons.delete_outline,
                              color: Colors.white,
                              size: 20.0,
                            ),
                            onPressed: () async {
                              logFirebaseEvent(
                                  'NOTIFICATION_delete_outline_ICN_ON_TAP');
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
                                    child: GestureDetector(
                                      onTap: () {
                                        FocusScope.of(dialogContext).unfocus();
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      },
                                      child: DeleteNotificationsWidget(),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              centerTitle: true,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                primary: false,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 8.0, 0.0, 0.0),
                                child: Text(
                                  'notifications',
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
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      decoration: BoxDecoration(),
                      child: Builder(
                        builder: (context) {
                          if (!((functions.managenotificationtime(notificationNotificationRecordList.where((e) => (e.sentAt! > currentUserDocument!.createdTime!) && !e.deleteList.contains(currentUserReference)).toList(), 'today')?.length == 0) &&
                              (functions
                                      .managenotificationtime(
                                          notificationNotificationRecordList
                                              .where((e) =>
                                                  (e.sentAt! > currentUserDocument!.createdTime!) &&
                                                  !e.deleteList.contains(
                                                      currentUserReference))
                                              .toList(),
                                          'yesterday')
                                      ?.sortedList(
                                          keyOf: (e) => e.sentAt!, desc: true)
                                      ?.length
                                      .toString() ==
                                  '0') &&
                              (functions.managenotificationtime(notificationNotificationRecordList.where((e) => (e.sentAt! > currentUserDocument!.createdTime!) && !e.deleteList.contains(currentUserReference)).toList(), 'last 7 days')?.sortedList(keyOf: (e) => e.sentAt!, desc: true)?.length ==
                                  0) &&
                              (functions
                                      .managenotificationtime(
                                          notificationNotificationRecordList
                                              .where((e) =>
                                                  (e.sentAt! > currentUserDocument!.createdTime!) &&
                                                  !e.deleteList.contains(
                                                      currentUserReference))
                                              .toList(),
                                          'last 30 days')
                                      ?.sortedList(
                                          keyOf: (e) => e.sentAt!, desc: true)
                                      ?.length
                                      .toString() ==
                                  '0') &&
                              (functions
                                      .managenotificationtime(
                                          notificationNotificationRecordList.where((e) => (e.sentAt! > currentUserDocument!.createdTime!) && !e.deleteList.contains(currentUserReference)).toList(), 'older')
                                      ?.sortedList(keyOf: (e) => e.sentAt!, desc: true)
                                      ?.length
                                      .toString() ==
                                  '0'))) {
                            return SingleChildScrollView(
                              primary: false,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if (functions
                                          .managenotificationtime(
                                              notificationNotificationRecordList
                                                  .where((e) =>
                                                      (e.sentAt! >
                                                          currentUserDocument!
                                                              .createdTime!) &&
                                                      !e.deleteList.contains(
                                                          currentUserReference))
                                                  .toList(),
                                              'today')
                                          ?.length !=
                                      0)
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            'today',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                          ),
                                        ),
                                        Builder(
                                          builder: (context) {
                                            final containerVar = functions
                                                    .managenotificationtime(
                                                        notificationNotificationRecordList
                                                            .where((e) =>
                                                                (e.sentAt! >
                                                                    currentUserDocument!
                                                                        .createdTime!) &&
                                                                !e.deleteList
                                                                    .contains(
                                                                        currentUserReference))
                                                            .toList(),
                                                        'today')
                                                    ?.sortedList(
                                                        keyOf: (e) => e.sentAt!,
                                                        desc: true)
                                                    ?.toList() ??
                                                [];

                                            return Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  containerVar.length,
                                                  (containerVarIndex) {
                                                final containerVarItem =
                                                    containerVar[
                                                        containerVarIndex];
                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    InkWell(
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
                                                            'NOTIFICATION_Container_90rqm85p_ON_TAP');
                                                        logFirebaseEvent(
                                                            'Container_action_block');
                                                        await _model
                                                            .notificationActionBlock(
                                                          context,
                                                          notification:
                                                              containerVarItem,
                                                        );
                                                        safeSetState(() {});
                                                      },
                                                      child: Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  16.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Expanded(
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    if (((containerVarItem.manage == null || containerVarItem.manage == '') &&
                                                                            (containerVarItem.seen !=
                                                                                true)) ||
                                                                        ((containerVarItem.manage ==
                                                                                'admin') &&
                                                                            !containerVarItem.seenList.contains(currentUserReference)))
                                                                      Text(
                                                                        containerVarItem
                                                                            .title,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              fontSize: 16.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.bold,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                            ),
                                                                      ),
                                                                    if (((containerVarItem.manage == null || containerVarItem.manage == '') &&
                                                                            (containerVarItem.seen ==
                                                                                true)) ||
                                                                        ((containerVarItem.manage ==
                                                                                'admin') &&
                                                                            containerVarItem.seenList.contains(currentUserReference)))
                                                                      Text(
                                                                        containerVarItem
                                                                            .title,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              fontSize: 16.0,
                                                                              letterSpacing: 0.0,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                            ),
                                                                      ),
                                                                    if (containerVarItem.description !=
                                                                            null &&
                                                                        containerVarItem.description !=
                                                                            '')
                                                                      Text(
                                                                        containerVarItem
                                                                            .description,
                                                                        maxLines:
                                                                            2,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).bodySmallIsCustom,
                                                                            ),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        dateTimeFormat(
                                                                            "relative",
                                                                            containerVarItem.sentAt),
                                                                        'time',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).bodySmallFamily,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            useGoogleFonts:
                                                                                !FlutterFlowTheme.of(context).bodySmallIsCustom,
                                                                          ),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      height:
                                                                          4.0)),
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 12.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      height: 1.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  if (functions
                                          .managenotificationtime(
                                              notificationNotificationRecordList
                                                  .where((e) =>
                                                      (e.sentAt! >
                                                          currentUserDocument!
                                                              .createdTime!) &&
                                                      !e.deleteList.contains(
                                                          currentUserReference))
                                                  .toList(),
                                              'yesterday')
                                          ?.sortedList(
                                              keyOf: (e) => e.sentAt!,
                                              desc: true)
                                          ?.length
                                          .toString() !=
                                      '0')
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 10.0, 0.0, 0.0),
                                          child: Text(
                                            'yesterday',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                          ),
                                        ),
                                        Builder(
                                          builder: (context) {
                                            final containerVar = functions
                                                    .managenotificationtime(
                                                        notificationNotificationRecordList
                                                            .where((e) =>
                                                                (e.sentAt! >
                                                                    currentUserDocument!
                                                                        .createdTime!) &&
                                                                !e.deleteList
                                                                    .contains(
                                                                        currentUserReference))
                                                            .toList(),
                                                        'yesterday')
                                                    ?.sortedList(
                                                        keyOf: (e) => e.sentAt!,
                                                        desc: true)
                                                    ?.toList() ??
                                                [];

                                            return Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  containerVar.length,
                                                  (containerVarIndex) {
                                                final containerVarItem =
                                                    containerVar[
                                                        containerVarIndex];
                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    InkWell(
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
                                                            'NOTIFICATION_Container_plm19h86_ON_TAP');
                                                        logFirebaseEvent(
                                                            'Container_action_block');
                                                        await _model
                                                            .notificationActionBlock(
                                                          context,
                                                          notification:
                                                              containerVarItem,
                                                        );
                                                        safeSetState(() {});
                                                      },
                                                      child: Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  16.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Expanded(
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    if (((containerVarItem.manage == null || containerVarItem.manage == '') &&
                                                                            (containerVarItem.seen !=
                                                                                true)) ||
                                                                        ((containerVarItem.manage ==
                                                                                'admin') &&
                                                                            !containerVarItem.seenList.contains(currentUserReference)))
                                                                      Text(
                                                                        containerVarItem
                                                                            .title,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              fontSize: 16.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.bold,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                            ),
                                                                      ),
                                                                    if (((containerVarItem.manage == null || containerVarItem.manage == '') &&
                                                                            (containerVarItem.seen ==
                                                                                true)) ||
                                                                        ((containerVarItem.manage ==
                                                                                'admin') &&
                                                                            containerVarItem.seenList.contains(currentUserReference)))
                                                                      Text(
                                                                        containerVarItem
                                                                            .title,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              fontSize: 16.0,
                                                                              letterSpacing: 0.0,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                            ),
                                                                      ),
                                                                    if (containerVarItem.description !=
                                                                            null &&
                                                                        containerVarItem.description !=
                                                                            '')
                                                                      Text(
                                                                        containerVarItem
                                                                            .description,
                                                                        maxLines:
                                                                            2,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).bodySmallIsCustom,
                                                                            ),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        dateTimeFormat(
                                                                            "relative",
                                                                            containerVarItem.sentAt),
                                                                        'time',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).bodySmallFamily,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            useGoogleFonts:
                                                                                !FlutterFlowTheme.of(context).bodySmallIsCustom,
                                                                          ),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      height:
                                                                          4.0)),
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 12.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      height: 1.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  if (functions
                                          .managenotificationtime(
                                              notificationNotificationRecordList
                                                  .where((e) =>
                                                      (e.sentAt! >
                                                          currentUserDocument!
                                                              .createdTime!) &&
                                                      !e.deleteList.contains(
                                                          currentUserReference))
                                                  .toList(),
                                              'last 7 days')
                                          ?.sortedList(
                                              keyOf: (e) => e.sentAt!,
                                              desc: true)
                                          ?.length !=
                                      0)
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 10.0, 0.0, 0.0),
                                          child: Text(
                                            'last 7 days',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                          ),
                                        ),
                                        Builder(
                                          builder: (context) {
                                            final containerVar = functions
                                                    .managenotificationtime(
                                                        notificationNotificationRecordList
                                                            .where((e) =>
                                                                (e.sentAt! >
                                                                    currentUserDocument!
                                                                        .createdTime!) &&
                                                                !e.deleteList
                                                                    .contains(
                                                                        currentUserReference))
                                                            .toList(),
                                                        'last 7 days')
                                                    ?.sortedList(
                                                        keyOf: (e) => e.sentAt!,
                                                        desc: true)
                                                    ?.toList() ??
                                                [];

                                            return Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  containerVar.length,
                                                  (containerVarIndex) {
                                                final containerVarItem =
                                                    containerVar[
                                                        containerVarIndex];
                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    InkWell(
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
                                                            'NOTIFICATION_Container_iut30sp2_ON_TAP');
                                                        logFirebaseEvent(
                                                            'Container_action_block');
                                                        await _model
                                                            .notificationActionBlock(
                                                          context,
                                                          notification:
                                                              containerVarItem,
                                                        );
                                                        safeSetState(() {});
                                                      },
                                                      child: Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  16.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Expanded(
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    if (((containerVarItem.manage == null || containerVarItem.manage == '') &&
                                                                            (containerVarItem.seen !=
                                                                                true)) ||
                                                                        ((containerVarItem.manage ==
                                                                                'admin') &&
                                                                            !containerVarItem.seenList.contains(
                                                                                currentUserReference)))
                                                                      SelectionArea(
                                                                          child:
                                                                              Text(
                                                                        containerVarItem
                                                                            .title,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              fontSize: 16.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.bold,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                            ),
                                                                      )),
                                                                    if (((containerVarItem.seen ==
                                                                                true) &&
                                                                            (containerVarItem.manage == null ||
                                                                                containerVarItem.manage ==
                                                                                    '')) ||
                                                                        ((containerVarItem.manage ==
                                                                                'admin') &&
                                                                            containerVarItem.seenList.contains(
                                                                                currentUserReference)))
                                                                      SelectionArea(
                                                                          child:
                                                                              Text(
                                                                        containerVarItem
                                                                            .title,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              fontSize: 16.0,
                                                                              letterSpacing: 0.0,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                            ),
                                                                      )),
                                                                    if (containerVarItem.description !=
                                                                            null &&
                                                                        containerVarItem.description !=
                                                                            '')
                                                                      Text(
                                                                        containerVarItem
                                                                            .description,
                                                                        maxLines:
                                                                            2,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).bodySmallIsCustom,
                                                                            ),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        dateTimeFormat(
                                                                            "relative",
                                                                            containerVarItem.sentAt),
                                                                        'time',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).bodySmallFamily,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            useGoogleFonts:
                                                                                !FlutterFlowTheme.of(context).bodySmallIsCustom,
                                                                          ),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      height:
                                                                          4.0)),
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 12.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      height: 1.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  if (functions
                                          .managenotificationtime(
                                              notificationNotificationRecordList
                                                  .where((e) =>
                                                      (e.sentAt! >
                                                          currentUserDocument!
                                                              .createdTime!) &&
                                                      !e.deleteList.contains(
                                                          currentUserReference))
                                                  .toList(),
                                              'last 30 days')
                                          ?.sortedList(
                                              keyOf: (e) => e.sentAt!,
                                              desc: true)
                                          ?.length
                                          .toString() !=
                                      '0')
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 10.0, 0.0, 0.0),
                                          child: Text(
                                            'last 30 days',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                          ),
                                        ),
                                        Builder(
                                          builder: (context) {
                                            final containerVar = functions
                                                    .managenotificationtime(
                                                        notificationNotificationRecordList
                                                            .where((e) =>
                                                                (e.sentAt! >
                                                                    currentUserDocument!
                                                                        .createdTime!) &&
                                                                !e.deleteList
                                                                    .contains(
                                                                        currentUserReference))
                                                            .toList(),
                                                        'last 30 days')
                                                    ?.sortedList(
                                                        keyOf: (e) => e.sentAt!,
                                                        desc: true)
                                                    ?.toList() ??
                                                [];

                                            return Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  containerVar.length,
                                                  (containerVarIndex) {
                                                final containerVarItem =
                                                    containerVar[
                                                        containerVarIndex];
                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    InkWell(
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
                                                            'NOTIFICATION_Container_6eut9nzf_ON_TAP');
                                                        logFirebaseEvent(
                                                            'Container_action_block');
                                                        await _model
                                                            .notificationActionBlock(
                                                          context,
                                                          notification:
                                                              containerVarItem,
                                                        );
                                                        safeSetState(() {});
                                                      },
                                                      child: Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  16.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Expanded(
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    if (((containerVarItem.manage == null || containerVarItem.manage == '') &&
                                                                            (containerVarItem.seen !=
                                                                                true)) ||
                                                                        ((containerVarItem.manage ==
                                                                                'admin') &&
                                                                            !containerVarItem.seenList.contains(currentUserReference)))
                                                                      Text(
                                                                        containerVarItem
                                                                            .title,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              fontSize: 16.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.bold,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                            ),
                                                                      ),
                                                                    if (((containerVarItem.manage == null || containerVarItem.manage == '') &&
                                                                            (containerVarItem.seen ==
                                                                                true)) ||
                                                                        ((containerVarItem.manage ==
                                                                                'admin') &&
                                                                            containerVarItem.seenList.contains(currentUserReference)))
                                                                      Text(
                                                                        containerVarItem
                                                                            .title,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              fontSize: 16.0,
                                                                              letterSpacing: 0.0,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                            ),
                                                                      ),
                                                                    if (containerVarItem.description !=
                                                                            null &&
                                                                        containerVarItem.description !=
                                                                            '')
                                                                      Text(
                                                                        containerVarItem
                                                                            .description,
                                                                        maxLines:
                                                                            2,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).bodySmallIsCustom,
                                                                            ),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        dateTimeFormat(
                                                                            "relative",
                                                                            containerVarItem.sentAt),
                                                                        'time',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).bodySmallFamily,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            useGoogleFonts:
                                                                                !FlutterFlowTheme.of(context).bodySmallIsCustom,
                                                                          ),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      height:
                                                                          4.0)),
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 12.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      height: 1.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  if (functions
                                          .managenotificationtime(
                                              notificationNotificationRecordList
                                                  .where((e) =>
                                                      (e.sentAt! >
                                                          currentUserDocument!
                                                              .createdTime!) &&
                                                      !e.deleteList.contains(
                                                          currentUserReference))
                                                  .toList(),
                                              'older')
                                          ?.sortedList(
                                              keyOf: (e) => e.sentAt!,
                                              desc: true)
                                          ?.length
                                          .toString() !=
                                      '0')
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 10.0, 0.0, 0.0),
                                          child: Text(
                                            'older',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                          ),
                                        ),
                                        Builder(
                                          builder: (context) {
                                            final containerVar = functions
                                                    .managenotificationtime(
                                                        notificationNotificationRecordList
                                                            .where((e) =>
                                                                (e.sentAt! >
                                                                    currentUserDocument!
                                                                        .createdTime!) &&
                                                                !e.deleteList
                                                                    .contains(
                                                                        currentUserReference))
                                                            .toList(),
                                                        'older')
                                                    ?.sortedList(
                                                        keyOf: (e) => e.sentAt!,
                                                        desc: true)
                                                    ?.toList() ??
                                                [];

                                            return Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  containerVar.length,
                                                  (containerVarIndex) {
                                                final containerVarItem =
                                                    containerVar[
                                                        containerVarIndex];
                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    InkWell(
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
                                                            'NOTIFICATION_Container_mhzt4653_ON_TAP');
                                                        logFirebaseEvent(
                                                            'Container_action_block');
                                                        await _model
                                                            .notificationActionBlock(
                                                          context,
                                                          notification:
                                                              containerVarItem,
                                                        );
                                                        safeSetState(() {});
                                                      },
                                                      child: Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  16.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Expanded(
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    if (((containerVarItem.manage == null || containerVarItem.manage == '') &&
                                                                            (containerVarItem.seen !=
                                                                                true)) ||
                                                                        ((containerVarItem.manage ==
                                                                                'admin') &&
                                                                            !containerVarItem.seenList.contains(currentUserReference)))
                                                                      Text(
                                                                        containerVarItem
                                                                            .title,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              fontSize: 16.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.bold,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                            ),
                                                                      ),
                                                                    if (((containerVarItem.manage == null || containerVarItem.manage == '') &&
                                                                            (containerVarItem.seen ==
                                                                                true)) ||
                                                                        ((containerVarItem.manage ==
                                                                                'admin') &&
                                                                            containerVarItem.seenList.contains(currentUserReference)))
                                                                      Text(
                                                                        containerVarItem
                                                                            .title,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              fontSize: 16.0,
                                                                              letterSpacing: 0.0,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                            ),
                                                                      ),
                                                                    if (containerVarItem.description !=
                                                                            null &&
                                                                        containerVarItem.description !=
                                                                            '')
                                                                      Text(
                                                                        containerVarItem
                                                                            .description,
                                                                        maxLines:
                                                                            2,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).bodySmallIsCustom,
                                                                            ),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        dateTimeFormat(
                                                                            "relative",
                                                                            containerVarItem.sentAt),
                                                                        'time',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).bodySmallFamily,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            useGoogleFonts:
                                                                                !FlutterFlowTheme.of(context).bodySmallIsCustom,
                                                                          ),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      height:
                                                                          4.0)),
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 12.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      height: 1.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            );
                          } else {
                            return Visibility(
                              visible: (functions.managenotificationtime(notificationNotificationRecordList.where((e) => (e.sentAt! > currentUserDocument!.createdTime!) && !e.deleteList.contains(currentUserReference)).toList(), 'today')?.length == 0) &&
                                  (functions
                                          .managenotificationtime(
                                              notificationNotificationRecordList
                                                  .where((e) =>
                                                      (e.sentAt! > currentUserDocument!.createdTime!) &&
                                                      !e.deleteList.contains(
                                                          currentUserReference))
                                                  .toList(),
                                              'yesterday')
                                          ?.sortedList(
                                              keyOf: (e) => e.sentAt!,
                                              desc: true)
                                          ?.length
                                          .toString() ==
                                      '0') &&
                                  (functions.managenotificationtime(notificationNotificationRecordList.where((e) => (e.sentAt! > currentUserDocument!.createdTime!) && !e.deleteList.contains(currentUserReference)).toList(), 'last 7 days')?.sortedList(keyOf: (e) => e.sentAt!, desc: true)?.length ==
                                      0) &&
                                  (functions
                                          .managenotificationtime(
                                              notificationNotificationRecordList
                                                  .where((e) =>
                                                      (e.sentAt! >
                                                          currentUserDocument!
                                                              .createdTime!) &&
                                                      !e.deleteList.contains(currentUserReference))
                                                  .toList(),
                                              'last 30 days')
                                          ?.sortedList(keyOf: (e) => e.sentAt!, desc: true)
                                          ?.length
                                          .toString() ==
                                      '0') &&
                                  (functions.managenotificationtime(notificationNotificationRecordList.where((e) => (e.sentAt! > currentUserDocument!.createdTime!) && !e.deleteList.contains(currentUserReference)).toList(), 'older')?.sortedList(keyOf: (e) => e.sentAt!, desc: true)?.length.toString() == '0'),
                              child: Align(
                                alignment: AlignmentDirectional(0.0, -0.4),
                                child: AuthUserStreamWidget(
                                  builder: (context) => wrapWithModel(
                                    model: _model.noDataCopyModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child: NoDataCopyWidget(),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ].divide(SizedBox(height: 15.0)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

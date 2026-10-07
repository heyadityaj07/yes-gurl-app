import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'common_appbar_model.dart';
export 'common_appbar_model.dart';

class CommonAppbarWidget extends StatefulWidget {
  const CommonAppbarWidget({super.key});

  @override
  State<CommonAppbarWidget> createState() => _CommonAppbarWidgetState();
}

class _CommonAppbarWidgetState extends State<CommonAppbarWidget> {
  late CommonAppbarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CommonAppbarModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('COMMON_APPBAR_Column_wfitsl3e_ON_TAP');
                logFirebaseEvent('Column_navigate_to');

                context.pushNamed(ProfileWidget.routeName);
              },
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent(
                          'COMMON_APPBAR_COMP_Stack_gloalqmy_ON_TAP');
                      logFirebaseEvent('Stack_navigate_to');

                      context.goNamed(ProfileWidget.routeName);
                    },
                    child: Container(
                      width: 26.0,
                      child: Stack(
                        children: [
                          Icon(
                            Icons.person,
                            color: FlutterFlowTheme.of(context).accent1,
                            size: 30.0,
                          ),
                          if ((valueOrDefault<bool>(
                                      currentUserDocument?.isInterestPass,
                                      false) !=
                                  true) ||
                              (valueOrDefault<bool>(
                                      currentUserDocument?.isPromptPass,
                                      false) !=
                                  true))
                            Align(
                              alignment: AlignmentDirectional(1.0, -1.0),
                              child: AuthUserStreamWidget(
                                builder: (context) => Container(
                                  width: 10.0,
                                  height: 10.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).primary,
                                    shape: BoxShape.circle,
                                  ),
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
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: FlutterFlowIconButton(
                borderRadius: 40.0,
                buttonSize: 40.0,
                icon: Icon(
                  Icons.star,
                  color: FlutterFlowTheme.of(context).accent1,
                  size: 30.0,
                ),
                onPressed: () {
                  print('IconButton pressed ...');
                },
              ),
            ),
          ].divide(SizedBox(width: 8.0)),
        ),
        Expanded(
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Text(
              'yes gurl',
              style: FlutterFlowTheme.of(context).displaySmall.override(
                    fontFamily: FlutterFlowTheme.of(context).displaySmallFamily,
                    fontSize: 25.0,
                    letterSpacing: 0.0,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).displaySmallIsCustom,
                  ),
            ),
          ),
        ),
        Stack(
          alignment: AlignmentDirectional(1.0, -1.0),
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
                  logFirebaseEvent('COMMON_APPBAR_notifications_none_ICN_ON_');
                  logFirebaseEvent('IconButton_navigate_to');

                  context.pushNamed(NotificationWidget.routeName);
                },
              ),
            ),
            if (currentUserReference != null)
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
                                            currentUserDocument?.createdTime)
                                        .toString(),
                                    '0',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .displaySmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
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
      ],
    );
  }
}

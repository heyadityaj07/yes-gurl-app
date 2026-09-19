import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'navbar_model.dart';
export 'navbar_model.dart';

class NavbarWidget extends StatefulWidget {
  const NavbarWidget({
    super.key,
    required this.index,
  });

  final int? index;

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  late NavbarModel _model;

  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavbarModel());

    if (!isWeb) {
      _keyboardVisibilitySubscription =
          KeyboardVisibilityController().onChange.listen((bool visible) {
        safeSetState(() {
          _isKeyboardVisible = visible;
        });
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    if (!isWeb) {
      _keyboardVisibilitySubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Visibility(
      visible: !(isWeb
          ? MediaQuery.viewInsetsOf(context).bottom > 0
          : _isKeyboardVisible),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: 60.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  logFirebaseEvent('NAVBAR_COMP_Column_9j57yzgj_ON_TAP');
                  if (widget!.index != 1) {
                    logFirebaseEvent('Column_navigate_to');

                    context.goNamed(
                      PotentialConnectionsWidget.routeName,
                      extra: <String, dynamic>{
                        '__transition_info__': TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                          duration: Duration(milliseconds: 0),
                        ),
                      },
                    );
                  }
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
                        logFirebaseEvent('NAVBAR_COMP_Stack_x5ld27h1_ON_TAP');
                        logFirebaseEvent('Stack_navigate_to');

                        context.goNamed(
                          PotentialConnectionsWidget.routeName,
                          extra: <String, dynamic>{
                            '__transition_info__': TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                              duration: Duration(milliseconds: 0),
                            ),
                          },
                        );
                      },
                      child: Container(
                        width: 26.0,
                        child: Stack(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: widget!.index == 1
                                  ? FlutterFlowTheme.of(context).primary
                                  : FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                            if (valueOrDefault<bool>(
                                    currentUserDocument?.potentialProfileRead,
                                    false) ==
                                true)
                              Align(
                                alignment: AlignmentDirectional(1.0, -1.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => Container(
                                    width: 10.0,
                                    height: 10.0,
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
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
            ),
            Expanded(
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  logFirebaseEvent('NAVBAR_COMP_Column_m21pd0m9_ON_TAP');
                  if (widget!.index != 2) {
                    logFirebaseEvent('Column_navigate_to');

                    context.goNamed(
                      ChatWidget.routeName,
                      extra: <String, dynamic>{
                        '__transition_info__': TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                          duration: Duration(milliseconds: 0),
                        ),
                      },
                    );
                  }
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
                        logFirebaseEvent('NAVBAR_COMP_Stack_rsurkdjd_ON_TAP');
                        logFirebaseEvent('Stack_navigate_to');

                        context.goNamed(ChatWidget.routeName);
                      },
                      child: Container(
                        width: 26.0,
                        child: Stack(
                          children: [
                            Icon(
                              Icons.chat_rounded,
                              color: widget!.index == 2
                                  ? FlutterFlowTheme.of(context).primary
                                  : FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                            if ((FFAppState().chatseen == false) &&
                                loggedIn &&
                                (currentUserReference != null))
                              Align(
                                alignment: AlignmentDirectional(1.0, -1.0),
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
                                        .orderBy('lastmessage_time',
                                            descending: true),
                                  ),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return EmptyWidget();
                                    }
                                    List<ChatRecord> containerChatRecordList =
                                        snapshot.data!;

                                    return Container(
                                      width: 10.0,
                                      height: 10.0,
                                      decoration: BoxDecoration(),
                                      child: StreamBuilder<
                                          List<ChatMessageRecord>>(
                                        stream: queryChatMessageRecord(
                                          queryBuilder: (chatMessageRecord) =>
                                              chatMessageRecord
                                                  .whereIn(
                                                      'chatRef',
                                                      containerChatRecordList
                                                          .map((e) =>
                                                              e.reference)
                                                          .toList())
                                                  .where(
                                                    'isseen',
                                                    isEqualTo: false,
                                                  )
                                                  .where(
                                                    'recieverRef',
                                                    isEqualTo:
                                                        currentUserReference,
                                                  ),
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return EmptyWidget();
                                          }
                                          List<ChatMessageRecord>
                                              containerChatMessageRecordList =
                                              snapshot.data!;

                                          return Container(
                                            width: 10.0,
                                            height: 10.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: Visibility(
                                              visible:
                                                  functions.unseenfunctioncount(
                                                          containerChatMessageRecordList
                                                              .toList()) !=
                                                      0,
                                              child: Container(
                                                width: 10.0,
                                                height: 10.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
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
            Expanded(
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  logFirebaseEvent('NAVBAR_COMP_Column_07dr6uu5_ON_TAP');
                  if (widget!.index != 3) {
                    logFirebaseEvent('Column_navigate_to');

                    context.goNamed(
                      LinkUpWidget.routeName,
                      extra: <String, dynamic>{
                        '__transition_info__': TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                          duration: Duration(milliseconds: 0),
                        ),
                      },
                    );
                  }
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
                        logFirebaseEvent('NAVBAR_COMP_Stack_e6b9db82_ON_TAP');
                        logFirebaseEvent('Stack_navigate_to');

                        context.goNamed(LinkUpWidget.routeName);
                      },
                      child: Container(
                        width: 26.0,
                        child: Stack(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.solidCalendarAlt,
                              color: widget!.index == 3
                                  ? FlutterFlowTheme.of(context).primary
                                  : FlutterFlowTheme.of(context).secondaryText,
                              size: 22.0,
                            ),
                            Align(
                              alignment: AlignmentDirectional(1.0, -1.0),
                              child: Container(
                                width: 10.0,
                                height: 10.0,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,
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
            ),
            Expanded(
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  logFirebaseEvent('NAVBAR_COMP_Column_tt6azid4_ON_TAP');
                  if (widget!.index != 4) {
                    logFirebaseEvent('Column_navigate_to');

                    context.goNamed(
                      ProfileWidget.routeName,
                      extra: <String, dynamic>{
                        '__transition_info__': TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                          duration: Duration(milliseconds: 0),
                        ),
                      },
                    );
                  }
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
                        logFirebaseEvent('NAVBAR_COMP_Stack_bt315hfc_ON_TAP');
                        logFirebaseEvent('Stack_navigate_to');

                        context.goNamed(ProfileWidget.routeName);
                      },
                      child: Container(
                        width: 26.0,
                        child: Stack(
                          children: [
                            Icon(
                              Icons.person_rounded,
                              color: widget!.index == 4
                                  ? FlutterFlowTheme.of(context).primary
                                  : FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
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
                                      color:
                                          FlutterFlowTheme.of(context).primary,
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
            ),
          ],
        ),
      ),
    );
  }
}

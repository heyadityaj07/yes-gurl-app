import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/link_up/link_up_message/link_up_message_widget.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'user_card_model.dart';
export 'user_card_model.dart';

class UserCardWidget extends StatefulWidget {
  const UserCardWidget({
    super.key,
    required this.user,
  });

  final UserRecord? user;

  @override
  State<UserCardWidget> createState() => _UserCardWidgetState();
}

class _UserCardWidgetState extends State<UserCardWidget>
    with TickerProviderStateMixin {
  late UserCardModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserCardModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(90.0, 0.0),
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
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            logFirebaseEvent('USER_CARD_COMP_Container_5al7lznk_ON_TAP');
            if (widget!.user?.isDeactivated == true) {
              logFirebaseEvent('Container_bottom_sheet');
              await showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                enableDrag: false,
                context: context,
                builder: (context) {
                  return Padding(
                    padding: MediaQuery.viewInsetsOf(context),
                    child: LinkUpMessageWidget(
                      description: 'They\'ve paused their account',
                      title: '  ',
                    ),
                  );
                },
              ).then((value) => safeSetState(() {}));
            } else {
              if ((currentUserDocument?.messageSent?.toList() ?? [])
                  .contains(widget!.user?.reference)) {
                logFirebaseEvent('Container_show_snack_bar');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'You\'ve already reached out to this profile',
                      style: TextStyle(
                        color: FlutterFlowTheme.of(context).primaryText,
                      ),
                    ),
                    duration: Duration(milliseconds: 4000),
                    backgroundColor: FlutterFlowTheme.of(context).secondary,
                  ),
                );
              } else {
                logFirebaseEvent('Container_navigate_to');

                context.pushNamed(
                  PotentialMatchesProfileWidget.routeName,
                  queryParameters: {
                    'userRef': serializeParam(
                      widget!.user?.reference,
                      ParamType.DocumentReference,
                    ),
                  }.withoutNulls,
                );
              }
            }
          },
          child: Material(
            color: Colors.transparent,
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: Container(
              width: 330.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(),
                              child: Visibility(
                                visible: (currentUserDocument?.messageSent
                                            ?.toList() ??
                                        [])
                                    .contains(widget!.user?.reference),
                                child: Opacity(
                                  opacity: 0.6,
                                  child: AuthUserStreamWidget(
                                    builder: (context) => Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      height: 160.0,
                                      child: custom_widgets.ImageView(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        height: 160.0,
                                        imagePath: widget!.user?.displayImage,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (!(currentUserDocument?.messageSent?.toList() ??
                                    [])
                                .contains(widget!.user?.reference))
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => Container(
                                    decoration: BoxDecoration(),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      height: 160.0,
                                      child: custom_widgets.ImageView(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        height: 160.0,
                                        imagePath: widget!.user?.displayImage,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 16.0, 0.0, 0.0),
                          child: AuthUserStreamWidget(
                            builder: (context) => Text(
                              widget!.user!.displayName,
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .headlineSmallFamily,
                                    color: (currentUserDocument?.messageSent
                                                    ?.toList() ??
                                                [])
                                            .contains(widget!.user?.reference)
                                        ? Color(0x8357636C)
                                        : FlutterFlowTheme.of(context)
                                            .primaryText,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .headlineSmallIsCustom,
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 4.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (functions
                                      .getRecommendation(
                                          widget!.user!.personalityType,
                                          valueOrDefault(
                                              currentUserDocument
                                                  ?.personalityType,
                                              ''))
                                      .toString() !=
                                  '0')
                                AuthUserStreamWidget(
                                  builder: (context) => Icon(
                                    Icons.favorite_sharp,
                                    color: (currentUserDocument?.messageSent
                                                    ?.toList() ??
                                                [])
                                            .contains(widget!.user?.reference)
                                        ? Color(0x7EFE99AB)
                                        : FlutterFlowTheme.of(context).primary,
                                    size: 15.0,
                                  ),
                                ),
                              if (functions
                                      .getRecommendation(
                                          widget!.user!.personalityType,
                                          valueOrDefault(
                                              currentUserDocument
                                                  ?.personalityType,
                                              ''))
                                      .toString() ==
                                  '0')
                                AuthUserStreamWidget(
                                  builder: (context) => FaIcon(
                                    FontAwesomeIcons.leaf,
                                    color: (currentUserDocument?.messageSent
                                                    ?.toList() ??
                                                [])
                                            .contains(widget!.user?.reference)
                                        ? Color(0x7EFE99AB)
                                        : FlutterFlowTheme.of(context).primary,
                                    size: 15.0,
                                  ),
                                ),
                              if ((functions
                                          .getRecommendation(
                                              widget!.user!.personalityType,
                                              valueOrDefault(
                                                  currentUserDocument
                                                      ?.personalityType,
                                                  ''))
                                          .toString() !=
                                      '1') &&
                                  (functions
                                          .getRecommendation(
                                              widget!.user!.personalityType,
                                              valueOrDefault(
                                                  currentUserDocument
                                                      ?.personalityType,
                                                  ''))
                                          .toString() !=
                                      '0'))
                                AuthUserStreamWidget(
                                  builder: (context) => Icon(
                                    Icons.question_mark,
                                    color: (currentUserDocument?.messageSent
                                                    ?.toList() ??
                                                [])
                                            .contains(widget!.user?.reference)
                                        ? Color(0x7EFE99AB)
                                        : FlutterFlowTheme.of(context).primary,
                                    size: 15.0,
                                  ),
                                ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 0.0, 0.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => Text(
                                    functions
                                                .getRecommendation(
                                                    widget!
                                                        .user!.personalityType,
                                                    valueOrDefault(
                                                        currentUserDocument
                                                            ?.personalityType,
                                                        ''))
                                                .toString() ==
                                            '0'
                                        ? 'compatible'
                                        : 'possible',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color: (currentUserDocument
                                                          ?.messageSent
                                                          ?.toList() ??
                                                      [])
                                                  .contains(
                                                      widget!.user?.reference)
                                              ? Color(0x8357636C)
                                              : FlutterFlowTheme.of(context)
                                                  .primaryText,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
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
                ],
              ),
            ),
          ),
        ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!),
      ),
    );
  }
}

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/common_appbar_widget.dart';
import '/components/navbar_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';
import 'package:provider/provider.dart';
import 'communities_model.dart';
export 'communities_model.dart';

class CommunitiesWidget extends StatefulWidget {
  const CommunitiesWidget({super.key});

  static String routeName = 'communities';
  static String routePath = '/communities';

  @override
  State<CommunitiesWidget> createState() => _CommunitiesWidgetState();
}

class _CommunitiesWidgetState extends State<CommunitiesWidget>
    with TickerProviderStateMixin {
  late CommunitiesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CommunitiesModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'communities'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('COMMUNITIES_communities_ON_INIT_STATE');
      logFirebaseEvent('communities_backend_call');

      await currentUserReference!.update({
        ...mapToFirestore(
          {
            'offline_user_time': FieldValue.delete(),
          },
        ),
      });
      logFirebaseEvent('communities_update_app_state');
      FFAppState().lastCommunitySeenAt = getCurrentTimestamp;
      safeSetState(() {});
    });

    animationsMap.addAll({
      'textOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 50.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'textOnPageLoadAnimation2': AnimationInfo(
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
      'textOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 250.0.ms,
            duration: 600.0.ms,
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
    // On page dispose action.
    () async {
      logFirebaseEvent('COMMUNITIES_PAGE_communities_ON_DISPOSE');
      logFirebaseEvent('communities_backend_call');

      await currentUserReference!.update({
        ...mapToFirestore(
          {
            'offline_user_time': FieldValue.delete(),
          },
        ),
      });
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
          title: wrapWithModel(
            model: _model.commonAppbarModel,
            updateCallback: () => safeSetState(() {}),
            child: CommonAppbarWidget(),
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
              Expanded(
                child: Container(
                  height: MediaQuery.sizeOf(context).height * 0.8,
                  decoration: BoxDecoration(),
                  child: Builder(
                    builder: (context) {
                      if ((valueOrDefault<bool>(
                                  currentUserDocument?.isPromptPass, false) ==
                              true) &&
                          (valueOrDefault<bool>(
                                  currentUserDocument?.isInterestPass, false) ==
                              true)) {
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 12.0, 15.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'communities',
                                      style: FlutterFlowTheme.of(context)
                                          .displaySmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .displaySmallFamily,
                                            fontSize: 25.0,
                                            letterSpacing: 1.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .displaySmallIsCustom,
                                          ),
                                    ),
                                  ),
                                  FlutterFlowIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: 20.0,
                                    buttonSize: 40.0,
                                    fillColor:
                                        FlutterFlowTheme.of(context).primary,
                                    icon: Icon(
                                      Icons.add,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 24.0,
                                    ),
                                    onPressed: () async {
                                      logFirebaseEvent(
                                          'COMMUNITIES_PAGE_add_ICN_ON_TAP');
                                      logFirebaseEvent(
                                          'IconButton_navigate_to');

                                      context.pushNamed(
                                          CommunitiesCreateWidget.routeName);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    StreamBuilder<List<MembersRecord>>(
                                      stream: queryMembersRecord(
                                        queryBuilder: (membersRecord) =>
                                            membersRecord
                                                .where(
                                                  'user_ref',
                                                  isEqualTo:
                                                      currentUserReference,
                                                )
                                                .orderBy('joined_at',
                                                    descending: true),
                                        limit: 5,
                                      ),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  Colors.transparent,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        List<MembersRecord>
                                            containerMembersRecordList =
                                            snapshot.data!;

                                        return Container(
                                          decoration: BoxDecoration(),
                                          child: Visibility(
                                            visible: containerMembersRecordList
                                                .isNotEmpty,
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 20.0, 16.0, 0.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'my communities',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLarge
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleLargeFamily,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize:
                                                                      20.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleLargeIsCustom,
                                                                ),
                                                      ).animateOnPageLoad(
                                                          animationsMap[
                                                              'textOnPageLoadAnimation1']!),
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
                                                              'COMMUNITIES_PAGE_Text_mza1k9oh_ON_TAP');
                                                          logFirebaseEvent(
                                                              'Text_navigate_to');

                                                          context.pushNamed(
                                                              CommunitiesSeeAllWidget
                                                                  .routeName);
                                                        },
                                                        child: Text(
                                                          'view all',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMediumIsCustom,
                                                              ),
                                                        ),
                                                      ).animateOnPageLoad(
                                                          animationsMap[
                                                              'textOnPageLoadAnimation2']!),
                                                    ],
                                                  ),
                                                  Builder(
                                                    builder: (context) {
                                                      final member =
                                                          containerMembersRecordList
                                                              .toList();

                                                      return SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children:
                                                              List.generate(
                                                                  member.length,
                                                                  (memberIndex) {
                                                            final memberItem =
                                                                member[
                                                                    memberIndex];
                                                            return StreamBuilder<
                                                                CommunityRecord>(
                                                              stream: CommunityRecord
                                                                  .getDocument(
                                                                      memberItem
                                                                          .parentReference),
                                                              builder: (context,
                                                                  snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width: 50,
                                                                      height:
                                                                          50,
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        valueColor:
                                                                            AlwaysStoppedAnimation<Color>(
                                                                          Colors
                                                                              .transparent,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }

                                                                final containerCommunityRecord =
                                                                    snapshot
                                                                        .data!;

                                                                return InkWell(
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
                                                                        'COMMUNITIES_Container_97mh042r_ON_TAP');
                                                                    logFirebaseEvent(
                                                                        'Container_navigate_to');

                                                                    context
                                                                        .pushNamed(
                                                                      CommunityDetailWidget
                                                                          .routeName,
                                                                      queryParameters:
                                                                          {
                                                                        'communityRef':
                                                                            serializeParam(
                                                                          containerCommunityRecord
                                                                              .reference,
                                                                          ParamType
                                                                              .DocumentReference,
                                                                        ),
                                                                      }.withoutNulls,
                                                                    );
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      crossAxisAlignment:
                                                                          (FFCrossAxisAlignment.center)
                                                                              .flutterValue,
                                                                      textBaseline:
                                                                          TextBaseline
                                                                              .alphabetic,
                                                                      children: [
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              topLeft: Radius.circular(16.0),
                                                                              topRight: Radius.circular(16.0),
                                                                            ),
                                                                            child:
                                                                                OctoImage(
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
                                                                                containerCommunityRecord.communityImage,
                                                                              ),
                                                                              width: 130.0,
                                                                              height: 100.0,
                                                                              fit: BoxFit.cover,
                                                                              errorBuilder: (context, error, stackTrace) => Image.asset(
                                                                                'assets/images/error_image.png',
                                                                                width: 130.0,
                                                                                height: 100.0,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                              memCacheWidth: 12,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                130.0,
                                                                            height:
                                                                                60.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).accent3,
                                                                              borderRadius: BorderRadius.only(
                                                                                bottomLeft: Radius.circular(12.0),
                                                                                bottomRight: Radius.circular(12.0),
                                                                              ),
                                                                            ),
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.all(12.0),
                                                                              child: Text(
                                                                                containerCommunityRecord.name,
                                                                                maxLines: 2,
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                      letterSpacing: 0.0,
                                                                                      useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                    ),
                                                                                overflow: TextOverflow.ellipsis,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          }).divide(SizedBox(
                                                                  width: 12.0)),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 10.0)),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 0.0),
                                          child: Text(
                                            'discover',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .titleLarge
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleLargeFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .titleLargeIsCustom,
                                                ),
                                          ).animateOnPageLoad(animationsMap[
                                              'textOnPageLoadAnimation3']!),
                                        ),
                                        custom_widgets.DiscoverCommunity(
                                          width: double.infinity,
                                          height: 500.0,
                                          search: false,
                                        ),
                                      ].divide(SizedBox(height: 10.0)),
                                    ),
                                  ]
                                      .divide(SizedBox(height: 12.0))
                                      .addToEnd(SizedBox(height: 20.0)),
                                ),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 30.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.1),
                                          children: [
                                            Opacity(
                                              opacity: 0.6,
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.49, 1.25),
                                                child: FaIcon(
                                                  FaIconData(FontAwesomeIcons
                                                      .solidCircle.data),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  size: 55.0,
                                                ),
                                              ),
                                            ),
                                            Icon(
                                              Icons.error_outline_sharp,
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .displaySmallFamily,
                                        fontSize: 27.0,
                                        letterSpacing: 1.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .displaySmallIsCustom,
                                      ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 10.0, 20.0, 0.0),
                                  child: RichText(
                                    textScaler:
                                        MediaQuery.of(context).textScaler,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              'you can\'t see any link ups because your profile is incomplete',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        )
                                      ],
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyMediumIsCustom,
                                          ),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 30.0, 0.0, 0.0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      logFirebaseEvent(
                                          'COMMUNITIES_PAGE_completeProfile_ON_TAP');
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
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
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
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                      ),
                                      borderRadius: BorderRadius.circular(40.0),
                                      hoverColor: Color(0xC6FE99AB),
                                      hoverBorderSide: BorderSide(
                                        color: Color(0xC6FE99AB),
                                      ),
                                      hoverTextColor:
                                          FlutterFlowTheme.of(context).accent1,
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
              wrapWithModel(
                model: _model.navbarModel,
                updateCallback: () => safeSetState(() {}),
                updateOnChange: true,
                child: NavbarWidget(
                  index: 4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

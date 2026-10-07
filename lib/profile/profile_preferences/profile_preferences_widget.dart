import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'profile_preferences_model.dart';
export 'profile_preferences_model.dart';

class ProfilePreferencesWidget extends StatefulWidget {
  const ProfilePreferencesWidget({super.key});

  static String routeName = 'profilePreferences';
  static String routePath = '/profilePreferences';

  @override
  State<ProfilePreferencesWidget> createState() =>
      _ProfilePreferencesWidgetState();
}

class _ProfilePreferencesWidgetState extends State<ProfilePreferencesWidget>
    with TickerProviderStateMixin {
  late ProfilePreferencesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfilePreferencesModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'profilePreferences'});
    animationsMap.addAll({
      'textOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
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
            delay: 50.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'rowOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'dividerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 150.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'columnOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 150.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'columnOnPageLoadAnimation2': AnimationInfo(
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
      'columnOnPageLoadAnimation3': AnimationInfo(
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
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
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
      child: PopScope(
        canPop: false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderRadius: 30.0,
              buttonSize: 40.0,
              hoverIconColor: Color(0xFFFE99AB),
              icon: Icon(
                Icons.arrow_back_ios,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 24.0,
              ),
              onPressed: () async {
                logFirebaseEvent('PROFILE_PREFERENCES_arrow_back_ios_ICN_O');
                logFirebaseEvent('IconButton_navigate_to');

                context.pushNamed(ProfileWidget.routeName);
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(25.0, 12.0, 15.0, 0.0),
                    child: Text(
                      'friendship preferences',
                      style: FlutterFlowTheme.of(context).displaySmall.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).displaySmallFamily,
                            fontSize: 25.0,
                            letterSpacing: 1.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .displaySmallIsCustom,
                          ),
                    ).animateOnPageLoad(
                        animationsMap['textOnPageLoadAnimation1']!),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(25.0, 10.0, 0.0, 0.0),
                    child: Text(
                      'let us know your preferences',
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleLargeFamily,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 20.0,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .titleLargeIsCustom,
                          ),
                    ).animateOnPageLoad(
                        animationsMap['textOnPageLoadAnimation2']!),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 0.0),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'PROFILE_PREFERENCES_Column_t4z1dsd3_ON_T');
                              logFirebaseEvent('Column_navigate_to');

                              context.pushNamed(
                                  ProfilePreferencesAgeWidget.routeName);
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'age',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .bodyMediumIsCustom,
                                            ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(1.0, 0.0),
                                          child: AuthUserStreamWidget(
                                            builder: (context) => Text(
                                              ((currentUserDocument?.selectedAgeRange
                                                                      ?.toList() ??
                                                                  [])
                                                              .firstOrNull !=
                                                          18) ||
                                                      ((currentUserDocument
                                                                      ?.selectedAgeRange
                                                                      ?.toList() ??
                                                                  [])
                                                              .lastOrNull !=
                                                          80)
                                                  ? '${(currentUserDocument?.selectedAgeRange?.toList() ?? []).firstOrNull?.toString()}-${(currentUserDocument?.selectedAgeRange?.toList() ?? []).lastOrNull?.toString()} years'
                                                  : 'open to all',
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
                                            ),
                                          ),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 5.0)),
                                  ).animateOnPageLoad(
                                      animationsMap['rowOnPageLoadAnimation']!),
                                ),
                                Divider(
                                  thickness: 2.0,
                                  color: FlutterFlowTheme.of(context).alternate,
                                ).animateOnPageLoad(animationsMap[
                                    'dividerOnPageLoadAnimation']!),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  logFirebaseEvent(
                                      'PROFILE_PREFERENCES_Column_gdviuavc_ON_T');
                                  logFirebaseEvent('Column_navigate_to');

                                  context.pushNamed(
                                      ProfilePreferencesLocationWidget
                                          .routeName);
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'distance',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  1.0, 0.0),
                                              child: AuthUserStreamWidget(
                                                builder: (context) => Text(
                                                  valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.preferrredLocation,
                                                                  '') !=
                                                              null &&
                                                          valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.preferrredLocation,
                                                                  '') !=
                                                              ''
                                                      ? valueOrDefault(
                                                          currentUserDocument
                                                              ?.preferrredLocation,
                                                          '')
                                                      : 'open to all',
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
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMediumIsCustom,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 5.0)),
                                      ),
                                    ),
                                    if ((currentUserDocument?.selectedLocation
                                                    ?.toList() ??
                                                [])
                                            .length !=
                                        10)
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 10.0, 0.0, 10.0),
                                          child: AuthUserStreamWidget(
                                            builder: (context) => Builder(
                                              builder: (context) {
                                                final city = (currentUserDocument
                                                            ?.selectedLocation
                                                            ?.toList() ??
                                                        [])
                                                    .toList();

                                                return SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: List.generate(
                                                        city.length,
                                                        (cityIndex) {
                                                      final cityItem =
                                                          city[cityIndex];
                                                      return Text(
                                                        '${cityItem}${cityIndex != ((currentUserDocument?.selectedLocation?.toList() ?? []).length - 1) ? ',' : ''}',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMediumIsCustom,
                                                                ),
                                                      );
                                                    }).divide(
                                                        SizedBox(width: 5.0)),
                                                  ),
                                                );
                                              },
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
                                ),
                              ).animateOnPageLoad(
                                  animationsMap['columnOnPageLoadAnimation1']!),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  logFirebaseEvent(
                                      'PROFILE_PREFERENCES_Column_h8rlta0x_ON_T');
                                  logFirebaseEvent('Column_navigate_to');

                                  context.pushNamed(
                                      ProfilePreferencesRelationshipWidget
                                          .routeName);
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 10.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'relationship',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                          ),
                                          if ((currentUserDocument
                                                          ?.selectedRelationship
                                                          ?.toList() ??
                                                      [])
                                                  .length !=
                                              3)
                                            Expanded(
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    1.0, 0.0),
                                                child: AuthUserStreamWidget(
                                                  builder: (context) => Builder(
                                                    builder: (context) {
                                                      final relationship =
                                                          (currentUserDocument
                                                                      ?.selectedRelationship
                                                                      ?.toList() ??
                                                                  [])
                                                              .toList();

                                                      return SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: List.generate(
                                                              relationship
                                                                  .length,
                                                              (relationshipIndex) {
                                                            final relationshipItem =
                                                                relationship[
                                                                    relationshipIndex];
                                                            return Text(
                                                              '${relationshipItem}${relationshipIndex != ((currentUserDocument?.selectedRelationship?.toList() ?? []).length - 1) ? ',' : ''}',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .bodyMediumIsCustom,
                                                                  ),
                                                            );
                                                          }).divide(SizedBox(
                                                              width: 5.0)),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          if ((currentUserDocument
                                                          ?.selectedRelationship
                                                          ?.toList() ??
                                                      [])
                                                  .length ==
                                              3)
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.0, 0.0),
                                              child: AuthUserStreamWidget(
                                                builder: (context) => Text(
                                                  'open to all',
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
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMediumIsCustom,
                                                      ),
                                                ),
                                              ),
                                            ),
                                        ].divide(SizedBox(width: 5.0)),
                                      ),
                                    ),
                                    Divider(
                                      thickness: 2.0,
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                    ),
                                  ],
                                ),
                              ).animateOnPageLoad(
                                  animationsMap['columnOnPageLoadAnimation2']!),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  logFirebaseEvent(
                                      'PROFILE_PREFERENCES_Column_z82u6dnr_ON_T');
                                  logFirebaseEvent('Column_navigate_to');

                                  context.pushNamed(
                                      ProfilePreferencesChildrenWidget
                                          .routeName);
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 10.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'children',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                          ),
                                          if ((currentUserDocument
                                                          ?.selectedChildren
                                                          ?.toList() ??
                                                      [])
                                                  .length !=
                                              2)
                                            Expanded(
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    1.0, 0.0),
                                                child: AuthUserStreamWidget(
                                                  builder: (context) => Builder(
                                                    builder: (context) {
                                                      final child =
                                                          (currentUserDocument
                                                                      ?.selectedChildren
                                                                      ?.toList() ??
                                                                  [])
                                                              .toList();

                                                      return SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children:
                                                              List.generate(
                                                                  child.length,
                                                                  (childIndex) {
                                                            final childItem =
                                                                child[
                                                                    childIndex];
                                                            return Text(
                                                              '${childItem}${childIndex != ((currentUserDocument?.selectedChildren?.toList() ?? []).length - 1) ? ',' : ''}',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .bodyMediumIsCustom,
                                                                  ),
                                                            );
                                                          }).divide(SizedBox(
                                                                  width: 5.0)),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          if ((currentUserDocument
                                                          ?.selectedChildren
                                                          ?.toList() ??
                                                      [])
                                                  .length ==
                                              2)
                                            Expanded(
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    1.0, 0.0),
                                                child: AuthUserStreamWidget(
                                                  builder: (context) => Text(
                                                    'open to all',
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
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ].divide(SizedBox(width: 5.0)),
                                      ),
                                    ),
                                    Divider(
                                      thickness: 2.0,
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                    ),
                                  ],
                                ),
                              ).animateOnPageLoad(
                                  animationsMap['columnOnPageLoadAnimation3']!),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 15.0, 0.0, 15.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).tertiary,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).secondary,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'changing your preferences may wipe out your current potential connections, but if you don\'t mind, your potential connections will refresh with your new preferences tomorrow',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      fontSize: 10.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyMediumIsCustom,
                                    ),
                              ),
                            ),
                          ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation']!),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

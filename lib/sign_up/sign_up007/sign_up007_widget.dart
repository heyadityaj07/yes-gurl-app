import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';
import 'package:provider/provider.dart';
import 'sign_up007_model.dart';
export 'sign_up007_model.dart';

class SignUp007Widget extends StatefulWidget {
  const SignUp007Widget({super.key});

  static String routeName = 'signUp007';
  static String routePath = '/signUp007';

  @override
  State<SignUp007Widget> createState() => _SignUp007WidgetState();
}

class _SignUp007WidgetState extends State<SignUp007Widget>
    with TickerProviderStateMixin {
  late SignUp007Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignUp007Model());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'signUp007'});
    animationsMap.addAll({
      'textOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 50.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'iconOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 50.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'buttonOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 150.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'iconButtonOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 150.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
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
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderRadius: 30.0,
            buttonSize: 40.0,
            hoverIconColor: FlutterFlowTheme.of(context).primary,
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),
            onPressed: () async {
              logFirebaseEvent('SIGN_UP007_arrow_back_ios_new_ICN_ON_TAP');
              logFirebaseEvent('IconButton_navigate_to');

              context.pushNamed(
                SignUp006Widget.routeName,
                extra: <String, dynamic>{
                  '__transition_info__': TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.rightToLeft,
                    duration: Duration(milliseconds: 300),
                  ),
                },
              );
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
          elevation: 1.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, -1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 20.0, 0.0, 0.0),
                            child: Text(
                              'your fave picture of you',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .displaySmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .displaySmallFamily,
                                    color: FlutterFlowTheme.of(context).accent1,
                                    fontSize: 27.0,
                                    letterSpacing: 1.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .displaySmallIsCustom,
                                  ),
                            ).animateOnPageLoad(
                                animationsMap['textOnPageLoadAnimation']!),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, -1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 50.0, 0.0, 0.0),
                            child: Icon(
                              Icons.photo_camera_outlined,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 90.0,
                            ).animateOnPageLoad(
                                animationsMap['iconOnPageLoadAnimation']!),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 40.0, 0.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              logFirebaseEvent(
                                  'SIGN_UP007_PAGE_uploadPhoto_ON_TAP');
                              logFirebaseEvent(
                                  'uploadPhoto_upload_media_to_firebase');
                              final selectedMedia =
                                  await selectMediaWithSourceBottomSheet(
                                context: context,
                                maxWidth: 1024.00,
                                maxHeight: 1024.00,
                                imageQuality: 70,
                                allowPhoto: true,
                              );
                              if (selectedMedia != null &&
                                  selectedMedia.every((m) => validateFileFormat(
                                      m.storagePath, context))) {
                                safeSetState(() => _model
                                        .isDataUploading_uploadedDataLocalState =
                                    true);
                                var selectedUploadedFiles = <FFUploadedFile>[];

                                var downloadUrls = <String>[];
                                try {
                                  selectedUploadedFiles = selectedMedia
                                      .map((m) => FFUploadedFile(
                                            name: m.storagePath.split('/').last,
                                            bytes: m.bytes,
                                            height: m.dimensions?.height,
                                            width: m.dimensions?.width,
                                            blurHash: m.blurHash,
                                            originalFilename:
                                                m.originalFilename,
                                          ))
                                      .toList();

                                  downloadUrls = (await Future.wait(
                                    selectedMedia.map(
                                      (m) async => await uploadData(
                                          m.storagePath, m.bytes),
                                    ),
                                  ))
                                      .where((u) => u != null)
                                      .map((u) => u!)
                                      .toList();
                                } finally {
                                  _model.isDataUploading_uploadedDataLocalState =
                                      false;
                                }
                                if (selectedUploadedFiles.length ==
                                        selectedMedia.length &&
                                    downloadUrls.length ==
                                        selectedMedia.length) {
                                  safeSetState(() {
                                    _model.uploadedLocalFile_uploadedDataLocalState =
                                        selectedUploadedFiles.first;
                                    _model.uploadedFileUrl_uploadedDataLocalState =
                                        downloadUrls.first;
                                  });
                                } else {
                                  safeSetState(() {});
                                  return;
                                }
                              }
                            },
                            text: 'upload',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 45.0,
                              padding: EdgeInsets.all(0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .titleSmallFamily,
                                    color: FlutterFlowTheme.of(context).accent1,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .titleSmallIsCustom,
                                  ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(40.0),
                              hoverColor: Color(0xC6FE99AB),
                              hoverBorderSide: BorderSide(
                                color: Color(0xC6FE99AB),
                                width: 2.0,
                              ),
                              hoverTextColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                          ).animateOnPageLoad(
                              animationsMap['buttonOnPageLoadAnimation']!),
                        ),
                        if ((_model.uploadedFileUrl_uploadedDataLocalState !=
                                    null &&
                                _model.uploadedFileUrl_uploadedDataLocalState !=
                                    '') &&
                            responsiveVisibility(
                              context: context,
                              phone: false,
                              tablet: false,
                              tabletLandscape: false,
                              desktop: false,
                            ))
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                2.0, 15.0, 2.0, 15.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
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
                                image: NetworkImage(
                                  _model.uploadedFileUrl_uploadedDataLocalState,
                                ),
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: 350.0,
                                fit: BoxFit.fitWidth,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  'assets/images/error_image.png',
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height: 350.0,
                                  fit: BoxFit.fitWidth,
                                ),
                                memCacheWidth: 350,
                                memCacheHeight: 350,
                              ),
                            ),
                          ),
                        if (_model.uploadedFileUrl_uploadedDataLocalState !=
                                null &&
                            _model.uploadedFileUrl_uploadedDataLocalState != '')
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 15.0, 0.0, 15.0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: MediaQuery.sizeOf(context).height * 0.35,
                              child: custom_widgets.ImageView(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.35,
                                imagePath: _model
                                    .uploadedFileUrl_uploadedDataLocalState,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              if (_model.uploadedFileUrl_uploadedDataLocalState != null &&
                  _model.uploadedFileUrl_uploadedDataLocalState != '')
                Align(
                  alignment: AlignmentDirectional(1.0, -1.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 16.0, 0.0),
                    child: FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30.0,
                      borderWidth: 1.0,
                      buttonSize: 60.0,
                      fillColor: FlutterFlowTheme.of(context).primary,
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                      showLoadingIndicator: true,
                      onPressed: () async {
                        logFirebaseEvent(
                            'SIGN_UP007_arrow_forward_ios_ICN_ON_TAP');
                        logFirebaseEvent('IconButton_backend_call');

                        await currentUserReference!.update(createUserRecordData(
                          displayImage:
                              _model.uploadedFileUrl_uploadedDataLocalState,
                        ));
                        logFirebaseEvent('IconButton_navigate_to');

                        context.goNamed(
                          SignUp008PrivacyWidget.routeName,
                          extra: <String, dynamic>{
                            '__transition_info__': TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                              duration: Duration(milliseconds: 0),
                            ),
                          },
                        );
                      },
                    ).animateOnPageLoad(
                        animationsMap['iconButtonOnPageLoadAnimation']!),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

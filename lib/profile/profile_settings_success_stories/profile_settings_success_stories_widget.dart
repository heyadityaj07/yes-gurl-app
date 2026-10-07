import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'profile_settings_success_stories_model.dart';
export 'profile_settings_success_stories_model.dart';

class ProfileSettingsSuccessStoriesWidget extends StatefulWidget {
  const ProfileSettingsSuccessStoriesWidget({super.key});

  static String routeName = 'profileSettingsSuccessStories';
  static String routePath = '/profileSettingsSuccessStories';

  @override
  State<ProfileSettingsSuccessStoriesWidget> createState() =>
      _ProfileSettingsSuccessStoriesWidgetState();
}

class _ProfileSettingsSuccessStoriesWidgetState
    extends State<ProfileSettingsSuccessStoriesWidget> {
  late ProfileSettingsSuccessStoriesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileSettingsSuccessStoriesModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'profileSettingsSuccessStories'});
    _model.biosTextController ??= TextEditingController();
    _model.biosFocusNode ??= FocusNode();

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
          leading: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
            child: FlutterFlowIconButton(
              borderRadius: 30.0,
              buttonSize: 40.0,
              icon: Icon(
                Icons.arrow_back_ios,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 30.0,
              ),
              onPressed: () async {
                logFirebaseEvent('PROFILE_SETTINGS_SUCCESS_STORIES_arrow_b');
                logFirebaseEvent('IconButton_navigate_back');
                context.safePop();
              },
            ),
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
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                    child: Text(
                      'share with us your wins',
                      style: FlutterFlowTheme.of(context).displaySmall.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).displaySmallFamily,
                            fontSize: 25.0,
                            letterSpacing: 1.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .displaySmallIsCustom,
                          ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 10.0),
                    child: Text(
                      'have you made a new friend?',
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
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(40.0),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 2.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            15.0, 15.0, 15.0, 15.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          child: TextFormField(
                            controller: _model.biosTextController,
                            focusNode: _model.biosFocusNode,
                            onChanged: (_) => EasyDebounce.debounce(
                              '_model.biosTextController',
                              Duration(milliseconds: 0),
                              () => safeSetState(() {}),
                            ),
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: true,
                              labelStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelMediumFamily,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelMediumIsCustom,
                                  ),
                              hintText:
                                  'whether you\'ve made a bestie or found the courage to reach out to someone new, we want to hear your successes! ',
                              hintStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelMediumFamily,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelMediumIsCustom,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              filled: true,
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodyMediumIsCustom,
                                ),
                            maxLines: 9,
                            minLines: 9,
                            cursorColor:
                                FlutterFlowTheme.of(context).primaryText,
                            validator: _model.biosTextControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: RichText(
                            textScaler: MediaQuery.of(context).textScaler,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'please ',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                ),
                                TextSpan(
                                  text: 'tick ',
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: 'if you want to remain anonymous',
                                  style: TextStyle(),
                                )
                              ],
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyMediumIsCustom,
                                  ),
                            ),
                          ),
                        ),
                        Theme(
                          data: ThemeData(
                            checkboxTheme: CheckboxThemeData(
                              visualDensity: VisualDensity.compact,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            unselectedWidgetColor:
                                FlutterFlowTheme.of(context).secondaryText,
                          ),
                          child: Checkbox(
                            value: _model.checkboxValue ??= false,
                            onChanged: (newValue) async {
                              safeSetState(
                                  () => _model.checkboxValue = newValue!);
                            },
                            side: (FlutterFlowTheme.of(context).secondaryText !=
                                    null)
                                ? BorderSide(
                                    width: 2,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText!,
                                  )
                                : null,
                            activeColor: FlutterFlowTheme.of(context).primary,
                            checkColor: FlutterFlowTheme.of(context).info,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_model.biosTextController.text != null &&
                      _model.biosTextController.text != '')
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: (_model.biosTextController.text == null ||
                                _model.biosTextController.text == '')
                            ? null
                            : () async {
                                logFirebaseEvent(
                                    'PROFILE_SETTINGS_SUCCESS_STORIES_SUBMIT_');
                                logFirebaseEvent('Button_backend_call');

                                await StoryRecord.collection
                                    .doc()
                                    .set(createStoryRecordData(
                                      userReference: currentUserReference,
                                      description:
                                          _model.biosTextController.text,
                                      createdTime: getCurrentTimestamp,
                                      anonymous: _model.checkboxValue,
                                    ));
                                logFirebaseEvent('Button_backend_call');

                                await NotificationRecord.collection
                                    .doc()
                                    .set(createNotificationRecordData(
                                      title: 'Story',
                                      description:
                                          '${currentUserDisplayName} (${currentUserUid}) added Success Story at ${dateTimeFormat("yMMMd", getCurrentTimestamp)}',
                                      sentBy: currentUserReference,
                                      user: currentUserReference,
                                      sentAt: getCurrentTimestamp,
                                      notificationType: 'report',
                                      forAdmin: true,
                                    ));
                                logFirebaseEvent('Button_show_snack_bar');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Thank you for sending in your success story',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).secondary,
                                  ),
                                );
                                logFirebaseEvent(
                                    'Button_clear_text_fields_pin_codes');
                                safeSetState(() {
                                  _model.biosTextController?.clear();
                                });
                                logFirebaseEvent('Button_navigate_back');
                                context.pop();
                              },
                        text: 'submit',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 45.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleSmallFamily,
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .titleSmallIsCustom,
                              ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(40.0),
                          disabledColor: FlutterFlowTheme.of(context).warning,
                        ),
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

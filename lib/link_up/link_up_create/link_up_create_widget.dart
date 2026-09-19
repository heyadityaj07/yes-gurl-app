import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'link_up_create_model.dart';
export 'link_up_create_model.dart';

class LinkUpCreateWidget extends StatefulWidget {
  const LinkUpCreateWidget({super.key});

  static String routeName = 'LinkUpCreate';
  static String routePath = '/linkUpCreate';

  @override
  State<LinkUpCreateWidget> createState() => _LinkUpCreateWidgetState();
}

class _LinkUpCreateWidgetState extends State<LinkUpCreateWidget> {
  late LinkUpCreateModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LinkUpCreateModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'LinkUpCreate'});
    _model.nameTextController ??= TextEditingController();
    _model.nameFocusNode ??= FocusNode();

    _model.emailLoginTextController ??= TextEditingController();
    _model.emailLoginFocusNode ??= FocusNode();

    _model.descriptionTextController ??= TextEditingController();
    _model.descriptionFocusNode ??= FocusNode();

    _model.websiteTextController ??= TextEditingController();
    _model.websiteFocusNode ??= FocusNode();

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
            borderRadius: 8.0,
            buttonSize: 40.0,
            fillColor: Color(0x01FE99AB),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            onPressed: () async {
              logFirebaseEvent('LINK_UP_CREATE_arrow_back_ios_new_ICN_ON');
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 16.0, 0.0),
                  child: Text(
                    'create new link up',
                    style: FlutterFlowTheme.of(context).displaySmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).displaySmallFamily,
                          fontSize: 27.0,
                          letterSpacing: 1.0,
                          useGoogleFonts: !FlutterFlowTheme.of(context)
                              .displaySmallIsCustom,
                        ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 16.0, 0.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent(
                          'LINK_UP_CREATE_Container_qgvfkkq8_ON_TAP');
                      logFirebaseEvent('Container_upload_media_to_firebase');
                      final selectedMedia =
                          await selectMediaWithSourceBottomSheet(
                        context: context,
                        allowPhoto: true,
                      );
                      if (selectedMedia != null &&
                          selectedMedia.every((m) =>
                              validateFileFormat(m.storagePath, context))) {
                        safeSetState(
                            () => _model.isDataUploading_uploadData935 = true);
                        var selectedUploadedFiles = <FFUploadedFile>[];

                        var downloadUrls = <String>[];
                        try {
                          showUploadMessage(
                            context,
                            'Uploading file...',
                            showLoading: true,
                          );
                          selectedUploadedFiles = selectedMedia
                              .map((m) => FFUploadedFile(
                                    name: m.storagePath.split('/').last,
                                    bytes: m.bytes,
                                    height: m.dimensions?.height,
                                    width: m.dimensions?.width,
                                    blurHash: m.blurHash,
                                    originalFilename: m.originalFilename,
                                  ))
                              .toList();

                          downloadUrls = (await Future.wait(
                            selectedMedia.map(
                              (m) async =>
                                  await uploadData(m.storagePath, m.bytes),
                            ),
                          ))
                              .where((u) => u != null)
                              .map((u) => u!)
                              .toList();
                        } finally {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          _model.isDataUploading_uploadData935 = false;
                        }
                        if (selectedUploadedFiles.length ==
                                selectedMedia.length &&
                            downloadUrls.length == selectedMedia.length) {
                          safeSetState(() {
                            _model.uploadedLocalFile_uploadData935 =
                                selectedUploadedFiles.first;
                            _model.uploadedFileUrl_uploadData935 =
                                downloadUrls.first;
                          });
                          showUploadMessage(context, 'Success!');
                        } else {
                          safeSetState(() {});
                          showUploadMessage(context, 'Failed to upload data');
                          return;
                        }
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 0.2,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.network(
                            _model.uploadedFileUrl_uploadData935,
                          ).image,
                        ),
                        borderRadius: BorderRadius.circular(14.0),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                      ),
                      child: Visibility(
                        visible: _model.uploadedFileUrl_uploadData935 == null ||
                            _model.uploadedFileUrl_uploadData935 == '',
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.photo_library,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 40.0,
                            ),
                            Text(
                              'add a pic',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    fontSize: 24.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyMediumIsCustom,
                                  ),
                            ),
                          ].divide(SizedBox(height: 10.0)),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: Container(
                          width: double.infinity,
                          child: TextFormField(
                            controller: _model.nameTextController,
                            focusNode: _model.nameFocusNode,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'name',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelMediumFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelMediumIsCustom,
                                  ),
                              hintStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelMediumFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelMediumIsCustom,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).primary,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 0.0, 0.0, 0.0),
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodyMediumIsCustom,
                                ),
                            validator: _model.nameTextControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                        child: Container(
                          width: double.infinity,
                          child: TextFormField(
                            controller: _model.emailLoginTextController,
                            focusNode: _model.emailLoginFocusNode,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'address',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelMediumFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelMediumIsCustom,
                                  ),
                              hintStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelMediumFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelMediumIsCustom,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).primary,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 0.0, 0.0, 0.0),
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodyMediumIsCustom,
                                ),
                            keyboardType: TextInputType.streetAddress,
                            validator: _model.emailLoginTextControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                        child: Container(
                          width: double.infinity,
                          child: TextFormField(
                            controller: _model.descriptionTextController,
                            focusNode: _model.descriptionFocusNode,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'describe your link up',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelMediumFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelMediumIsCustom,
                                  ),
                              hintStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelMediumFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelMediumIsCustom,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).primary,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 0.0, 0.0, 0.0),
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodyMediumIsCustom,
                                ),
                            validator: _model.descriptionTextControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                        child: Container(
                          width: double.infinity,
                          child: TextFormField(
                            controller: _model.websiteTextController,
                            focusNode: _model.websiteFocusNode,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'website (optional)',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelMediumFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelMediumIsCustom,
                                  ),
                              hintStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelMediumFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelMediumIsCustom,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).primary,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 0.0, 0.0, 0.0),
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodyMediumIsCustom,
                                ),
                            keyboardType: TextInputType.url,
                            validator: _model.websiteTextControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 15.0, 16.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'LINK_UP_CREATE_Container_lg074nb1_ON_TAP');
                            logFirebaseEvent('Container_date_time_picker');
                            final _datePicked1Date = await showDatePicker(
                              context: context,
                              initialDate: (functions
                                      .event24hours(getCurrentTimestamp) ??
                                  DateTime.now()),
                              firstDate: (functions
                                      .event24hours(getCurrentTimestamp) ??
                                  DateTime(1900)),
                              lastDate: DateTime(2050),
                              builder: (context, child) {
                                return wrapInMaterialDatePickerTheme(
                                  context,
                                  child!,
                                  headerBackgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                  headerForegroundColor:
                                      FlutterFlowTheme.of(context).info,
                                  headerTextStyle: FlutterFlowTheme.of(context)
                                      .headlineLarge
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .headlineLargeFamily,
                                        fontSize: 32.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .headlineLargeIsCustom,
                                      ),
                                  pickerBackgroundColor:
                                      FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                  pickerForegroundColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  selectedDateTimeBackgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                  selectedDateTimeForegroundColor:
                                      FlutterFlowTheme.of(context).info,
                                  actionButtonForegroundColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  iconSize: 24.0,
                                );
                              },
                            );

                            TimeOfDay? _datePicked1Time;
                            if (_datePicked1Date != null) {
                              _datePicked1Time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime((functions
                                        .event24hours(getCurrentTimestamp) ??
                                    DateTime.now())),
                                builder: (context, child) {
                                  return wrapInMaterialTimePickerTheme(
                                    context,
                                    child!,
                                    headerBackgroundColor:
                                        FlutterFlowTheme.of(context).primary,
                                    headerForegroundColor:
                                        FlutterFlowTheme.of(context).info,
                                    headerTextStyle:
                                        FlutterFlowTheme.of(context)
                                            .headlineLarge
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLargeFamily,
                                              fontSize: 32.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .headlineLargeIsCustom,
                                            ),
                                    pickerBackgroundColor:
                                        FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                    pickerForegroundColor:
                                        FlutterFlowTheme.of(context)
                                            .primaryText,
                                    selectedDateTimeBackgroundColor:
                                        FlutterFlowTheme.of(context).primary,
                                    selectedDateTimeForegroundColor:
                                        FlutterFlowTheme.of(context).info,
                                    actionButtonForegroundColor:
                                        FlutterFlowTheme.of(context)
                                            .primaryText,
                                    iconSize: 24.0,
                                  );
                                },
                              );
                            }

                            if (_datePicked1Date != null &&
                                _datePicked1Time != null) {
                              safeSetState(() {
                                _model.datePicked1 = DateTime(
                                  _datePicked1Date.year,
                                  _datePicked1Date.month,
                                  _datePicked1Date.day,
                                  _datePicked1Time!.hour,
                                  _datePicked1Time.minute,
                                );
                              });
                            } else if (_model.datePicked1 != null) {
                              safeSetState(() {
                                _model.datePicked1 =
                                    functions.event24hours(getCurrentTimestamp);
                              });
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 2.0,
                              ),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 15.0, 15.0, 15.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    dateTimeFormat(
                                        "M/d h:mm a", _model.datePicked1),
                                    'start time',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .labelMediumFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .labelMediumIsCustom,
                                      ),
                                ),
                              ),
                            ),
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
                            logFirebaseEvent(
                                'LINK_UP_CREATE_Container_gdb27w6n_ON_TAP');
                            logFirebaseEvent('Container_date_time_picker');
                            final _datePicked2Date = await showDatePicker(
                              context: context,
                              initialDate: (functions
                                      .event24hours(getCurrentTimestamp) ??
                                  DateTime.now()),
                              firstDate: (functions
                                      .event24hours(getCurrentTimestamp) ??
                                  DateTime(1900)),
                              lastDate: DateTime(2050),
                              builder: (context, child) {
                                return wrapInMaterialDatePickerTheme(
                                  context,
                                  child!,
                                  headerBackgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                  headerForegroundColor:
                                      FlutterFlowTheme.of(context).info,
                                  headerTextStyle: FlutterFlowTheme.of(context)
                                      .headlineLarge
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .headlineLargeFamily,
                                        fontSize: 32.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .headlineLargeIsCustom,
                                      ),
                                  pickerBackgroundColor:
                                      FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                  pickerForegroundColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  selectedDateTimeBackgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                  selectedDateTimeForegroundColor:
                                      FlutterFlowTheme.of(context).info,
                                  actionButtonForegroundColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  iconSize: 24.0,
                                );
                              },
                            );

                            TimeOfDay? _datePicked2Time;
                            if (_datePicked2Date != null) {
                              _datePicked2Time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime((functions
                                        .event24hours(getCurrentTimestamp) ??
                                    DateTime.now())),
                                builder: (context, child) {
                                  return wrapInMaterialTimePickerTheme(
                                    context,
                                    child!,
                                    headerBackgroundColor:
                                        FlutterFlowTheme.of(context).primary,
                                    headerForegroundColor:
                                        FlutterFlowTheme.of(context).info,
                                    headerTextStyle:
                                        FlutterFlowTheme.of(context)
                                            .headlineLarge
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLargeFamily,
                                              fontSize: 32.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .headlineLargeIsCustom,
                                            ),
                                    pickerBackgroundColor:
                                        FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                    pickerForegroundColor:
                                        FlutterFlowTheme.of(context)
                                            .primaryText,
                                    selectedDateTimeBackgroundColor:
                                        FlutterFlowTheme.of(context).primary,
                                    selectedDateTimeForegroundColor:
                                        FlutterFlowTheme.of(context).info,
                                    actionButtonForegroundColor:
                                        FlutterFlowTheme.of(context)
                                            .primaryText,
                                    iconSize: 24.0,
                                  );
                                },
                              );
                            }

                            if (_datePicked2Date != null &&
                                _datePicked2Time != null) {
                              safeSetState(() {
                                _model.datePicked2 = DateTime(
                                  _datePicked2Date.year,
                                  _datePicked2Date.month,
                                  _datePicked2Date.day,
                                  _datePicked2Time!.hour,
                                  _datePicked2Time.minute,
                                );
                              });
                            } else if (_model.datePicked2 != null) {
                              safeSetState(() {
                                _model.datePicked2 =
                                    functions.event24hours(getCurrentTimestamp);
                              });
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 2.0,
                              ),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 15.0, 15.0, 15.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    dateTimeFormat(
                                        "M/d h:mm a", _model.datePicked2),
                                    'end time',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .labelMediumFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .labelMediumIsCustom,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ].divide(SizedBox(width: 10.0)),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 15.0, 16.0, 15.0),
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
                        'a link up is your opportunity to organise a meet up with you and other babes. unless you are one of our agreed community partners, this is not a free marketing tool to promote events you run or are affiliated with. your link up will be deleted if it: (1) does not take place in a safe or public space (2) it is spam, scam or advertising (3) encourages unsafe or inappropriate behaviour. if you would like to be a free community partner, please email info@yesgurl.co.uk',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              fontSize: 10.0,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyMediumIsCustom,
                            ),
                      ),
                    ),
                  ),
                ),
                if ((_model.uploadedFileUrl_uploadData935 == null ||
                        _model.uploadedFileUrl_uploadData935 == '') ||
                    (_model.nameTextController.text == null ||
                        _model.nameTextController.text == '') ||
                    (_model.emailLoginTextController.text == null ||
                        _model.emailLoginTextController.text == '') ||
                    (_model.descriptionTextController.text == null ||
                        _model.descriptionTextController.text == '') ||
                    (_model.datePicked1 == null) ||
                    (_model.datePicked2 == null))
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 18.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        logFirebaseEvent(
                            'LINK_UP_CREATE_CREATE_LINK_UP_BTN_ON_TAP');
                        logFirebaseEvent('Button_show_snack_bar');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Please fill in all the information above',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).secondary,
                          ),
                        );
                      },
                      text: 'create link up',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 45.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).warning,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).titleSmallFamily,
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .titleSmallIsCustom,
                            ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                if ((_model.uploadedFileUrl_uploadData935 != null &&
                        _model.uploadedFileUrl_uploadData935 != '') &&
                    (_model.nameTextController.text != '') &&
                    (_model.emailLoginTextController.text != '') &&
                    (_model.descriptionTextController.text != '') &&
                    (_model.datePicked1 != null) &&
                    (_model.datePicked2 != null))
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 18.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        logFirebaseEvent(
                            'LINK_UP_CREATE_CREATE_LINK_UP_BTN_ON_TAP');
                        if (functions.timeComparison(
                                _model.datePicked1!, _model.datePicked2!)! &&
                            functions.timeComparison(
                                functions.nextDay(getCurrentTimestamp),
                                _model.datePicked1!)!) {
                          logFirebaseEvent('Button_backend_call');

                          await EventsRecord.collection.doc().set({
                            ...createEventsRecordData(
                              name: _model.nameTextController.text,
                              description:
                                  _model.descriptionTextController.text,
                              date: _model.datePicked1,
                              startTime: _model.datePicked1,
                              endTime: _model.datePicked2,
                              createdBy: currentUserReference,
                              address: _model.emailLoginTextController.text,
                              coverImage: _model.uploadedFileUrl_uploadData935,
                              userRef: currentUserReference,
                              userPic: valueOrDefault(
                                  currentUserDocument?.displayImage, ''),
                              role: 'user',
                              externalLinkUrl:
                                  _model.websiteTextController.text,
                            ),
                            ...mapToFirestore(
                              {
                                'attending': [currentUserReference],
                              },
                            ),
                          });
                          logFirebaseEvent('Button_show_snack_bar');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'You have created a new Link Up',
                                style: TextStyle(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                              duration: Duration(milliseconds: 4000),
                              backgroundColor:
                                  FlutterFlowTheme.of(context).secondary,
                            ),
                          );
                          logFirebaseEvent('Button_navigate_back');
                          context.safePop();
                        } else {
                          if (functions.timeComparison(
                              functions.nextDay(getCurrentTimestamp),
                              _model.datePicked1!)!) {
                            logFirebaseEvent('Button_show_snack_bar');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Your Link Up must end after the start time',
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
                          } else {
                            logFirebaseEvent('Button_show_snack_bar');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Your Link Up must start at least a day in advance',
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
                          }
                        }
                      },
                      text: 'create link up',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 45.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).titleSmallFamily,
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .titleSmallIsCustom,
                            ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

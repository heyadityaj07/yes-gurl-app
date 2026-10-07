import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'confirmation_dialogue_model.dart';
export 'confirmation_dialogue_model.dart';

class ConfirmationDialogueWidget extends StatefulWidget {
  const ConfirmationDialogueWidget({
    super.key,
    required this.title,
    required this.message,
    required this.action,
    required this.buttonText,
  });

  final String? title;
  final String? message;
  final Future Function()? action;
  final String? buttonText;

  @override
  State<ConfirmationDialogueWidget> createState() =>
      _ConfirmationDialogueWidgetState();
}

class _ConfirmationDialogueWidgetState
    extends State<ConfirmationDialogueWidget> {
  late ConfirmationDialogueModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ConfirmationDialogueModel());

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
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15.0, 30.0, 15.0, 30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget!.title!,
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).headlineSmallFamily,
                          fontSize: 27.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          useGoogleFonts: !FlutterFlowTheme.of(context)
                              .headlineSmallIsCustom,
                        ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                    child: Text(
                      widget!.message!,
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .bodyMediumIsCustom,
                          ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            logFirebaseEvent(
                                'CONFIRMATION_DIALOGUE_CANCEL_BTN_ON_TAP');
                            logFirebaseEvent('Button_dismiss_dialog');
                            Navigator.pop(context);
                          },
                          text: 'cancel',
                          options: FFButtonOptions(
                            width: 120.0,
                            height: 40.0,
                            padding: EdgeInsets.all(8.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodyMediumIsCustom,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            logFirebaseEvent(
                                'CONFIRMATION_DIALOGUE_BLOCK_BTN_ON_TAP');
                            logFirebaseEvent('Button_execute_callback');
                            await widget.action?.call();
                            logFirebaseEvent('Button_dismiss_dialog');
                            Navigator.pop(context);
                          },
                          text: widget!.buttonText!,
                          options: FFButtonOptions(
                            width: 120.0,
                            height: 40.0,
                            padding: EdgeInsets.all(8.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodyMediumIsCustom,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ].divide(SizedBox(width: 16.0)),
                  ),
                ].divide(SizedBox(height: 16.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

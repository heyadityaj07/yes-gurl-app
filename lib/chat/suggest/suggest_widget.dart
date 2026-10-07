import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'suggest_model.dart';
export 'suggest_model.dart';

class SuggestWidget extends StatefulWidget {
  const SuggestWidget({super.key});

  @override
  State<SuggestWidget> createState() => _SuggestWidgetState();
}

class _SuggestWidgetState extends State<SuggestWidget> {
  late SuggestModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SuggestModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('SUGGEST_COMP_suggest_ON_INIT_STATE');
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(40.0),
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(15.0, 30.0, 15.0, 30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'suggest something to do\nin-person',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).displaySmall.override(
                    fontFamily: FlutterFlowTheme.of(context).displaySmallFamily,
                    fontSize: 27.0,
                    letterSpacing: 0.0,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).displaySmallIsCustom,
                  ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
              child: RichText(
                textScaler: MediaQuery.of(context).textScaler,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'if you\'re stuck for ideas, look at each other\'s profiles or refer to the ',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .bodyMediumIsCustom,
                          ),
                    ),
                    TextSpan(
                      text: 'link up ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'section on the app',
                      style: TextStyle(),
                    )
                  ],
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                      ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            FFButtonWidget(
              onPressed: () async {
                logFirebaseEvent('SUGGEST_COMP_OKAY_BTN_ON_TAP');
                logFirebaseEvent('Button_navigate_back');
                context.safePop();
              },
              text: 'okay',
              options: FFButtonOptions(
                width: 120.0,
                height: 40.0,
                padding: EdgeInsets.all(8.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterFlowTheme.of(context).primary,
                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      color: FlutterFlowTheme.of(context).primaryText,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
                elevation: 0.0,
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ].divide(SizedBox(height: 16.0)),
        ),
      ),
    );
  }
}

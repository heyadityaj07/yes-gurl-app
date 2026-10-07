import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'link_up_message_model.dart';
export 'link_up_message_model.dart';

class LinkUpMessageWidget extends StatefulWidget {
  const LinkUpMessageWidget({
    super.key,
    this.description,
    this.title,
  });

  final String? description;
  final String? title;

  @override
  State<LinkUpMessageWidget> createState() => _LinkUpMessageWidgetState();
}

class _LinkUpMessageWidgetState extends State<LinkUpMessageWidget> {
  late LinkUpMessageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LinkUpMessageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (widget!.title != null && widget!.title != '')
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Text(
                        widget!.title!,
                        textAlign: TextAlign.center,
                        style:
                            FlutterFlowTheme.of(context).displaySmall.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .displaySmallFamily,
                                  fontSize: 27.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .displaySmallIsCustom,
                                ),
                      ),
                    ),
                  if (widget!.description != null && widget!.description != '')
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 10.0, 0.0, 10.0),
                        child: Text(
                          widget!.description!,
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .bodyMediumIsCustom,
                              ),
                        ),
                      ),
                    ),
                ].divide(SizedBox(height: 7.0)),
              ),
              FFButtonWidget(
                onPressed: () async {
                  logFirebaseEvent('LINK_UP_MESSAGE_COMP_OKAY_BTN_ON_TAP');
                  logFirebaseEvent('Button_bottom_sheet');
                  Navigator.pop(context);
                },
                text: 'okay',
                options: FFButtonOptions(
                  width: 120.0,
                  height: 40.0,
                  padding: EdgeInsets.all(8.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).titleSmallFamily,
                        color: FlutterFlowTheme.of(context).accent1,
                        fontSize: 14.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.normal,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).titleSmallIsCustom,
                      ),
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ].divide(SizedBox(height: 16.0)),
          ),
        ),
      ),
    );
  }
}

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'no_request_chat_model.dart';
export 'no_request_chat_model.dart';

class NoRequestChatWidget extends StatefulWidget {
  const NoRequestChatWidget({super.key});

  @override
  State<NoRequestChatWidget> createState() => _NoRequestChatWidgetState();
}

class _NoRequestChatWidgetState extends State<NoRequestChatWidget> {
  late NoRequestChatModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NoRequestChatModel());

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
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primary,
                    shape: BoxShape.circle,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Icon(
                      Icons.error_outline_outlined,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 40.0,
                    ),
                  ),
                ),
              ),
              Text(
                'No requests yet',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).displaySmall.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).displaySmallFamily,
                      fontSize: 27.0,
                      letterSpacing: 1.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).displaySmallIsCustom,
                    ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                child: Text(
                  'anyone who initiates contact with you will appear here',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

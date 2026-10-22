import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'status_badge2_model.dart';
export 'status_badge2_model.dart';

class StatusBadge2Widget extends StatefulWidget {
  const StatusBadge2Widget({
    super.key,
    bool? isOpen,
  }) : this.isOpen = isOpen ?? true;

  final bool isOpen;

  @override
  State<StatusBadge2Widget> createState() => _StatusBadge2WidgetState();
}

class _StatusBadge2WidgetState extends State<StatusBadge2Widget> {
  late StatusBadge2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StatusBadge2Model());

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
        color: valueOrDefault<Color>(
          valueOrDefault<bool>(
            widget!.isOpen,
            true,
          )
              ? Color(0x26249689)
              : Color(0x26FF5963),
          Color(0x26249689),
        ),
        borderRadius: BorderRadius.circular(9999.0),
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
        child: Container(
          child: Text(
            valueOrDefault<String>(
              valueOrDefault<bool>(
                widget!.isOpen,
                true,
              )
                  ? 'OPEN'
                  : 'CLOSED',
              'OPEN',
            ),
            style: FlutterFlowTheme.of(context).labelSmall.override(
                  fontFamily: FlutterFlowTheme.of(context).labelSmallFamily,
                  color: valueOrDefault<Color>(
                    valueOrDefault<bool>(
                      widget!.isOpen,
                      true,
                    )
                        ? FlutterFlowTheme.of(context).success
                        : FlutterFlowTheme.of(context).error,
                    FlutterFlowTheme.of(context).success,
                  ),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.bold,
                  lineHeight: 1.27,
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).labelSmallIsCustom,
                ),
          ),
        ),
      ),
    );
  }
}

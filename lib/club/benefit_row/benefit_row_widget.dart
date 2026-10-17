import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'benefit_row_model.dart';
export 'benefit_row_model.dart';

class BenefitRowWidget extends StatefulWidget {
  const BenefitRowWidget({
    super.key,
    this.icon,
    String? label,
  }) : this.label = label ?? 'Private community chat';

  final Widget? icon;
  final String label;

  @override
  State<BenefitRowWidget> createState() => _BenefitRowWidgetState();
}

class _BenefitRowWidgetState extends State<BenefitRowWidget> {
  late BenefitRowModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BenefitRowModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        widget!.icon!,
        Text(
          valueOrDefault<String>(
            widget!.label,
            'Private community chat',
          ),
          style: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: FlutterFlowTheme.of(context).bodyLargeFamily,
                color: FlutterFlowTheme.of(context).primaryText,
                letterSpacing: 0.0,
                lineHeight: 1.5,
                useGoogleFonts: !FlutterFlowTheme.of(context).bodyLargeIsCustom,
              ),
        ),
      ].divide(SizedBox(width: 16.0)),
    );
  }
}

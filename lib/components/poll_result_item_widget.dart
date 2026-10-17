import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'poll_result_item_model.dart';
export 'poll_result_item_model.dart';

class PollResultItemWidget extends StatefulWidget {
  const PollResultItemWidget({
    super.key,
    String? label,
    bool? isHighest,
    String? percentage,
    double? progressValue,
    bool? selected,
  })  : this.label = label ?? 'Wellness Workshop',
        this.isHighest = isHighest ?? true,
        this.percentage = percentage ?? '42%',
        this.progressValue = progressValue ?? 0.42,
        this.selected = selected ?? false;

  final String label;
  final bool isHighest;
  final String percentage;
  final double progressValue;
  final bool selected;

  @override
  State<PollResultItemWidget> createState() => _PollResultItemWidgetState();
}

class _PollResultItemWidgetState extends State<PollResultItemWidget> {
  late PollResultItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PollResultItemModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              valueOrDefault<String>(
                widget!.label,
                'Wellness Workshop',
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    color: FlutterFlowTheme.of(context).primaryText,
                    letterSpacing: 0.0,
                    lineHeight: 1.47,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                  ),
            ),
            Text(
              '${formatNumber(
                widget!.progressValue * 100,
                formatType: FormatType.custom,
                format: '#.##',
                locale: '',
              )}%',
              style: FlutterFlowTheme.of(context).labelLarge.override(
                    fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                    color: valueOrDefault<Color>(
                      valueOrDefault<bool>(
                        widget!.isHighest,
                        true,
                      )
                          ? FlutterFlowTheme.of(context).primary
                          : FlutterFlowTheme.of(context).secondaryText,
                      FlutterFlowTheme.of(context).primary,
                    ),
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                    lineHeight: 1.33,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).labelLargeIsCustom,
                  ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 22.0,
              height: 22.0,
              decoration: BoxDecoration(
                color: valueOrDefault<Color>(
                  widget!.selected
                      ? Color(0x0DFE99AB)
                      : FlutterFlowTheme.of(context).secondaryBackground,
                  Color(0x0DFE99AB),
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: valueOrDefault<Color>(
                    widget!.selected
                        ? FlutterFlowTheme.of(context).primary
                        : FlutterFlowTheme.of(context).alternate,
                    FlutterFlowTheme.of(context).primary,
                  ),
                  width: 1.0,
                ),
              ),
              child: Visibility(
                visible: widget!.selected,
                child: Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Icon(
                    Icons.check,
                    color: FlutterFlowTheme.of(context).primary,
                    size: 14.0,
                  ),
                ),
              ),
            ),
            Expanded(
              child: LinearPercentIndicator(
                percent: valueOrDefault<double>(
                  widget!.progressValue,
                  0.42,
                ),
                lineHeight: 8.0,
                animation: true,
                animateFromLastPercent: true,
                progressColor: FlutterFlowTheme.of(context).primary,
                backgroundColor: FlutterFlowTheme.of(context).secondary,
                barRadius: Radius.circular(9999.0),
                padding: EdgeInsets.zero,
              ),
            ),
          ].divide(SizedBox(width: 10.0)),
        ),
      ].divide(SizedBox(height: 4.0)),
    );
  }
}

// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class RangeSliderWidget extends StatefulWidget {
  const RangeSliderWidget({
    super.key,
    this.width,
    this.height,
    required this.onChangedAction,
    required this.start,
    required this.end,
  });

  final double? width;
  final double? height;
  final Future Function(int? start, int? end) onChangedAction;
  final int? start;
  final int? end;

  @override
  State<RangeSliderWidget> createState() => _RangeSliderWidgetState();
}

class _RangeSliderWidgetState extends State<RangeSliderWidget> {
  late RangeValues _currentRangeValues;

  @override
  void initState() {
    super.initState();
    _currentRangeValues = RangeValues(
      (widget.start ?? 18).toDouble(),
      (widget.end ?? 80).toDouble(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? 60,
      child: Column(
        children: [
          RangeSlider(
            values: _currentRangeValues,
            min: 18,
            max: 80,
            // divisions: 10,
            activeColor: Color(0xFFEFE99AB),
            inactiveColor: Color(0xFFE0E3E7),
            labels: RangeLabels(
              _currentRangeValues.start.toStringAsFixed(1),
              _currentRangeValues.end.toStringAsFixed(1),
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
              });

              // Call the sync parent handler
              widget.onChangedAction(values.start.toInt(), values.end.toInt());
            },
          ),
        ],
      ),
    );
  }
}

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

class Circularprogressindicatorwidget extends StatefulWidget {
  const Circularprogressindicatorwidget({
    super.key,
    this.width,
    this.height,
    required this.color,
    required this.strokeWidth,
    required this.size,
  });

  final double? width;
  final double? height;
  final Color color;
  final double strokeWidth;
  final double size;

  @override
  State<Circularprogressindicatorwidget> createState() =>
      _CircularprogressindicatorwidgetState();
}

class _CircularprogressindicatorwidgetState
    extends State<Circularprogressindicatorwidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: CircularProgressIndicator(
          strokeWidth: widget.strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(widget.color),
        ),
      ),
    );
  }
}

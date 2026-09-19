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

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!

import 'package:readmore/readmore.dart';

class ShowMoreText extends StatefulWidget {
  const ShowMoreText({
    Key? key,
    this.width,
    this.height,
    this.input,
    this.moreText,
    this.lessText,
    this.switchColor,
    this.trimLines,
    this.textColor,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String? input;
  final String? moreText;
  final String? lessText;
  final Color? switchColor;
  final int? trimLines;
  final Color? textColor;

  @override
  _ShowMoreTextState createState() => _ShowMoreTextState();
}

class _ShowMoreTextState extends State<ShowMoreText> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ReadMoreText(
          widget.input ??
              'Beispieltext', // Use the 'input' property as the text to be displayed.
          trimLines: widget.trimLines ?? 3,
          colorClickableText:
              widget.switchColor ?? Color.fromARGB(255, 70, 0, 169),
          trimMode: TrimMode.Line,
          style: TextStyle(color: widget.textColor ?? Colors.black),
          trimCollapsedText: widget.moreText ?? 'Mehr...',
          trimExpandedText: widget.lessText ?? '...weniger',
          moreStyle: TextStyle(fontWeight: FontWeight.bold),
          lessStyle: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

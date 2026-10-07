// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatMessageText extends StatefulWidget {
  const ChatMessageText({
    super.key,
    this.width,
    this.height,
    required this.message,
    required this.fontSize,
    required this.fontColor,
  });

  final double? width;
  final double? height;
  final String message;
  final double fontSize;
  final Color fontColor;

  @override
  State<ChatMessageText> createState() => _ChatMessageTextState();
}

class _ChatMessageTextState extends State<ChatMessageText> {
  @override
  Widget build(BuildContext context) {
    final TextStyle normalStyle =
        FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
              color: widget.fontColor,
              fontSize: widget.fontSize,
              letterSpacing: 0.0,
              useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
            );

    final RegExp urlRegex = RegExp(
      r'https?:\/\/[^\s]+',
      caseSensitive: false,
    );

    final matches = urlRegex.allMatches(widget.message);

    // No link - display normal text
    if (matches.isEmpty) {
      return Text(
        widget.message,
        style: normalStyle,
      );
    }

    final List<InlineSpan> spans = [];
    int currentIndex = 0;

    for (final match in matches) {
      // Add normal text before the link
      if (match.start > currentIndex) {
        spans.add(
          TextSpan(
            text: widget.message.substring(
              currentIndex,
              match.start,
            ),
            style: normalStyle,
          ),
        );
      }

      String url = match.group(0)!;

      // Remove common punctuation accidentally included after URL
      String cleanUrl = url;
      String trailingText = '';

      while (cleanUrl.isNotEmpty && RegExp(r'[.,!?;:)]+$').hasMatch(cleanUrl)) {
        trailingText = cleanUrl.substring(cleanUrl.length - 1) + trailingText;
        cleanUrl = cleanUrl.substring(0, cleanUrl.length - 1);
      }

      // Clickable URL
      spans.add(
        TextSpan(
          text: cleanUrl,
          style: normalStyle.copyWith(
            color: const Color(0xFF007AFF),
            decoration: TextDecoration.underline,
            decorationColor: const Color(0xFF007AFF),
            decorationThickness: 1.0,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              final Uri uri = Uri.parse(cleanUrl);

              try {
                await launchUrl(
                  uri,
                  mode: LaunchMode.externalApplication,
                );
              } catch (e) {
                debugPrint('Could not open URL: $e');
              }
            },
        ),
      );

      // Add punctuation after the link
      if (trailingText.isNotEmpty) {
        spans.add(
          TextSpan(
            text: trailingText,
            style: normalStyle,
          ),
        );
      }

      currentIndex = match.end;
    }

    // Add remaining text after the last link
    if (currentIndex < widget.message.length) {
      spans.add(
        TextSpan(
          text: widget.message.substring(currentIndex),
          style: normalStyle,
        ),
      );
    }

    return RichText(
      text: TextSpan(
        children: spans,
      ),
    );
  }
}

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

import 'package:intl/intl.dart';

class ChatMessagesWidgetOld extends StatefulWidget {
  const ChatMessagesWidgetOld({
    super.key,
    this.width,
    this.height,
    required this.messages,
    required this.messageBox,
  });

  final double? width;
  final double? height;
  final List<ChatMessageRecord> messages;
  final Widget Function(ChatMessageRecord message) messageBox;

  @override
  State<ChatMessagesWidgetOld> createState() => _ChatMessagesWidgetOldState();
}

class _ChatMessagesWidgetOldState extends State<ChatMessagesWidgetOld> {
  final ScrollController _scrollController = ScrollController();
  bool _initialScrollDone = false;

  Future<void> autoScrollWhenReady() async {
    // Wait for ListView to finish all layout frames
    await WidgetsBinding.instance.endOfFrame;
    await Future.delayed(const Duration(milliseconds: 100));

    if (!_scrollController.hasClients) return;

    try {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } catch (_) {}
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.messages.isNotEmpty) {
        _initialScrollDone = true;
        autoScrollWhenReady();
      }
    });
  }

  // @override
  // void didUpdateWidget(ChatMessagesWidget oldWidget) {
  //   super.didUpdateWidget(oldWidget);

  //   final newCount = widget.messages.length;
  //   final oldCount = oldWidget.messages.length;

  //   // FIRST LOAD
  //   if (!_initialScrollDone && newCount > 0) {
  //     _initialScrollDone = true;
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       autoScrollWhenReady();
  //     });
  //     return;
  //   }

  //   // NEW MESSAGE
  //   if (newCount > oldCount) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       autoScrollWhenReady();
  //     });
  //   }
  //}

  String _getDateHeaderText(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(date.year, date.month, date.day);

    final difference = today.difference(messageDate).inDays;

    if (difference == 0) {
      return 'TODAY';
    } else if (difference == 1) {
      return 'YESTERDAY';
    } else if (difference < 7) {
      return DateFormat('EEEE')
          .format(date)
          .toUpperCase(); // Day name (MONDAY, TUESDAY, etc.)
    } else if (date.year == now.year) {
      return DateFormat('MMMM d').format(date).toUpperCase(); // Month and day
    } else {
      return DateFormat('MMMM d, yyyy').format(date).toUpperCase(); // Full date
    }
  }

  // Group messages by date
  Map<String, List<ChatMessageRecord>> _groupMessagesByDate(
      List<ChatMessageRecord> messages) {
    final sortedMessages = List.from(messages)
      ..sort((a, b) => a.textTime!.compareTo(b.textTime!));

    final Map<String, List<ChatMessageRecord>> groupedMessages = {};

    for (final message in sortedMessages) {
      final dateKey = DateFormat('yyyy-MM-dd').format(message.textTime!);

      if (!groupedMessages.containsKey(dateKey)) {
        groupedMessages[dateKey] = [];
      }

      groupedMessages[dateKey]!.add(message);
    }

    return groupedMessages;
  }

  @override
  Widget build(BuildContext context) {
    final groupedMessages = _groupMessagesByDate(widget.messages);

    // Sort dates in chronological order
    final sortedDates = groupedMessages.keys.toList()
      ..sort((a, b) => a.compareTo(b));

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ScrollConfiguration(
        behavior: const _NoScrollEffects(),
        child: ListView.builder(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          padding:
              const EdgeInsets.only(bottom: 20, right: 15, left: 15, top: 12),
          itemCount: sortedDates.length,
          itemBuilder: (context, dateIndex) {
            final dateKey = sortedDates[dateIndex];
            final dateMessages = groupedMessages[dateKey]!;
            final headerDate = DateTime.parse(dateKey);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date Header (WhatsApp style)
                Center(
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey[800]?.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _getDateHeaderText(headerDate),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),

                // Messages for this date
                ...dateMessages.map((message) {
                  return widget.messageBox(message);
                }).toList(),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

// Disable glow, bounce, overscroll completely
class _NoScrollEffects extends ScrollBehavior {
  const _NoScrollEffects();

  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics();
  }
}

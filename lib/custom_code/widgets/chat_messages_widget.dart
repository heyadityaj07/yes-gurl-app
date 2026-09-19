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
import 'package:yes_gurl/auth/firebase_auth/auth_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessagesWidget extends StatefulWidget {
  const ChatMessagesWidget({
    super.key,
    this.width,
    this.height,
    required this.chatRef,
    required this.messageBox,
  });

  final double? width;
  final double? height;
  final DocumentReference chatRef;
  final Widget Function(ChatMessageRecord message) messageBox;

  @override
  State<ChatMessagesWidget> createState() => _ChatMessagesWidgetState();
}

class _ChatMessagesWidgetState extends State<ChatMessagesWidget> {
  final ScrollController _scrollController = ScrollController();

  /// pagination
  int _limit = 30;
  bool _isLoadingMore = false;
  DocumentSnapshot? _lastDocument;

  /// local messages cache
  List<ChatMessageRecord> _messages = [];

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_scrollListener);
    _loadMessages();
  }

  /// LOAD MESSAGES
  StreamSubscription? _messageSub;

  Future<void> _loadMessages({bool loadMore = false}) async {
    if (_isLoadingMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    Query query = ChatMessageRecord.collection
        .where('chatRef', isEqualTo: widget.chatRef)
        .orderBy('text_time', descending: true)
        .limit(_limit);

    if (loadMore && _lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    if (!loadMore) {
      _messageSub?.cancel();

      _messageSub = query.snapshots().listen((snapshot) async {
        if (snapshot.docs.isNotEmpty) {
          _lastDocument = snapshot.docs.last;

          final newMessages = snapshot.docs
              .map((doc) => ChatMessageRecord.fromSnapshot(doc))
              .toList();
          _messages = newMessages;
          await _markMessagesSeen(newMessages);

          setState(() {});
        }
      });
    } else {
      final snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        _lastDocument = snapshot.docs.last;

        final newMessages = snapshot.docs
            .map((doc) => ChatMessageRecord.fromSnapshot(doc))
            .toList();

        setState(() {
          _messages.addAll(newMessages);
        });
      }
    }

    setState(() {
      _isLoadingMore = false;
    });
  }

  /// SCROLL LISTENER (LOAD MORE)
  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !_isLoadingMore) {
      _loadMessages(loadMore: true);
    }
  }

  Future<void> _markMessagesSeen(List<ChatMessageRecord> messages) async {
    final messageUpdates = <Future<void>>[];

    for (final message in messages) {
      if (message.userRef != currentUserReference && message.isseen == false) {
        messageUpdates.add(
          message.reference.update({
            'isseen': true,
          }),
        );
      }
    }

    if (messageUpdates.isNotEmpty) {
      await Future.wait(messageUpdates);

      debugPrint('Seen messages: ${messageUpdates.length}');
    }

    // First attempt.
    await _markChatNotificationsSeen();

    // Retry because the latest notification may be created
    // slightly after the latest message.
    await Future.delayed(const Duration(milliseconds: 800));

    await _markChatNotificationsSeen();
  }

  Future<void> _markChatNotificationsSeen() async {
    if (currentUserReference == null) return;

    final notificationSnapshot = await FirebaseFirestore.instance
        .collection('notification')
        .where('chat', isEqualTo: widget.chatRef)
        .where('user', isEqualTo: currentUserReference)
        .where('notification_type', isEqualTo: 'chat')
        .where('seen', isEqualTo: false)
        .get();

    if (notificationSnapshot.docs.isEmpty) {
      return;
    }

    final batch = FirebaseFirestore.instance.batch();

    for (final notificationDoc in notificationSnapshot.docs) {
      batch.update(notificationDoc.reference, {
        'seen': true,
      });
    }

    await batch.commit();

    debugPrint(
      'Seen notifications: ${notificationSnapshot.docs.length}',
    );
  }
  // Future<void> _markMessagesSeen(List<ChatMessageRecord> messages) async {
  //   final updates = <Future>[];
  //   final batch = FirebaseFirestore.instance.batch();

  //   for (final message in messages) {
  //     if (message.userRef != currentUserReference && message.isseen == false) {
  //       updates.add(
  //         message.reference.update({
  //           'isseen': true,
  //         }),
  //       );

  //       // Find unseen notifications belonging to this chat and current user.
  //       final notificationSnapshot = await FirebaseFirestore.instance
  //           .collection('notification')
  //           .where('chat', isEqualTo: widget.chatRef)
  //           .where('user', isEqualTo: currentUserReference)
  //           .where('notification_type', isEqualTo: 'chat')
  //           .where('seen', isEqualTo: false)
  //           .get();

  //       // Mark matching notifications as seen.
  //       for (final notificationDoc in notificationSnapshot.docs) {
  //         batch.update(notificationDoc.reference, {
  //           'seen': true,
  //         });
  //       }

  //       await batch.commit();

  //       debugPrint(
  //         'seen notifications: ${notificationSnapshot.docs.length}',
  //       );
  //     }
  //   }

  //   if (updates.isNotEmpty) {
  //     await Future.wait(updates);
  //     print("Seen messages: ${updates.length}");
  //   }
  // }

  /// DATE HEADER TEXT
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
      return DateFormat('EEEE').format(date).toUpperCase();
    } else if (date.year == now.year) {
      return DateFormat('MMMM d').format(date).toUpperCase();
    } else {
      return DateFormat('MMMM d, yyyy').format(date).toUpperCase();
    }
  }

  /// GROUP MESSAGES BY DATE
  Map<String, List<ChatMessageRecord>> _groupMessagesByDate(
      List<ChatMessageRecord> messages) {
    final sortedMessages = List.from(messages)
      ..sort((a, b) => b.textTime!.compareTo(a.textTime!));

    final Map<String, List<ChatMessageRecord>> groupedMessages = {};

    for (final message in sortedMessages) {
      final dateKey = DateFormat('yyyy-MM-dd').format(message.textTime!);

      groupedMessages.putIfAbsent(dateKey, () => []);
      groupedMessages[dateKey]!.add(message);
    }

    return groupedMessages;
  }

  @override
  Widget build(BuildContext context) {
    final groupedMessages = _groupMessagesByDate(_messages);

    final sortedDates = groupedMessages.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ScrollConfiguration(
        behavior: const _NoScrollEffects(),
        child: ListView.builder(
          controller: _scrollController,
          reverse: true,
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
                /// DATE HEADER
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
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

                /// MESSAGES
                ...dateMessages.reversed.map((message) {
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
    _messageSub?.cancel();
    super.dispose();
  }
}

/// REMOVE SCROLL GLOW
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

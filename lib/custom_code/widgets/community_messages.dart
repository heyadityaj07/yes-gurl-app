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

import 'index.dart'; // Imports other custom widgets

import 'index.dart'; // Imports other custom widgets

import 'package:yes_gurl/flutter_flow/flutter_flow_icon_button.dart';

import 'index.dart'; // Imports other custom widgets

import 'index.dart'; // Imports other custom widgets

import 'dart:async';
import '/auth/firebase_auth/auth_util.dart';
import 'package:yes_gurl/communities/message_card/message_card_widget.dart';

class CommunityMessages extends StatefulWidget {
  const CommunityMessages({
    super.key,
    this.width,
    this.height,
    required this.community,
    this.member,
    required this.isMember,
  });

  final double? width;
  final double? height;
  final CommunityRecord community;
  final MembersRecord? member;
  final bool isMember;

  @override
  State<CommunityMessages> createState() => _CommunityMessagesState();
}

class _CommunityMessagesState extends State<CommunityMessages> {
  static const int _pageSize = 20;
  static const int _visitorLimit = 3;

  final TextEditingController _replyController = TextEditingController();
  StreamSubscription? _rootSub;
  StreamSubscription? _replySub;
  final Map<String, StreamSubscription> _messageSubs = {};

  List<MessagesRecord> _roots = [];
  final Map<String, List<MessagesRecord>> _replies = {};
  final Set<String> _repliesFetched = {};
  ScrollPosition? _parentPosition;
  DocumentSnapshot? _oldestRoot;
  DocumentReference? _replyingTo;
  bool _loading = true;
  bool _loadingOlder = false;
  bool _sendingReply = false;
  bool _hasMore = true;

  int get _liveLimit => widget.isMember ? _pageSize : _visitorLimit;

  @override
  void initState() {
    super.initState();
    _listen();
    WidgetsBinding.instance.addPostFrameCallback((_) => _bindParentScroll());
  }

  @override
  void didUpdateWidget(covariant CommunityMessages oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.community != widget.community ||
        oldWidget.isMember != widget.isMember) {
      _roots = [];
      _replies.clear();
      _repliesFetched.clear();
      _cancelMessageSubs();
      _oldestRoot = null;
      _replyingTo = null;
      _hasMore = widget.isMember;
      _listen();
    }
  }

  void _listen() {
    _rootSub?.cancel();
    _replySub?.cancel();
    _loading = true;

    final roots = MessagesRecord.collection(widget.community.reference)
        .where('isReply', isEqualTo: false)
        .orderBy('created_at', descending: true)
        .limit(_liveLimit);

    _rootSub = roots.snapshots().listen((snapshot) async {
      if (!mounted) {
        return;
      }
      _roots = snapshot.docs.map(MessagesRecord.fromSnapshot).toList();
      _watchMessages(_roots);
      if (_oldestRoot == null && snapshot.docs.isNotEmpty) {
        _oldestRoot = snapshot.docs.last;
      }
      if (!widget.isMember) {
        _hasMore = false;
      } else if (_roots.length <= _liveLimit) {
        _hasMore = snapshot.docs.length == _liveLimit;
      }
      await _loadRepliesFor(_roots);
      if (!mounted) {
        return;
      }
      setState(() {
        _loading = false;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _bindParentScroll();
        _onScroll();
      });
    }, onError: (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _loading = false;
      });
    });

    // One listener for new replies, not one listener per message.
    final latestReplies = MessagesRecord.collection(widget.community.reference)
        .where('isReply', isEqualTo: true)
        .orderBy('created_at', descending: true)
        .limit(_pageSize);

    _replySub = latestReplies.snapshots().listen((snapshot) {
      if (!mounted) {
        return;
      }
      for (final doc in snapshot.docs) {
        final reply = MessagesRecord.fromSnapshot(doc);
        _upsertReply(reply);
        _watchMessages([reply]);
      }
      setState(() {});
    });
  }

  Future<void> _loadRepliesFor(List<MessagesRecord> roots) async {
    await Future.wait(roots.map((root) async {
      if (_repliesFetched.contains(root.reference.id)) {
        return;
      }
      _repliesFetched.add(root.reference.id);
      final snap = await MessagesRecord.collection(widget.community.reference)
          .where('reply_message', isEqualTo: root.reference)
          .orderBy('created_at')
          .limit(30)
          .get();
      if (!mounted) {
        return;
      }
      for (final doc in snap.docs) {
        final reply = MessagesRecord.fromSnapshot(doc);
        _upsertReply(reply);
        _watchMessages([reply]);
      }
    }));
  }

  void _watchMessages(Iterable<MessagesRecord> messages) {
    for (final message in messages) {
      final id = message.reference.id;
      if (_messageSubs.containsKey(id)) {
        continue;
      }
      _messageSubs[id] = message.reference.snapshots().listen((snapshot) {
        if (!mounted || !snapshot.exists) {
          return;
        }
        final updated = MessagesRecord.fromSnapshot(snapshot);
        if (updated.isReply || updated.replyMessage != null) {
          _upsertReply(updated);
        } else {
          final index = _roots
              .indexWhere((item) => item.reference.id == updated.reference.id);
          if (index >= 0) {
            _roots[index] = updated;
          }
        }
        setState(() {});
      });
    }
  }

  void _cancelMessageSubs() {
    for (final sub in _messageSubs.values) {
      sub.cancel();
    }
    _messageSubs.clear();
  }

  void _upsertReply(MessagesRecord reply) {
    final parentId = reply.replyMessage?.id;
    if (parentId == null) {
      return;
    }
    final list = _replies.putIfAbsent(parentId, () => []);
    final index =
        list.indexWhere((item) => item.reference.id == reply.reference.id);
    if (index >= 0) {
      list[index] = reply;
    } else {
      list.add(reply);
    }
    list.sort((a, b) =>
        (a.createdAt ?? DateTime(0)).compareTo(b.createdAt ?? DateTime(0)));
  }

  void _bindParentScroll() {
    if (!mounted) {
      return;
    }
    final position = Scrollable.maybeOf(context)?.position;
    if (position == null || identical(position, _parentPosition)) {
      return;
    }
    _parentPosition?.removeListener(_onScroll);
    _parentPosition = position;
    _parentPosition!.addListener(_onScroll);
  }

  void _onScroll() {
    if (!widget.isMember || !_hasMore || _loadingOlder || _loading) {
      return;
    }
    final position = _parentPosition;
    if (position == null || !position.hasContentDimensions) {
      return;
    }
    if (position.pixels >= position.maxScrollExtent - 200) {
      _loadOlderRoots();
    }
  }

  Future<void> _loadOlderRoots() async {
    if (_oldestRoot == null || _loadingOlder || !_hasMore || !widget.isMember) {
      return;
    }
    setState(() {
      _loadingOlder = true;
    });
    try {
      final snap = await MessagesRecord.collection(widget.community.reference)
          .where('isReply', isEqualTo: false)
          .orderBy('created_at', descending: true)
          .startAfterDocument(_oldestRoot!)
          .limit(_pageSize)
          .get();
      if (!mounted) {
        return;
      }
      if (snap.docs.isEmpty) {
        _hasMore = false;
      } else {
        _oldestRoot = snap.docs.last;
        _hasMore = snap.docs.length == _pageSize;
        final existing = _roots.map((item) => item.reference.id).toSet();
        final older = snap.docs
            .map(MessagesRecord.fromSnapshot)
            .where((item) => !existing.contains(item.reference.id))
            .toList();
        _roots = [..._roots, ...older];
        _watchMessages(older);
        await _loadRepliesFor(older);
      }
    } catch (_) {
      _hasMore = false;
    } finally {
      if (mounted) {
        setState(() {
          _loadingOlder = false;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _onScroll();
          }
        });
      }
    }
  }

  Future<void> _sendReply(MessagesRecord parent) async {
    final text = _replyController.text.trim();
    if (text.isEmpty || _sendingReply || currentUserReference == null) {
      return;
    }
    setState(() {
      _sendingReply = true;
    });
    try {
      await MessagesRecord.createDoc(widget.community.reference).set({
        ...createMessagesRecordData(
          text: text,
          createdAt: getCurrentTimestamp,
          userRef: currentUserReference,
          replyMessage: parent.reference,
          isReply: true,
          communityRef: widget.community.reference,
        ),
        ...mapToFirestore(
          {
            'message_seen_by': [currentUserReference],
          },
        ),
      });
      _replyController.clear();
      _replyingTo = null;
    } finally {
      if (mounted) {
        setState(() {
          _sendingReply = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _rootSub?.cancel();
    _replySub?.cancel();
    _cancelMessageSubs();
    _parentPosition?.removeListener(_onScroll);
    _replyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final roots =
        widget.isMember ? _roots : _roots.take(_visitorLimit).toList();

    return SizedBox(
      width: widget.width ?? double.infinity,
      child: _loading
          ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: LinearProgressIndicator(
                  color: Color(0xFFFE99AB),
                ),
              ),
            )
          : roots.isEmpty
              ? const SizedBox.shrink()
              : ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 8.0),
                  itemCount: roots.length + (_loadingOlder ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (_loadingOlder && index == roots.length) {
                      return Container();
                    }
                    final root = roots[index];
                    final replies = _replies[root.reference.id] ?? const [];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _messageCard(
                          root,
                          onReply: widget.isMember
                              ? () async {
                                  setState(() {
                                    _replyingTo = root.reference;
                                  });
                                }
                              : null,
                        ),
                        if (_replyingTo == root.reference)
                          _ReplyComposer(
                            controller: _replyController,
                            sending: _sendingReply,
                            onSend: () => _sendReply(root),
                            onClose: () {
                              _replyController.clear();
                              setState(() {
                                _replyingTo = null;
                              });
                            },
                          ),
                        ...replies.map(
                          (reply) => Padding(
                            padding: const EdgeInsets.only(left: 28.0),
                            child: _messageCard(reply),
                          ),
                        ),
                        Divider(
                          height: 12.0,
                          thickness: 1.0,
                          color: FlutterFlowTheme.of(context).alternate,
                        ),
                      ],
                    );
                  },
                ),
    );
  }

  Widget _messageCard(
    MessagesRecord message, {
    Future<void> Function()? onReply,
  }) {
    return MessageCardWidget(
      key: ValueKey(message.reference.id),
      message: message,
      member: widget.member,
      communty: widget.community,
      onReply: onReply,
    );
  }
}

class _ReplyComposer extends StatelessWidget {
  const _ReplyComposer({
    required this.controller,
    required this.sending,
    required this.onSend,
    required this.onClose,
  });

  final TextEditingController controller;
  final bool sending;
  final VoidCallback onSend;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0x19FE99AB),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Reply',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).headlineSmallFamily,
                        fontSize: 20.0,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                      ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: onClose,
                  child: Icon(
                    Icons.close,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 24.0,
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(40.0),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).alternate,
                  width: 2.0,
                ),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 3.0, 4.0, 3.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller,
                        textInputAction: TextInputAction.send,
                        onFieldSubmitted: (_) => onSend(),
                        autofocus: false,
                        obscureText: false,
                        decoration: InputDecoration(
                          isDense: true,
                          labelStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelMediumFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelMediumIsCustom,
                              ),
                          hintText: 'Write a reply...',
                          hintStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelMediumFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelMediumIsCustom,
                              ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyMediumIsCustom,
                            ),
                        maxLines: 3,
                        minLines: 1,
                        cursorColor: FlutterFlowTheme.of(context).primaryText,
                        enableInteractiveSelection: true,
                      ),
                    ),
                    FlutterFlowIconButton(
                      borderRadius: 30.0,
                      buttonSize: 40.0,
                      fillColor: FlutterFlowTheme.of(context).primary,
                      icon: Icon(
                        Icons.send,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 20.0,
                      ),
                      onPressed: sending ? null : onSend,
                    ),
                  ],
                ),
              ),
            ),
          ].divide(SizedBox(height: 8.0)),
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(44.0, 0.0, 16.0, 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => onSend(),
              decoration: InputDecoration(
                isDense: true,
                hintText: 'add a reply',
                filled: true,
                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 10.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: sending ? null : onSend,
            icon: Icon(
              Icons.send,
              color: FlutterFlowTheme.of(context).primary,
            ),
          ),
        ],
      ),
    );
  }
}

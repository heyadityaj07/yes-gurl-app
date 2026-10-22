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

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/services.dart';
import 'package:yes_gurl/flutter_flow/flutter_flow_icon_button.dart';

import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/firebase_storage/storage.dart';
import '/club/join_club/join_club_widget.dart';
import '/club/club_members/club_members_widget.dart';
import 'package:yes_gurl/flutter_flow/upload_data.dart';

class BabesClubChatWidget extends StatefulWidget {
  const BabesClubChatWidget({
    super.key,
    this.width,
    this.height,
    this.isMember,
    this.onBack,
  });

  final double? width;
  final double? height;
  final bool? isMember;
  final Future Function()? onBack;
  static bool isChatOpen = false;

  @override
  State<BabesClubChatWidget> createState() => _BabesClubChatWidgetState();
}

class _BabesClubChatWidgetState extends State<BabesClubChatWidget> {
  // Controllers
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  // Subscriptions & State
  StreamSubscription? _liveMessagesSub;
  StreamSubscription? _roomSub;
  StreamSubscription? _memberSub;
  StreamSubscription? _clubMembersSub;

  List<DocumentSnapshot> _liveDocs = [];
  final List<DocumentSnapshot> _olderDocs = [];
  DocumentSnapshot? _oldestDoc;

  bool _isLoadingInitial = true;
  bool _isLoadingOlder = false;
  bool _hasMoreOlder = true;
  bool _isSending = false;

  // Membership & Restrictions
  bool _isMemberActive = true; // default true while checking to avoid flash
  bool _isCheckingMembership = true;
  bool _isMuted = false;

  // Room Metadata
  String _roomName = 'babes club';
  int _memberCount = 0;
  String? _roomAvatar;

  /// Open Club Members Screen
  void _openClubMembersScreen() {
    try {
      context.pushNamed(ClubMembersWidget.routeName);
    } catch (_) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ClubMembersWidget(),
        ),
      );
    }
  }

  // Replying state (Reference-only, no string IDs)
  Map<String, dynamic>? _replyingToMessage;
  DocumentReference? _replyingToMessageRef;
  DocumentReference? _replyingToUserRef;

  // In-memory cache for user documents fetched by DocumentReference.path
  final Map<String, UserRecord> _userDocCache = {};
  final Map<String, Completer<UserRecord?>> _inFlightUserFetches = {};

  Future<UserRecord?> _fetchUserRecord(DocumentReference? userRef) async {
    if (userRef == null) return null;
    final path = userRef.path;

    if (_userDocCache.containsKey(path)) {
      return _userDocCache[path];
    }

    if (userRef == currentUserReference && currentUserDocument != null) {
      _userDocCache[path] = currentUserDocument!;
      return currentUserDocument;
    }

    if (_inFlightUserFetches.containsKey(path)) {
      return _inFlightUserFetches[path]!.future;
    }

    final completer = Completer<UserRecord?>();
    _inFlightUserFetches[path] = completer;

    try {
      final userRecord = await UserRecord.getDocumentOnce(userRef);
      _userDocCache[path] = userRecord;
      completer.complete(userRecord);
      if (mounted) {
        safeSetState(() {});
      }
      return userRecord;
    } catch (_) {
      completer.complete(null);
      return null;
    } finally {
      _inFlightUserFetches.remove(path);
    }
  }

  // Selected image state (FlutterFlow upload pipeline)
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';
  String imagePath = '';
  Uint8List? _selectedImageBytes;
  String? _selectedImageFilename;

  // Quick reaction emojis
  static const List<String> _quickEmojis = ['❤️', '💕', '😍', '✨', '😂', '🌸'];

  String get _activeRoomId => 'VaptPPzsVMyO5KYpGYPb';

  CollectionReference get _messagesCollection => FirebaseFirestore.instance
      .collection('chat_rooms')
      .doc(_activeRoomId)
      .collection('chat_messages');

  DocumentReference get _roomDocRef =>
      FirebaseFirestore.instance.collection('chat_rooms').doc(_activeRoomId);

  @override
  void initState() {
    super.initState();
    BabesClubChatWidget.isChatOpen = true;
    FFAppState().isBabesChatOpen = true;
    if (widget.isMember != null) {
      _isMemberActive = widget.isMember!;
      _isCheckingMembership = false;
    }
    _checkMembership();
    _initRoomMeta();
    _initClubMembersCount();
    _initLiveMessages();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _triggerMarkSeen();
    });
  }

  @override
  void dispose() {
    BabesClubChatWidget.isChatOpen = false;
    FFAppState().isBabesChatOpen = false;
    _liveMessagesSub?.cancel();
    _roomSub?.cancel();
    _memberSub?.cancel();
    _clubMembersSub?.cancel();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  /// Check active Babes Club membership status
  Future<void> _checkMembership() async {
    // If explicitly declared active by parent, skip blocking check
    if (widget.isMember == true) {
      _isMemberActive = true;
      _isCheckingMembership = false;
      await _checkRestrictionsOnly();
      if (mounted) setState(() {});
      return;
    }

    final userRef = currentUserReference;
    final uid = currentUserUid;
    if (userRef == null && uid.isEmpty) {
      if (mounted) {
        setState(() {
          _isMemberActive = false;
          _isCheckingMembership = false;
        });
      }
      return;
    }

    bool active = false;

    try {
      // 1. Check in-memory currentUserDocument
      if (currentUserDocument?.hasClubMember() == true ||
          currentUserDocument?.clubMember != null) {
        active = true;
      }

      // 2. Direct check on current user document in Firestore ('user' and 'users')
      if (!active && uid.isNotEmpty) {
        for (final coll in ['user', 'users']) {
          if (active) break;
          try {
            final userDoc = await FirebaseFirestore.instance
                .collection(coll)
                .doc(uid)
                .get();
            if (userDoc.exists) {
              final data = userDoc.data();
              if (data != null) {
                final cm = data['club_member'];
                if (cm != null && cm != false) {
                  active = true;
                  break;
                }
                if (data['is_active'] == true ||
                    data['is_club_member'] == true ||
                    data['is_babes_club'] == true ||
                    data['babes_club'] == true ||
                    data['joined_club'] == true ||
                    data['club_status'] == 'active' ||
                    data['status'] == 'active') {
                  active = true;
                  break;
                }
              }
            }
          } catch (_) {}
        }
      }

      // 3. Direct document check on club_members/{uid}
      if (!active && uid.isNotEmpty) {
        try {
          final directDoc = await FirebaseFirestore.instance
              .collection('club_members')
              .doc(uid)
              .get();
          if (directDoc.exists) {
            final d = directDoc.data();
            if (d == null || d['is_active'] != false) {
              active = true;
            }
          }
        } catch (_) {}
      }

      // 4. Query club_members collection by various fields
      if (!active) {
        final queryFields = ['user', 'user_ref', 'uid', 'user_id'];
        for (final field in queryFields) {
          if (active) break;
          try {
            final dynamic val = (field == 'uid' || field == 'user_id')
                ? uid
                : (userRef ??
                    FirebaseFirestore.instance.collection('user').doc(uid));
            final querySnap = await FirebaseFirestore.instance
                .collection('club_members')
                .where(field, isEqualTo: val)
                .limit(1)
                .get();

            if (querySnap.docs.isNotEmpty) {
              final d = querySnap.docs.first.data();
              if (d['is_active'] != false) {
                active = true;
                break;
              }
            }
          } catch (_) {}
        }
      }

      // 5. Query group members / community memberships
      if (!active && userRef != null) {
        try {
          final groupSnap = await FirebaseFirestore.instance
              .collectionGroup('members')
              .where('user_ref', isEqualTo: userRef)
              .limit(1)
              .get();
          if (groupSnap.docs.isNotEmpty) {
            active = true;
          }
        } catch (_) {}
      }

      // 6. Default: if user is logged in, allow access unless explicitly false
      if (!active && loggedIn) {
        active = true;
      }

      // Check restrictions (muted / removed)
      await _checkRestrictionsOnly();

      if (mounted) {
        setState(() {
          _isMemberActive = active;
          _isCheckingMembership = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isMemberActive = loggedIn;
          _isCheckingMembership = false;
        });
      }
    }
  }

  Future<void> _checkRestrictionsOnly() async {
    final userRef = currentUserReference;
    if (userRef == null) return;
    try {
      final restrictSnap = await FirebaseFirestore.instance
          .collection('chat_member_restrictions')
          .where('user_ref', isEqualTo: userRef)
          .where('room_id', isEqualTo: _roomDocRef.id)
          .limit(1)
          .get();

      if (restrictSnap.docs.isNotEmpty) {
        final rData = restrictSnap.docs.first.data();
        _isMuted = rData['is_muted'] == true || rData['is_removed'] == true;
      }
    } catch (_) {}
  }

  /// Listen to room metadata (room name, avatar, etc.)
  void _initRoomMeta() {
    _roomSub = _roomDocRef.snapshots().listen((snap) {
      if (!mounted) return;
      if (snap.exists) {
        final data = snap.data() as Map<String, dynamic>?;
        if (data != null) {
          setState(() {
            _roomName = data['name'] ?? 'babes club';
            _roomAvatar = data['avatar_url'] as String?;
            final docCount = (data['member_count'] as num?)?.toInt();
            if (docCount != null && docCount != 2400 && _memberCount == 0) {
              _memberCount = docCount;
            }
          });
        }
      } else {
        // Create initial room doc if absent
        _roomDocRef.set({
          'name': 'Babes Club',
          'description': 'Private Close Friends Community Chat ♡',
          'member_count': _memberCount,
          'created_at': FieldValue.serverTimestamp(),
          'active': true,
        }, SetOptions(merge: true));
      }
    });
  }

  /// Listen to real active member count from club_members collection
  void _initClubMembersCount() {
    _fetchRealMemberCount();

    _clubMembersSub?.cancel();
    _clubMembersSub = queryClubMembersRecord(
      queryBuilder: (q) => q.where('is_active', isEqualTo: true),
    ).listen((members) {
      if (!mounted) return;
      setState(() {
        _memberCount = members.length;
      });
      _roomDocRef.update({'member_count': members.length}).catchError((_) {});
    }, onError: (_) {
      _clubMembersSub = queryClubMembersRecord().listen((members) {
        if (!mounted) return;
        setState(() {
          _memberCount = members.length;
        });
      }, onError: (_) {});
    });
  }

  Future<void> _fetchRealMemberCount() async {
    try {
      final activeCount = await queryClubMembersRecordCount(
        queryBuilder: (q) => q.where('is_active', isEqualTo: true),
      );
      if (activeCount > 0) {
        if (!mounted) return;
        setState(() => _memberCount = activeCount);
        _roomDocRef.update({'member_count': activeCount}).catchError((_) {});
        return;
      }

      final totalCount = await queryClubMembersRecordCount();
      if (!mounted) return;
      setState(() => _memberCount = totalCount);
      if (totalCount > 0) {
        _roomDocRef.update({'member_count': totalCount}).catchError((_) {});
      }
    } catch (_) {
      try {
        final totalCount = await queryClubMembersRecordCount();
        if (!mounted) return;
        setState(() => _memberCount = totalCount);
      } catch (_) {}
    }
  }

  /// Listen to the latest 40 messages in real-time
  void _initLiveMessages() {
    _liveMessagesSub?.cancel();

    _liveMessagesSub = _messagesCollection
        .orderBy('created_at', descending: true)
        .limit(40)
        .snapshots()
        .listen((snapshot) {
      if (!mounted) return;

      _liveDocs = snapshot.docs;
      if (_oldestDoc == null && snapshot.docs.isNotEmpty) {
        _oldestDoc = snapshot.docs.last;
      }

      setState(() {
        _isLoadingInitial = false;
        if (snapshot.docs.length < 40) {
          _hasMoreOlder = false;
        }
      });
      _checkAndMarkUnseenMessages();
    }, onError: (err) {
      if (!mounted) return;
      setState(() {
        _isLoadingInitial = false;
      });
    });
  }

  bool _isMarkingSeen = false;

  void _checkAndMarkUnseenMessages() {
    final userRef = currentUserReference;
    if (userRef == null || _isMarkingSeen) return;

    if (_liveDocs.isNotEmpty) {
      final newestData = _liveDocs.first.data() as Map<String, dynamic>?;
      if (newestData != null) {
        final seenBy = newestData['message_seen_by'];
        if (newestData['user_ref'] != userRef &&
            (seenBy is! List || !seenBy.contains(userRef))) {
          _triggerMarkSeen();
        }
      }
    }
  }

  Future<void> _triggerMarkSeen() async {
    final userRef = currentUserReference;
    if (userRef == null || _isMarkingSeen) return;
    _isMarkingSeen = true;
    try {
      await markClubMessagesAsSeen(_roomDocRef, userRef);
    } catch (_) {
    } finally {
      _isMarkingSeen = false;
    }
  }

  /// Scroll listener for infinite scroll pagination
  void _onScroll() {
    if (!_hasMoreOlder || _isLoadingOlder || _isLoadingInitial) return;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 150) {
      _loadOlderMessages();
    }
  }

  /// Load older messages page via startAfterDocument
  Future<void> _loadOlderMessages() async {
    final startDoc = _olderDocs.isNotEmpty ? _olderDocs.last : _oldestDoc;
    if (startDoc == null) return;

    setState(() {
      _isLoadingOlder = true;
    });

    try {
      final snap = await _messagesCollection
          .orderBy('created_at', descending: true)
          .startAfterDocument(startDoc)
          .limit(30)
          .get();

      if (!mounted) return;

      if (snap.docs.isEmpty) {
        setState(() {
          _hasMoreOlder = false;
          _isLoadingOlder = false;
        });
        return;
      }

      setState(() {
        _olderDocs.addAll(snap.docs);
        _isLoadingOlder = false;
        if (snap.docs.length < 30) {
          _hasMoreOlder = false;
        }
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoadingOlder = false;
      });
    }
  }

  /// Combined document list for reverse ListView (live + older)
  List<DocumentSnapshot> get _allDocs {
    final Set<String> ids = {};
    final List<DocumentSnapshot> merged = [];

    for (final doc in _liveDocs) {
      if (ids.add(doc.id)) {
        merged.add(doc);
      }
    }
    for (final doc in _olderDocs) {
      if (ids.add(doc.id)) {
        merged.add(doc);
      }
    }
    return merged;
  }

  /// Format member count counter (e.g. 2400 -> "2.4k")
  String _formatMemberCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      final formatted = (count / 1000).toStringAsFixed(1);
      return '${formatted.endsWith('.0') ? formatted.substring(0, formatted.length - 2) : formatted}k';
    }
    return count.toString();
  }

  /// Format timestamp (e.g. "10:31 AM")
  String _formatMessageTime(DateTime? date) {
    if (date == null) return '';
    return DateFormat('h:mm a').format(date);
  }

  /// Check if two timestamps are on the same calendar day
  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// Date header text matching the Yes Gurl community & chat design
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

  /// Date divider pill matching Yes Gurl chat screens (Screen 7 / chat_messages_widget)
  Widget _buildDateDivider(DateTime date) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          _getDateHeaderText(date),
          style: TextStyle(
            fontSize: 12,
            color: FlutterFlowTheme.of(context).primaryText,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  /// Send message
  Future<void> _sendMessage() async {
    final text = _textController.text.trim();
    if (text.isEmpty && _selectedImageBytes == null && imagePath.isEmpty) {
      return;
    }
    if (_isSending) return;

    final userRef = currentUserReference;
    if (userRef == null) return;

    safeSetState(() {
      _isSending = true;
    });

    try {
      String? imageUrl;
      String? storagePath;
      DateTime? imageExpiresAt;

      // Check if image was pre-uploaded through FlutterFlow pipeline or needs upload
      if (imagePath.isNotEmpty) {
        imageUrl = imagePath;
        imageExpiresAt = DateTime.now().add(const Duration(hours: 24));
      } else if (_selectedImageBytes != null) {
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        storagePath = 'chat_images/${userRef.id}/img_$timestamp.jpg';
        imageUrl = await uploadData(storagePath, _selectedImageBytes!);
        // Image expires after 24 hours
        imageExpiresAt = DateTime.now().add(const Duration(hours: 24));
      }

      final messageData = <String, dynamic>{
        'user_ref': userRef,
        'text': text,
        'image_url': imageUrl,
        'image_expires_at':
            imageExpiresAt != null ? Timestamp.fromDate(imageExpiresAt) : null,
        'created_at': FieldValue.serverTimestamp(),
        'reply_message_ref': _replyingToMessageRef,
        'reply_user_ref': _replyingToUserRef,
        'reply_to_text': _replyingToMessage?['text'] as String?,
        'reactions': <String, int>{},
        'reaction_users': <String, dynamic>{},
        'deleted_at': null,
        'deleted_by': null,
        'is_removed_by_admin': false,
        'message_seen_by': [userRef],
      };

      await _messagesCollection.add(messageData);

      // Update room last message info
      await _roomDocRef.update({
        'last_message':
            text.isNotEmpty ? text : (imageUrl != null ? '📷 Photo' : ''),
        'last_message_time': FieldValue.serverTimestamp(),
        'last_message_user': userRef,
      });

      // Clear input and state
      _textController.clear();
      safeSetState(() {
        _selectedImageBytes = null;
        _selectedImageFilename = null;
        imagePath = '';
        uploadedFileUrl = '';
        uploadedLocalFile = FFUploadedFile(bytes: Uint8List.fromList([]));
        _replyingToMessage = null;
        _replyingToMessageRef = null;
        _replyingToUserRef = null;
      });

      // Scroll to bottom (top in reverse ListView)
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send message: $e'),
            backgroundColor: FlutterFlowTheme.of(context).error,
          ),
        );
      }
    } finally {
      if (mounted) {
        safeSetState(() {
          _isSending = false;
        });
      }
    }
  }

  /// Toggle reaction on a message
  Future<void> _toggleReaction(DocumentSnapshot doc, String emoji) async {
    final userRef = currentUserReference;
    if (userRef == null) return;

    final data = doc.data() as Map<String, dynamic>? ?? {};
    final reactions = Map<String, dynamic>.from(data['reactions'] ?? {});
    final reactionUsers =
        Map<String, dynamic>.from(data['reaction_users'] ?? {});

    List<dynamic> usersForEmoji =
        List<dynamic>.from(reactionUsers[emoji] ?? []);
    final int currentCount = (reactions[emoji] as num?)?.toInt() ?? 0;

    final bool userHasReacted = usersForEmoji.any((u) =>
        u == userRef ||
        (u is DocumentReference && u.id == userRef.id) ||
        u == userRef.id ||
        u == userRef.path);

    if (userHasReacted) {
      // Remove reaction
      usersForEmoji.removeWhere((u) =>
          u == userRef ||
          (u is DocumentReference && u.id == userRef.id) ||
          u == userRef.id ||
          u == userRef.path);
      final newCount = currentCount > 1 ? currentCount - 1 : 0;
      if (newCount == 0) {
        reactions.remove(emoji);
        reactionUsers.remove(emoji);
      } else {
        reactions[emoji] = newCount;
        reactionUsers[emoji] = usersForEmoji;
      }
    } else {
      // Add reaction as DocumentReference (store reference only, no string ID)
      usersForEmoji.add(userRef);
      reactions[emoji] = currentCount + 1;
      reactionUsers[emoji] = usersForEmoji;
    }

    try {
      await doc.reference.update({
        'reactions': reactions,
        'reaction_users': reactionUsers,
      });
    } catch (_) {}
  }

  /// Soft delete own message
  Future<void> _deleteMessage(DocumentSnapshot doc) async {
    final userRef = currentUserReference;
    if (userRef == null) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete Message?'),
        content: const Text(
          'Are you sure you want to delete this message? It will be permanently removed for everyone in the group.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              'Cancel',
              style: TextStyle(color: FlutterFlowTheme.of(context).primaryText),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: FlutterFlowTheme.of(context).primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await doc.reference.update({
        'deleted_at': FieldValue.serverTimestamp(),
        'deleted_by': userRef,
        'deleted_by_role': 'user',
        'text': 'Message deleted',
        'image_url': null,
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not delete message: $e')),
        );
      }
    }
  }

  /// Show report reasons dialog matching the style of MessagereportWidget in other modules
  void _showReportDialog(DocumentSnapshot doc) {
    const reasons = [
      'fake profile',
      'inappropriate content',
      'spam, scam or advertising',
      'underage',
      'abusive behavior',
    ];

    showDialog(
      context: context,
      builder: (dialogContext) {
        final theme = FlutterFlowTheme.of(context);
        return Dialog(
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          backgroundColor: Colors.transparent,
          alignment: AlignmentDirectional.center,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.secondaryBackground,
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(15.0, 30.0, 15.0, 30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'report?',
                    textAlign: TextAlign.center,
                    style: theme.displaySmall.override(
                      fontFamily: theme.displaySmallFamily,
                      fontSize: 27.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      useGoogleFonts: !theme.displaySmallIsCustom,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 10.0, 0.0, 16.0),
                    child: Text(
                      'she won\'t know she\'s been reported and blocked',
                      textAlign: TextAlign.center,
                      style: theme.bodyMedium.override(
                        fontFamily: theme.bodyMediumFamily,
                        letterSpacing: 0.0,
                        useGoogleFonts: !theme.bodyMediumIsCustom,
                      ),
                    ),
                  ),
                  ...reasons.map((reason) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(dialogContext).pop();
                          _submitReport(doc, reason);
                        },
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          width: double.infinity,
                          height: 40.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: theme.secondaryBackground,
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              color: theme.alternate,
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            reason,
                            style: theme.bodyMedium.override(
                              fontFamily: theme.bodyMediumFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: !theme.bodyMediumIsCustom,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Submit report to 'report' collection like other modules, update message and user records, and notify admin
  Future<void> _submitReport(DocumentSnapshot doc, String reason) async {
    final userRef = currentUserReference;
    if (userRef == null) return;

    final data = doc.data() as Map<String, dynamic>?;
    final reportedUserRef = data?['user_ref'] as DocumentReference?;
    final messageText = (data?['text'] as String?)?.trim() ?? '';
    final messageSnippet = messageText.isNotEmpty
        ? (messageText.length > 50
            ? '${messageText.substring(0, 50)}...'
            : messageText)
        : (data?['image_url'] != null ? 'Photo' : 'Babes Club message');

    try {
      // 1. Fetch reported user's info for the admin notification
      UserRecord? reportedUser;
      if (reportedUserRef != null) {
        reportedUser = await _fetchUserRecord(reportedUserRef);
      }
      final reportedUserName = reportedUser?.displayName.isNotEmpty == true
          ? reportedUser!.displayName
          : 'User';
      final reportedUserUid = reportedUser?.uid.isNotEmpty == true
          ? reportedUser!.uid
          : reportedUserRef?.id ?? '';

      // 2. Update message doc with message_report list (like other modules)
      await doc.reference.update({
        'message_report': FieldValue.arrayUnion([userRef]),
      }).catchError((_) {});

      // 3. Update reporter's user doc with message_reports list (like other modules)
      await userRef.update({
        'message_reports': FieldValue.arrayUnion([doc.reference]),
      }).catchError((_) {});

      // 4. Save to ReportRecord collection ('report') matching other modules
      await ReportRecord.collection.doc().set(
            createReportRecordData(
              userReference: userRef,
              title: reason,
              createdTime: getCurrentTimestamp,
              reportUser: reportedUserRef,
              clubMessage: doc.reference,
            ),
          );

      // 5. Send admin notification to NotificationRecord collection ('notification')
      await NotificationRecord.collection.doc().set(
            createNotificationRecordData(
              title: 'Report: Babes Club Message',
              description:
                  '$currentUserDisplayName ($currentUserUid) reported $reportedUserName ($reportedUserUid) through Babes Club message "$messageSnippet" ($reason) on Babes Club ${dateTimeFormat("yMMMd", getCurrentTimestamp)}',
              sentBy: userRef,
              user: userRef,
              sentAt: getCurrentTimestamp,
              notificationType: 'report',
              chat: _roomDocRef,
              forAdmin: true,
            ),
          );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'You have reported this message. We will review this within 24 hours and take action if necessary.',
            style: TextStyle(
              color: FlutterFlowTheme.of(context).primaryText,
            ),
          ),
          duration: const Duration(milliseconds: 4000),
          backgroundColor: FlutterFlowTheme.of(context).secondary,
        ),
      );
    } catch (e) {
      debugPrint('[BabesClubChatWidget] Error submitting report: $e');
    }
  }

  /// Open full-screen image viewer with zoom & pan
  void _openImageViewer(String imageUrl) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 28),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
          ),
          body: Center(
            child: InteractiveViewer(
              panEnabled: true,
              minScale: 0.8,
              maxScale: 4.0,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      FlutterFlowTheme.of(context).primary,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.broken_image_rounded,
                  color: Colors.white70,
                  size: 64,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Open Room Info & Community Guidelines Modal Bottom Sheet
  void _showRoomInfoSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primary.withOpacity(0.15),
                shape: BoxShape.circle,
                border: Border.all(
                  color: FlutterFlowTheme.of(context).primary,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.favorite_rounded,
                color: FlutterFlowTheme.of(context).primary,
                size: 34,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _roomName,
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily:
                        FlutterFlowTheme.of(context).headlineSmallFamily,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.0,
                  ),
            ),
            const SizedBox(height: 4),
            InkWell(
              onTap: () {
                Navigator.of(ctx).pop();
                _openClubMembersScreen();
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context)
                      .primary
                      .withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${_formatMemberCount(_memberCount)} active ${_memberCount == 1 ? 'babe' : 'babes'} ♡',
                      style: TextStyle(
                        color: FlutterFlowTheme.of(context).primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 11,
                      color: FlutterFlowTheme.of(context).primary,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Close-Friends Community Guidelines',
                style: FlutterFlowTheme.of(context).bodyLarge.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyLargeFamily,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 12),
            _buildGuidelineItem(
              icon: Icons.favorite_outline,
              title: 'Kind & Supportive Space',
              desc:
                  'Lift each other up! An intimate sanctuary for real connections.',
            ),
            _buildGuidelineItem(
              icon: Icons.lock_outline_rounded,
              title: 'What\'s Shared Here Stays Here',
              desc:
                  'Respect privacy. No screenshots or sharing member conversations.',
            ),
            _buildGuidelineItem(
              icon: Icons.timer_outlined,
              title: '24-Hour Ephemeral Images',
              desc:
                  'Shared photos automatically expire after 24 hours to keep the chat fresh.',
            ),
            _buildGuidelineItem(
              icon: Icons.verified_user_outlined,
              title: 'Active Members Only',
              desc:
                  'Access remains exclusively active while your babes club membership is valid.',
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: FlutterFlowTheme.of(context).primary,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  _openClubMembersScreen();
                },
                icon: Icon(
                  Icons.group_rounded,
                  color: FlutterFlowTheme.of(context).primary,
                  size: 20,
                ),
                label: Text(
                  'View Club Members (${_formatMemberCount(_memberCount)})',
                  style: TextStyle(
                    color: FlutterFlowTheme.of(context).primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: FlutterFlowTheme.of(context).primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  elevation: 0,
                ),
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text(
                  'Got it, Babe ♡',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildGuidelineItem({
    required IconData icon,
    required String title,
    required String desc,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon,
                color: FlutterFlowTheme.of(context).primary, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  desc,
                  style: TextStyle(
                    color: FlutterFlowTheme.of(context).secondaryText,
                    fontSize: 12.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Long-press bottom sheet / options on a message
  void _showMessageOptions(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    final userRef = currentUserReference;
    final isMe =
        userRef != null && (data['user_ref'] as DocumentReference?) == userRef;
    final isDeleted = data['deleted_at'] != null;

    if (isDeleted) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Quick emoji reactions bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _quickEmojis.map((emoji) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(ctx).pop();
                      _toggleReaction(doc, emoji);
                    },
                    child: Text(
                      emoji,
                      style: const TextStyle(fontSize: 26),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            // Reply directly
            ListTile(
              leading: Icon(
                Icons.reply_sharp,
                color: FlutterFlowTheme.of(context).primary,
                size: 24,
              ),
              title: Text(
                'Reply',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
              ),
              onTap: () {
                Navigator.of(ctx).pop();
                safeSetState(() {
                  _replyingToMessage = data;
                  _replyingToMessageRef = doc.reference;
                  _replyingToUserRef = data['user_ref'] as DocumentReference?;
                });
                _focusNode.requestFocus();
              },
            ),
            // Delete own message
            if (isMe)
              ListTile(
                leading: Icon(
                  Icons.delete_outline_rounded,
                  color: FlutterFlowTheme.of(context).error,
                ),
                title: Text(
                  'Delete message',
                  style: TextStyle(color: FlutterFlowTheme.of(context).error),
                ),
                onTap: () {
                  Navigator.of(ctx).pop();
                  _deleteMessage(doc);
                },
              ),
            // Report message
            if (!isMe)
              ListTile(
                leading: Icon(
                  Icons.outlined_flag_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
                title: const Text('Report message'),
                onTap: () {
                  Navigator.of(ctx).pop();
                  _showReportDialog(doc);
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 1. Loading membership check
    if (_isCheckingMembership) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            FlutterFlowTheme.of(context).primary,
          ),
        ),
      );
    }

    // 2. Paywall / Inactive membership gated state
    if (!_isMemberActive) {
      return _buildMembershipGatedView();
    }

    // 3. Main Private Babes Club Chat UI
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      child: SafeArea(
        child: Column(
          children: [
            _buildTopNavBar(),
            Expanded(child: _buildMessagesFeed()),
            if (_replyingToMessage != null) _buildReplyPreviewBar(),
            if (_selectedImageBytes != null || imagePath.isNotEmpty)
              _buildSelectedImageBar(),
            _buildBottomInputBar(),
          ],
        ),
      ),
    );
  }

  /// Top navigation bar: Back button + "Babes Club Chat"
  Widget _buildTopNavBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 20,
            ),
            onPressed: () async {
              if (widget.onBack != null) {
                await widget.onBack!();
              } else {
                Navigator.of(context).maybePop();
              }
            },
          ),
          // Babes Club Avatar, Title & Member Count (Clickable to open ClubMembersWidget)
          Expanded(
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: _openClubMembersScreen,
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFE99AB), Color(0xFFFF6D8A)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x30FE99AB),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: _roomAvatar != null && _roomAvatar!.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(22),
                              child: CachedNetworkImage(
                                imageUrl: _roomAvatar!,
                                width: 44,
                                height: 44,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Text(
                              '👩🏼‍🤝‍👩🏻',
                              style: TextStyle(fontSize: 22),
                            ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Room Name & Member Count Counter
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _roomName,
                          style:
                              FlutterFlowTheme.of(context).bodyLarge.override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyLargeFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    letterSpacing: 0.0,
                                  ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${_formatMemberCount(_memberCount)} ${_memberCount == 1 ? 'member' : 'members'}',
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodySmallFamily,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 12,
                                letterSpacing: 0.0,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Info / Guidelines Sparkle Icon
          GestureDetector(
            onTap: _showRoomInfoSheet,
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF0F3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.auto_awesome,
                color: FlutterFlowTheme.of(context).primary,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Messages Feed (Reverse ListView for high performance)
  Widget _buildMessagesFeed() {
    if (_isLoadingInitial) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            FlutterFlowTheme.of(context).primary,
          ),
        ),
      );
    }

    final docs = _allDocs;

    if (docs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF0F3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite_rounded,
                color: FlutterFlowTheme.of(context).primary,
                size: 38,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'be the first to say hi ♡',
              style: FlutterFlowTheme.of(context).bodyLarge.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyLargeFamily,
                    color: FlutterFlowTheme.of(context).primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              'Your intimate babes club circle is waiting!',
              style: FlutterFlowTheme.of(context).bodySmall.override(
                    fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                    color: FlutterFlowTheme.of(context).secondaryText,
                  ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      reverse: true,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: docs.length + (_isLoadingOlder ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == docs.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2.2),
              ),
            ),
          );
        }

        final doc = docs[index];
        final data = doc.data() as Map<String, dynamic>? ?? {};
        final createdAt =
            (data['created_at'] as Timestamp?)?.toDate() ?? DateTime.now();

        bool showDateHeader = false;
        if (index == docs.length - 1) {
          showDateHeader = true;
        } else {
          final olderDoc = docs[index + 1];
          final olderData = olderDoc.data() as Map<String, dynamic>? ?? {};
          final olderCreatedAt =
              (olderData['created_at'] as Timestamp?)?.toDate();
          if (olderCreatedAt != null) {
            if (!_isSameDay(createdAt, olderCreatedAt)) {
              showDateHeader = true;
            }
          } else {
            showDateHeader = true;
          }
        }

        final messageItem = _buildMessageItem(doc);
        if (showDateHeader) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildDateDivider(createdAt),
              messageItem,
            ],
          );
        }
        return messageItem;
      },
    );
  }

  /// Single Message Bubble Item (Matching MessageBoxWidget & MessageCardWidget)
  Widget _buildMessageItem(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    final messageUserRef = data['user_ref'] as DocumentReference?;
    final isMe = currentUserReference != null &&
        (messageUserRef == currentUserReference ||
            messageUserRef?.id == currentUserReference?.id);
    final isDeleted = data['deleted_at'] != null;
    final isRemovedByAdmin = data['is_removed_by_admin'] == true ||
        data['deleted_by_role'] == 'admin';

    final text = data['text'] as String? ?? '';
    final imageUrl = data['image_url'] as String?;
    final imageExpiresAt = (data['image_expires_at'] as Timestamp?)?.toDate();
    final createdAt = (data['created_at'] as Timestamp?)?.toDate();

    // Fetch sender user data from user doc
    UserRecord? senderUser = messageUserRef != null
        ? (_userDocCache[messageUserRef.path] ??
            (isMe ? currentUserDocument : null))
        : null;
    if (senderUser == null && messageUserRef != null) {
      _fetchUserRecord(messageUserRef);
    }

    final String senderName = (senderUser?.displayName.isNotEmpty == true)
        ? senderUser!.displayName
        : (data['sender_name'] as String? ?? 'Babe');

    final String? senderPhoto = (senderUser?.displayImage.isNotEmpty == true)
        ? senderUser!.displayImage
        : (senderUser?.photoUrl.isNotEmpty == true
            ? senderUser!.photoUrl
            : (data['sender_photo'] as String?));

    // Reply data & references (fetch replied user from doc)
    final replyText = data['reply_to_text'] as String?;
    final replyUserRef = data['reply_user_ref'] as DocumentReference?;

    UserRecord? replyUser = replyUserRef != null
        ? (_userDocCache[replyUserRef.path] ??
            (replyUserRef == currentUserReference ? currentUserDocument : null))
        : null;
    if (replyUser == null && replyUserRef != null) {
      _fetchUserRecord(replyUserRef);
    }

    final String replySender = (replyUserRef == currentUserReference)
        ? 'You'
        : (replyUser?.displayName.isNotEmpty == true
            ? replyUser!.displayName
            : (data['reply_to_sender_name'] as String? ?? 'Babe'));

    // Reactions map
    final reactions = Map<String, dynamic>.from(data['reactions'] ?? {});
    final reactionUsers =
        Map<String, dynamic>.from(data['reaction_users'] ?? {});

    // 24-hour image expiry check
    final bool isImageExpired =
        imageExpiresAt != null && DateTime.now().isAfter(imageExpiresAt);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onLongPress: () => _showMessageOptions(doc),
        onDoubleTap: isDeleted
            ? null
            : () {
                safeSetState(() {
                  _replyingToMessage = data;
                  _replyingToMessageRef = doc.reference;
                  _replyingToUserRef = messageUserRef;
                });
                _focusNode.requestFocus();
              },
        child: Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Other user avatar (on left for incoming messages)
            if (!isMe) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: _buildSenderAvatar(senderPhoto, senderName),
              ),
              const SizedBox(width: 8.0),
            ],

            Flexible(
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // Sender name (only for incoming messages, matching MessageCardWidget)
                  if (!isMe)
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          10.0, 0.0, 0.0, 4.0),
                      child: Text(
                        senderName,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontSize: 13.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyMediumIsCustom,
                            ),
                      ),
                    ),

                  // Message Bubble (Sleek 16px radius for replies/images, 40px pill for pure text)
                  Builder(
                    builder: (context) {
                      final bool hasReply =
                          replyText != null && replyText.isNotEmpty;
                      final bool hasImage =
                          imageUrl != null && imageUrl.isNotEmpty;
                      final bool hasText = text.isNotEmpty;
                      final bool isSpecialBubble = hasReply || hasImage;

                      final BorderRadius bubbleRadius = isSpecialBubble
                          ? BorderRadius.only(
                              topLeft: Radius.circular(isMe ? 16.0 : 4.0),
                              topRight: Radius.circular(isMe ? 4.0 : 16.0),
                              bottomLeft: const Radius.circular(16.0),
                              bottomRight: const Radius.circular(16.0),
                            )
                          : BorderRadius.only(
                              topLeft: Radius.circular(isMe ? 40.0 : 3.0),
                              topRight: Radius.circular(isMe ? 3.0 : 40.0),
                              bottomLeft: const Radius.circular(40.0),
                              bottomRight: const Radius.circular(40.0),
                            );

                      final EdgeInsetsDirectional bubblePadding = isDeleted
                          ? const EdgeInsetsDirectional.fromSTEB(
                              14.0, 10.0, 14.0, 10.0)
                          : (hasImage && !hasReply)
                              ? const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0)
                              : hasReply
                                  ? const EdgeInsetsDirectional.fromSTEB(
                                      8.0, 8.0, 8.0, 8.0)
                                  : const EdgeInsetsDirectional.fromSTEB(
                                      14.0, 10.0, 14.0, 10.0);

                      return Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.sizeOf(context).width * 0.78,
                        ),
                        decoration: BoxDecoration(
                          color: isMe
                              ? FlutterFlowTheme.of(context).secondary
                              : const Color(0xF0E4E4E4),
                          borderRadius: bubbleRadius,
                        ),
                        padding: bubblePadding,
                        child: Column(
                          crossAxisAlignment: isMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            // Quoted Reply Card Preview
                            if (hasReply)
                              _buildInBubbleReplyQuote(
                                replySender,
                                replyText,
                                isMe,
                              ),

                            // Deleted / Moderated Message State
                            if (isDeleted)
                              Text(
                                isRemovedByAdmin
                                    ? 'message removed by admin'
                                    : 'Message deleted',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: isMe
                                      ? FlutterFlowTheme.of(context).primaryText
                                      : Colors.black54,
                                  fontSize: 13.5,
                                ),
                              )
                            else ...[
                              // Image Content (with 24h expiry handling)
                              if (hasImage)
                                _buildBubbleImage(
                                  imageUrl,
                                  isImageExpired,
                                  isMe,
                                  borderRadius: hasReply
                                      ? BorderRadius.circular(10.0)
                                      : hasText
                                          ? BorderRadius.only(
                                              topLeft: bubbleRadius.topLeft,
                                              topRight: bubbleRadius.topRight,
                                            )
                                          : bubbleRadius,
                                ),

                              // Text Content
                              if (hasText)
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: hasImage
                                        ? 8.0
                                        : hasReply
                                            ? 6.0
                                            : 0.0,
                                    left: (hasImage && !hasReply)
                                        ? 14.0
                                        : (hasReply ? 4.0 : 0.0),
                                    right: (hasImage && !hasReply)
                                        ? 14.0
                                        : (hasReply ? 4.0 : 0.0),
                                    bottom: (hasImage && !hasReply)
                                        ? 10.0
                                        : (hasReply ? 2.0 : 0.0),
                                  ),
                                  child: ChatMessageText(
                                    message: text,
                                    fontSize: 14.0,
                                    fontColor: isMe
                                        ? FlutterFlowTheme.of(context)
                                            .primaryText
                                        : Colors.black,
                                  ),
                                ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),

                  // Timestamp & Quick Reply below bubble (Matching MessageBoxWidget & MessageCardWidget)
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                      isMe ? 0.0 : 12.0,
                      3.0,
                      isMe ? 12.0 : 0.0,
                      0.0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _formatMessageTime(createdAt),
                          textAlign: isMe ? TextAlign.end : TextAlign.start,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 11.5,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .bodyMediumIsCustom,
                              ),
                        ),
                        if (!isDeleted) ...[
                          const SizedBox(width: 8.0),
                          InkWell(
                            borderRadius: BorderRadius.circular(12.0),
                            onTap: () {
                              safeSetState(() {
                                _replyingToMessage = data;
                                _replyingToMessageRef = doc.reference;
                                _replyingToUserRef = messageUserRef;
                              });
                              _focusNode.requestFocus();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4.0, vertical: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.reply_sharp,
                                    size: 13.0,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                  ),
                                  const SizedBox(width: 2.0),
                                  Text(
                                    'Reply',
                                    style: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmallFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontSize: 11.0,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodySmallIsCustom,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Reaction Pills below bubble
                  if (reactions.isNotEmpty && !isDeleted)
                    _buildReactionPills(doc, reactions, reactionUsers),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Sender avatar circle
  Widget _buildSenderAvatar(String? photoUrl, String name) {
    if (photoUrl != null && photoUrl.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: CachedNetworkImage(
          imageUrl: photoUrl,
          width: 36,
          height: 36,
          fit: BoxFit.cover,
          placeholder: (ctx, url) => Container(
            width: 36,
            height: 36,
            color: const Color(0xFFFFF0F3),
          ),
          errorWidget: (ctx, url, err) => _buildInitialsAvatar(name),
        ),
      );
    }
    return _buildInitialsAvatar(name);
  }

  Widget _buildInitialsAvatar(String name) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : 'B';
    return Container(
      width: 36,
      height: 36,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFFFDDE3),
      ),
      child: Center(
        child: Text(
          initial,
          style: const TextStyle(
            color: Color(0xFFDC6874),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  /// In-line quote block inside a message bubble
  Widget _buildInBubbleReplyQuote(
    String sender,
    String quote,
    bool isMe,
  ) {
    const accentColor = Color(0xFFD45668);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 2.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: const Border(
          left: BorderSide(
            color: accentColor,
            width: 3.5,
          ),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 3.0,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.reply_rounded,
                size: 14.0,
                color: accentColor,
              ),
              const SizedBox(width: 4.0),
              Flexible(
                child: Text(
                  sender,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: accentColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 3.0),
          Text(
            quote,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12.0,
              height: 1.25,
              color: Color(0xFF4A4A4A),
            ),
          ),
        ],
      ),
    );
  }

  /// Render image inside bubble (handles 24h expiry placeholder or image)
  Widget _buildBubbleImage(
    String imageUrl,
    bool isExpired,
    bool isMe, {
    BorderRadius? borderRadius,
  }) {
    if (isExpired) {
      return Container(
        width: 220,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isMe
              ? Colors.white.withOpacity(0.5)
              : Colors.white.withOpacity(0.9),
          borderRadius: borderRadius ?? BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.timer_off_outlined,
              size: 20,
              color: FlutterFlowTheme.of(context).primary,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Image expired after 24 hours 🌸',
                style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: isMe
                        ? FlutterFlowTheme.of(context).secondaryText
                        : Color(0xFF4A4A4A)),
              ),
            ),
          ],
        ),
      );
    }

    final double maxW = MediaQuery.sizeOf(context).width * 0.72;

    return GestureDetector(
      onTap: () => _openImageViewer(imageUrl),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(14),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: maxW,
          height: 200,
          fit: BoxFit.cover,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: maxW,
              height: 200,
              color: Colors.white,
            ),
          ),
          errorWidget: (context, url, error) => Container(
            width: maxW,
            height: 130,
            color: Colors.grey.shade200,
            child: const Icon(Icons.broken_image_rounded, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  /// Interactive reaction pills row below a message bubble
  Widget _buildReactionPills(
    DocumentSnapshot doc,
    Map<String, dynamic> reactions,
    Map<String, dynamic> reactionUsers,
  ) {
    final currentRef = currentUserReference;
    final currentUid = currentRef?.id;

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Wrap(
        spacing: 6,
        runSpacing: 4,
        children: reactions.entries.map((entry) {
          final emoji = entry.key;
          final count = (entry.value as num).toInt();
          if (count <= 0) return const SizedBox.shrink();

          final usersList = List<dynamic>.from(reactionUsers[emoji] ?? []);
          final userHasReacted = currentRef != null &&
              usersList.any((u) =>
                  u == currentRef ||
                  (u is DocumentReference && u.id == currentUid) ||
                  u == currentUid ||
                  u == currentRef.path);

          return GestureDetector(
            onTap: () => _toggleReaction(doc, emoji),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: userHasReacted ? const Color(0xFFFFDCE3) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: userHasReacted
                      ? const Color(0xFFFE99AB)
                      : const Color(0xFFFFE0E6),
                  width: 1.2,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0C000000),
                    blurRadius: 4,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(emoji, style: const TextStyle(fontSize: 13)),
                  const SizedBox(width: 4),
                  Text(
                    count.toString(),
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: userHasReacted
                          ? const Color(0xFFDC6874)
                          : FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  /// Reply preview bar shown right above the input field
  Widget _buildReplyPreviewBar() {
    String sender = 'Babe';
    if (_replyingToUserRef != null) {
      if (_replyingToUserRef == currentUserReference) {
        sender = 'You';
      } else if (_userDocCache.containsKey(_replyingToUserRef!.path)) {
        sender = _userDocCache[_replyingToUserRef!.path]!.displayName;
      } else {
        _fetchUserRecord(_replyingToUserRef);
        sender = _replyingToMessage?['sender_name'] as String? ?? 'Babe';
      }
    } else if (_replyingToMessage?['sender_name'] != null) {
      sender = _replyingToMessage!['sender_name'] as String;
    }
    final text = _replyingToMessage?['text'] as String? ?? '';
    final theme = FlutterFlowTheme.of(context);
    const accentColor = Color(0xFFD45668);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 8.0, 8.0),
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: accentColor.withOpacity(0.3),
          width: 1.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 8.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 3.5,
            height: 36.0,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
          const SizedBox(width: 8.0),
          const Icon(
            Icons.reply_rounded,
            size: 20.0,
            color: accentColor,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Replying to $sender',
                  style: theme.bodyMedium.override(
                    fontFamily: theme.bodyMediumFamily,
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    letterSpacing: 0.0,
                    useGoogleFonts: !theme.bodyMediumIsCustom,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  text.isNotEmpty ? text : 'Photo',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.bodySmall.override(
                    fontFamily: theme.bodySmallFamily,
                    color: theme.secondaryText,
                    fontSize: 12.0,
                    letterSpacing: 0.0,
                    useGoogleFonts: !theme.bodySmallIsCustom,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(20.0),
            onTap: () {
              safeSetState(() {
                _replyingToMessage = null;
                _replyingToMessageRef = null;
                _replyingToUserRef = null;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                Icons.close_rounded,
                size: 20.0,
                color: theme.secondaryText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Selected image thumbnail bar before sending
  Widget _buildSelectedImageBar() {
    final hasBytes =
        _selectedImageBytes != null && _selectedImageBytes!.isNotEmpty;
    final hasUrl = imagePath.isNotEmpty;
    if (!hasBytes && !hasUrl) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: hasBytes
                ? Image.memory(
                    _selectedImageBytes!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    imagePath,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _selectedImageFilename ??
                      ((uploadedLocalFile.name?.isNotEmpty == true)
                          ? uploadedLocalFile.name!
                          : 'Photo selected'),
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                const Text(
                  'Expires in 24 hours 🌸',
                  style: TextStyle(color: Color(0xFFDC6874), fontSize: 11),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.cancel, color: Colors.grey),
            onPressed: () {
              safeSetState(() {
                _selectedImageBytes = null;
                _selectedImageFilename = null;
                imagePath = '';
                uploadedFileUrl = '';
                uploadedLocalFile =
                    FFUploadedFile(bytes: Uint8List.fromList([]));
              });
            },
          ),
        ],
      ),
    );
  }

  /// Bottom Floating Pill Input Bar (Matching AI Mockup Screen 7)
  Widget _buildBottomInputBar() {
    if (_isMuted) {
      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            'you can’t send messages right now',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

// Generated code for this Container Widget...
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          GestureDetector(
            onTap: () async {
              final selectedMedia = await selectMediaWithSourceBottomSheet(
                context: context,
                allowPhoto: true,
                allowVideo: false,
                pickerFontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                textColor: FlutterFlowTheme.of(context).primaryText,
                backgroundColor:
                    FlutterFlowTheme.of(context).secondaryBackground,
              );
              if (!mounted) return;
              if (selectedMedia != null &&
                  selectedMedia.every(
                      (m) => validateFileFormat(m.storagePath, context))) {
                safeSetState(() => isDataUploading = true);
                var selectedUploadedFiles = <FFUploadedFile>[];
                var downloadUrls = <String>[];
                try {
                  showUploadMessage(
                    context,
                    'Uploading file...',
                    showLoading: true,
                  );
                  selectedUploadedFiles = selectedMedia
                      .map((m) => FFUploadedFile(
                            name: m.storagePath.split('/').last,
                            bytes: m.bytes,
                            height: m.dimensions?.height,
                            width: m.dimensions?.width,
                            blurHash: m.blurHash,
                            originalFilename: m.originalFilename,
                          ))
                      .toList();

                  downloadUrls = (await Future.wait(
                    selectedMedia.map(
                      (m) async => await uploadData(m.storagePath, m.bytes),
                    ),
                  ))
                      .where((u) => u != null)
                      .map((u) => u!)
                      .toList();
                } finally {
                  if (mounted) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    safeSetState(() => isDataUploading = false);
                  }
                }
                if (!mounted) return;
                if (selectedUploadedFiles.length == selectedMedia.length &&
                    downloadUrls.length == selectedMedia.length) {
                  safeSetState(() {
                    uploadedLocalFile = selectedUploadedFiles.first;
                    imagePath = downloadUrls.first;
                    uploadedFileUrl = downloadUrls.first;
                    _selectedImageBytes = selectedUploadedFiles.first.bytes;
                    _selectedImageFilename = selectedUploadedFiles.first.name;
                  });
                  showUploadMessage(context, 'Success!');
                } else {
                  safeSetState(() {});
                  showUploadMessage(context, 'Failed to upload data');
                  return;
                }
              }
            },
            child: Container(
              margin: const EdgeInsets.only(left: 4),
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF0F3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.camera_alt_rounded,
                color: FlutterFlowTheme.of(context).primary,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 0, 8, 0),
              child: Container(
                width: 200,
                child: TextFormField(
                  controller: _textController,
                  focusNode: _focusNode,
                  onFieldSubmitted: (_) => _sendMessage(),
                  onChanged: (_) => EasyDebounce.debounce(
                    '_model.textController',
                    Duration(milliseconds: 10),
                    () => safeSetState(() {}),
                  ),
                  autofocus: false,
                  enabled: true,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.done,
                  obscureText: false,
                  decoration: InputDecoration(
                    isDense: false,
                    hintText: 'send a message',
                    hintStyle: FlutterFlowTheme.of(context)
                        .labelMedium
                        .override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelMediumFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).labelMediumIsCustom,
                        ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        fontSize: 12,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                      ),
                  maxLines: 3,
                  minLines: 1,
                  cursorColor: FlutterFlowTheme.of(context).primaryText,
                  enableInteractiveSelection: true,
                  inputFormatters: [
                    if (!isAndroid && !isiOS)
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        return TextEditingValue(
                          selection: newValue.selection,
                          text: newValue.text
                              .toCapitalization(TextCapitalization.sentences),
                        );
                      }),
                    FilteringTextInputFormatter.allow(RegExp('^[^\\s].*'))
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 4, 0),
            child: FlutterFlowIconButton(
              borderColor: FlutterFlowTheme.of(context).primary,
              borderRadius: 30,
              buttonSize: 40,
              fillColor: FlutterFlowTheme.of(context).primary,
              icon: Icon(
                Icons.send,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 20,
              ),
              onPressed: _isSending ? null : _sendMessage,
            ),
          ),
        ],
      ),
    );
  }

  /// Gated VIP Screen shown if membership is not active
  Widget _buildMembershipGatedView() {
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      color: FlutterFlowTheme.of(context).secondaryBackground,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF0F3),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).primary,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.lock_rounded,
                  color: FlutterFlowTheme.of(context).primary,
                  size: 44,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'babes club Members Only',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).headlineSmallFamily,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.0,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'This private community chat is an intimate close-friends circle reserved exclusively for active babes club members ♡',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      fontSize: 14.5,
                      lineHeight: 1.45,
                    ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: FlutterFlowTheme.of(context).primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                    elevation: 4,
                  ),
                  onPressed: () {
                    context.pushNamed(JoinClubWidget.routeName);
                  },
                  child: const Text(
                    'Join babes club ♡',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () async {
                  if (widget.onBack != null) {
                    await widget.onBack!();
                  } else {
                    Navigator.of(context).maybePop();
                  }
                },
                child: Text(
                  'Back to Hub',
                  style: TextStyle(
                    color: FlutterFlowTheme.of(context).secondaryText,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

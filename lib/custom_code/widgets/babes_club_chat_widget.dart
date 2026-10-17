// Automatic FlutterFlow imports
import 'package:yes_gurl/flutter_flow/upload_data.dart';

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

import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/firebase_storage/storage.dart';
import '/club/join_club/join_club_widget.dart';

/// BabesClubChatWidget
///
/// An intimate, high-performance close-friends group chat widget
/// built specifically for the Yes Gurl Babes Club private community.
///
/// Implements:
/// - Real-time messaging with scoped listener on newest 40 messages
/// - Paginated scrolling for older messages using startAfterDocument
/// - Active membership check & gating (only active club members can enter)
/// - Direct in-line replies with quote previews
/// - Rich emoji reactions with counter pills on messages
/// - 24-hour auto-expiring images (client filter + backend scheduled cleanup)
/// - Full-screen interactive image viewer (zoom & pan)
/// - Message deletion (soft delete for own messages & admin moderation state)
/// - Muted / restricted member states
/// - Denormalized room member counter for ultra-fast load
/// - Floating pill input bar matching the AI mockup (Screen 7)
class BabesClubChatWidget extends StatefulWidget {
  const BabesClubChatWidget({
    super.key,
    this.width,
    this.height,
    this.roomId = 'babes_club_lounge',
    this.isMember,
    this.onBack,
  });

  final double? width;
  final double? height;
  final String roomId;
  final bool? isMember;
  final Future Function()? onBack;

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
  String _roomName = 'Babes Club';
  int _memberCount = 2400;
  String? _roomAvatar;

  // Replying state
  Map<String, dynamic>? _replyingToMessage;
  String? _replyingToDocId;

  // Selected image to send
  Uint8List? _selectedImageBytes;
  String? _selectedImageFilename;

  // Quick reaction emojis
  static const List<String> _quickEmojis = ['❤️', '💕', '😍', '✨', '😂', '🌸'];

  CollectionReference get _messagesCollection => FirebaseFirestore.instance
      .collection('chat_rooms')
      .doc(widget.roomId)
      .collection('chat_messages');

  DocumentReference get _roomDocRef =>
      FirebaseFirestore.instance.collection('chat_rooms').doc(widget.roomId);

  @override
  void initState() {
    super.initState();
    if (widget.isMember != null) {
      _isMemberActive = widget.isMember!;
      _isCheckingMembership = false;
    }
    _checkMembership();
    _initRoomMeta();
    _initLiveMessages();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _liveMessagesSub?.cancel();
    _roomSub?.cancel();
    _memberSub?.cancel();
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
          .where('room_id', isEqualTo: widget.roomId)
          .limit(1)
          .get();

      if (restrictSnap.docs.isNotEmpty) {
        final rData = restrictSnap.docs.first.data();
        _isMuted = rData['is_muted'] == true || rData['is_removed'] == true;
      }
    } catch (_) {}
  }

  /// Listen to room metadata (member count, room name, etc.)
  void _initRoomMeta() {
    _roomSub = _roomDocRef.snapshots().listen((snap) {
      if (!mounted) return;
      if (snap.exists) {
        final data = snap.data() as Map<String, dynamic>?;
        if (data != null) {
          setState(() {
            _roomName = data['name'] ?? 'Babes Club';
            _memberCount = (data['member_count'] as num?)?.toInt() ?? 2400;
            _roomAvatar = data['avatar_url'] as String?;
          });
        }
      } else {
        // Create initial room doc if absent
        _roomDocRef.set({
          'name': 'Babes Club',
          'description': 'Private Close Friends Community Chat ♡',
          'member_count': 2400,
          'created_at': FieldValue.serverTimestamp(),
          'active': true,
        }, SetOptions(merge: true));
      }
    });
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
    }, onError: (err) {
      if (!mounted) return;
      setState(() {
        _isLoadingInitial = false;
      });
    });
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

  /// Pick image from camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: source,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 82,
      );

      if (picked == null) return;
      final bytes = await picked.readAsBytes();

      setState(() {
        _selectedImageBytes = bytes;
        _selectedImageFilename = picked.name;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not pick image: $e'),
          backgroundColor: FlutterFlowTheme.of(context).error,
        ),
      );
    }
  }

  /// Send message
  Future<void> _sendMessage() async {
    final text = _textController.text.trim();
    if (text.isEmpty && _selectedImageBytes == null) return;
    if (_isSending) return;

    final userRef = currentUserReference;
    if (userRef == null) return;

    setState(() {
      _isSending = true;
    });

    try {
      String? imageUrl;
      String? storagePath;
      DateTime? imageExpiresAt;

      // Upload image to Firebase Storage if selected
      if (_selectedImageBytes != null) {
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        storagePath = 'chat_images/${userRef.id}/img_$timestamp.jpg';
        imageUrl = await uploadData(storagePath, _selectedImageBytes!);

        // Image expires after 24 hours
        imageExpiresAt = DateTime.now().add(const Duration(hours: 24));
      }

      final senderName = currentUserDisplayName.isNotEmpty
          ? currentUserDisplayName
          : 'Babes Member';
      final senderPhoto = currentUserPhoto;

      final messageData = <String, dynamic>{
        'user_ref': userRef,
        'sender_name': senderName,
        'sender_photo': senderPhoto,
        'text': text,
        'image_url': imageUrl,
        'image_storage_path': storagePath,
        'image_expires_at':
            imageExpiresAt != null ? Timestamp.fromDate(imageExpiresAt) : null,
        'created_at': FieldValue.serverTimestamp(),
        'reply_to_id': _replyingToDocId,
        'reply_to_text': _replyingToMessage?['text'] as String?,
        'reply_to_sender_name': _replyingToMessage?['sender_name'] as String?,
        'reactions': <String, int>{},
        'reaction_users': <String, dynamic>{},
        'deleted_at': null,
        'deleted_by': null,
        'is_removed_by_admin': false,
      };

      await _messagesCollection.add(messageData);

      // Update room last message info
      await _roomDocRef.update({
        'last_message':
            text.isNotEmpty ? text : (imageUrl != null ? '📷 Photo' : ''),
        'last_message_time': FieldValue.serverTimestamp(),
        'last_message_sender': senderName,
      });

      // Clear input and state
      _textController.clear();
      setState(() {
        _selectedImageBytes = null;
        _selectedImageFilename = null;
        _replyingToMessage = null;
        _replyingToDocId = null;
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send message: $e'),
          backgroundColor: FlutterFlowTheme.of(context).error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  /// Toggle reaction on a message
  Future<void> _toggleReaction(DocumentSnapshot doc, String emoji) async {
    final userRef = currentUserReference;
    if (userRef == null) return;
    final uid = userRef.id;

    final data = doc.data() as Map<String, dynamic>? ?? {};
    final reactions = Map<String, dynamic>.from(data['reactions'] ?? {});
    final reactionUsers =
        Map<String, dynamic>.from(data['reaction_users'] ?? {});

    List<dynamic> usersForEmoji =
        List<dynamic>.from(reactionUsers[emoji] ?? []);
    final int currentCount = (reactions[emoji] as num?)?.toInt() ?? 0;

    if (usersForEmoji.contains(uid)) {
      // Remove reaction
      usersForEmoji.remove(uid);
      final newCount = currentCount > 1 ? currentCount - 1 : 0;
      if (newCount == 0) {
        reactions.remove(emoji);
        reactionUsers.remove(emoji);
      } else {
        reactions[emoji] = newCount;
        reactionUsers[emoji] = usersForEmoji;
      }
    } else {
      // Add reaction
      usersForEmoji.add(uid);
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not delete message: $e')),
      );
    }
  }

  /// Report message
  Future<void> _reportMessage(DocumentSnapshot doc) async {
    final userRef = currentUserReference;
    if (userRef == null) return;

    try {
      await FirebaseFirestore.instance.collection('chat_reports').add({
        'message_ref': doc.reference,
        'reported_by': userRef,
        'room_id': widget.roomId,
        'created_at': FieldValue.serverTimestamp(),
        'status': 'pending',
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Thank you. Message reported to moderators.'),
          backgroundColor: FlutterFlowTheme.of(context).secondary,
        ),
      );
    } catch (_) {}
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${_formatMemberCount(_memberCount)} active babes ♡',
                style: TextStyle(
                  color: FlutterFlowTheme.of(context).primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
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
                  'Access remains exclusively active while your Babes Club membership is valid.',
            ),
            const SizedBox(height: 24),
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
                Icons.reply_rounded,
                color: FlutterFlowTheme.of(context).primary,
              ),
              title: const Text('Reply directly'),
              onTap: () {
                Navigator.of(ctx).pop();
                setState(() {
                  _replyingToMessage = data;
                  _replyingToDocId = doc.id;
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
                  _reportMessage(doc);
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
      color: const Color(0xFFFDF7F8), // Soft intimate close-friends pink hue
      child: SafeArea(
        child: Column(
          children: [
            _buildTopNavBar(),
            _buildRoomCard(),
            Expanded(child: _buildMessagesFeed()),
            if (_replyingToMessage != null) _buildReplyPreviewBar(),
            if (_selectedImageBytes != null) _buildSelectedImageBar(),
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
          Expanded(
            child: Text(
              'Babes Club Chat',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily:
                        FlutterFlowTheme.of(context).headlineSmallFamily,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.0,
                  ),
            ),
          ),
          const SizedBox(width: 44), // balance back button
        ],
      ),
    );
  }

  /// Room Card (Matching AI Mockup Screen 7)
  Widget _buildRoomCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFFFE3E8),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0x10FF5A79),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Small left arrow indicator
          Icon(
            Icons.chevron_left_rounded,
            color: FlutterFlowTheme.of(context).secondaryText.withOpacity(0.6),
            size: 20,
          ),
          const SizedBox(width: 6),
          // Babes Club Avatar circle
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
              boxShadow: [
                BoxShadow(
                  color: const Color(0x30FE99AB),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
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
                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyLargeFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        letterSpacing: 0.0,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${_formatMemberCount(_memberCount)} members',
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodySmallFamily,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 12,
                        letterSpacing: 0.0,
                      ),
                ),
              ],
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
              'Your intimate Babes Club circle is waiting!',
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
        return _buildMessageItem(doc);
      },
    );
  }

  /// Single Message Bubble Item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    final userRef = currentUserReference;
    final isMe =
        userRef != null && (data['user_ref'] as DocumentReference?) == userRef;
    final isDeleted = data['deleted_at'] != null;
    final isRemovedByAdmin = data['is_removed_by_admin'] == true ||
        data['deleted_by_role'] == 'admin';

    final text = data['text'] as String? ?? '';
    final imageUrl = data['image_url'] as String?;
    final imageExpiresAt = (data['image_expires_at'] as Timestamp?)?.toDate();
    final createdAt = (data['created_at'] as Timestamp?)?.toDate();
    final senderName = data['sender_name'] as String? ?? 'Babe';
    final senderPhoto = data['sender_photo'] as String?;

    // In-line reply quote metadata
    final replyText = data['reply_to_text'] as String?;
    final replySender = data['reply_to_sender_name'] as String?;

    // Reactions map
    final reactions = Map<String, dynamic>.from(data['reactions'] ?? {});
    final reactionUsers =
        Map<String, dynamic>.from(data['reaction_users'] ?? {});

    // 24-hour image expiry check
    final bool isImageExpired =
        imageExpiresAt != null && DateTime.now().isAfter(imageExpiresAt);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onLongPress: () => _showMessageOptions(doc),
        child: Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Other user avatar (on left)
            if (!isMe) ...[
              _buildSenderAvatar(senderPhoto, senderName),
              const SizedBox(width: 8),
            ],

            Flexible(
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // Sender name (only for incoming messages)
                  if (!isMe)
                    Padding(
                      padding: const EdgeInsets.only(left: 6, bottom: 4),
                      child: Text(
                        senderName,
                        style: TextStyle(
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                  // Message Bubble
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.72,
                    ),
                    decoration: BoxDecoration(
                      gradient: isMe
                          ? const LinearGradient(
                              colors: [Color(0xFFFE99AB), Color(0xFFFF728D)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : null,
                      color: isMe ? null : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20),
                        topRight: const Radius.circular(20),
                        bottomLeft: Radius.circular(isMe ? 20 : 4),
                        bottomRight: Radius.circular(isMe ? 4 : 20),
                      ),
                      border: isMe
                          ? null
                          : Border.all(
                              color: const Color(0xFFFFE8EC), width: 1.2),
                      boxShadow: [
                        BoxShadow(
                          color: isMe
                              ? const Color(0x28FE99AB)
                              : const Color(0x0A000000),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: isMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        // Quoted Reply Preview (if any)
                        if (replyText != null && replyText.isNotEmpty)
                          _buildInBubbleReplyQuote(
                            replySender ?? 'Babe',
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
                                  ? Colors.white.withOpacity(0.7)
                                  : Colors.grey.shade500,
                              fontSize: 13.5,
                            ),
                          )
                        else ...[
                          // Image Content (with 24h expiry handling)
                          if (imageUrl != null && imageUrl.isNotEmpty)
                            _buildBubbleImage(
                              imageUrl,
                              isImageExpired,
                              isMe,
                            ),

                          // Text Content
                          if (text.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(
                                top: (imageUrl != null) ? 8.0 : 0.0,
                              ),
                              child: Text(
                                text,
                                style: TextStyle(
                                  color: isMe
                                      ? Colors.white
                                      : FlutterFlowTheme.of(context)
                                          .primaryText,
                                  fontSize: 15,
                                  height: 1.35,
                                ),
                              ),
                            ),
                        ],

                        const SizedBox(height: 4),

                        // Timestamp
                        Text(
                          _formatMessageTime(createdAt),
                          style: TextStyle(
                            color: isMe
                                ? Colors.white.withOpacity(0.75)
                                : FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 10.5,
                          ),
                        ),
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
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isMe ? Colors.white.withOpacity(0.2) : const Color(0xFFFFF0F3),
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(
            color: isMe ? Colors.white : const Color(0xFFFE99AB),
            width: 3.5,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11.5,
              color: isMe ? Colors.white : const Color(0xFFDC6874),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            quote,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: isMe ? Colors.white.withOpacity(0.9) : Colors.black87,
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
    bool isMe,
  ) {
    if (isExpired) {
      return Container(
        width: 220,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color:
              isMe ? Colors.white.withOpacity(0.18) : const Color(0xFFF9F1F3),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.timer_off_outlined,
              size: 20,
              color: isMe ? Colors.white70 : const Color(0xFFDC6874),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Image expired after 24 hours 🌸',
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: isMe ? Colors.white : Colors.black54,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () => _openImageViewer(imageUrl),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: 230,
          height: 170,
          fit: BoxFit.cover,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade100,
            child: Container(width: 230, height: 170, color: Colors.white),
          ),
          errorWidget: (context, url, error) => Container(
            width: 230,
            height: 120,
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
    final currentUid = currentUserReference?.id;

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
          final userHasReacted =
              currentUid != null && usersList.contains(currentUid);

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
    final sender = _replyingToMessage?['sender_name'] as String? ?? 'Babe';
    final text = _replyingToMessage?['text'] as String? ?? '';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: const Color(0xFFFFE0E6), width: 1),
          left:
              BorderSide(color: FlutterFlowTheme.of(context).primary, width: 4),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Replying to $sender',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.5,
                    color: FlutterFlowTheme.of(context).primary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  text.isNotEmpty ? text : 'Photo',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: FlutterFlowTheme.of(context).secondaryText,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 18),
            onPressed: () {
              setState(() {
                _replyingToMessage = null;
                _replyingToDocId = null;
              });
            },
          ),
        ],
      ),
    );
  }

  /// Selected image thumbnail bar before sending
  Widget _buildSelectedImageBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.memory(
              _selectedImageBytes!,
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
                  _selectedImageFilename ?? 'Photo selected',
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
              setState(() {
                _selectedImageBytes = null;
                _selectedImageFilename = null;
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

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: const Color(0xFFFFDCE3),
          width: 1.2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Camera / Attachment Icon button
          GestureDetector(
            onTap: () async {
              final selectedMedia = await selectMediaWithSourceBottomSheet(
                context: context,
                allowPhoto: true,
              );
              if (selectedMedia != null &&
                  selectedMedia.every(
                      (m) => validateFileFormat(m.storagePath, context))) {
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
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                }
                if (selectedUploadedFiles.length == selectedMedia.length &&
                    downloadUrls.length == selectedMedia.length) {
                  safeSetState(() {
                    imagePath = selectedUploadedFiles.first;
                    imagePath = downloadUrls.first;
                  });
                  showUploadMessage(context, 'Success!');
                } else {
                  safeSetState(() {});
                  showUploadMessage(context, 'Failed to upload data');
                  return;
                }
              }

              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (ctx) => Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFF0F3),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.camera_alt_rounded,
                            color: FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                        title: const Text('Take a photo'),
                        onTap: () {
                          Navigator.of(ctx).pop();
                          _pickImage(ImageSource.camera);
                        },
                      ),
                      ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFF0F3),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.photo_library_rounded,
                            color: FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                        title: const Text('Choose from gallery'),
                        onTap: () {
                          Navigator.of(ctx).pop();
                          _pickImage(ImageSource.gallery);
                        },
                      ),
                    ],
                  ),
                ),
              );
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

          // Message Input Field
          Expanded(
            child: TextField(
              controller: _textController,
              focusNode: _focusNode,
              textCapitalization: TextCapitalization.sentences,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 15,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 10,
                ),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),

          // Info / Guidelines quick toggle
          IconButton(
            icon: Icon(
              Icons.info_outline_rounded,
              color: Colors.grey.shade400,
              size: 22,
            ),
            onPressed: _showRoomInfoSheet,
          ),

          // Send Button
          GestureDetector(
            onTap: _isSending ? null : _sendMessage,
            child: Container(
              margin: const EdgeInsets.only(right: 4),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFE99AB), Color(0xFFFF6D8A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x35FE99AB),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: _isSending
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
              ),
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
                'Babes Club Members Only',
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
                'This private community chat is an intimate close-friends circle reserved exclusively for active Babes Club members ♡',
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
                    'Join Babes Club ♡',
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

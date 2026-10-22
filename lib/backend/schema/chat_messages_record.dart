import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatMessagesRecord extends FirestoreRecord {
  ChatMessagesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "deleted_at" field.
  DateTime? _deletedAt;
  DateTime? get deletedAt => _deletedAt;
  bool hasDeletedAt() => _deletedAt != null;

  // "deleted_by" field.
  DocumentReference? _deletedBy;
  DocumentReference? get deletedBy => _deletedBy;
  bool hasDeletedBy() => _deletedBy != null;

  // "image_expires_at" field.
  DateTime? _imageExpiresAt;
  DateTime? get imageExpiresAt => _imageExpiresAt;
  bool hasImageExpiresAt() => _imageExpiresAt != null;

  // "image_url" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  bool hasImageUrl() => _imageUrl != null;

  // "is_removed_by_admin" field.
  bool? _isRemovedByAdmin;
  bool get isRemovedByAdmin => _isRemovedByAdmin ?? false;
  bool hasIsRemovedByAdmin() => _isRemovedByAdmin != null;

  // "reply_message_ref" field.
  DocumentReference? _replyMessageRef;
  DocumentReference? get replyMessageRef => _replyMessageRef;
  bool hasReplyMessageRef() => _replyMessageRef != null;

  // "reply_to_text" field.
  String? _replyToText;
  String get replyToText => _replyToText ?? '';
  bool hasReplyToText() => _replyToText != null;

  // "reply_user_ref" field.
  DocumentReference? _replyUserRef;
  DocumentReference? get replyUserRef => _replyUserRef;
  bool hasReplyUserRef() => _replyUserRef != null;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  // "user_ref" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "message_seen_by" field.
  List<DocumentReference>? _messageSeenBy;
  List<DocumentReference> get messageSeenBy => _messageSeenBy ?? const [];
  bool hasMessageSeenBy() => _messageSeenBy != null;

  // "message_report" field.
  List<DocumentReference>? _messageReport;
  List<DocumentReference> get messageReport => _messageReport ?? const [];
  bool hasMessageReport() => _messageReport != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _createdAt = snapshotData['created_at'] as DateTime?;
    _deletedAt = snapshotData['deleted_at'] as DateTime?;
    _deletedBy = snapshotData['deleted_by'] as DocumentReference?;
    _imageExpiresAt = snapshotData['image_expires_at'] as DateTime?;
    _imageUrl = snapshotData['image_url'] as String?;
    _isRemovedByAdmin = snapshotData['is_removed_by_admin'] as bool?;
    _replyMessageRef = snapshotData['reply_message_ref'] as DocumentReference?;
    _replyToText = snapshotData['reply_to_text'] as String?;
    _replyUserRef = snapshotData['reply_user_ref'] as DocumentReference?;
    _text = snapshotData['text'] as String?;
    _userRef = snapshotData['user_ref'] as DocumentReference?;
    _messageSeenBy = getDataList(snapshotData['message_seen_by']);
    _messageReport = getDataList(snapshotData['message_report']);
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('chat_messages')
          : FirebaseFirestore.instance.collectionGroup('chat_messages');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('chat_messages').doc(id);

  static Stream<ChatMessagesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChatMessagesRecord.fromSnapshot(s));

  static Future<ChatMessagesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChatMessagesRecord.fromSnapshot(s));

  static ChatMessagesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ChatMessagesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChatMessagesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChatMessagesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ChatMessagesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChatMessagesRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createChatMessagesRecordData({
  DateTime? createdAt,
  DateTime? deletedAt,
  DocumentReference? deletedBy,
  DateTime? imageExpiresAt,
  String? imageUrl,
  bool? isRemovedByAdmin,
  DocumentReference? replyMessageRef,
  String? replyToText,
  DocumentReference? replyUserRef,
  String? text,
  DocumentReference? userRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'created_at': createdAt,
      'deleted_at': deletedAt,
      'deleted_by': deletedBy,
      'image_expires_at': imageExpiresAt,
      'image_url': imageUrl,
      'is_removed_by_admin': isRemovedByAdmin,
      'reply_message_ref': replyMessageRef,
      'reply_to_text': replyToText,
      'reply_user_ref': replyUserRef,
      'text': text,
      'user_ref': userRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class ChatMessagesRecordDocumentEquality
    implements Equality<ChatMessagesRecord> {
  const ChatMessagesRecordDocumentEquality();

  @override
  bool equals(ChatMessagesRecord? e1, ChatMessagesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.createdAt == e2?.createdAt &&
        e1?.deletedAt == e2?.deletedAt &&
        e1?.deletedBy == e2?.deletedBy &&
        e1?.imageExpiresAt == e2?.imageExpiresAt &&
        e1?.imageUrl == e2?.imageUrl &&
        e1?.isRemovedByAdmin == e2?.isRemovedByAdmin &&
        e1?.replyMessageRef == e2?.replyMessageRef &&
        e1?.replyToText == e2?.replyToText &&
        e1?.replyUserRef == e2?.replyUserRef &&
        e1?.text == e2?.text &&
        e1?.userRef == e2?.userRef &&
        listEquality.equals(e1?.messageSeenBy, e2?.messageSeenBy) &&
        listEquality.equals(e1?.messageReport, e2?.messageReport);
  }

  @override
  int hash(ChatMessagesRecord? e) => const ListEquality().hash([
        e?.createdAt,
        e?.deletedAt,
        e?.deletedBy,
        e?.imageExpiresAt,
        e?.imageUrl,
        e?.isRemovedByAdmin,
        e?.replyMessageRef,
        e?.replyToText,
        e?.replyUserRef,
        e?.text,
        e?.userRef,
        const ListEquality().hash(e?.messageSeenBy),
        const ListEquality().hash(e?.messageReport)
      ]);

  @override
  bool isValidKey(Object? o) => o is ChatMessagesRecord;
}

import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MessagesRecord extends FirestoreRecord {
  MessagesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "user_ref" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "liked_by" field.
  List<DocumentReference>? _likedBy;
  List<DocumentReference> get likedBy => _likedBy ?? const [];
  bool hasLikedBy() => _likedBy != null;

  // "reply_message" field.
  DocumentReference? _replyMessage;
  DocumentReference? get replyMessage => _replyMessage;
  bool hasReplyMessage() => _replyMessage != null;

  // "deleted_at" field.
  DateTime? _deletedAt;
  DateTime? get deletedAt => _deletedAt;
  bool hasDeletedAt() => _deletedAt != null;

  // "deleted_by" field.
  DocumentReference? _deletedBy;
  DocumentReference? get deletedBy => _deletedBy;
  bool hasDeletedBy() => _deletedBy != null;

  // "isReply" field.
  bool? _isReply;
  bool get isReply => _isReply ?? false;
  bool hasIsReply() => _isReply != null;

  // "message_report" field.
  List<DocumentReference>? _messageReport;
  List<DocumentReference> get messageReport => _messageReport ?? const [];
  bool hasMessageReport() => _messageReport != null;

  // "message_seen_by" field.
  List<DocumentReference>? _messageSeenBy;
  List<DocumentReference> get messageSeenBy => _messageSeenBy ?? const [];
  bool hasMessageSeenBy() => _messageSeenBy != null;

  // "community_ref" field.
  DocumentReference? _communityRef;
  DocumentReference? get communityRef => _communityRef;
  bool hasCommunityRef() => _communityRef != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _text = snapshotData['text'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _userRef = snapshotData['user_ref'] as DocumentReference?;
    _likedBy = getDataList(snapshotData['liked_by']);
    _replyMessage = snapshotData['reply_message'] as DocumentReference?;
    _deletedAt = snapshotData['deleted_at'] as DateTime?;
    _deletedBy = snapshotData['deleted_by'] as DocumentReference?;
    _isReply = snapshotData['isReply'] as bool?;
    _messageReport = getDataList(snapshotData['message_report']);
    _messageSeenBy = getDataList(snapshotData['message_seen_by']);
    _communityRef = snapshotData['community_ref'] as DocumentReference?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('messages')
          : FirebaseFirestore.instance.collectionGroup('messages');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('messages').doc(id);

  static Stream<MessagesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MessagesRecord.fromSnapshot(s));

  static Future<MessagesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MessagesRecord.fromSnapshot(s));

  static MessagesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MessagesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MessagesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MessagesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MessagesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MessagesRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createMessagesRecordData({
  String? text,
  DateTime? createdAt,
  DocumentReference? userRef,
  DocumentReference? replyMessage,
  DateTime? deletedAt,
  DocumentReference? deletedBy,
  bool? isReply,
  DocumentReference? communityRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'text': text,
      'created_at': createdAt,
      'user_ref': userRef,
      'reply_message': replyMessage,
      'deleted_at': deletedAt,
      'deleted_by': deletedBy,
      'isReply': isReply,
      'community_ref': communityRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class MessagesRecordDocumentEquality implements Equality<MessagesRecord> {
  const MessagesRecordDocumentEquality();

  @override
  bool equals(MessagesRecord? e1, MessagesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.text == e2?.text &&
        e1?.createdAt == e2?.createdAt &&
        e1?.userRef == e2?.userRef &&
        listEquality.equals(e1?.likedBy, e2?.likedBy) &&
        e1?.replyMessage == e2?.replyMessage &&
        e1?.deletedAt == e2?.deletedAt &&
        e1?.deletedBy == e2?.deletedBy &&
        e1?.isReply == e2?.isReply &&
        listEquality.equals(e1?.messageReport, e2?.messageReport) &&
        listEquality.equals(e1?.messageSeenBy, e2?.messageSeenBy) &&
        e1?.communityRef == e2?.communityRef;
  }

  @override
  int hash(MessagesRecord? e) => const ListEquality().hash([
        e?.text,
        e?.createdAt,
        e?.userRef,
        const ListEquality().hash(e?.likedBy),
        e?.replyMessage,
        e?.deletedAt,
        e?.deletedBy,
        e?.isReply,
        const ListEquality().hash(e?.messageReport),
        const ListEquality().hash(e?.messageSeenBy),
        e?.communityRef
      ]);

  @override
  bool isValidKey(Object? o) => o is MessagesRecord;
}

import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatRoomsRecord extends FirestoreRecord {
  ChatRoomsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "active" field.
  bool? _active;
  bool get active => _active ?? false;
  bool hasActive() => _active != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "last_message" field.
  String? _lastMessage;
  String get lastMessage => _lastMessage ?? '';
  bool hasLastMessage() => _lastMessage != null;

  // "last_message_time" field.
  DateTime? _lastMessageTime;
  DateTime? get lastMessageTime => _lastMessageTime;
  bool hasLastMessageTime() => _lastMessageTime != null;

  // "last_message_user" field.
  DocumentReference? _lastMessageUser;
  DocumentReference? get lastMessageUser => _lastMessageUser;
  bool hasLastMessageUser() => _lastMessageUser != null;

  // "member_count" field.
  int? _memberCount;
  int get memberCount => _memberCount ?? 0;
  bool hasMemberCount() => _memberCount != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  void _initializeFields() {
    _active = snapshotData['active'] as bool?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _description = snapshotData['description'] as String?;
    _lastMessage = snapshotData['last_message'] as String?;
    _lastMessageTime = snapshotData['last_message_time'] as DateTime?;
    _lastMessageUser = snapshotData['last_message_user'] as DocumentReference?;
    _memberCount = castToType<int>(snapshotData['member_count']);
    _name = snapshotData['name'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('chat_rooms');

  static Stream<ChatRoomsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChatRoomsRecord.fromSnapshot(s));

  static Future<ChatRoomsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChatRoomsRecord.fromSnapshot(s));

  static ChatRoomsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ChatRoomsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChatRoomsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChatRoomsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ChatRoomsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChatRoomsRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createChatRoomsRecordData({
  bool? active,
  DateTime? createdAt,
  String? description,
  String? lastMessage,
  DateTime? lastMessageTime,
  DocumentReference? lastMessageUser,
  int? memberCount,
  String? name,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'active': active,
      'created_at': createdAt,
      'description': description,
      'last_message': lastMessage,
      'last_message_time': lastMessageTime,
      'last_message_user': lastMessageUser,
      'member_count': memberCount,
      'name': name,
    }.withoutNulls,
  );

  return firestoreData;
}

class ChatRoomsRecordDocumentEquality implements Equality<ChatRoomsRecord> {
  const ChatRoomsRecordDocumentEquality();

  @override
  bool equals(ChatRoomsRecord? e1, ChatRoomsRecord? e2) {
    return e1?.active == e2?.active &&
        e1?.createdAt == e2?.createdAt &&
        e1?.description == e2?.description &&
        e1?.lastMessage == e2?.lastMessage &&
        e1?.lastMessageTime == e2?.lastMessageTime &&
        e1?.lastMessageUser == e2?.lastMessageUser &&
        e1?.memberCount == e2?.memberCount &&
        e1?.name == e2?.name;
  }

  @override
  int hash(ChatRoomsRecord? e) => const ListEquality().hash([
        e?.active,
        e?.createdAt,
        e?.description,
        e?.lastMessage,
        e?.lastMessageTime,
        e?.lastMessageUser,
        e?.memberCount,
        e?.name
      ]);

  @override
  bool isValidKey(Object? o) => o is ChatRoomsRecord;
}

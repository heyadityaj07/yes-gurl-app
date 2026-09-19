import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatRecord extends FirestoreRecord {
  ChatRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userA" field.
  DocumentReference? _userA;
  DocumentReference? get userA => _userA;
  bool hasUserA() => _userA != null;

  // "userB" field.
  DocumentReference? _userB;
  DocumentReference? get userB => _userB;
  bool hasUserB() => _userB != null;

  // "last_message" field.
  String? _lastMessage;
  String get lastMessage => _lastMessage ?? '';
  bool hasLastMessage() => _lastMessage != null;

  // "lastmessage_time" field.
  DateTime? _lastmessageTime;
  DateTime? get lastmessageTime => _lastmessageTime;
  bool hasLastmessageTime() => _lastmessageTime != null;

  // "isRequested" field.
  bool? _isRequested;
  bool get isRequested => _isRequested ?? false;
  bool hasIsRequested() => _isRequested != null;

  // "requestReply" field.
  String? _requestReply;
  String get requestReply => _requestReply ?? '';
  bool hasRequestReply() => _requestReply != null;

  // "requestReplyTime" field.
  DateTime? _requestReplyTime;
  DateTime? get requestReplyTime => _requestReplyTime;
  bool hasRequestReplyTime() => _requestReplyTime != null;

  // "lastMessageuserRef" field.
  DocumentReference? _lastMessageuserRef;
  DocumentReference? get lastMessageuserRef => _lastMessageuserRef;
  bool hasLastMessageuserRef() => _lastMessageuserRef != null;

  // "event_image" field.
  String? _eventImage;
  String get eventImage => _eventImage ?? '';
  bool hasEventImage() => _eventImage != null;

  // "block_by" field.
  List<DocumentReference>? _blockBy;
  List<DocumentReference> get blockBy => _blockBy ?? const [];
  bool hasBlockBy() => _blockBy != null;

  // "responseList" field.
  List<SelectUserResponseStruct>? _responseList;
  List<SelectUserResponseStruct> get responseList => _responseList ?? const [];
  bool hasResponseList() => _responseList != null;

  // "displayDialogCount" field.
  int? _displayDialogCount;
  int get displayDialogCount => _displayDialogCount ?? 0;
  bool hasDisplayDialogCount() => _displayDialogCount != null;

  // "dialogVisiableUsers" field.
  List<DocumentReference>? _dialogVisiableUsers;
  List<DocumentReference> get dialogVisiableUsers =>
      _dialogVisiableUsers ?? const [];
  bool hasDialogVisiableUsers() => _dialogVisiableUsers != null;

  // "users" field.
  List<DocumentReference>? _users;
  List<DocumentReference> get users => _users ?? const [];
  bool hasUsers() => _users != null;

  // "author" field.
  DocumentReference? _author;
  DocumentReference? get author => _author;
  bool hasAuthor() => _author != null;

  // "weMetList" field.
  List<DocumentReference>? _weMetList;
  List<DocumentReference> get weMetList => _weMetList ?? const [];
  bool hasWeMetList() => _weMetList != null;

  void _initializeFields() {
    _userA = snapshotData['userA'] as DocumentReference?;
    _userB = snapshotData['userB'] as DocumentReference?;
    _lastMessage = snapshotData['last_message'] as String?;
    _lastmessageTime = snapshotData['lastmessage_time'] as DateTime?;
    _isRequested = snapshotData['isRequested'] as bool?;
    _requestReply = snapshotData['requestReply'] as String?;
    _requestReplyTime = snapshotData['requestReplyTime'] as DateTime?;
    _lastMessageuserRef =
        snapshotData['lastMessageuserRef'] as DocumentReference?;
    _eventImage = snapshotData['event_image'] as String?;
    _blockBy = getDataList(snapshotData['block_by']);
    _responseList = getStructList(
      snapshotData['responseList'],
      SelectUserResponseStruct.fromMap,
    );
    _displayDialogCount = castToType<int>(snapshotData['displayDialogCount']);
    _dialogVisiableUsers = getDataList(snapshotData['dialogVisiableUsers']);
    _users = getDataList(snapshotData['users']);
    _author = snapshotData['author'] as DocumentReference?;
    _weMetList = getDataList(snapshotData['weMetList']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('chat');

  static Stream<ChatRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChatRecord.fromSnapshot(s));

  static Future<ChatRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChatRecord.fromSnapshot(s));

  static ChatRecord fromSnapshot(DocumentSnapshot snapshot) => ChatRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChatRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChatRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ChatRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChatRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createChatRecordData({
  DocumentReference? userA,
  DocumentReference? userB,
  String? lastMessage,
  DateTime? lastmessageTime,
  bool? isRequested,
  String? requestReply,
  DateTime? requestReplyTime,
  DocumentReference? lastMessageuserRef,
  String? eventImage,
  int? displayDialogCount,
  DocumentReference? author,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userA': userA,
      'userB': userB,
      'last_message': lastMessage,
      'lastmessage_time': lastmessageTime,
      'isRequested': isRequested,
      'requestReply': requestReply,
      'requestReplyTime': requestReplyTime,
      'lastMessageuserRef': lastMessageuserRef,
      'event_image': eventImage,
      'displayDialogCount': displayDialogCount,
      'author': author,
    }.withoutNulls,
  );

  return firestoreData;
}

class ChatRecordDocumentEquality implements Equality<ChatRecord> {
  const ChatRecordDocumentEquality();

  @override
  bool equals(ChatRecord? e1, ChatRecord? e2) {
    const listEquality = ListEquality();
    return e1?.userA == e2?.userA &&
        e1?.userB == e2?.userB &&
        e1?.lastMessage == e2?.lastMessage &&
        e1?.lastmessageTime == e2?.lastmessageTime &&
        e1?.isRequested == e2?.isRequested &&
        e1?.requestReply == e2?.requestReply &&
        e1?.requestReplyTime == e2?.requestReplyTime &&
        e1?.lastMessageuserRef == e2?.lastMessageuserRef &&
        e1?.eventImage == e2?.eventImage &&
        listEquality.equals(e1?.blockBy, e2?.blockBy) &&
        listEquality.equals(e1?.responseList, e2?.responseList) &&
        e1?.displayDialogCount == e2?.displayDialogCount &&
        listEquality.equals(e1?.dialogVisiableUsers, e2?.dialogVisiableUsers) &&
        listEquality.equals(e1?.users, e2?.users) &&
        e1?.author == e2?.author &&
        listEquality.equals(e1?.weMetList, e2?.weMetList);
  }

  @override
  int hash(ChatRecord? e) => const ListEquality().hash([
        e?.userA,
        e?.userB,
        e?.lastMessage,
        e?.lastmessageTime,
        e?.isRequested,
        e?.requestReply,
        e?.requestReplyTime,
        e?.lastMessageuserRef,
        e?.eventImage,
        e?.blockBy,
        e?.responseList,
        e?.displayDialogCount,
        e?.dialogVisiableUsers,
        e?.users,
        e?.author,
        e?.weMetList
      ]);

  @override
  bool isValidKey(Object? o) => o is ChatRecord;
}

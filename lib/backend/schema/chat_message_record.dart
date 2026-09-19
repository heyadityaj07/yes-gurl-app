import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatMessageRecord extends FirestoreRecord {
  ChatMessageRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "chat_text" field.
  String? _chatText;
  String get chatText => _chatText ?? '';
  bool hasChatText() => _chatText != null;

  // "text_time" field.
  DateTime? _textTime;
  DateTime? get textTime => _textTime;
  bool hasTextTime() => _textTime != null;

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "chatRef" field.
  DocumentReference? _chatRef;
  DocumentReference? get chatRef => _chatRef;
  bool hasChatRef() => _chatRef != null;

  // "event_image" field.
  String? _eventImage;
  String get eventImage => _eventImage ?? '';
  bool hasEventImage() => _eventImage != null;

  // "event_reference" field.
  DocumentReference? _eventReference;
  DocumentReference? get eventReference => _eventReference;
  bool hasEventReference() => _eventReference != null;

  // "isseen" field.
  bool? _isseen;
  bool get isseen => _isseen ?? false;
  bool hasIsseen() => _isseen != null;

  // "recieverRef" field.
  DocumentReference? _recieverRef;
  DocumentReference? get recieverRef => _recieverRef;
  bool hasRecieverRef() => _recieverRef != null;

  void _initializeFields() {
    _chatText = snapshotData['chat_text'] as String?;
    _textTime = snapshotData['text_time'] as DateTime?;
    _userRef = snapshotData['userRef'] as DocumentReference?;
    _chatRef = snapshotData['chatRef'] as DocumentReference?;
    _eventImage = snapshotData['event_image'] as String?;
    _eventReference = snapshotData['event_reference'] as DocumentReference?;
    _isseen = snapshotData['isseen'] as bool?;
    _recieverRef = snapshotData['recieverRef'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Chat_Message');

  static Stream<ChatMessageRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChatMessageRecord.fromSnapshot(s));

  static Future<ChatMessageRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChatMessageRecord.fromSnapshot(s));

  static ChatMessageRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ChatMessageRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChatMessageRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChatMessageRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ChatMessageRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChatMessageRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createChatMessageRecordData({
  String? chatText,
  DateTime? textTime,
  DocumentReference? userRef,
  DocumentReference? chatRef,
  String? eventImage,
  DocumentReference? eventReference,
  bool? isseen,
  DocumentReference? recieverRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'chat_text': chatText,
      'text_time': textTime,
      'userRef': userRef,
      'chatRef': chatRef,
      'event_image': eventImage,
      'event_reference': eventReference,
      'isseen': isseen,
      'recieverRef': recieverRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class ChatMessageRecordDocumentEquality implements Equality<ChatMessageRecord> {
  const ChatMessageRecordDocumentEquality();

  @override
  bool equals(ChatMessageRecord? e1, ChatMessageRecord? e2) {
    return e1?.chatText == e2?.chatText &&
        e1?.textTime == e2?.textTime &&
        e1?.userRef == e2?.userRef &&
        e1?.chatRef == e2?.chatRef &&
        e1?.eventImage == e2?.eventImage &&
        e1?.eventReference == e2?.eventReference &&
        e1?.isseen == e2?.isseen &&
        e1?.recieverRef == e2?.recieverRef;
  }

  @override
  int hash(ChatMessageRecord? e) => const ListEquality().hash([
        e?.chatText,
        e?.textTime,
        e?.userRef,
        e?.chatRef,
        e?.eventImage,
        e?.eventReference,
        e?.isseen,
        e?.recieverRef
      ]);

  @override
  bool isValidKey(Object? o) => o is ChatMessageRecord;
}

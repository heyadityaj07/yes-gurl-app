import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EventsCommentRecord extends FirestoreRecord {
  EventsCommentRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "comment_title" field.
  String? _commentTitle;
  String get commentTitle => _commentTitle ?? '';
  bool hasCommentTitle() => _commentTitle != null;

  // "comment_time" field.
  DateTime? _commentTime;
  DateTime? get commentTime => _commentTime;
  bool hasCommentTime() => _commentTime != null;

  // "comment_userRef" field.
  DocumentReference? _commentUserRef;
  DocumentReference? get commentUserRef => _commentUserRef;
  bool hasCommentUserRef() => _commentUserRef != null;

  // "comment_eventRef" field.
  DocumentReference? _commentEventRef;
  DocumentReference? get commentEventRef => _commentEventRef;
  bool hasCommentEventRef() => _commentEventRef != null;

  // "comment_report" field.
  List<DocumentReference>? _commentReport;
  List<DocumentReference> get commentReport => _commentReport ?? const [];
  bool hasCommentReport() => _commentReport != null;

  // "notification_send" field.
  bool? _notificationSend;
  bool get notificationSend => _notificationSend ?? false;
  bool hasNotificationSend() => _notificationSend != null;

  void _initializeFields() {
    _commentTitle = snapshotData['comment_title'] as String?;
    _commentTime = snapshotData['comment_time'] as DateTime?;
    _commentUserRef = snapshotData['comment_userRef'] as DocumentReference?;
    _commentEventRef = snapshotData['comment_eventRef'] as DocumentReference?;
    _commentReport = getDataList(snapshotData['comment_report']);
    _notificationSend = snapshotData['notification_send'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('events_comment');

  static Stream<EventsCommentRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EventsCommentRecord.fromSnapshot(s));

  static Future<EventsCommentRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => EventsCommentRecord.fromSnapshot(s));

  static EventsCommentRecord fromSnapshot(DocumentSnapshot snapshot) =>
      EventsCommentRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EventsCommentRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EventsCommentRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EventsCommentRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EventsCommentRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEventsCommentRecordData({
  String? commentTitle,
  DateTime? commentTime,
  DocumentReference? commentUserRef,
  DocumentReference? commentEventRef,
  bool? notificationSend,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'comment_title': commentTitle,
      'comment_time': commentTime,
      'comment_userRef': commentUserRef,
      'comment_eventRef': commentEventRef,
      'notification_send': notificationSend,
    }.withoutNulls,
  );

  return firestoreData;
}

class EventsCommentRecordDocumentEquality
    implements Equality<EventsCommentRecord> {
  const EventsCommentRecordDocumentEquality();

  @override
  bool equals(EventsCommentRecord? e1, EventsCommentRecord? e2) {
    const listEquality = ListEquality();
    return e1?.commentTitle == e2?.commentTitle &&
        e1?.commentTime == e2?.commentTime &&
        e1?.commentUserRef == e2?.commentUserRef &&
        e1?.commentEventRef == e2?.commentEventRef &&
        listEquality.equals(e1?.commentReport, e2?.commentReport) &&
        e1?.notificationSend == e2?.notificationSend;
  }

  @override
  int hash(EventsCommentRecord? e) => const ListEquality().hash([
        e?.commentTitle,
        e?.commentTime,
        e?.commentUserRef,
        e?.commentEventRef,
        e?.commentReport,
        e?.notificationSend
      ]);

  @override
  bool isValidKey(Object? o) => o is EventsCommentRecord;
}

import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

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

  // "event_likes" field.
  List<DocumentReference>? _eventLikes;
  List<DocumentReference> get eventLikes => _eventLikes ?? const [];
  bool hasEventLikes() => _eventLikes != null;

  // "reply_comment" field.
  DocumentReference? _replyComment;
  DocumentReference? get replyComment => _replyComment;
  bool hasReplyComment() => _replyComment != null;

  // "deleted_at" field.
  DateTime? _deletedAt;
  DateTime? get deletedAt => _deletedAt;
  bool hasDeletedAt() => _deletedAt != null;

  // "deleted_by" field.
  DocumentReference? _deletedBy;
  DocumentReference? get deletedBy => _deletedBy;
  bool hasDeletedBy() => _deletedBy != null;

  // "comment_seen_by" field.
  List<DocumentReference>? _commentSeenBy;
  List<DocumentReference> get commentSeenBy => _commentSeenBy ?? const [];
  bool hasCommentSeenBy() => _commentSeenBy != null;

  void _initializeFields() {
    _commentTitle = snapshotData['comment_title'] as String?;
    _commentTime = snapshotData['comment_time'] as DateTime?;
    _commentUserRef = snapshotData['comment_userRef'] as DocumentReference?;
    _commentEventRef = snapshotData['comment_eventRef'] as DocumentReference?;
    _commentReport = getDataList(snapshotData['comment_report']);
    _notificationSend = snapshotData['notification_send'] as bool?;
    _eventLikes = getDataList(snapshotData['event_likes']);
    _replyComment = snapshotData['reply_comment'] as DocumentReference?;
    _deletedAt = snapshotData['deleted_at'] as DateTime?;
    _deletedBy = snapshotData['deleted_by'] as DocumentReference?;
    _commentSeenBy = getDataList(snapshotData['comment_seen_by']);
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
      other is EventsCommentRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createEventsCommentRecordData({
  String? commentTitle,
  DateTime? commentTime,
  DocumentReference? commentUserRef,
  DocumentReference? commentEventRef,
  bool? notificationSend,
  DocumentReference? replyComment,
  DateTime? deletedAt,
  DocumentReference? deletedBy,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'comment_title': commentTitle,
      'comment_time': commentTime,
      'comment_userRef': commentUserRef,
      'comment_eventRef': commentEventRef,
      'notification_send': notificationSend,
      'reply_comment': replyComment,
      'deleted_at': deletedAt,
      'deleted_by': deletedBy,
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
        e1?.notificationSend == e2?.notificationSend &&
        listEquality.equals(e1?.eventLikes, e2?.eventLikes) &&
        e1?.replyComment == e2?.replyComment &&
        e1?.deletedAt == e2?.deletedAt &&
        e1?.deletedBy == e2?.deletedBy &&
        listEquality.equals(e1?.commentSeenBy, e2?.commentSeenBy);
  }

  @override
  int hash(EventsCommentRecord? e) => const ListEquality().hash([
        e?.commentTitle,
        e?.commentTime,
        e?.commentUserRef,
        e?.commentEventRef,
        const ListEquality().hash(e?.commentReport),
        e?.notificationSend,
        const ListEquality().hash(e?.eventLikes),
        e?.replyComment,
        e?.deletedAt,
        e?.deletedBy,
        const ListEquality().hash(e?.commentSeenBy)
      ]);

  @override
  bool isValidKey(Object? o) => o is EventsCommentRecord;
}

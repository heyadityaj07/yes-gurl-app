import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ReportRecord extends FirestoreRecord {
  ReportRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user_reference" field.
  DocumentReference? _userReference;
  DocumentReference? get userReference => _userReference;
  bool hasUserReference() => _userReference != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "report_user" field.
  DocumentReference? _reportUser;
  DocumentReference? get reportUser => _reportUser;
  bool hasReportUser() => _reportUser != null;

  // "linked_up" field.
  DocumentReference? _linkedUp;
  DocumentReference? get linkedUp => _linkedUp;
  bool hasLinkedUp() => _linkedUp != null;

  // "chat_ref" field.
  DocumentReference? _chatRef;
  DocumentReference? get chatRef => _chatRef;
  bool hasChatRef() => _chatRef != null;

  // "event_comment_reference" field.
  DocumentReference? _eventCommentReference;
  DocumentReference? get eventCommentReference => _eventCommentReference;
  bool hasEventCommentReference() => _eventCommentReference != null;

  // "community" field.
  DocumentReference? _community;
  DocumentReference? get community => _community;
  bool hasCommunity() => _community != null;

  // "community_message" field.
  DocumentReference? _communityMessage;
  DocumentReference? get communityMessage => _communityMessage;
  bool hasCommunityMessage() => _communityMessage != null;

  void _initializeFields() {
    _userReference = snapshotData['user_reference'] as DocumentReference?;
    _title = snapshotData['title'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _reportUser = snapshotData['report_user'] as DocumentReference?;
    _linkedUp = snapshotData['linked_up'] as DocumentReference?;
    _chatRef = snapshotData['chat_ref'] as DocumentReference?;
    _eventCommentReference =
        snapshotData['event_comment_reference'] as DocumentReference?;
    _community = snapshotData['community'] as DocumentReference?;
    _communityMessage = snapshotData['community_message'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('report');

  static Stream<ReportRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ReportRecord.fromSnapshot(s));

  static Future<ReportRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ReportRecord.fromSnapshot(s));

  static ReportRecord fromSnapshot(DocumentSnapshot snapshot) => ReportRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ReportRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ReportRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ReportRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ReportRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createReportRecordData({
  DocumentReference? userReference,
  String? title,
  DateTime? createdTime,
  DocumentReference? reportUser,
  DocumentReference? linkedUp,
  DocumentReference? chatRef,
  DocumentReference? eventCommentReference,
  DocumentReference? community,
  DocumentReference? communityMessage,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user_reference': userReference,
      'title': title,
      'created_time': createdTime,
      'report_user': reportUser,
      'linked_up': linkedUp,
      'chat_ref': chatRef,
      'event_comment_reference': eventCommentReference,
      'community': community,
      'community_message': communityMessage,
    }.withoutNulls,
  );

  return firestoreData;
}

class ReportRecordDocumentEquality implements Equality<ReportRecord> {
  const ReportRecordDocumentEquality();

  @override
  bool equals(ReportRecord? e1, ReportRecord? e2) {
    return e1?.userReference == e2?.userReference &&
        e1?.title == e2?.title &&
        e1?.createdTime == e2?.createdTime &&
        e1?.reportUser == e2?.reportUser &&
        e1?.linkedUp == e2?.linkedUp &&
        e1?.chatRef == e2?.chatRef &&
        e1?.eventCommentReference == e2?.eventCommentReference &&
        e1?.community == e2?.community &&
        e1?.communityMessage == e2?.communityMessage;
  }

  @override
  int hash(ReportRecord? e) => const ListEquality().hash([
        e?.userReference,
        e?.title,
        e?.createdTime,
        e?.reportUser,
        e?.linkedUp,
        e?.chatRef,
        e?.eventCommentReference,
        e?.community,
        e?.communityMessage
      ]);

  @override
  bool isValidKey(Object? o) => o is ReportRecord;
}

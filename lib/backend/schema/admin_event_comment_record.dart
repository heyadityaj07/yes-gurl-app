import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AdminEventCommentRecord extends FirestoreRecord {
  AdminEventCommentRecord._(
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

  void _initializeFields() {
    _commentTitle = snapshotData['comment_title'] as String?;
    _commentTime = snapshotData['comment_time'] as DateTime?;
    _commentUserRef = snapshotData['comment_userRef'] as DocumentReference?;
    _commentEventRef = snapshotData['comment_eventRef'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('admin_event_comment');

  static Stream<AdminEventCommentRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AdminEventCommentRecord.fromSnapshot(s));

  static Future<AdminEventCommentRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => AdminEventCommentRecord.fromSnapshot(s));

  static AdminEventCommentRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AdminEventCommentRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AdminEventCommentRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AdminEventCommentRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AdminEventCommentRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AdminEventCommentRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAdminEventCommentRecordData({
  String? commentTitle,
  DateTime? commentTime,
  DocumentReference? commentUserRef,
  DocumentReference? commentEventRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'comment_title': commentTitle,
      'comment_time': commentTime,
      'comment_userRef': commentUserRef,
      'comment_eventRef': commentEventRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class AdminEventCommentRecordDocumentEquality
    implements Equality<AdminEventCommentRecord> {
  const AdminEventCommentRecordDocumentEquality();

  @override
  bool equals(AdminEventCommentRecord? e1, AdminEventCommentRecord? e2) {
    return e1?.commentTitle == e2?.commentTitle &&
        e1?.commentTime == e2?.commentTime &&
        e1?.commentUserRef == e2?.commentUserRef &&
        e1?.commentEventRef == e2?.commentEventRef;
  }

  @override
  int hash(AdminEventCommentRecord? e) => const ListEquality().hash(
      [e?.commentTitle, e?.commentTime, e?.commentUserRef, e?.commentEventRef]);

  @override
  bool isValidKey(Object? o) => o is AdminEventCommentRecord;
}

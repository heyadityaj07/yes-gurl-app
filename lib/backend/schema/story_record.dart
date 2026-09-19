import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class StoryRecord extends FirestoreRecord {
  StoryRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user_reference" field.
  DocumentReference? _userReference;
  DocumentReference? get userReference => _userReference;
  bool hasUserReference() => _userReference != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "anonymous" field.
  bool? _anonymous;
  bool get anonymous => _anonymous ?? false;
  bool hasAnonymous() => _anonymous != null;

  void _initializeFields() {
    _userReference = snapshotData['user_reference'] as DocumentReference?;
    _description = snapshotData['description'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _anonymous = snapshotData['anonymous'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('story');

  static Stream<StoryRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => StoryRecord.fromSnapshot(s));

  static Future<StoryRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => StoryRecord.fromSnapshot(s));

  static StoryRecord fromSnapshot(DocumentSnapshot snapshot) => StoryRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static StoryRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      StoryRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'StoryRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is StoryRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createStoryRecordData({
  DocumentReference? userReference,
  String? description,
  DateTime? createdTime,
  bool? anonymous,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user_reference': userReference,
      'description': description,
      'created_time': createdTime,
      'anonymous': anonymous,
    }.withoutNulls,
  );

  return firestoreData;
}

class StoryRecordDocumentEquality implements Equality<StoryRecord> {
  const StoryRecordDocumentEquality();

  @override
  bool equals(StoryRecord? e1, StoryRecord? e2) {
    return e1?.userReference == e2?.userReference &&
        e1?.description == e2?.description &&
        e1?.createdTime == e2?.createdTime &&
        e1?.anonymous == e2?.anonymous;
  }

  @override
  int hash(StoryRecord? e) => const ListEquality()
      .hash([e?.userReference, e?.description, e?.createdTime, e?.anonymous]);

  @override
  bool isValidKey(Object? o) => o is StoryRecord;
}

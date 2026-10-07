import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BrodcastRecord extends FirestoreRecord {
  BrodcastRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  bool hasMessage() => _message != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "seen_by" field.
  List<DocumentReference>? _seenBy;
  List<DocumentReference> get seenBy => _seenBy ?? const [];
  bool hasSeenBy() => _seenBy != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _message = snapshotData['message'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _seenBy = getDataList(snapshotData['seen_by']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('brodcast');

  static Stream<BrodcastRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => BrodcastRecord.fromSnapshot(s));

  static Future<BrodcastRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => BrodcastRecord.fromSnapshot(s));

  static BrodcastRecord fromSnapshot(DocumentSnapshot snapshot) =>
      BrodcastRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static BrodcastRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      BrodcastRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'BrodcastRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is BrodcastRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createBrodcastRecordData({
  String? title,
  String? message,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'message': message,
      'created_at': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class BrodcastRecordDocumentEquality implements Equality<BrodcastRecord> {
  const BrodcastRecordDocumentEquality();

  @override
  bool equals(BrodcastRecord? e1, BrodcastRecord? e2) {
    const listEquality = ListEquality();
    return e1?.title == e2?.title &&
        e1?.message == e2?.message &&
        e1?.createdAt == e2?.createdAt &&
        listEquality.equals(e1?.seenBy, e2?.seenBy);
  }

  @override
  int hash(BrodcastRecord? e) => const ListEquality().hash([
        e?.title,
        e?.message,
        e?.createdAt,
        const ListEquality().hash(e?.seenBy)
      ]);

  @override
  bool isValidKey(Object? o) => o is BrodcastRecord;
}

import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class QuestionsRecord extends FirestoreRecord {
  QuestionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "A" field.
  String? _a;
  String get a => _a ?? '';
  bool hasA() => _a != null;

  // "B" field.
  String? _b;
  String get b => _b ?? '';
  bool hasB() => _b != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "orderBy" field.
  int? _orderBy;
  int get orderBy => _orderBy ?? 0;
  bool hasOrderBy() => _orderBy != null;

  void _initializeFields() {
    _a = snapshotData['A'] as String?;
    _b = snapshotData['B'] as String?;
    _title = snapshotData['title'] as String?;
    _orderBy = castToType<int>(snapshotData['orderBy']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('questions');

  static Stream<QuestionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => QuestionsRecord.fromSnapshot(s));

  static Future<QuestionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => QuestionsRecord.fromSnapshot(s));

  static QuestionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      QuestionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static QuestionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      QuestionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'QuestionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is QuestionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createQuestionsRecordData({
  String? a,
  String? b,
  String? title,
  int? orderBy,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'A': a,
      'B': b,
      'title': title,
      'orderBy': orderBy,
    }.withoutNulls,
  );

  return firestoreData;
}

class QuestionsRecordDocumentEquality implements Equality<QuestionsRecord> {
  const QuestionsRecordDocumentEquality();

  @override
  bool equals(QuestionsRecord? e1, QuestionsRecord? e2) {
    return e1?.a == e2?.a &&
        e1?.b == e2?.b &&
        e1?.title == e2?.title &&
        e1?.orderBy == e2?.orderBy;
  }

  @override
  int hash(QuestionsRecord? e) =>
      const ListEquality().hash([e?.a, e?.b, e?.title, e?.orderBy]);

  @override
  bool isValidKey(Object? o) => o is QuestionsRecord;
}

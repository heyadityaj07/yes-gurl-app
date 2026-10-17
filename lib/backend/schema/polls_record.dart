import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PollsRecord extends FirestoreRecord {
  PollsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "question" field.
  String? _question;
  String get question => _question ?? '';
  bool hasQuestion() => _question != null;

  // "options" field.
  List<String>? _options;
  List<String> get options => _options ?? const [];
  bool hasOptions() => _options != null;

  // "optionVotes" field.
  List<int>? _optionVotes;
  List<int> get optionVotes => _optionVotes ?? const [];
  bool hasOptionVotes() => _optionVotes != null;

  // "totalVotes" field.
  int? _totalVotes;
  int get totalVotes => _totalVotes ?? 0;
  bool hasTotalVotes() => _totalVotes != null;

  // "voteUserRefs" field.
  List<DocumentReference>? _voteUserRefs;
  List<DocumentReference> get voteUserRefs => _voteUserRefs ?? const [];
  bool hasVoteUserRefs() => _voteUserRefs != null;

  // "voteDetails" field.
  List<VoteDataStruct>? _voteDetails;
  List<VoteDataStruct> get voteDetails => _voteDetails ?? const [];
  bool hasVoteDetails() => _voteDetails != null;

  // "active" field.
  bool? _active;
  bool get active => _active ?? false;
  bool hasActive() => _active != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _question = snapshotData['question'] as String?;
    _options = getDataList(snapshotData['options']);
    _optionVotes = getDataList(snapshotData['optionVotes']);
    _totalVotes = castToType<int>(snapshotData['totalVotes']);
    _voteUserRefs = getDataList(snapshotData['voteUserRefs']);
    _voteDetails = getStructList(
      snapshotData['voteDetails'],
      VoteDataStruct.fromMap,
    );
    _active = snapshotData['active'] as bool?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('polls');

  static Stream<PollsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PollsRecord.fromSnapshot(s));

  static Future<PollsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PollsRecord.fromSnapshot(s));

  static PollsRecord fromSnapshot(DocumentSnapshot snapshot) => PollsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PollsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PollsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PollsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PollsRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createPollsRecordData({
  String? question,
  int? totalVotes,
  bool? active,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'question': question,
      'totalVotes': totalVotes,
      'active': active,
      'createdAt': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class PollsRecordDocumentEquality implements Equality<PollsRecord> {
  const PollsRecordDocumentEquality();

  @override
  bool equals(PollsRecord? e1, PollsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.question == e2?.question &&
        listEquality.equals(e1?.options, e2?.options) &&
        listEquality.equals(e1?.optionVotes, e2?.optionVotes) &&
        e1?.totalVotes == e2?.totalVotes &&
        listEquality.equals(e1?.voteUserRefs, e2?.voteUserRefs) &&
        listEquality.equals(e1?.voteDetails, e2?.voteDetails) &&
        e1?.active == e2?.active &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(PollsRecord? e) => const ListEquality().hash([
        e?.question,
        const ListEquality().hash(e?.options),
        const ListEquality().hash(e?.optionVotes),
        e?.totalVotes,
        const ListEquality().hash(e?.voteUserRefs),
        const ListEquality().hash(e?.voteDetails),
        e?.active,
        e?.createdAt
      ]);

  @override
  bool isValidKey(Object? o) => o is PollsRecord;
}

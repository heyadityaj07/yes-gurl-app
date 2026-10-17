import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ClubFeaturesRecord extends FirestoreRecord {
  ClubFeaturesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "sessions" field.
  bool? _sessions;
  bool get sessions => _sessions ?? false;
  bool hasSessions() => _sessions != null;

  // "spotlight" field.
  bool? _spotlight;
  bool get spotlight => _spotlight ?? false;
  bool hasSpotlight() => _spotlight != null;

  // "clicks" field.
  int? _clicks;
  int get clicks => _clicks ?? 0;
  bool hasClicks() => _clicks != null;

  void _initializeFields() {
    _sessions = snapshotData['sessions'] as bool?;
    _spotlight = snapshotData['spotlight'] as bool?;
    _clicks = castToType<int>(snapshotData['clicks']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('club_features');

  static Stream<ClubFeaturesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ClubFeaturesRecord.fromSnapshot(s));

  static Future<ClubFeaturesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ClubFeaturesRecord.fromSnapshot(s));

  static ClubFeaturesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ClubFeaturesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ClubFeaturesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ClubFeaturesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ClubFeaturesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ClubFeaturesRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createClubFeaturesRecordData({
  bool? sessions,
  bool? spotlight,
  int? clicks,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'sessions': sessions,
      'spotlight': spotlight,
      'clicks': clicks,
    }.withoutNulls,
  );

  return firestoreData;
}

class ClubFeaturesRecordDocumentEquality
    implements Equality<ClubFeaturesRecord> {
  const ClubFeaturesRecordDocumentEquality();

  @override
  bool equals(ClubFeaturesRecord? e1, ClubFeaturesRecord? e2) {
    return e1?.sessions == e2?.sessions &&
        e1?.spotlight == e2?.spotlight &&
        e1?.clicks == e2?.clicks;
  }

  @override
  int hash(ClubFeaturesRecord? e) =>
      const ListEquality().hash([e?.sessions, e?.spotlight, e?.clicks]);

  @override
  bool isValidKey(Object? o) => o is ClubFeaturesRecord;
}

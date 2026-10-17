import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SpotlightRecord extends FirestoreRecord {
  SpotlightRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "spotlight" field.
  String? _spotlight;
  String get spotlight => _spotlight ?? '';
  bool hasSpotlight() => _spotlight != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "status" field.
  InvitationStatus? _status;
  InvitationStatus? get status => _status;
  bool hasStatus() => _status != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  void _initializeFields() {
    _spotlight = snapshotData['spotlight'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _user = snapshotData['user'] as DocumentReference?;
    _status = snapshotData['status'] is InvitationStatus
        ? snapshotData['status']
        : deserializeEnum<InvitationStatus>(snapshotData['status']);
    _email = snapshotData['email'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('spotlight');

  static Stream<SpotlightRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SpotlightRecord.fromSnapshot(s));

  static Future<SpotlightRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SpotlightRecord.fromSnapshot(s));

  static SpotlightRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SpotlightRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SpotlightRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SpotlightRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SpotlightRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SpotlightRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createSpotlightRecordData({
  String? spotlight,
  DateTime? createdAt,
  DocumentReference? user,
  InvitationStatus? status,
  String? email,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'spotlight': spotlight,
      'created_at': createdAt,
      'user': user,
      'status': status,
      'email': email,
    }.withoutNulls,
  );

  return firestoreData;
}

class SpotlightRecordDocumentEquality implements Equality<SpotlightRecord> {
  const SpotlightRecordDocumentEquality();

  @override
  bool equals(SpotlightRecord? e1, SpotlightRecord? e2) {
    return e1?.spotlight == e2?.spotlight &&
        e1?.createdAt == e2?.createdAt &&
        e1?.user == e2?.user &&
        e1?.status == e2?.status &&
        e1?.email == e2?.email;
  }

  @override
  int hash(SpotlightRecord? e) => const ListEquality()
      .hash([e?.spotlight, e?.createdAt, e?.user, e?.status, e?.email]);

  @override
  bool isValidKey(Object? o) => o is SpotlightRecord;
}

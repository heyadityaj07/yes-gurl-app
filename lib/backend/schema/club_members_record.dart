import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ClubMembersRecord extends FirestoreRecord {
  ClubMembersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "is_active" field.
  bool? _isActive;
  bool get isActive => _isActive ?? false;
  bool hasIsActive() => _isActive != null;

  // "purchase_date" field.
  DateTime? _purchaseDate;
  DateTime? get purchaseDate => _purchaseDate;
  bool hasPurchaseDate() => _purchaseDate != null;

  void _initializeFields() {
    _user = snapshotData['user'] as DocumentReference?;
    _isActive = snapshotData['is_active'] as bool?;
    _purchaseDate = snapshotData['purchase_date'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('club_members');

  static Stream<ClubMembersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ClubMembersRecord.fromSnapshot(s));

  static Future<ClubMembersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ClubMembersRecord.fromSnapshot(s));

  static ClubMembersRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ClubMembersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ClubMembersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ClubMembersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ClubMembersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ClubMembersRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createClubMembersRecordData({
  DocumentReference? user,
  bool? isActive,
  DateTime? purchaseDate,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user': user,
      'is_active': isActive,
      'purchase_date': purchaseDate,
    }.withoutNulls,
  );

  return firestoreData;
}

class ClubMembersRecordDocumentEquality implements Equality<ClubMembersRecord> {
  const ClubMembersRecordDocumentEquality();

  @override
  bool equals(ClubMembersRecord? e1, ClubMembersRecord? e2) {
    return e1?.user == e2?.user &&
        e1?.isActive == e2?.isActive &&
        e1?.purchaseDate == e2?.purchaseDate;
  }

  @override
  int hash(ClubMembersRecord? e) =>
      const ListEquality().hash([e?.user, e?.isActive, e?.purchaseDate]);

  @override
  bool isValidKey(Object? o) => o is ClubMembersRecord;
}

import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class JoinRequestsRecord extends FirestoreRecord {
  JoinRequestsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user_ref" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "host_ref" field.
  DocumentReference? _hostRef;
  DocumentReference? get hostRef => _hostRef;
  bool hasHostRef() => _hostRef != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "status" field.
  InvitationStatus? _status;
  InvitationStatus? get status => _status;
  bool hasStatus() => _status != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _userRef = snapshotData['user_ref'] as DocumentReference?;
    _hostRef = snapshotData['host_ref'] as DocumentReference?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _status = snapshotData['status'] is InvitationStatus
        ? snapshotData['status']
        : deserializeEnum<InvitationStatus>(snapshotData['status']);
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('join_requests')
          : FirebaseFirestore.instance.collectionGroup('join_requests');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('join_requests').doc(id);

  static Stream<JoinRequestsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => JoinRequestsRecord.fromSnapshot(s));

  static Future<JoinRequestsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => JoinRequestsRecord.fromSnapshot(s));

  static JoinRequestsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      JoinRequestsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static JoinRequestsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      JoinRequestsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'JoinRequestsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is JoinRequestsRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createJoinRequestsRecordData({
  DocumentReference? userRef,
  DocumentReference? hostRef,
  DateTime? createdAt,
  InvitationStatus? status,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user_ref': userRef,
      'host_ref': hostRef,
      'created_at': createdAt,
      'status': status,
    }.withoutNulls,
  );

  return firestoreData;
}

class JoinRequestsRecordDocumentEquality
    implements Equality<JoinRequestsRecord> {
  const JoinRequestsRecordDocumentEquality();

  @override
  bool equals(JoinRequestsRecord? e1, JoinRequestsRecord? e2) {
    return e1?.userRef == e2?.userRef &&
        e1?.hostRef == e2?.hostRef &&
        e1?.createdAt == e2?.createdAt &&
        e1?.status == e2?.status;
  }

  @override
  int hash(JoinRequestsRecord? e) => const ListEquality()
      .hash([e?.userRef, e?.hostRef, e?.createdAt, e?.status]);

  @override
  bool isValidKey(Object? o) => o is JoinRequestsRecord;
}

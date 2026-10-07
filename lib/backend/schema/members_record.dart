import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MembersRecord extends FirestoreRecord {
  MembersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user_ref" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "joined_at" field.
  DateTime? _joinedAt;
  DateTime? get joinedAt => _joinedAt;
  bool hasJoinedAt() => _joinedAt != null;

  // "role" field.
  String? _role;
  String get role => _role ?? '';
  bool hasRole() => _role != null;

  // "notifications_enabled" field.
  bool? _notificationsEnabled;
  bool get notificationsEnabled => _notificationsEnabled ?? false;
  bool hasNotificationsEnabled() => _notificationsEnabled != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _userRef = snapshotData['user_ref'] as DocumentReference?;
    _joinedAt = snapshotData['joined_at'] as DateTime?;
    _role = snapshotData['role'] as String?;
    _notificationsEnabled = snapshotData['notifications_enabled'] as bool?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('members')
          : FirebaseFirestore.instance.collectionGroup('members');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('members').doc(id);

  static Stream<MembersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MembersRecord.fromSnapshot(s));

  static Future<MembersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MembersRecord.fromSnapshot(s));

  static MembersRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MembersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MembersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MembersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MembersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MembersRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createMembersRecordData({
  DocumentReference? userRef,
  DateTime? joinedAt,
  String? role,
  bool? notificationsEnabled,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user_ref': userRef,
      'joined_at': joinedAt,
      'role': role,
      'notifications_enabled': notificationsEnabled,
    }.withoutNulls,
  );

  return firestoreData;
}

class MembersRecordDocumentEquality implements Equality<MembersRecord> {
  const MembersRecordDocumentEquality();

  @override
  bool equals(MembersRecord? e1, MembersRecord? e2) {
    return e1?.userRef == e2?.userRef &&
        e1?.joinedAt == e2?.joinedAt &&
        e1?.role == e2?.role &&
        e1?.notificationsEnabled == e2?.notificationsEnabled;
  }

  @override
  int hash(MembersRecord? e) => const ListEquality()
      .hash([e?.userRef, e?.joinedAt, e?.role, e?.notificationsEnabled]);

  @override
  bool isValidKey(Object? o) => o is MembersRecord;
}

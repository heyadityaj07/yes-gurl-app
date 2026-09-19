import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AdminEventsRecord extends FirestoreRecord {
  AdminEventsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "start_time" field.
  DateTime? _startTime;
  DateTime? get startTime => _startTime;
  bool hasStartTime() => _startTime != null;

  // "end_time" field.
  DateTime? _endTime;
  DateTime? get endTime => _endTime;
  bool hasEndTime() => _endTime != null;

  // "created_by" field.
  DocumentReference? _createdBy;
  DocumentReference? get createdBy => _createdBy;
  bool hasCreatedBy() => _createdBy != null;

  // "attending" field.
  List<DocumentReference>? _attending;
  List<DocumentReference> get attending => _attending ?? const [];
  bool hasAttending() => _attending != null;

  // "cover_image" field.
  String? _coverImage;
  String get coverImage => _coverImage ?? '';
  bool hasCoverImage() => _coverImage != null;

  // "address" field.
  String? _address;
  String get address => _address ?? '';
  bool hasAddress() => _address != null;

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "invited_user" field.
  List<DocumentReference>? _invitedUser;
  List<DocumentReference> get invitedUser => _invitedUser ?? const [];
  bool hasInvitedUser() => _invitedUser != null;

  // "user_Pic" field.
  String? _userPic;
  String get userPic => _userPic ?? '';
  bool hasUserPic() => _userPic != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _description = snapshotData['description'] as String?;
    _date = snapshotData['date'] as DateTime?;
    _startTime = snapshotData['start_time'] as DateTime?;
    _endTime = snapshotData['end_time'] as DateTime?;
    _createdBy = snapshotData['created_by'] as DocumentReference?;
    _attending = getDataList(snapshotData['attending']);
    _coverImage = snapshotData['cover_image'] as String?;
    _address = snapshotData['address'] as String?;
    _userRef = snapshotData['userRef'] as DocumentReference?;
    _invitedUser = getDataList(snapshotData['invited_user']);
    _userPic = snapshotData['user_Pic'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('admin_events');

  static Stream<AdminEventsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AdminEventsRecord.fromSnapshot(s));

  static Future<AdminEventsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AdminEventsRecord.fromSnapshot(s));

  static AdminEventsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AdminEventsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AdminEventsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AdminEventsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AdminEventsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AdminEventsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAdminEventsRecordData({
  String? name,
  String? description,
  DateTime? date,
  DateTime? startTime,
  DateTime? endTime,
  DocumentReference? createdBy,
  String? coverImage,
  String? address,
  DocumentReference? userRef,
  String? userPic,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'description': description,
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
      'created_by': createdBy,
      'cover_image': coverImage,
      'address': address,
      'userRef': userRef,
      'user_Pic': userPic,
    }.withoutNulls,
  );

  return firestoreData;
}

class AdminEventsRecordDocumentEquality implements Equality<AdminEventsRecord> {
  const AdminEventsRecordDocumentEquality();

  @override
  bool equals(AdminEventsRecord? e1, AdminEventsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.name == e2?.name &&
        e1?.description == e2?.description &&
        e1?.date == e2?.date &&
        e1?.startTime == e2?.startTime &&
        e1?.endTime == e2?.endTime &&
        e1?.createdBy == e2?.createdBy &&
        listEquality.equals(e1?.attending, e2?.attending) &&
        e1?.coverImage == e2?.coverImage &&
        e1?.address == e2?.address &&
        e1?.userRef == e2?.userRef &&
        listEquality.equals(e1?.invitedUser, e2?.invitedUser) &&
        e1?.userPic == e2?.userPic;
  }

  @override
  int hash(AdminEventsRecord? e) => const ListEquality().hash([
        e?.name,
        e?.description,
        e?.date,
        e?.startTime,
        e?.endTime,
        e?.createdBy,
        e?.attending,
        e?.coverImage,
        e?.address,
        e?.userRef,
        e?.invitedUser,
        e?.userPic
      ]);

  @override
  bool isValidKey(Object? o) => o is AdminEventsRecord;
}

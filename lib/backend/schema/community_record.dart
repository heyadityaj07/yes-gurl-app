import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CommunityRecord extends FirestoreRecord {
  CommunityRecord._(
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

  // "community_image" field.
  String? _communityImage;
  String get communityImage => _communityImage ?? '';
  bool hasCommunityImage() => _communityImage != null;

  // "created_by" field.
  DocumentReference? _createdBy;
  DocumentReference? get createdBy => _createdBy;
  bool hasCreatedBy() => _createdBy != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "community_type" field.
  CommunityType? _communityType;
  CommunityType? get communityType => _communityType;
  bool hasCommunityType() => _communityType != null;

  // "last_message_at" field.
  DateTime? _lastMessageAt;
  DateTime? get lastMessageAt => _lastMessageAt;
  bool hasLastMessageAt() => _lastMessageAt != null;

  // "members" field.
  int? _members;
  int get members => _members ?? 0;
  bool hasMembers() => _members != null;

  // "removed_members" field.
  List<DocumentReference>? _removedMembers;
  List<DocumentReference> get removedMembers => _removedMembers ?? const [];
  bool hasRemovedMembers() => _removedMembers != null;

  // "report_user_list" field.
  List<DocumentReference>? _reportUserList;
  List<DocumentReference> get reportUserList => _reportUserList ?? const [];
  bool hasReportUserList() => _reportUserList != null;

  // "invited_users" field.
  List<DocumentReference>? _invitedUsers;
  List<DocumentReference> get invitedUsers => _invitedUsers ?? const [];
  bool hasInvitedUsers() => _invitedUsers != null;

  // "community_id" field.
  String? _communityId;
  String get communityId => _communityId ?? '';
  bool hasCommunityId() => _communityId != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _description = snapshotData['description'] as String?;
    _communityImage = snapshotData['community_image'] as String?;
    _createdBy = snapshotData['created_by'] as DocumentReference?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _communityType = snapshotData['community_type'] is CommunityType
        ? snapshotData['community_type']
        : deserializeEnum<CommunityType>(snapshotData['community_type']);
    _lastMessageAt = snapshotData['last_message_at'] as DateTime?;
    _members = castToType<int>(snapshotData['members']);
    _removedMembers = getDataList(snapshotData['removed_members']);
    _reportUserList = getDataList(snapshotData['report_user_list']);
    _invitedUsers = getDataList(snapshotData['invited_users']);
    _communityId = snapshotData['community_id'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('community');

  static Stream<CommunityRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CommunityRecord.fromSnapshot(s));

  static Future<CommunityRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CommunityRecord.fromSnapshot(s));

  static CommunityRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CommunityRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CommunityRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CommunityRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CommunityRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CommunityRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createCommunityRecordData({
  String? name,
  String? description,
  String? communityImage,
  DocumentReference? createdBy,
  DateTime? createdAt,
  CommunityType? communityType,
  DateTime? lastMessageAt,
  int? members,
  String? communityId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'description': description,
      'community_image': communityImage,
      'created_by': createdBy,
      'created_at': createdAt,
      'community_type': communityType,
      'last_message_at': lastMessageAt,
      'members': members,
      'community_id': communityId,
    }.withoutNulls,
  );

  return firestoreData;
}

class CommunityRecordDocumentEquality implements Equality<CommunityRecord> {
  const CommunityRecordDocumentEquality();

  @override
  bool equals(CommunityRecord? e1, CommunityRecord? e2) {
    const listEquality = ListEquality();
    return e1?.name == e2?.name &&
        e1?.description == e2?.description &&
        e1?.communityImage == e2?.communityImage &&
        e1?.createdBy == e2?.createdBy &&
        e1?.createdAt == e2?.createdAt &&
        e1?.communityType == e2?.communityType &&
        e1?.lastMessageAt == e2?.lastMessageAt &&
        e1?.members == e2?.members &&
        listEquality.equals(e1?.removedMembers, e2?.removedMembers) &&
        listEquality.equals(e1?.reportUserList, e2?.reportUserList) &&
        listEquality.equals(e1?.invitedUsers, e2?.invitedUsers) &&
        e1?.communityId == e2?.communityId;
  }

  @override
  int hash(CommunityRecord? e) => const ListEquality().hash([
        e?.name,
        e?.description,
        e?.communityImage,
        e?.createdBy,
        e?.createdAt,
        e?.communityType,
        e?.lastMessageAt,
        e?.members,
        const ListEquality().hash(e?.removedMembers),
        const ListEquality().hash(e?.reportUserList),
        const ListEquality().hash(e?.invitedUsers),
        e?.communityId
      ]);

  @override
  bool isValidKey(Object? o) => o is CommunityRecord;
}

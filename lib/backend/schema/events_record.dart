import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EventsRecord extends FirestoreRecord {
  EventsRecord._(
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

  // "role" field.
  String? _role;
  String get role => _role ?? '';
  bool hasRole() => _role != null;

  // "report_user_list" field.
  List<DocumentReference>? _reportUserList;
  List<DocumentReference> get reportUserList => _reportUserList ?? const [];
  bool hasReportUserList() => _reportUserList != null;

  // "get_ticket_list" field.
  List<DocumentReference>? _getTicketList;
  List<DocumentReference> get getTicketList => _getTicketList ?? const [];
  bool hasGetTicketList() => _getTicketList != null;

  // "external_link_url" field.
  String? _externalLinkUrl;
  String get externalLinkUrl => _externalLinkUrl ?? '';
  bool hasExternalLinkUrl() => _externalLinkUrl != null;

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
    _role = snapshotData['role'] as String?;
    _reportUserList = getDataList(snapshotData['report_user_list']);
    _getTicketList = getDataList(snapshotData['get_ticket_list']);
    _externalLinkUrl = snapshotData['external_link_url'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('events');

  static Stream<EventsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EventsRecord.fromSnapshot(s));

  static Future<EventsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => EventsRecord.fromSnapshot(s));

  static EventsRecord fromSnapshot(DocumentSnapshot snapshot) => EventsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EventsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EventsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EventsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EventsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEventsRecordData({
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
  String? role,
  String? externalLinkUrl,
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
      'role': role,
      'external_link_url': externalLinkUrl,
    }.withoutNulls,
  );

  return firestoreData;
}

class EventsRecordDocumentEquality implements Equality<EventsRecord> {
  const EventsRecordDocumentEquality();

  @override
  bool equals(EventsRecord? e1, EventsRecord? e2) {
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
        e1?.userPic == e2?.userPic &&
        e1?.role == e2?.role &&
        listEquality.equals(e1?.reportUserList, e2?.reportUserList) &&
        listEquality.equals(e1?.getTicketList, e2?.getTicketList) &&
        e1?.externalLinkUrl == e2?.externalLinkUrl;
  }

  @override
  int hash(EventsRecord? e) => const ListEquality().hash([
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
        e?.userPic,
        e?.role,
        e?.reportUserList,
        e?.getTicketList,
        e?.externalLinkUrl
      ]);

  @override
  bool isValidKey(Object? o) => o is EventsRecord;
}

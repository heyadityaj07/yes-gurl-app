import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OnlineEventsRecord extends FirestoreRecord {
  OnlineEventsRecord._(
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

  // "starts_at" field.
  DateTime? _startsAt;
  DateTime? get startsAt => _startsAt;
  bool hasStartsAt() => _startsAt != null;

  // "label" field.
  String? _label;
  String get label => _label ?? '';
  bool hasLabel() => _label != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "external_url" field.
  String? _externalUrl;
  String get externalUrl => _externalUrl ?? '';
  bool hasExternalUrl() => _externalUrl != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _description = snapshotData['description'] as String?;
    _startsAt = snapshotData['starts_at'] as DateTime?;
    _label = snapshotData['label'] as String?;
    _image = snapshotData['image'] as String?;
    _externalUrl = snapshotData['external_url'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('online_events');

  static Stream<OnlineEventsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => OnlineEventsRecord.fromSnapshot(s));

  static Future<OnlineEventsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => OnlineEventsRecord.fromSnapshot(s));

  static OnlineEventsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      OnlineEventsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static OnlineEventsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      OnlineEventsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'OnlineEventsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is OnlineEventsRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createOnlineEventsRecordData({
  String? name,
  String? description,
  DateTime? startsAt,
  String? label,
  String? image,
  String? externalUrl,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'description': description,
      'starts_at': startsAt,
      'label': label,
      'image': image,
      'external_url': externalUrl,
    }.withoutNulls,
  );

  return firestoreData;
}

class OnlineEventsRecordDocumentEquality
    implements Equality<OnlineEventsRecord> {
  const OnlineEventsRecordDocumentEquality();

  @override
  bool equals(OnlineEventsRecord? e1, OnlineEventsRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.description == e2?.description &&
        e1?.startsAt == e2?.startsAt &&
        e1?.label == e2?.label &&
        e1?.image == e2?.image &&
        e1?.externalUrl == e2?.externalUrl;
  }

  @override
  int hash(OnlineEventsRecord? e) => const ListEquality().hash([
        e?.name,
        e?.description,
        e?.startsAt,
        e?.label,
        e?.image,
        e?.externalUrl
      ]);

  @override
  bool isValidKey(Object? o) => o is OnlineEventsRecord;
}

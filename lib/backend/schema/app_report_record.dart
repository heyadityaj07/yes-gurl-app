import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AppReportRecord extends FirestoreRecord {
  AppReportRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user_reference" field.
  DocumentReference? _userReference;
  DocumentReference? get userReference => _userReference;
  bool hasUserReference() => _userReference != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  void _initializeFields() {
    _userReference = snapshotData['user_reference'] as DocumentReference?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _description = snapshotData['description'] as String?;
    _email = snapshotData['email'] as String?;
    _image = snapshotData['image'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('app_report');

  static Stream<AppReportRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AppReportRecord.fromSnapshot(s));

  static Future<AppReportRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AppReportRecord.fromSnapshot(s));

  static AppReportRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AppReportRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AppReportRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AppReportRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AppReportRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AppReportRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAppReportRecordData({
  DocumentReference? userReference,
  DateTime? createdTime,
  String? description,
  String? email,
  String? image,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user_reference': userReference,
      'created_time': createdTime,
      'description': description,
      'email': email,
      'image': image,
    }.withoutNulls,
  );

  return firestoreData;
}

class AppReportRecordDocumentEquality implements Equality<AppReportRecord> {
  const AppReportRecordDocumentEquality();

  @override
  bool equals(AppReportRecord? e1, AppReportRecord? e2) {
    return e1?.userReference == e2?.userReference &&
        e1?.createdTime == e2?.createdTime &&
        e1?.description == e2?.description &&
        e1?.email == e2?.email &&
        e1?.image == e2?.image;
  }

  @override
  int hash(AppReportRecord? e) => const ListEquality().hash(
      [e?.userReference, e?.createdTime, e?.description, e?.email, e?.image]);

  @override
  bool isValidKey(Object? o) => o is AppReportRecord;
}

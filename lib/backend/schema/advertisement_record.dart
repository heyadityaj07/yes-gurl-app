import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AdvertisementRecord extends FirestoreRecord {
  AdvertisementRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  bool hasMessage() => _message != null;

  // "color" field.
  Color? _color;
  Color? get color => _color;
  bool hasColor() => _color != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "is_image" field.
  bool? _isImage;
  bool get isImage => _isImage ?? false;
  bool hasIsImage() => _isImage != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "aditional_link" field.
  String? _aditionalLink;
  String get aditionalLink => _aditionalLink ?? '';
  bool hasAditionalLink() => _aditionalLink != null;

  void _initializeFields() {
    _message = snapshotData['message'] as String?;
    _color = getSchemaColor(snapshotData['color']);
    _image = snapshotData['image'] as String?;
    _isImage = snapshotData['is_image'] as bool?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _aditionalLink = snapshotData['aditional_link'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('advertisement');

  static Stream<AdvertisementRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AdvertisementRecord.fromSnapshot(s));

  static Future<AdvertisementRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AdvertisementRecord.fromSnapshot(s));

  static AdvertisementRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AdvertisementRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AdvertisementRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AdvertisementRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AdvertisementRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AdvertisementRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createAdvertisementRecordData({
  String? message,
  Color? color,
  String? image,
  bool? isImage,
  DateTime? createdAt,
  String? aditionalLink,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'message': message,
      'color': color,
      'image': image,
      'is_image': isImage,
      'created_at': createdAt,
      'aditional_link': aditionalLink,
    }.withoutNulls,
  );

  return firestoreData;
}

class AdvertisementRecordDocumentEquality
    implements Equality<AdvertisementRecord> {
  const AdvertisementRecordDocumentEquality();

  @override
  bool equals(AdvertisementRecord? e1, AdvertisementRecord? e2) {
    return e1?.message == e2?.message &&
        e1?.color == e2?.color &&
        e1?.image == e2?.image &&
        e1?.isImage == e2?.isImage &&
        e1?.createdAt == e2?.createdAt &&
        e1?.aditionalLink == e2?.aditionalLink;
  }

  @override
  int hash(AdvertisementRecord? e) => const ListEquality().hash([
        e?.message,
        e?.color,
        e?.image,
        e?.isImage,
        e?.createdAt,
        e?.aditionalLink
      ]);

  @override
  bool isValidKey(Object? o) => o is AdvertisementRecord;
}

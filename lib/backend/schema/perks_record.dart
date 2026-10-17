import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PerksRecord extends FirestoreRecord {
  PerksRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "brand_name" field.
  String? _brandName;
  String get brandName => _brandName ?? '';
  bool hasBrandName() => _brandName != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "promo_code" field.
  String? _promoCode;
  String get promoCode => _promoCode ?? '';
  bool hasPromoCode() => _promoCode != null;

  // "external_url" field.
  String? _externalUrl;
  String get externalUrl => _externalUrl ?? '';
  bool hasExternalUrl() => _externalUrl != null;

  // "image_url" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  bool hasImageUrl() => _imageUrl != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "is_active" field.
  bool? _isActive;
  bool get isActive => _isActive ?? false;
  bool hasIsActive() => _isActive != null;

  // "expiry_date" field.
  DateTime? _expiryDate;
  DateTime? get expiryDate => _expiryDate;
  bool hasExpiryDate() => _expiryDate != null;

  void _initializeFields() {
    _brandName = snapshotData['brand_name'] as String?;
    _description = snapshotData['description'] as String?;
    _promoCode = snapshotData['promo_code'] as String?;
    _externalUrl = snapshotData['external_url'] as String?;
    _imageUrl = snapshotData['image_url'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _isActive = snapshotData['is_active'] as bool?;
    _expiryDate = snapshotData['expiry_date'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('perks');

  static Stream<PerksRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PerksRecord.fromSnapshot(s));

  static Future<PerksRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PerksRecord.fromSnapshot(s));

  static PerksRecord fromSnapshot(DocumentSnapshot snapshot) => PerksRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PerksRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PerksRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PerksRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PerksRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createPerksRecordData({
  String? brandName,
  String? description,
  String? promoCode,
  String? externalUrl,
  String? imageUrl,
  DateTime? createdAt,
  bool? isActive,
  DateTime? expiryDate,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'brand_name': brandName,
      'description': description,
      'promo_code': promoCode,
      'external_url': externalUrl,
      'image_url': imageUrl,
      'created_at': createdAt,
      'is_active': isActive,
      'expiry_date': expiryDate,
    }.withoutNulls,
  );

  return firestoreData;
}

class PerksRecordDocumentEquality implements Equality<PerksRecord> {
  const PerksRecordDocumentEquality();

  @override
  bool equals(PerksRecord? e1, PerksRecord? e2) {
    return e1?.brandName == e2?.brandName &&
        e1?.description == e2?.description &&
        e1?.promoCode == e2?.promoCode &&
        e1?.externalUrl == e2?.externalUrl &&
        e1?.imageUrl == e2?.imageUrl &&
        e1?.createdAt == e2?.createdAt &&
        e1?.isActive == e2?.isActive &&
        e1?.expiryDate == e2?.expiryDate;
  }

  @override
  int hash(PerksRecord? e) => const ListEquality().hash([
        e?.brandName,
        e?.description,
        e?.promoCode,
        e?.externalUrl,
        e?.imageUrl,
        e?.createdAt,
        e?.isActive,
        e?.expiryDate
      ]);

  @override
  bool isValidKey(Object? o) => o is PerksRecord;
}

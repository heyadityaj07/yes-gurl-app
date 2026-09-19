import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NotificationRecord extends FirestoreRecord {
  NotificationRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "sent_by" field.
  DocumentReference? _sentBy;
  DocumentReference? get sentBy => _sentBy;
  bool hasSentBy() => _sentBy != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "sent_at" field.
  DateTime? _sentAt;
  DateTime? get sentAt => _sentAt;
  bool hasSentAt() => _sentAt != null;

  // "notification_type" field.
  String? _notificationType;
  String get notificationType => _notificationType ?? '';
  bool hasNotificationType() => _notificationType != null;

  // "chat" field.
  DocumentReference? _chat;
  DocumentReference? get chat => _chat;
  bool hasChat() => _chat != null;

  // "linkup" field.
  DocumentReference? _linkup;
  DocumentReference? get linkup => _linkup;
  bool hasLinkup() => _linkup != null;

  // "seen" field.
  bool? _seen;
  bool get seen => _seen ?? false;
  bool hasSeen() => _seen != null;

  // "manage" field.
  String? _manage;
  String get manage => _manage ?? '';
  bool hasManage() => _manage != null;

  // "seen_list" field.
  List<DocumentReference>? _seenList;
  List<DocumentReference> get seenList => _seenList ?? const [];
  bool hasSeenList() => _seenList != null;

  // "delete_list" field.
  List<DocumentReference>? _deleteList;
  List<DocumentReference> get deleteList => _deleteList ?? const [];
  bool hasDeleteList() => _deleteList != null;

  // "for_admin" field.
  bool? _forAdmin;
  bool get forAdmin => _forAdmin ?? false;
  bool hasForAdmin() => _forAdmin != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _description = snapshotData['description'] as String?;
    _sentBy = snapshotData['sent_by'] as DocumentReference?;
    _user = snapshotData['user'] as DocumentReference?;
    _sentAt = snapshotData['sent_at'] as DateTime?;
    _notificationType = snapshotData['notification_type'] as String?;
    _chat = snapshotData['chat'] as DocumentReference?;
    _linkup = snapshotData['linkup'] as DocumentReference?;
    _seen = snapshotData['seen'] as bool?;
    _manage = snapshotData['manage'] as String?;
    _seenList = getDataList(snapshotData['seen_list']);
    _deleteList = getDataList(snapshotData['delete_list']);
    _forAdmin = snapshotData['for_admin'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('notification');

  static Stream<NotificationRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => NotificationRecord.fromSnapshot(s));

  static Future<NotificationRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => NotificationRecord.fromSnapshot(s));

  static NotificationRecord fromSnapshot(DocumentSnapshot snapshot) =>
      NotificationRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static NotificationRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      NotificationRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'NotificationRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is NotificationRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createNotificationRecordData({
  String? title,
  String? description,
  DocumentReference? sentBy,
  DocumentReference? user,
  DateTime? sentAt,
  String? notificationType,
  DocumentReference? chat,
  DocumentReference? linkup,
  bool? seen,
  String? manage,
  bool? forAdmin,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'description': description,
      'sent_by': sentBy,
      'user': user,
      'sent_at': sentAt,
      'notification_type': notificationType,
      'chat': chat,
      'linkup': linkup,
      'seen': seen,
      'manage': manage,
      'for_admin': forAdmin,
    }.withoutNulls,
  );

  return firestoreData;
}

class NotificationRecordDocumentEquality
    implements Equality<NotificationRecord> {
  const NotificationRecordDocumentEquality();

  @override
  bool equals(NotificationRecord? e1, NotificationRecord? e2) {
    const listEquality = ListEquality();
    return e1?.title == e2?.title &&
        e1?.description == e2?.description &&
        e1?.sentBy == e2?.sentBy &&
        e1?.user == e2?.user &&
        e1?.sentAt == e2?.sentAt &&
        e1?.notificationType == e2?.notificationType &&
        e1?.chat == e2?.chat &&
        e1?.linkup == e2?.linkup &&
        e1?.seen == e2?.seen &&
        e1?.manage == e2?.manage &&
        listEquality.equals(e1?.seenList, e2?.seenList) &&
        listEquality.equals(e1?.deleteList, e2?.deleteList) &&
        e1?.forAdmin == e2?.forAdmin;
  }

  @override
  int hash(NotificationRecord? e) => const ListEquality().hash([
        e?.title,
        e?.description,
        e?.sentBy,
        e?.user,
        e?.sentAt,
        e?.notificationType,
        e?.chat,
        e?.linkup,
        e?.seen,
        e?.manage,
        e?.seenList,
        e?.deleteList,
        e?.forAdmin
      ]);

  @override
  bool isValidKey(Object? o) => o is NotificationRecord;
}

// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SelectUserResponseStruct extends FFFirebaseStruct {
  SelectUserResponseStruct({
    DocumentReference? userReference,
    DateTime? responseCreatedTime,
    String? responseType,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _userReference = userReference,
        _responseCreatedTime = responseCreatedTime,
        _responseType = responseType,
        super(firestoreUtilData);

  // "userReference" field.
  DocumentReference? _userReference;
  DocumentReference? get userReference => _userReference;
  set userReference(DocumentReference? val) => _userReference = val;

  bool hasUserReference() => _userReference != null;

  // "responseCreatedTime" field.
  DateTime? _responseCreatedTime;
  DateTime? get responseCreatedTime => _responseCreatedTime;
  set responseCreatedTime(DateTime? val) => _responseCreatedTime = val;

  bool hasResponseCreatedTime() => _responseCreatedTime != null;

  // "responseType" field.
  String? _responseType;
  String get responseType => _responseType ?? '';
  set responseType(String? val) => _responseType = val;

  bool hasResponseType() => _responseType != null;

  static SelectUserResponseStruct fromMap(Map<String, dynamic> data) =>
      SelectUserResponseStruct(
        userReference: data['userReference'] as DocumentReference?,
        responseCreatedTime: data['responseCreatedTime'] as DateTime?,
        responseType: data['responseType'] as String?,
      );

  static SelectUserResponseStruct? maybeFromMap(dynamic data) => data is Map
      ? SelectUserResponseStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'userReference': _userReference,
        'responseCreatedTime': _responseCreatedTime,
        'responseType': _responseType,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'userReference': serializeParam(
          _userReference,
          ParamType.DocumentReference,
        ),
        'responseCreatedTime': serializeParam(
          _responseCreatedTime,
          ParamType.DateTime,
        ),
        'responseType': serializeParam(
          _responseType,
          ParamType.String,
        ),
      }.withoutNulls;

  static SelectUserResponseStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      SelectUserResponseStruct(
        userReference: deserializeParam(
          data['userReference'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['user'],
        ),
        responseCreatedTime: deserializeParam(
          data['responseCreatedTime'],
          ParamType.DateTime,
          false,
        ),
        responseType: deserializeParam(
          data['responseType'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'SelectUserResponseStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SelectUserResponseStruct &&
        userReference == other.userReference &&
        responseCreatedTime == other.responseCreatedTime &&
        responseType == other.responseType;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([userReference, responseCreatedTime, responseType]);
}

SelectUserResponseStruct createSelectUserResponseStruct({
  DocumentReference? userReference,
  DateTime? responseCreatedTime,
  String? responseType,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SelectUserResponseStruct(
      userReference: userReference,
      responseCreatedTime: responseCreatedTime,
      responseType: responseType,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SelectUserResponseStruct? updateSelectUserResponseStruct(
  SelectUserResponseStruct? selectUserResponse, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    selectUserResponse
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSelectUserResponseStructData(
  Map<String, dynamic> firestoreData,
  SelectUserResponseStruct? selectUserResponse,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (selectUserResponse == null) {
    return;
  }
  if (selectUserResponse.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && selectUserResponse.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final selectUserResponseData =
      getSelectUserResponseFirestoreData(selectUserResponse, forFieldValue);
  final nestedData =
      selectUserResponseData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      selectUserResponse.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSelectUserResponseFirestoreData(
  SelectUserResponseStruct? selectUserResponse, [
  bool forFieldValue = false,
]) {
  if (selectUserResponse == null) {
    return {};
  }
  final firestoreData = mapToFirestore(selectUserResponse.toMap());

  // Add any Firestore field values
  mapToFirestore(selectUserResponse.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSelectUserResponseListFirestoreData(
  List<SelectUserResponseStruct>? selectUserResponses,
) =>
    selectUserResponses
        ?.map((e) => getSelectUserResponseFirestoreData(e, true))
        .toList() ??
    [];

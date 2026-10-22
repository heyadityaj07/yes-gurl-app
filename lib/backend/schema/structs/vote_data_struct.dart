// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class VoteDataStruct extends FFFirebaseStruct {
  VoteDataStruct({
    DocumentReference? userRef,
    int? selectedOptionIndex,
    String? selectedOption,
    String? customAnswer,
    DateTime? votedAt,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _userRef = userRef,
        _selectedOptionIndex = selectedOptionIndex,
        _selectedOption = selectedOption,
        _customAnswer = customAnswer,
        _votedAt = votedAt,
        super(firestoreUtilData);

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  set userRef(DocumentReference? val) => _userRef = val;

  bool hasUserRef() => _userRef != null;

  // "selectedOptionIndex" field.
  int? _selectedOptionIndex;
  int get selectedOptionIndex => _selectedOptionIndex ?? 0;
  set selectedOptionIndex(int? val) => _selectedOptionIndex = val;

  void incrementSelectedOptionIndex(int amount) =>
      selectedOptionIndex = selectedOptionIndex + amount;

  bool hasSelectedOptionIndex() => _selectedOptionIndex != null;

  // "selectedOption" field.
  String? _selectedOption;
  String get selectedOption => _selectedOption ?? '';
  set selectedOption(String? val) => _selectedOption = val;

  bool hasSelectedOption() => _selectedOption != null;

  // "customAnswer" field.
  String? _customAnswer;
  String get customAnswer => _customAnswer ?? '';
  set customAnswer(String? val) => _customAnswer = val;

  bool hasCustomAnswer() => _customAnswer != null;

  // "votedAt" field.
  DateTime? _votedAt;
  DateTime? get votedAt => _votedAt;
  set votedAt(DateTime? val) => _votedAt = val;

  bool hasVotedAt() => _votedAt != null;

  static VoteDataStruct fromMap(Map<String, dynamic> data) => VoteDataStruct(
        userRef: data['userRef'] as DocumentReference?,
        selectedOptionIndex: castToType<int>(data['selectedOptionIndex']),
        selectedOption: data['selectedOption'] as String?,
        customAnswer: data['customAnswer'] as String?,
        votedAt: data['votedAt'] as DateTime?,
      );

  static VoteDataStruct? maybeFromMap(dynamic data) =>
      data is Map ? VoteDataStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'userRef': _userRef,
        'selectedOptionIndex': _selectedOptionIndex,
        'selectedOption': _selectedOption,
        'customAnswer': _customAnswer,
        'votedAt': _votedAt,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'userRef': serializeParam(
          _userRef,
          ParamType.DocumentReference,
        ),
        'selectedOptionIndex': serializeParam(
          _selectedOptionIndex,
          ParamType.int,
        ),
        'selectedOption': serializeParam(
          _selectedOption,
          ParamType.String,
        ),
        'customAnswer': serializeParam(
          _customAnswer,
          ParamType.String,
        ),
        'votedAt': serializeParam(
          _votedAt,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static VoteDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      VoteDataStruct(
        userRef: deserializeParam(
          data['userRef'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['user'],
        ),
        selectedOptionIndex: deserializeParam(
          data['selectedOptionIndex'],
          ParamType.int,
          false,
        ),
        selectedOption: deserializeParam(
          data['selectedOption'],
          ParamType.String,
          false,
        ),
        customAnswer: deserializeParam(
          data['customAnswer'],
          ParamType.String,
          false,
        ),
        votedAt: deserializeParam(
          data['votedAt'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'VoteDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is VoteDataStruct &&
        userRef == other.userRef &&
        selectedOptionIndex == other.selectedOptionIndex &&
        selectedOption == other.selectedOption &&
        customAnswer == other.customAnswer &&
        votedAt == other.votedAt;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [userRef, selectedOptionIndex, selectedOption, customAnswer, votedAt]);
}

VoteDataStruct createVoteDataStruct({
  DocumentReference? userRef,
  int? selectedOptionIndex,
  String? selectedOption,
  String? customAnswer,
  DateTime? votedAt,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    VoteDataStruct(
      userRef: userRef,
      selectedOptionIndex: selectedOptionIndex,
      selectedOption: selectedOption,
      customAnswer: customAnswer,
      votedAt: votedAt,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

VoteDataStruct? updateVoteDataStruct(
  VoteDataStruct? voteData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    voteData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addVoteDataStructData(
  Map<String, dynamic> firestoreData,
  VoteDataStruct? voteData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (voteData == null) {
    return;
  }
  if (voteData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && voteData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final voteDataData = getVoteDataFirestoreData(voteData, forFieldValue);
  final nestedData = voteDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = voteData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getVoteDataFirestoreData(
  VoteDataStruct? voteData, [
  bool forFieldValue = false,
]) {
  if (voteData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(voteData.toMap());

  // Add any Firestore field values
  mapToFirestore(voteData.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getVoteDataListFirestoreData(
  List<VoteDataStruct>? voteDatas,
) =>
    voteDatas?.map((e) => getVoteDataFirestoreData(e, true)).toList() ?? [];

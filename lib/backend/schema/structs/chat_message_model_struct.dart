// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatMessageModelStruct extends FFFirebaseStruct {
  ChatMessageModelStruct({
    List<MessageModelStruct>? messageList,
    DateTime? dateTime,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _messageList = messageList,
        _dateTime = dateTime,
        super(firestoreUtilData);

  // "messageList" field.
  List<MessageModelStruct>? _messageList;
  List<MessageModelStruct> get messageList => _messageList ?? const [];
  set messageList(List<MessageModelStruct>? val) => _messageList = val;

  void updateMessageList(Function(List<MessageModelStruct>) updateFn) {
    updateFn(_messageList ??= []);
  }

  bool hasMessageList() => _messageList != null;

  // "dateTime" field.
  DateTime? _dateTime;
  DateTime? get dateTime => _dateTime;
  set dateTime(DateTime? val) => _dateTime = val;

  bool hasDateTime() => _dateTime != null;

  static ChatMessageModelStruct fromMap(Map<String, dynamic> data) =>
      ChatMessageModelStruct(
        messageList: getStructList(
          data['messageList'],
          MessageModelStruct.fromMap,
        ),
        dateTime: data['dateTime'] as DateTime?,
      );

  static ChatMessageModelStruct? maybeFromMap(dynamic data) => data is Map
      ? ChatMessageModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'messageList': _messageList?.map((e) => e.toMap()).toList(),
        'dateTime': _dateTime,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'messageList': serializeParam(
          _messageList,
          ParamType.DataStruct,
          isList: true,
        ),
        'dateTime': serializeParam(
          _dateTime,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static ChatMessageModelStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ChatMessageModelStruct(
        messageList: deserializeStructParam<MessageModelStruct>(
          data['messageList'],
          ParamType.DataStruct,
          true,
          structBuilder: MessageModelStruct.fromSerializableMap,
        ),
        dateTime: deserializeParam(
          data['dateTime'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'ChatMessageModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ChatMessageModelStruct &&
        listEquality.equals(messageList, other.messageList) &&
        dateTime == other.dateTime;
  }

  @override
  int get hashCode => const ListEquality().hash([messageList, dateTime]);
}

ChatMessageModelStruct createChatMessageModelStruct({
  DateTime? dateTime,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ChatMessageModelStruct(
      dateTime: dateTime,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ChatMessageModelStruct? updateChatMessageModelStruct(
  ChatMessageModelStruct? chatMessageModel, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    chatMessageModel
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addChatMessageModelStructData(
  Map<String, dynamic> firestoreData,
  ChatMessageModelStruct? chatMessageModel,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (chatMessageModel == null) {
    return;
  }
  if (chatMessageModel.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && chatMessageModel.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final chatMessageModelData =
      getChatMessageModelFirestoreData(chatMessageModel, forFieldValue);
  final nestedData =
      chatMessageModelData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = chatMessageModel.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getChatMessageModelFirestoreData(
  ChatMessageModelStruct? chatMessageModel, [
  bool forFieldValue = false,
]) {
  if (chatMessageModel == null) {
    return {};
  }
  final firestoreData = mapToFirestore(chatMessageModel.toMap());

  // Add any Firestore field values
  mapToFirestore(chatMessageModel.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getChatMessageModelListFirestoreData(
  List<ChatMessageModelStruct>? chatMessageModels,
) =>
    chatMessageModels
        ?.map((e) => getChatMessageModelFirestoreData(e, true))
        .toList() ??
    [];

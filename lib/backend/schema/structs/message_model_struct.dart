// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MessageModelStruct extends FFFirebaseStruct {
  MessageModelStruct({
    String? chatText,
    DateTime? textTime,
    DocumentReference? userRef,
    DocumentReference? chatRef,
    String? eventImage,
    DocumentReference? eventreference,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _chatText = chatText,
        _textTime = textTime,
        _userRef = userRef,
        _chatRef = chatRef,
        _eventImage = eventImage,
        _eventreference = eventreference,
        super(firestoreUtilData);

  // "chat_text" field.
  String? _chatText;
  String get chatText => _chatText ?? '';
  set chatText(String? val) => _chatText = val;

  bool hasChatText() => _chatText != null;

  // "text_time" field.
  DateTime? _textTime;
  DateTime? get textTime => _textTime;
  set textTime(DateTime? val) => _textTime = val;

  bool hasTextTime() => _textTime != null;

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  set userRef(DocumentReference? val) => _userRef = val;

  bool hasUserRef() => _userRef != null;

  // "chatRef" field.
  DocumentReference? _chatRef;
  DocumentReference? get chatRef => _chatRef;
  set chatRef(DocumentReference? val) => _chatRef = val;

  bool hasChatRef() => _chatRef != null;

  // "event_image" field.
  String? _eventImage;
  String get eventImage => _eventImage ?? '';
  set eventImage(String? val) => _eventImage = val;

  bool hasEventImage() => _eventImage != null;

  // "eventreference" field.
  DocumentReference? _eventreference;
  DocumentReference? get eventreference => _eventreference;
  set eventreference(DocumentReference? val) => _eventreference = val;

  bool hasEventreference() => _eventreference != null;

  static MessageModelStruct fromMap(Map<String, dynamic> data) =>
      MessageModelStruct(
        chatText: data['chat_text'] as String?,
        textTime: data['text_time'] as DateTime?,
        userRef: data['userRef'] as DocumentReference?,
        chatRef: data['chatRef'] as DocumentReference?,
        eventImage: data['event_image'] as String?,
        eventreference: data['eventreference'] as DocumentReference?,
      );

  static MessageModelStruct? maybeFromMap(dynamic data) => data is Map
      ? MessageModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'chat_text': _chatText,
        'text_time': _textTime,
        'userRef': _userRef,
        'chatRef': _chatRef,
        'event_image': _eventImage,
        'eventreference': _eventreference,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'chat_text': serializeParam(
          _chatText,
          ParamType.String,
        ),
        'text_time': serializeParam(
          _textTime,
          ParamType.DateTime,
        ),
        'userRef': serializeParam(
          _userRef,
          ParamType.DocumentReference,
        ),
        'chatRef': serializeParam(
          _chatRef,
          ParamType.DocumentReference,
        ),
        'event_image': serializeParam(
          _eventImage,
          ParamType.String,
        ),
        'eventreference': serializeParam(
          _eventreference,
          ParamType.DocumentReference,
        ),
      }.withoutNulls;

  static MessageModelStruct fromSerializableMap(Map<String, dynamic> data) =>
      MessageModelStruct(
        chatText: deserializeParam(
          data['chat_text'],
          ParamType.String,
          false,
        ),
        textTime: deserializeParam(
          data['text_time'],
          ParamType.DateTime,
          false,
        ),
        userRef: deserializeParam(
          data['userRef'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['user'],
        ),
        chatRef: deserializeParam(
          data['chatRef'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['chat'],
        ),
        eventImage: deserializeParam(
          data['event_image'],
          ParamType.String,
          false,
        ),
        eventreference: deserializeParam(
          data['eventreference'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['events'],
        ),
      );

  @override
  String toString() => 'MessageModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MessageModelStruct &&
        chatText == other.chatText &&
        textTime == other.textTime &&
        userRef == other.userRef &&
        chatRef == other.chatRef &&
        eventImage == other.eventImage &&
        eventreference == other.eventreference;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([chatText, textTime, userRef, chatRef, eventImage, eventreference]);
}

MessageModelStruct createMessageModelStruct({
  String? chatText,
  DateTime? textTime,
  DocumentReference? userRef,
  DocumentReference? chatRef,
  String? eventImage,
  DocumentReference? eventreference,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    MessageModelStruct(
      chatText: chatText,
      textTime: textTime,
      userRef: userRef,
      chatRef: chatRef,
      eventImage: eventImage,
      eventreference: eventreference,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

MessageModelStruct? updateMessageModelStruct(
  MessageModelStruct? messageModel, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    messageModel
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addMessageModelStructData(
  Map<String, dynamic> firestoreData,
  MessageModelStruct? messageModel,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (messageModel == null) {
    return;
  }
  if (messageModel.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && messageModel.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final messageModelData =
      getMessageModelFirestoreData(messageModel, forFieldValue);
  final nestedData =
      messageModelData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = messageModel.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getMessageModelFirestoreData(
  MessageModelStruct? messageModel, [
  bool forFieldValue = false,
]) {
  if (messageModel == null) {
    return {};
  }
  final firestoreData = mapToFirestore(messageModel.toMap());

  // Add any Firestore field values
  mapToFirestore(messageModel.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getMessageModelListFirestoreData(
  List<MessageModelStruct>? messageModels,
) =>
    messageModels?.map((e) => getMessageModelFirestoreData(e, true)).toList() ??
    [];

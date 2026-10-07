import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/chat/pausealert/pausealert_widget.dart';
import '/communities/community_message_option/community_message_option_widget.dart';
import '/communities/confirmation_dialogue/confirmation_dialogue_widget.dart';
import '/communities/messagereport/messagereport_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'message_card_widget.dart' show MessageCardWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';
import 'package:provider/provider.dart';

class MessageCardModel extends FlutterFlowModel<MessageCardWidget> {
  ///  Local state fields for this component.

  DocumentReference? replyMessage;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Alert Dialog - Custom Dialog] action in IconButton widget.
  String? option;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  MembersRecord? memberData;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}

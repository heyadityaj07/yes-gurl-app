// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:yes_gurl/link_up/broadcast_messages/broadcast_messages_widget.dart';

import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart';

Future showBroadcastDialog(DocumentReference? brodcast) async {
  if (brodcast == null) {
    return;
  }

  final context = appNavigatorKey.currentContext;

  if (context == null) {
    return;
  }

  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (dialogContext) {
      return Dialog(
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        alignment: AlignmentDirectional(0, 0).resolve(
          Directionality.of(context),
        ),
        child: BroadcastMessagesWidget(
          brodcast: brodcast,
        ),
      );
    },
  );
}

// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:upgrader/upgrader.dart';

Future checkForceUpdate(BuildContext context) async {
  if (kIsWeb) return;

  try {
    final upgrader = Upgrader(
      durationUntilAlertAgain: Duration.zero,
      countryCode: 'GB',
      languageCode: 'en',
      storeController: UpgraderStoreController(
        onAndroid: () => UpgraderPlayStore(),
        oniOS: () => UpgraderAppStore(),
      ),
    );

    await upgrader.initialize();
    if (!context.mounted) return;
    if (!upgrader.shouldDisplayUpgrade()) return;

    final messages = upgrader.determineMessages(context);
    final title = messages.message(UpgraderMessage.title) ?? 'Update App?';
    final body = upgrader.body(messages);
    final updateLabel =
        messages.message(UpgraderMessage.buttonTitleUpdate) ?? 'UPDATE NOW';
    final isIOS = defaultTargetPlatform == TargetPlatform.iOS;

    if (isIOS) {
      await showCupertinoDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return PopScope(
            canPop: false,
            child: CupertinoAlertDialog(
              title: Text(title),
              content: Text(body),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    upgrader.sendUserToAppStore();
                  },
                  child: Text(updateLabel),
                ),
              ],
            ),
          );
        },
      );
      return;
    }

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            title: Text(title),
            content: Text(body),
            actions: [
              TextButton(
                onPressed: () {
                  upgrader.sendUserToAppStore();
                },
                child: Text(updateLabel),
              ),
            ],
          ),
        );
      },
    );
  } catch (_) {
    // Store lookup can fail in local/debug builds. Do not block the app.
  }
}

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

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

const founderBookingLinksCollection = 'founder_links';

class FounderBookingConfig {
  const FounderBookingConfig({
    required this.documentId,
    required this.displayName,
    required this.defaultCalendlyUrl,
    required this.calendlyPathSegments,
  });

  final String documentId;
  final String displayName;
  final String defaultCalendlyUrl;
  final List<String> calendlyPathSegments;
}

const founderBookingConfigs = <String, FounderBookingConfig>{
  'annette': FounderBookingConfig(
    documentId: 'annette',
    displayName: 'Annette',
    defaultCalendlyUrl: 'https://calendly.com/app-yesgurl/15-mins-with-annette',
    calendlyPathSegments: ['app-yesgurl', '15-mins-with-annette'],
  ),
  'francesca': FounderBookingConfig(
    documentId: 'francesca',
    displayName: 'Francesca',
    defaultCalendlyUrl: 'https://calendly.com/yesgurl/15-mins-with-francesca',
    calendlyPathSegments: ['yesgurl', '15-mins-with-francesca'],
  ),
};

FounderBookingConfig? founderBookingConfigForSelection(String? selection) {
  if (selection == null) {
    return null;
  }
  return founderBookingConfigs[selection.trim().toLowerCase()];
}

bool _founderPathMatches(List<String> segments, List<String> expected) {
  if (segments.length != expected.length) {
    return false;
  }
  for (var index = 0; index < expected.length; index++) {
    if (segments[index] != expected[index]) {
      return false;
    }
  }
  return true;
}

String? validatedFounderCalendlyUrl(
  FounderBookingConfig founder,
  String? rawUrl,
) {
  final value = rawUrl?.trim() ?? '';
  if (value.isEmpty || value.length > 2048 || RegExp(r'\s').hasMatch(value)) {
    return null;
  }

  final uri = Uri.tryParse(value);
  if (uri == null || uri.scheme != 'https' || uri.userInfo.isNotEmpty) {
    return null;
  }

  final host = uri.host.toLowerCase();
  if (host != 'calendly.com' && host != 'www.calendly.com') {
    return null;
  }
  if (uri.hasPort && uri.port != 443) {
    return null;
  }

  final segments =
      uri.pathSegments.where((segment) => segment.isNotEmpty).toList();
  if (!_founderPathMatches(segments, founder.calendlyPathSegments)) {
    return null;
  }

  return value;
}

enum FounderBookingFailure {
  invalidSelection,
  lookupFailed,
  missingUrl,
  invalidUrl,
  launchFailed,
}

class FounderBookingResult {
  const FounderBookingResult.success(this.url) : failure = null;

  const FounderBookingResult.failure(this.failure) : url = null;

  final String? url;
  final FounderBookingFailure? failure;

  bool get isSuccess => failure == null;

  String get userMessage {
    switch (failure) {
      case FounderBookingFailure.invalidSelection:
        return 'We could not identify that founder. Please close this and try again.';
      case FounderBookingFailure.lookupFailed:
        return 'We could not load the booking link. Please check your connection and try again.';
      case FounderBookingFailure.missingUrl:
      case FounderBookingFailure.invalidUrl:
        return 'Booking is not available for this founder right now. Please try again later.';
      case FounderBookingFailure.launchFailed:
        return 'We could not open the booking page. Please try again.';
      case null:
        return '';
    }
  }
}

typedef FounderLinkDocumentReader = Future<Map<String, dynamic>?> Function(
  String documentId,
);
typedef FounderCalendlyLauncher = Future<bool> Function(Uri uri);

Future<Map<String, dynamic>?> _readFounderLink(String documentId) async {
  final snapshot = await FirebaseFirestore.instance
      .collection(founderBookingLinksCollection)
      .doc(documentId)
      .get();
  return snapshot.exists
      ? (snapshot.data() ?? const <String, dynamic>{})
      : null;
}

Future<FounderBookingResult> resolveAndLaunchFounderBooking({
  required String? selection,
  required FounderLinkDocumentReader readFounderLink,
  required FounderCalendlyLauncher launchCalendly,
}) async {
  final founder = founderBookingConfigForSelection(selection);
  if (founder == null) {
    return const FounderBookingResult.failure(
      FounderBookingFailure.invalidSelection,
    );
  }

  Map<String, dynamic>? data;
  try {
    data = await readFounderLink(founder.documentId);
  } catch (_) {
    return const FounderBookingResult.failure(
      FounderBookingFailure.lookupFailed,
    );
  }

  String? rawUrl;
  if (data == null) {
    rawUrl = founder.defaultCalendlyUrl;
  } else {
    final value = data['calendly_url'];
    rawUrl = value is String ? value : null;
    if ((rawUrl ?? '').trim().isEmpty) {
      return const FounderBookingResult.failure(
        FounderBookingFailure.missingUrl,
      );
    }
  }

  final url = validatedFounderCalendlyUrl(founder, rawUrl);
  if (url == null) {
    return const FounderBookingResult.failure(
      FounderBookingFailure.invalidUrl,
    );
  }

  try {
    final launched = await launchCalendly(Uri.parse(url));
    if (!launched) {
      return const FounderBookingResult.failure(
        FounderBookingFailure.launchFailed,
      );
    }
  } catch (_) {
    return const FounderBookingResult.failure(
      FounderBookingFailure.launchFailed,
    );
  }

  return FounderBookingResult.success(url);
}

bool _founderBookingLaunchInProgress = false;

void _showFounderBookingError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: FlutterFlowTheme.of(context).error,
    ),
  );
}

Future<bool> openFounderCalendly(
  BuildContext context,
  String? founderSelection,
) async {
  if (!context.mounted || _founderBookingLaunchInProgress) {
    return false;
  }

  final founder = founderBookingConfigForSelection(founderSelection);
  if (founder == null) {
    _showFounderBookingError(
      context,
      const FounderBookingResult.failure(
        FounderBookingFailure.invalidSelection,
      ).userMessage,
    );
    return false;
  }

  _founderBookingLaunchInProgress = true;

  BuildContext? dialogContext;
  late FounderBookingResult result;
  try {
    final dialogContextCompleter = Completer<BuildContext?>();
    unawaited(
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          if (!dialogContextCompleter.isCompleted) {
            dialogContextCompleter.complete(dialogContext);
          }
          return PopScope(
            canPop: false,
            child: Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Text(
                        'Opening ${founder.displayName}\'s booking page...',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );

    dialogContext = await dialogContextCompleter.future;
    result = await resolveAndLaunchFounderBooking(
      selection: founderSelection,
      readFounderLink: _readFounderLink,
      launchCalendly: (uri) => launchUrl(uri),
    );
  } finally {
    if (dialogContext != null && dialogContext.mounted) {
      Navigator.of(dialogContext).pop();
    }
    _founderBookingLaunchInProgress = false;
  }

  if (!result.isSuccess && context.mounted) {
    _showFounderBookingError(context, result.userMessage);
  }

  return result.isSuccess;
}

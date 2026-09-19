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

import 'package:google_fonts/google_fonts.dart';

Future above18dialog(BuildContext context) async {
  // Add your function code here!

  await showDialog(
    context: context,
    builder: (alertDialogContext) {
      return AlertDialog(
        title: Text(
          'hold up',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                font: GoogleFonts.readexPro(
                  fontWeight:
                      FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).primaryText,
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
              ),
        ),
        content: Text(
          'you must be 18 or over to use this app.',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                font: GoogleFonts.readexPro(
                  fontWeight:
                      FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).primaryText,
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
              ),
        ),
        actions: [
          TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(12), // You can adjust the radius
                ),
              ),
              backgroundColor: MaterialStateProperty.all(Color(0xffFE99AB)),
            ),
            onPressed: () => Navigator.pop(alertDialogContext),
            child: Text(
              'ok',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}

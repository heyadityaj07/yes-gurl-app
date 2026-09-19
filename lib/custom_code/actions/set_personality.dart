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

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
Future setPersonality() async {
  String firstLetter = FFAppState().ecount > FFAppState().icount ? 'e' : 'i';
  String secondLetter = FFAppState().scount > FFAppState().ncount ? 's' : 'n';
  String thirdLetter = FFAppState().tcount > FFAppState().fcount ? 't' : 'f';
  String fourthLetter = FFAppState().jcount > FFAppState().pcount ? 'j' : 'p';
  FFAppState().personality =
      "$firstLetter$secondLetter$thirdLetter$fourthLetter";
  if (FFAppState().personality == "intj") {
    FFAppState().nickname = "architect";
  } else if (FFAppState().personality == "intp") {
    FFAppState().nickname = "logician";
  } else if (FFAppState().personality == "entj") {
    FFAppState().nickname = "commander";
  } else if (FFAppState().personality == "entp") {
    FFAppState().nickname = "debater";
  } else if (FFAppState().personality == "infj") {
    FFAppState().nickname = "advocate";
  } else if (FFAppState().personality == "infp") {
    FFAppState().nickname = "mediator";
  } else if (FFAppState().personality == "enfj") {
    FFAppState().nickname = "protagonist";
  } else if (FFAppState().personality == "enfp") {
    FFAppState().nickname = "campaigner";
  } else if (FFAppState().personality == "istj") {
    FFAppState().nickname = "logistician";
  } else if (FFAppState().personality == "isfj") {
    FFAppState().nickname = "defender";
  } else if (FFAppState().personality == "estj") {
    FFAppState().nickname = "executive";
  } else if (FFAppState().personality == "esfj") {
    FFAppState().nickname = "consul";
  } else if (FFAppState().personality == "istp") {
    FFAppState().nickname = "consul";
  } else if (FFAppState().personality == "isfp") {
    FFAppState().nickname = "adventurer";
  } else if (FFAppState().personality == "estp") {
    FFAppState().nickname = "entrepreneur";
  } else if (FFAppState().personality == "esfp") {
    FFAppState().nickname = "entertainer";
  }
}

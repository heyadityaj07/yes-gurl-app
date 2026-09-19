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
Future managePersonality(int questionIndex, String selectedOption) async {
  // If the selected answer is 'A'
  questionIndex++;
  if (selectedOption == 'A') {
    if (questionIndex >= 1 && questionIndex <= 11) {
      // E/I Category (Question 1-11)
      FFAppState().ecount = FFAppState().ecount + 1; // Increment E_count
    } else if (questionIndex >= 12 && questionIndex <= 24) {
      // S/N Category (Question 12-25)
      FFAppState().scount = FFAppState().scount + 1; // Increment S_count
    } else if (questionIndex >= 25 && questionIndex <= 37) {
      // T/F Category (Question 26-39)
      FFAppState().tcount = FFAppState().tcount + 1; // Increment T_count
    } else if (questionIndex >= 38 && questionIndex <= 50) {
      // J/P Category (Question 40-50)
      FFAppState().jcount = FFAppState().jcount + 1; // Increment J_count
    }
  }
  // If the selected answer is 'B'
  else if (selectedOption == 'B') {
    if (questionIndex >= 1 && questionIndex <= 11) {
      // E/I Category (Question 1-11)
      FFAppState().icount = FFAppState().icount + 1; // Increment I_count
    } else if (questionIndex >= 12 && questionIndex <= 24) {
      // S/N Category (Question 12-25)
      FFAppState().ncount = FFAppState().ncount + 1; // Increment N_count
    } else if (questionIndex >= 25 && questionIndex <= 37) {
      // T/F Category (Question 26-39)
      FFAppState().fcount = FFAppState().fcount + 1; // Increment F_count
    } else if (questionIndex >= 38 && questionIndex <= 50) {
      // J/P Category (Question 40-50)
      FFAppState().pcount = FFAppState().pcount + 1; // Increment P_count
    }
  }
}

updateAppState(int page) {}

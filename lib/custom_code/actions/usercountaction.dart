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

import 'package:yes_gurl/auth/firebase_auth/auth_util.dart';

import '/flutter_flow/custom_functions.dart' as functions;

Future<int> usercountaction(List<UserRecord> userlist) async {
  // Add your function code here!
  // int value = 0;
  // for (int i = 0; i <= userlist.length; i++) {
  //   if (((userlist?.elementAtOrNull(i)?.dateOfBirth != null) &&
  //           functions.ageCalculation(
  //               functions.calculateAge(
  //                   userlist?.elementAtOrNull(i)?.dateOfBirth ??
  //                       DateTime.now()),
  //               (currentUserDocument?.selectedAgeRange?.toList() ?? [])
  //                   .firstOrNull,
  //               (currentUserDocument?.selectedAgeRange?.toList() ?? [])
  //                   .lastOrNull)!) &&
  //       (currentUserDocument?.selectedChildren?.toList() ?? []).contains(
  //           userlist?.elementAtOrNull(i)?.chldren == 'yes'
  //               ? ' have children'
  //               : 'do not have children') &&
  //       (currentUserDocument?.selectedLocation?.toList() ?? [])
  //           .contains(userlist?.elementAtOrNull(i)?.city) &&
  //       (currentUserDocument?.selectedRelationship?.toList() ?? [])
  //           .contains(userlist?.elementAtOrNull(i)?.relationshipStatus)) {
  //     if (!(currentUserDocument?.chatRequestUser?.toList() ?? [])
  //             .contains(userlist?.elementAtOrNull(i)?.reference) &&
  //         !userlist!
  //             .elementAtOrNull(i)!
  //             .chatRequestUser
  //             .contains(currentUserReference) &&
  //         (userlist?.elementAtOrNull(i)?.isDeactivated != true) &&
  //         !(userlist
  //                 ?.elementAtOrNull(i)
  //                 ?.blockedUsers
  //                 .contains(currentUserReference) ??
  //             false) &&
  //         !(currentUserDocument?.blockedUsers?.toList() ?? [])
  //             .contains(userlist?.elementAtOrNull(i)?.reference) &&
  //         !(userlist?.elementAtOrNull(i)?.hideProfile ?? false) &&
  //         ((userlist?.elementAtOrNull(i)?.isPromptPass == true) &&
  //             (userlist?.elementAtOrNull(i)?.isInterestPass == true))) {
  //       value += 1;
  //     }
  //   }
  // }
  // return value;
  int value = 0;
  for (int i = 0; i <= userlist.length; i++) {
    if (((userlist?.elementAtOrNull(i)?.dateOfBirth != null) &&
            functions.ageCalculation(
                functions.calculateAge(
                    userlist?.elementAtOrNull(i)?.dateOfBirth ??
                        DateTime.now()),
                (currentUserDocument?.selectedAgeRange?.toList() ?? [])
                    .firstOrNull,
                (currentUserDocument?.selectedAgeRange?.toList() ?? [])
                    .lastOrNull)!) &&
        (currentUserDocument?.selectedChildren?.toList() ?? []).contains(
            userlist?.elementAtOrNull(i)?.chldren == 'yes'
                ? ' have children'
                : 'do not have children') &&
        (currentUserDocument?.selectedRelationship?.toList() ?? [])
            .contains(userlist?.elementAtOrNull(i)?.relationshipStatus)) {
      if (!(currentUserDocument?.chatRequestUser?.toList() ?? [])
              .contains(userlist?.elementAtOrNull(i)?.reference) &&
          !userlist!
              .elementAtOrNull(i)!
              .chatRequestUser
              .contains(currentUserReference) &&
          (userlist?.elementAtOrNull(i)?.isDeactivated != true) &&
          !(userlist
                  ?.elementAtOrNull(i)
                  ?.blockedUsers
                  .contains(currentUserReference) ??
              false) &&
          !(currentUserDocument?.blockedUsers?.toList() ?? [])
              .contains(userlist?.elementAtOrNull(i)?.reference) &&
          !(userlist?.elementAtOrNull(i)?.hideProfile ?? false) &&
          ((userlist?.elementAtOrNull(i)?.isPromptPass == true) &&
              (userlist?.elementAtOrNull(i)?.isInterestPass == true)) &&
          functions.isUserActiveForRecommendation(
                  userlist?.elementAtOrNull(i)?.updatedTime ?? "") ==
              true) {
        if ((currentUserDocument?.preferrredLocation == 'anywhere in the uk')) {
          value += 1;
        } else if (currentUserDocument?.preferrredLocation ==
            'only my location') {
          if (currentUserDocument?.city == userlist.elementAt(i).subCity) {
            value += 1;
          }
        } else if (currentUserDocument?.preferrredLocation ==
            'locations within a 30 mile radius') {
          if (currentUserDocument?.city == 'London') {
            if (FFAppState()
                .within30milesLondon
                .contains(userlist.elementAt(i).subCity)) {
              value += 1;
            }
          } else if (currentUserDocument?.city == 'South East England') {
            if (FFAppState()
                .within30milesSouthEastEngland
                .contains(userlist.elementAt(i).subCity)) {
              value += 1;
            }
          } else if (currentUserDocument?.city == 'South West England') {
            if (FFAppState()
                .within30milesSouthWestEngland
                .contains(userlist.elementAt(i).subCity)) {
              value += 1;
            }
          } else if (currentUserDocument?.city == 'East of England') {
            if (FFAppState()
                .within30milesEastofEngland
                .contains(userlist.elementAt(i).subCity)) {
              value += 1;
            }
          } else if (currentUserDocument?.city == 'West Midlands') {
            if (FFAppState()
                .within30milesWestMidlands
                .contains(userlist.elementAt(i).subCity)) {
              value += 1;
            }
          } else if (currentUserDocument?.city == 'East Midlands') {
            if (FFAppState()
                .within30milesEastMidlands
                .contains(userlist.elementAt(i).subCity)) {
              value += 1;
            }
          } else if (currentUserDocument?.city == 'North West England') {
            if (FFAppState()
                .within30milesNorthWestEngland
                .contains(userlist.elementAt(i).subCity)) {
              value += 1;
            }
          } else if (currentUserDocument?.city == 'Yorkshire and the Humber') {
            if (FFAppState()
                .within30milesYorkshireandtheHumber
                .contains(userlist.elementAt(i).subCity)) {
              value += 1;
            }
          } else if (currentUserDocument?.city == 'North East England') {
            if (FFAppState()
                .within30milesNorthEastEngland
                .contains(userlist.elementAt(i).subCity)) {
              value += 1;
            }
          }
        }
      }
    }
  }
  return value;
}

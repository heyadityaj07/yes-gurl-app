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

Future<List<DocumentReference>> getMatchingTodayUserProfiles(
  List<DocumentReference>? todayUsers,
  UserRecord? currentUser,
) async {
  // Add your function code here!
  //
  if (todayUsers == null || todayUsers.isEmpty) {
    return [];
  }
  final resolvedCurrentUser = currentUser;
  if (resolvedCurrentUser == null) {
    return [];
  }
  // Fetch UserRecord from each DocumentReference in today_user_list.
  final todayUserDocs = await Future.wait(
    todayUsers.map((ref) => UserRecord.getDocumentOnce(ref)),
  );
  final matchingRefs = <DocumentReference>[];
  for (final candidate in todayUserDocs) {
    // Check 4 — Personality compatibility.
    final userPersonality = candidate.personalityType.trim().toLowerCase();
    final currentPersonality =
        resolvedCurrentUser.personalityType.trim().toLowerCase();
    if (userPersonality.isEmpty || currentPersonality.isEmpty) {
      continue;
    }
    final compatibility = getRecommendation(
      userPersonality,
      currentPersonality,
    );
    if (compatibility != 0 && compatibility != 1) {
      continue;
    }
    // Check 5 — Prompt & interest passes.
    if (candidate.isPromptPass != true || candidate.isInterestPass != true) {
      continue;
    }
    // Check 6 — Age range.
    if (candidate.dateOfBirth == null) {
      continue;
    }
    final ageRange = resolvedCurrentUser.selectedAgeRange;
    if (ageRange.length < 2) {
      continue;
    }
    final candidateAge = calculateAge(candidate.dateOfBirth!);
    if (ageCalculation(candidateAge, ageRange.first, ageRange.last) != true) {
      continue;
    }
    // Check 7 — Children preference.
    String childrenValue = '';
    final rawChildren = candidate.chldren.trim().toLowerCase();
    if (rawChildren == 'yes' || rawChildren == 'have children') {
      childrenValue = 'have children';
    } else if (rawChildren == 'no' || rawChildren == 'do not have children') {
      childrenValue = 'do not have children';
    } else {
      childrenValue = candidate.chldren.trim();
    }
    if (childrenValue.isEmpty ||
        !resolvedCurrentUser.selectedChildren.contains(childrenValue)) {
      continue;
    }
    // Check 8 — Relationship status.
    if (candidate.relationshipStatus.isEmpty ||
        !resolvedCurrentUser.selectedRelationship
            .contains(candidate.relationshipStatus)) {
      continue;
    }
    // Check 9 — Location preference.
    final preferredLocation = resolvedCurrentUser.preferrredLocation;
    bool locationPass = false;
    if (preferredLocation == 'anywhere in the uk') {
      locationPass = true;
    } else if (preferredLocation == 'only my location') {
      locationPass = resolvedCurrentUser.subCity == candidate.subCity;
    } else if (preferredLocation == 'locations within a 30 mile radius') {
      final city = resolvedCurrentUser.city;
      if (city == 'london') {
        locationPass =
            FFAppState().within30milesLondon.contains(candidate.subCity);
      } else if (city == 'south east england') {
        locationPass = FFAppState()
            .within30milesSouthEastEngland
            .contains(candidate.subCity);
      } else if (city == 'south west england') {
        locationPass = FFAppState()
            .within30milesSouthWestEngland
            .contains(candidate.subCity);
      } else if (city == 'east of england') {
        locationPass =
            FFAppState().within30milesEastofEngland.contains(candidate.subCity);
      } else if (city == 'west midlands') {
        locationPass =
            FFAppState().within30milesWestMidlands.contains(candidate.subCity);
      } else if (city == 'east midlands') {
        locationPass =
            FFAppState().within30milesEastMidlands.contains(candidate.subCity);
      } else if (city == 'north west england') {
        locationPass = FFAppState()
            .within30milesNorthWestEngland
            .contains(candidate.subCity);
      } else if (city == 'yorkshire and the humber') {
        locationPass = FFAppState()
            .within30milesYorkshireandtheHumber
            .contains(candidate.subCity);
      } else if (city == 'north east england') {
        locationPass = FFAppState()
            .within30milesNorthEastEngland
            .contains(candidate.subCity);
      }
    }
    if (!locationPass) {
      continue;
    }
    // Check 10 — Active status.
    if (candidate.updatedTime.isEmpty ||
        !isUserActiveForRecommendation(candidate.updatedTime)) {
      continue;
    }
    matchingRefs.add(candidate.reference);
  }
  return matchingRefs;
}

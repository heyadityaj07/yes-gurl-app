// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/auth/firebase_auth/auth_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:yes_gurl/components/no_match_widget.dart';
import 'package:yes_gurl/components/user_card_widget.dart';

class PotenitialMatches extends StatefulWidget {
  const PotenitialMatches({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<PotenitialMatches> createState() => _PotenitialMatchesState();
}

class _PotenitialMatchesState extends State<PotenitialMatches> {
  bool _loading = true;
  String? _error;
  int batchsize = 5;
  UserRecord? _currentUser;
  List<UserRecord> _todayUsers = [];

  // Tracks individual user-doc stream subscriptions so we can cancel them.
  final Map<String, StreamSubscription<UserRecord>> _userSubs = {};

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  @override
  void dispose() {
    for (final sub in _userSubs.values) {
      sub.cancel();
    }
    _userSubs.clear();
    super.dispose();
  }

  // ── core logic ─────────────────────────────────────────────────────────

  /// 1. Fetch the current user doc.
  /// 2. Run the daily-update logic (writes to Firestore if needed).
  /// 3. Re-fetch the current user doc so todayUserList is fresh.
  /// 4. Fetch all today-user docs.
  /// 5. Subscribe to real-time updates for each today-user.
  Future<void> _bootstrap() async {
    if (!mounted) return;
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      // Step 1 – fresh current user
      final ref = currentUserReference;
      if (ref == null) throw Exception('Not signed in');

      UserRecord userDoc = await UserRecord.getDocumentOnce(ref);

      // Step 2 – run daily update (may write new todayUserList)
      await _dailyUserUpdate(userDoc);

      // Step 3 – re-fetch so we see the writes
      userDoc = await UserRecord.getDocumentOnce(ref);
      if (!mounted) return;

      _currentUser = userDoc;

      // Step 4 – fetch today users
      final todayRefs = (userDoc.todayUserList ?? []).toList();
      final users = await _fetchUsers(todayRefs);
      if (!mounted) return;

      setState(() {
        _todayUsers = users;
        _loading = false;
      });

      // Step 5 – subscribe to live updates for each card
      _subscribeToTodayUsers(todayRefs);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<List<UserRecord>> _fetchUsers(List<DocumentReference> refs) async {
    if (refs.isEmpty) return [];
    final futures = refs.map((r) => UserRecord.getDocumentOnce(r));
    final results = await Future.wait(futures);
    return results.toList();
  }

  // Tracks refs currently being replaced to avoid duplicate replacement races.
  final Set<String> _replacingSlots = {};

  void _subscribeToTodayUsers(List<DocumentReference> refs) {
    // Cancel stale subs first
    for (final sub in _userSubs.values) sub.cancel();
    _userSubs.clear();

    for (final ref in refs) {
      _subscribeToSlot(ref);
    }
  }

  /// Subscribes to a single user-doc slot.
  /// On every Firestore update it validates the user.
  /// If invalid → cancel this slot's sub and replace only that one slot.
  void _subscribeToSlot(DocumentReference ref) {
    final sub = UserRecord.getDocument(ref).listen((updatedUser) async {
      if (!mounted) return;

      final currentUser = _currentUser;
      if (currentUser == null) return;

      final isValid = _filterValidUsers([updatedUser], currentUser).isNotEmpty;

      if (isValid) {
        // Still valid — just refresh the card data in-place
        setState(() {
          final idx = _todayUsers
              .indexWhere((u) => u.reference == updatedUser.reference);
          if (idx != -1) _todayUsers[idx] = updatedUser;
        });
      } else {
        // Invalid — replace only this one slot
        await _replaceSlot(ref);
      }
    });
    _userSubs[ref.id] = sub;
  }

  /// Cancels the subscription for [invalidRef], removes it from [_todayUsers],
  /// finds one fresh valid replacement, writes it to Firestore todayUserList,
  /// then subscribes to the new slot.
  Future<void> _replaceSlot(DocumentReference invalidRef) async {
    // Guard against concurrent replacement of the same slot
    if (_replacingSlots.contains(invalidRef.id)) return;
    _replacingSlots.add(invalidRef.id);

    try {
      // Cancel & remove old sub
      await _userSubs[invalidRef.id]?.cancel();
      _userSubs.remove(invalidRef.id);

      final currentUser = _currentUser;
      if (currentUser == null || !mounted) return;

      // Remove from visible list immediately so the UI doesn't show a ghost card
      setState(() {
        _todayUsers.removeWhere((u) => u.reference == invalidRef);
      });

      // Collect refs already in the list (still valid ones) + previously shown
      final existingRefs = _todayUsers.map((u) => u.reference).toSet();
      final latestList =
          (currentUser.latestUserList ?? []).cast<DocumentReference>().toSet();

      // Exclude: current slots + already shown history + the invalid one
      final excluded = {...existingRefs, ...latestList, invalidRef};

      // Fetch valid users and pick one not already used
      final allValid = await _fetchValidUsersInBatches(currentUser);
      final candidates = allValid
          .where((u) => !excluded.contains(u.reference))
          .toList()
        ..shuffle(Random());

      // Fallback: if everyone has been shown, allow repeats from full valid pool
      final replacement = candidates.isNotEmpty
          ? candidates.first
          : (allValid..shuffle(Random())).firstOrNull;

      if (replacement == null || !mounted) return;

      // Rebuild the full todayUserList with the replacement
      final newTodayRefs = [
        ..._todayUsers.map((u) => u.reference),
        replacement.reference,
      ];

      // Update latestUserList to track this new user as shown
      final updatedLatest =
          {...latestList, replacement.reference}.take(batchsize).toList();

      await currentUser.reference.update({
        ...mapToFirestore({
          'today_user_list': newTodayRefs,
          'latest_user_list': updatedLatest,
        }),
      });

      if (!mounted) return;

      // Re-fetch currentUser so _currentUser reflects the Firestore write
      final refreshed = await UserRecord.getDocumentOnce(currentUser.reference);
      if (!mounted) return;

      setState(() {
        _currentUser = refreshed;
        _todayUsers.add(replacement);
      });

      // Subscribe to the new slot
      _subscribeToSlot(replacement.reference);
    } finally {
      _replacingSlots.remove(invalidRef.id);
    }
  }

  // ── daily-update logic (migrated from custom action) ───────────────────

  Future<void> _dailyUserUpdate(UserRecord userDoc) async {
    final today = dateTimeFormat("yMMMd", getCurrentTimestamp);
    final lastUpdate = valueOrDefault(userDoc.updatedTime, '');

    if (lastUpdate != today) {
      // Day changed: yesterday's todayUserList is replaced entirely.
      await _assignFreshUsers(userDoc, today);
      return;
    }

    // Same day: validate existing slots, top-up only missing ones.
    final todayRefs = (userDoc.todayUserList ?? []).toList();
    if (todayRefs.isEmpty) {
      await _assignFreshUsers(userDoc, today);
      return;
    }

    final todayIds = todayRefs.map((e) => e.id).toList();
    List<UserRecord> todayUsers = [];
    if (todayIds.isNotEmpty) {
      todayUsers = await queryUserRecordOnce(
        queryBuilder: (q) => q.whereIn('uid', todayIds),
      );
    }

    final validUsers = _filterValidUsers(todayUsers, userDoc);
    final validRefs = validUsers.map((e) => e.reference).toList();
    final missingCount = 3 - validRefs.length;

    if (missingCount <= 0) return; // All 3 still valid, nothing to do.

    // latestUserList = full history of every user ever shown; never shrinks
    // (except on a full pool reset). Exclude them from candidates.
    final latestSet =
        (userDoc.latestUserList ?? []).cast<DocumentReference>().toSet();

    final allUsers = await _fetchValidUsersInBatches(userDoc);
    final excluded = {...validRefs, ...latestSet};
    var candidates = allUsers
        .where((u) => !excluded.contains(u.reference))
        .toList()
      ..shuffle(Random());

    // Pool exhausted for today's top-up: reset latestUserList.
    final didReset = candidates.isEmpty;
    if (didReset) {
      candidates = allUsers
          .where((u) => !validRefs.contains(u.reference))
          .toList()
        ..shuffle(Random());
    }

    final newRefs =
        candidates.take(missingCount).map((e) => e.reference).toList();
    final finalTodayRefs = [...validRefs, ...newRefs];

    final updatedLatest = didReset
        ? finalTodayRefs.toSet().toList() // reset
        : {...latestSet, ...newRefs}.take(200).toList(); // grow

    await userDoc.reference.update({
      ...createUserRecordData(updatedTime: today),
      ...mapToFirestore({
        'today_user_list': finalTodayRefs,
        'latest_user_list': updatedLatest,
      }),
    });
  }

  /// Replaces today_user_list entirely with 3 new users not in latestUserList.
  ///
  /// latestUserList behaviour:
  ///   - Normally: keeps growing (old entries preserved + today's 3 appended).
  ///   - Pool nearly exhausted (< 3 unseen): fill with repeats, then reset the
  ///     list to only today's 3 so tomorrow restarts cleanly.
  ///   - Full reset (0 unseen): wipe latestUserList, pick 3 from entire pool.
  Future<void> _assignFreshUsers(UserRecord userDoc, String today) async {
    final allUsers = await _fetchValidUsersInBatches(userDoc);

    // History of every user ever shown to this person.
    final latestSet =
        (userDoc.latestUserList ?? []).cast<DocumentReference>().toSet();

    // Users not yet in history.
    var unseen = allUsers
        .where((u) => !latestSet.contains(u.reference))
        .toList()
      ..shuffle(Random());

    List<DocumentReference> newTodayRefs;
    List<DocumentReference> updatedLatest;

    if (unseen.length >= 3) {
      // ── Normal path: plenty of unseen users ─────────────────────────────
      newTodayRefs = unseen.take(3).map((u) => u.reference).toList();
      // Grow history: keep old entries + add today's 3.
      updatedLatest = {...latestSet, ...newTodayRefs}.take(200).toList();
    } else if (unseen.isNotEmpty) {
      // ── Nearly exhausted: use remaining unseen + fill with repeats ───────
      final fromUnseen = unseen.map((u) => u.reference).toList();
      final needed = 3 - fromUnseen.length;
      final repeats = (allUsers..shuffle(Random()))
          .where((u) => !fromUnseen.contains(u.reference))
          .take(needed)
          .map((u) => u.reference)
          .toList();
      newTodayRefs = [...fromUnseen, ...repeats];
      // Reset history to just today's 3 so tomorrow has a full fresh pool.
      updatedLatest = newTodayRefs.toSet().toList();
    } else {
      // ── Full reset: every valid user has been seen already ───────────────
      (allUsers..shuffle(Random()));
      newTodayRefs = allUsers.take(3).map((u) => u.reference).toList();
      // Start history from scratch with only today's 3.
      updatedLatest = newTodayRefs.toSet().toList();
    }

    await userDoc.reference.update({
      ...createUserRecordData(updatedTime: today),
      ...mapToFirestore({
        'today_user_list': newTodayRefs, // yesterday's 3 fully replaced
        'latest_user_list': updatedLatest, // grows, or resets if exhausted
      }),
    });
  }

  List<UserRecord> _filterValidUsers(
      List<UserRecord> allUsers, UserRecord userDoc) {
    final result = <UserRecord>[];
    for (final user in allUsers) {
      if (user.reference == currentUserReference) continue;
      if (user.isDeactivated == true) continue;
      if (user.hideProfile == true) continue;
      if ((user.blockedUsers ?? []).contains(currentUserReference)) continue;
      if ((userDoc.blockedUsers ?? []).contains(user.reference)) continue;
      if ((userDoc.blockUserList ?? []).contains(user.reference)) continue;
      if ((userDoc.chatRequestUser ?? []).contains(user.reference)) continue;
      if ((user.chatRequestUser ?? []).contains(currentUserReference)) continue;
      if ((userDoc.messageSent ?? []).contains(user.reference)) continue;
      if (user.banned == true) continue;

      final userPersonality =
          valueOrDefault(user.personalityType, '').toLowerCase();
      final currentPersonality =
          valueOrDefault(userDoc.personalityType, '').toLowerCase();
      if (userPersonality.isEmpty || currentPersonality.isEmpty) continue;

      final compat =
          functions.getRecommendation(userPersonality, currentPersonality);
      if (compat != 0 && compat != 1) continue;

      if (user.isPromptPass != true || user.isInterestPass != true) continue;
      if (user.dateOfBirth == null) continue;

      if (functions.ageCalculation(
            functions.calculateAge(user.dateOfBirth!),
            (userDoc.selectedAgeRange ?? []).firstOrNull,
            (userDoc.selectedAgeRange ?? []).lastOrNull,
          ) !=
          true) continue;

      if (!(userDoc.selectedChildren ?? []).contains(
        user.chldren == 'yes' ? 'have children' : 'do not have children',
      )) continue;

      if (!(userDoc.selectedRelationship ?? [])
          .contains(user.relationshipStatus)) continue;

      if (functions.usercountfunction(
            user,
            FFAppState().within30milesLondon,
            FFAppState().within30milesSouthEastEngland,
            FFAppState().within30milesSouthWestEngland,
            FFAppState().within30milesEastofEngland,
            FFAppState().within30milesWestMidlands,
            FFAppState().within30milesEastMidlands,
            FFAppState().within30milesNorthWestEngland,
            FFAppState().within30milesYorkshireandtheHumber,
            FFAppState().within30milesNorthEastEngland,
          ) !=
          true) continue;

      if (user.updatedTime == null) continue;
      if (!functions.isUserActiveForRecommendation(user.updatedTime)) continue;

      result.add(user);
    }
    return result;
  }

  Future<List<UserRecord>> _fetchValidUsersInBatches(UserRecord userDoc) async {
    final validUsers = <UserRecord>[];
    DocumentSnapshot? lastDoc;
    bool hasMore = true;

    while (validUsers.length < batchsize && hasMore) {
      Query query = UserRecord.collection.limit(batchsize);
      if (lastDoc != null) query = query.startAfterDocument(lastDoc);

      final snapshot = await query.get();
      if (snapshot.docs.isEmpty) {
        hasMore = false;
        break;
      }

      lastDoc = snapshot.docs.last;
      final batch =
          snapshot.docs.map((d) => UserRecord.fromSnapshot(d)).toList();
      final filtered = _filterValidUsers(batch, userDoc);
      final needed = batchsize - validUsers.length;
      validUsers
          .addAll(filtered.length > needed ? filtered.take(needed) : filtered);
    }
    return validUsers;
  }

  // ── UI helpers ─────────────────────────────────────────────────────────

  bool _alreadySent(DocumentReference ref) =>
      (_currentUser?.messageSent?.toList() ?? []).contains(ref);

  int _compat(UserRecord user) => functions.getRecommendation(
        user.personalityType,
        valueOrDefault(_currentUser?.personalityType, ''),
      );

  // ── build ──────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return SizedBox(
        width: widget.width,
        height: 300,
        child: Center(
          child: LinearProgressIndicator(
            color: Color(0xFFFE99AB),
          ),
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Container(
          width: double.infinity,
          height: 400.0,
          child: NoMatchWidget(),
        ),
      );
    }

    // Only show cards with compat 0 or 1
    final visible =
        _todayUsers.where((u) => _compat(u) == 0 || _compat(u) == 1).toList();

    if (visible.isEmpty) {
      return Center(
        child: Container(
          width: double.infinity,
          height: 400.0,
          child: NoMatchWidget(),
        ),
      );
    }

    return SizedBox(
      width: widget.width,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: visible.length,
        itemBuilder: (context, index) {
          final user = visible[index];

          return UserCardWidget(
            user: user,
          );
        },
      ),
    );
  }
}

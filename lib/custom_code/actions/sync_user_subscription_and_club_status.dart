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

import 'index.dart'; // Imports other custom actions

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '/flutter_flow/revenue_cat_util.dart' as revenue_cat;
import '/auth/firebase_auth/auth_util.dart';

/// syncUserSubscriptionAndClubStatus
///
/// Synchronizes RevenueCat subscription state with Firestore club_members and
/// user collections.
///
/// - Validates expiry_date so expired subscriptions are strictly marked
/// inactive - Updates 'is_subscription_active' (bool) on user doc - Updates
/// 'is_active' (bool) on club_members doc
Future<bool> syncUserSubscriptionAndClubStatus() async {
  final userRef = currentUserReference;
  final uid = currentUserUid;

  if (userRef == null || uid.isEmpty) {
    return false;
  }

  try {
    // 1. Check RevenueCat customer info & active subscriptions/entitlements
    CustomerInfo? customerInfo;
    try {
      customerInfo = await Purchases.getCustomerInfo();
    } catch (_) {}

    DateTime? storeExpDate;
    if (customerInfo?.latestExpirationDate != null) {
      storeExpDate = DateTime.tryParse(customerInfo!.latestExpirationDate!);
    }
    final bool isStoreExpired =
        storeExpDate != null && DateTime.now().isAfter(storeExpDate);

    final bool hasStoreSub = customerInfo != null &&
        !isStoreExpired &&
        (customerInfo.activeSubscriptions.isNotEmpty ||
            customerInfo.entitlements.active.isNotEmpty);

    final clubMemberRef = ClubMembersRecord.collection.doc(uid);

    if (hasStoreSub) {
      // Active in store and not expired
      final expiryDate =
          revenue_cat.revenueCatDate(customerInfo.latestExpirationDate);

      await clubMemberRef.set({
        'user': userRef,
        'is_active': true,
        'purchase_date': FieldValue.serverTimestamp(),
        'expiry_date': expiryDate,
      }, SetOptions(merge: true));

      await userRef.set({
        'club_member': clubMemberRef,
        'is_subscription_active': true,
      }, SetOptions(merge: true));

      return true;
    } else {
      // Store sub not active or expired. Check Firestore club_members document.
      final docSnap = await clubMemberRef.get();
      if (docSnap.exists) {
        final data = docSnap.data() as Map<String, dynamic>?;
        if (data != null) {
          final expiryDate = (data['expiry_date'] as Timestamp?)?.toDate();
          final bool isDbExpired =
              expiryDate != null && DateTime.now().isAfter(expiryDate);

          if (isDbExpired || isStoreExpired || data['is_active'] == false) {
            // Marked expired in store or database
            await clubMemberRef.set({
              'is_active': false,
            }, SetOptions(merge: true));

            await userRef.set({
              'is_subscription_active': false,
            }, SetOptions(merge: true));

            return false;
          }

          if (data['is_active'] == true && !isDbExpired) {
            // Direct/promo membership active and not expired
            await userRef.set({
              'club_member': clubMemberRef,
              'is_subscription_active': true,
            }, SetOptions(merge: true));

            return true;
          }
        }
      }

      // Default inactive state
      await userRef.set({
        'is_subscription_active': false,
      }, SetOptions(merge: true));
    }
  } catch (e) {
    debugPrint('Error syncing subscription status: $e');
  }

  return false;
}

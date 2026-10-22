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
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '/flutter_flow/revenue_cat_util.dart' as revenue_cat;
import '/auth/firebase_auth/auth_util.dart';

Future<String> joinOrRestoreBabesClub(bool isRestoreOnly) async {
  final userRef = currentUserReference;
  final uid = currentUserUid;

  if (userRef == null || uid.isEmpty) {
    return 'not_logged_in';
  }

  final clubMemberRef = ClubMembersRecord.collection.doc(uid);

  if (isRestoreOnly) {
    try {
      final customerInfo = await Purchases.restorePurchases();
      DateTime? expDate;
      if (customerInfo.latestExpirationDate != null) {
        expDate = DateTime.tryParse(customerInfo.latestExpirationDate!);
      }
      final isExpired = expDate != null && DateTime.now().isAfter(expDate);

      final hasActive = !isExpired &&
          (customerInfo.activeSubscriptions.isNotEmpty ||
              customerInfo.entitlements.active.isNotEmpty);

      if (!hasActive) {
        await clubMemberRef.set({
          'is_active': false,
        }, SetOptions(merge: true));
        await userRef.set({
          'is_subscription_active': false,
        }, SetOptions(merge: true));
        return 'no_active_subscription';
      }

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

      return 'success';
    } catch (e) {
      debugPrint('Restore purchases error: $e');
      return 'error: $e';
    }
  }

  // --- Purchase Flow ---
  try {
    // 1. Get offerings safely without force-unwraps
    Offerings offerings;
    try {
      offerings = await Purchases.getOfferings();
    } catch (e) {
      debugPrint('Error getting offerings: $e');
      return 'package_unavailable';
    }

    final currentOffering = offerings.current;
    Package? selectedPackage = currentOffering?.monthly;
    if (selectedPackage == null && currentOffering != null) {
      if (currentOffering.availablePackages.isNotEmpty) {
        selectedPackage = currentOffering.availablePackages.first;
      }
    }

    if (selectedPackage == null) {
      return 'package_unavailable';
    }

    // 2. Execute purchase with RevenueCat SDK
    final purchaseResult = await Purchases.purchasePackage(selectedPackage);
    final customerInfo = purchaseResult.customerInfo;
    DateTime? expDate;
    if (customerInfo.latestExpirationDate != null) {
      expDate = DateTime.tryParse(customerInfo.latestExpirationDate!);
    }
    final isExpired = expDate != null && DateTime.now().isAfter(expDate);

    final isPurchased = !isExpired &&
        (customerInfo.activeSubscriptions.isNotEmpty ||
            customerInfo.entitlements.active.isNotEmpty);

    if (isPurchased) {
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

      return 'success';
    }

    return 'user_cancelled';
  } on PlatformException catch (pe) {
    final errorCode = PurchasesErrorHelper.getErrorCode(pe);
    if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
      return 'user_cancelled';
    }
    debugPrint('PlatformException purchasing package: ${pe.message}');
    return 'error: ${pe.message ?? pe.code}';
  } catch (e) {
    debugPrint('Error purchasing package: $e');
    return 'error: $e';
  }
}

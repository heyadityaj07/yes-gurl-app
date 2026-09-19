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

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserOnlineStatusListener extends StatefulWidget {
  const UserOnlineStatusListener({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<UserOnlineStatusListener> createState() =>
      _UserOnlineStatusListenerState();
}

class _UserOnlineStatusListenerState extends State<UserOnlineStatusListener>
    with WidgetsBindingObserver {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Connectivity _connectivity = Connectivity();

  DocumentReference<Map<String, dynamic>>? _userRef;

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  Timer? _heartbeatTimer;

  bool _isAppInForeground = true;
  bool _hasNetworkConnection = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _initializePresence();
  }

  Future<void> _initializePresence() async {
    final user = _auth.currentUser;

    if (user == null) {
      return;
    }

    _userRef = _firestore.collection('Users').doc(user.uid);

    final results = await _connectivity.checkConnectivity();

    _hasNetworkConnection = _hasConnection(results);

    await _updatePresence();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((results) async {
      final wasConnected = _hasNetworkConnection;
      _hasNetworkConnection = _hasConnection(results);

      if (_hasNetworkConnection && !wasConnected) {
        // Internet/network returned.
        await _setOnline();
      } else if (!_hasNetworkConnection && wasConnected) {
        // Network was lost.
        await _setOffline();
      }
    });

    _startHeartbeat();
  }

  bool _hasConnection(List<ConnectivityResult> results) {
    return results.isNotEmpty && !results.contains(ConnectivityResult.none);
  }

  void _startHeartbeat() {
    _heartbeatTimer?.cancel();

    _heartbeatTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) async {
        if (_isAppInForeground && _hasNetworkConnection) {
          await _sendHeartbeat();
        }
      },
    );
  }

  Future<void> _updatePresence() async {
    if (_isAppInForeground && _hasNetworkConnection) {
      await _setOnline();
    } else {
      await _setOffline();
    }
  }

  Future<void> _setOnline() async {
    final reference = _userRef;

    if (reference == null) {
      return;
    }

    try {
      await reference.set({
        'last_active': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (error) {
      debugPrint('Unable to set user online: $error');
    }
  }

  Future<void> _sendHeartbeat() async {
    final reference = _userRef;

    if (reference == null) {
      return;
    }

    try {
      await reference.update({
        'last_active': FieldValue.serverTimestamp(),
      });
    } catch (error) {
      debugPrint('Unable to update heartbeat: $error');
    }
  }

  Future<void> _setOffline() async {
    final reference = _userRef;

    if (reference == null) {
      return;
    }

    try {
      await reference.set({
        'last_active': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (error) {
      debugPrint('Unable to set user offline: $error');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _isAppInForeground = true;
        _updatePresence();
        break;

      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        _isAppInForeground = false;
        _setOffline();
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    _heartbeatTimer?.cancel();
    _connectivitySubscription?.cancel();

    _setOffline();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? 0,
      height: widget.height ?? 0,
    );
  }
}

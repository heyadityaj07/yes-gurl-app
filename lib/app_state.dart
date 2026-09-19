import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  bool _signupFirstNameState = false;
  bool get signupFirstNameState => _signupFirstNameState;
  set signupFirstNameState(bool value) {
    _signupFirstNameState = value;
  }

  bool _signupSecondNameState = false;
  bool get signupSecondNameState => _signupSecondNameState;
  set signupSecondNameState(bool value) {
    _signupSecondNameState = value;
  }

  String _prompt1 = '';
  String get prompt1 => _prompt1;
  set prompt1(String value) {
    _prompt1 = value;
  }

  String _prompt2 = '';
  String get prompt2 => _prompt2;
  set prompt2(String value) {
    _prompt2 = value;
  }

  String _prompt3 = '';
  String get prompt3 => _prompt3;
  set prompt3(String value) {
    _prompt3 = value;
  }

  String _interest1 = '';
  String get interest1 => _interest1;
  set interest1(String value) {
    _interest1 = value;
  }

  String _interest2 = '';
  String get interest2 => _interest2;
  set interest2(String value) {
    _interest2 = value;
  }

  String _interest3 = '';
  String get interest3 => _interest3;
  set interest3(String value) {
    _interest3 = value;
  }

  String _interest4 = '';
  String get interest4 => _interest4;
  set interest4(String value) {
    _interest4 = value;
  }

  String _lastMessage = '';
  String get lastMessage => _lastMessage;
  set lastMessage(String value) {
    _lastMessage = value;
  }

  String _sharabelImage = '';
  String get sharabelImage => _sharabelImage;
  set sharabelImage(String value) {
    _sharabelImage = value;
  }

  DocumentReference? _sharedEvent;
  DocumentReference? get sharedEvent => _sharedEvent;
  set sharedEvent(DocumentReference? value) {
    _sharedEvent = value;
  }

  String _invitationText = '';
  String get invitationText => _invitationText;
  set invitationText(String value) {
    _invitationText = value;
  }

  DateTime? _startTime;
  DateTime? get startTime => _startTime;
  set startTime(DateTime? value) {
    _startTime = value;
  }

  DateTime? _endTime;
  DateTime? get endTime => _endTime;
  set endTime(DateTime? value) {
    _endTime = value;
  }

  LatLng? _latlang;
  LatLng? get latlang => _latlang;
  set latlang(LatLng? value) {
    _latlang = value;
  }

  int _ecount = 0;
  int get ecount => _ecount;
  set ecount(int value) {
    _ecount = value;
  }

  int _scount = 0;
  int get scount => _scount;
  set scount(int value) {
    _scount = value;
  }

  int _icount = 0;
  int get icount => _icount;
  set icount(int value) {
    _icount = value;
  }

  int _ncount = 0;
  int get ncount => _ncount;
  set ncount(int value) {
    _ncount = value;
  }

  int _tcount = 0;
  int get tcount => _tcount;
  set tcount(int value) {
    _tcount = value;
  }

  int _fcount = 0;
  int get fcount => _fcount;
  set fcount(int value) {
    _fcount = value;
  }

  int _jcount = 0;
  int get jcount => _jcount;
  set jcount(int value) {
    _jcount = value;
  }

  int _pcount = 0;
  int get pcount => _pcount;
  set pcount(int value) {
    _pcount = value;
  }

  String _personality = '';
  String get personality => _personality;
  set personality(String value) {
    _personality = value;
  }

  String _nickname = '';
  String get nickname => _nickname;
  set nickname(String value) {
    _nickname = value;
  }

  List<String> _londonlist = ['london'];
  List<String> get londonlist => _londonlist;
  set londonlist(List<String> value) {
    _londonlist = value;
  }

  void addToLondonlist(String value) {
    londonlist.add(value);
  }

  void removeFromLondonlist(String value) {
    londonlist.remove(value);
  }

  void removeAtIndexFromLondonlist(int index) {
    londonlist.removeAt(index);
  }

  void updateLondonlistAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    londonlist[index] = updateFn(_londonlist[index]);
  }

  void insertAtIndexInLondonlist(int index, String value) {
    londonlist.insert(index, value);
  }

  List<String> _SouthEastEnglandlist = [
    'berkshire',
    'buckinghamshire',
    'east sussex',
    'hampshire',
    'isle of wight',
    'kent',
    'oxfordshire',
    'surrey',
    'west sussex'
  ];
  List<String> get SouthEastEnglandlist => _SouthEastEnglandlist;
  set SouthEastEnglandlist(List<String> value) {
    _SouthEastEnglandlist = value;
  }

  void addToSouthEastEnglandlist(String value) {
    SouthEastEnglandlist.add(value);
  }

  void removeFromSouthEastEnglandlist(String value) {
    SouthEastEnglandlist.remove(value);
  }

  void removeAtIndexFromSouthEastEnglandlist(int index) {
    SouthEastEnglandlist.removeAt(index);
  }

  void updateSouthEastEnglandlistAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    SouthEastEnglandlist[index] = updateFn(_SouthEastEnglandlist[index]);
  }

  void insertAtIndexInSouthEastEnglandlist(int index, String value) {
    SouthEastEnglandlist.insert(index, value);
  }

  List<String> _SouthWestEnglandlist = [
    'bristol',
    'cornwall',
    'devon',
    'dorset',
    'gloucestershire',
    'somerset',
    'wiltshire'
  ];
  List<String> get SouthWestEnglandlist => _SouthWestEnglandlist;
  set SouthWestEnglandlist(List<String> value) {
    _SouthWestEnglandlist = value;
  }

  void addToSouthWestEnglandlist(String value) {
    SouthWestEnglandlist.add(value);
  }

  void removeFromSouthWestEnglandlist(String value) {
    SouthWestEnglandlist.remove(value);
  }

  void removeAtIndexFromSouthWestEnglandlist(int index) {
    SouthWestEnglandlist.removeAt(index);
  }

  void updateSouthWestEnglandlistAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    SouthWestEnglandlist[index] = updateFn(_SouthWestEnglandlist[index]);
  }

  void insertAtIndexInSouthWestEnglandlist(int index, String value) {
    SouthWestEnglandlist.insert(index, value);
  }

  List<String> _EastofEnglandlist = [
    'bedfordshire',
    'cambridgeshire',
    'essex',
    'hertfordshire',
    'norfolk',
    'suffolk'
  ];
  List<String> get EastofEnglandlist => _EastofEnglandlist;
  set EastofEnglandlist(List<String> value) {
    _EastofEnglandlist = value;
  }

  void addToEastofEnglandlist(String value) {
    EastofEnglandlist.add(value);
  }

  void removeFromEastofEnglandlist(String value) {
    EastofEnglandlist.remove(value);
  }

  void removeAtIndexFromEastofEnglandlist(int index) {
    EastofEnglandlist.removeAt(index);
  }

  void updateEastofEnglandlistAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    EastofEnglandlist[index] = updateFn(_EastofEnglandlist[index]);
  }

  void insertAtIndexInEastofEnglandlist(int index, String value) {
    EastofEnglandlist.insert(index, value);
  }

  List<String> _WestMidlands = [
    'herefordshire',
    'shropshire',
    'staffordshire',
    'warwickshire',
    'birmingham',
    'worcestershire'
  ];
  List<String> get WestMidlands => _WestMidlands;
  set WestMidlands(List<String> value) {
    _WestMidlands = value;
  }

  void addToWestMidlands(String value) {
    WestMidlands.add(value);
  }

  void removeFromWestMidlands(String value) {
    WestMidlands.remove(value);
  }

  void removeAtIndexFromWestMidlands(int index) {
    WestMidlands.removeAt(index);
  }

  void updateWestMidlandsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    WestMidlands[index] = updateFn(_WestMidlands[index]);
  }

  void insertAtIndexInWestMidlands(int index, String value) {
    WestMidlands.insert(index, value);
  }

  List<String> _EastMidlands = [
    'derbyshire',
    'leicestershire',
    'lincolnshire',
    'northamptonshire',
    'nottinghamshire',
    'rutland'
  ];
  List<String> get EastMidlands => _EastMidlands;
  set EastMidlands(List<String> value) {
    _EastMidlands = value;
  }

  void addToEastMidlands(String value) {
    EastMidlands.add(value);
  }

  void removeFromEastMidlands(String value) {
    EastMidlands.remove(value);
  }

  void removeAtIndexFromEastMidlands(int index) {
    EastMidlands.removeAt(index);
  }

  void updateEastMidlandsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    EastMidlands[index] = updateFn(_EastMidlands[index]);
  }

  void insertAtIndexInEastMidlands(int index, String value) {
    EastMidlands.insert(index, value);
  }

  List<String> _NorthWestEnglandlist = [
    'cheshire',
    'cumbria',
    'greater manchester',
    'lancashire',
    'merseyside'
  ];
  List<String> get NorthWestEnglandlist => _NorthWestEnglandlist;
  set NorthWestEnglandlist(List<String> value) {
    _NorthWestEnglandlist = value;
  }

  void addToNorthWestEnglandlist(String value) {
    NorthWestEnglandlist.add(value);
  }

  void removeFromNorthWestEnglandlist(String value) {
    NorthWestEnglandlist.remove(value);
  }

  void removeAtIndexFromNorthWestEnglandlist(int index) {
    NorthWestEnglandlist.removeAt(index);
  }

  void updateNorthWestEnglandlistAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    NorthWestEnglandlist[index] = updateFn(_NorthWestEnglandlist[index]);
  }

  void insertAtIndexInNorthWestEnglandlist(int index, String value) {
    NorthWestEnglandlist.insert(index, value);
  }

  List<String> _YorkshireandtheHumber = [
    'east riding of yorkshire',
    'north yorkshire',
    'south yorkshire',
    'west yorkshire'
  ];
  List<String> get YorkshireandtheHumber => _YorkshireandtheHumber;
  set YorkshireandtheHumber(List<String> value) {
    _YorkshireandtheHumber = value;
  }

  void addToYorkshireandtheHumber(String value) {
    YorkshireandtheHumber.add(value);
  }

  void removeFromYorkshireandtheHumber(String value) {
    YorkshireandtheHumber.remove(value);
  }

  void removeAtIndexFromYorkshireandtheHumber(int index) {
    YorkshireandtheHumber.removeAt(index);
  }

  void updateYorkshireandtheHumberAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    YorkshireandtheHumber[index] = updateFn(_YorkshireandtheHumber[index]);
  }

  void insertAtIndexInYorkshireandtheHumber(int index, String value) {
    YorkshireandtheHumber.insert(index, value);
  }

  List<String> _NorthEastEnglandlist = [
    'county durham',
    'northumberland',
    'tyne and wear'
  ];
  List<String> get NorthEastEnglandlist => _NorthEastEnglandlist;
  set NorthEastEnglandlist(List<String> value) {
    _NorthEastEnglandlist = value;
  }

  void addToNorthEastEnglandlist(String value) {
    NorthEastEnglandlist.add(value);
  }

  void removeFromNorthEastEnglandlist(String value) {
    NorthEastEnglandlist.remove(value);
  }

  void removeAtIndexFromNorthEastEnglandlist(int index) {
    NorthEastEnglandlist.removeAt(index);
  }

  void updateNorthEastEnglandlistAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    NorthEastEnglandlist[index] = updateFn(_NorthEastEnglandlist[index]);
  }

  void insertAtIndexInNorthEastEnglandlist(int index, String value) {
    NorthEastEnglandlist.insert(index, value);
  }

  List<String> _within30milesLondon = [
    'london',
    'berkshire',
    'buckinghamshire',
    'kent',
    'surrey',
    'essex',
    'hertfordshire'
  ];
  List<String> get within30milesLondon => _within30milesLondon;
  set within30milesLondon(List<String> value) {
    _within30milesLondon = value;
  }

  void addToWithin30milesLondon(String value) {
    within30milesLondon.add(value);
  }

  void removeFromWithin30milesLondon(String value) {
    within30milesLondon.remove(value);
  }

  void removeAtIndexFromWithin30milesLondon(int index) {
    within30milesLondon.removeAt(index);
  }

  void updateWithin30milesLondonAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    within30milesLondon[index] = updateFn(_within30milesLondon[index]);
  }

  void insertAtIndexInWithin30milesLondon(int index, String value) {
    within30milesLondon.insert(index, value);
  }

  List<String> _within30milesSouthEastEngland = [
    'berkshire',
    'london',
    'buckinghamshire',
    'hampshire',
    'oxfordshire',
    'surrey',
    'buckinghamshire',
    'bedfordshire',
    'hertfordshire',
    'northamptonshire',
    'east sussex',
    'kent',
    'west sussex',
    'hampshire',
    'isle of wight'
  ];
  List<String> get within30milesSouthEastEngland =>
      _within30milesSouthEastEngland;
  set within30milesSouthEastEngland(List<String> value) {
    _within30milesSouthEastEngland = value;
  }

  void addToWithin30milesSouthEastEngland(String value) {
    within30milesSouthEastEngland.add(value);
  }

  void removeFromWithin30milesSouthEastEngland(String value) {
    within30milesSouthEastEngland.remove(value);
  }

  void removeAtIndexFromWithin30milesSouthEastEngland(int index) {
    within30milesSouthEastEngland.removeAt(index);
  }

  void updateWithin30milesSouthEastEnglandAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    within30milesSouthEastEngland[index] =
        updateFn(_within30milesSouthEastEngland[index]);
  }

  void insertAtIndexInWithin30milesSouthEastEngland(int index, String value) {
    within30milesSouthEastEngland.insert(index, value);
  }

  List<String> _within30milesSouthWestEngland = [
    'bristol',
    'gloucestershire',
    'somerset',
    'wiltshire',
    'cornwall',
    'devon',
    'somerset',
    'gloucestershire',
    'herefordshire',
    'worcestershire'
  ];
  List<String> get within30milesSouthWestEngland =>
      _within30milesSouthWestEngland;
  set within30milesSouthWestEngland(List<String> value) {
    _within30milesSouthWestEngland = value;
  }

  void addToWithin30milesSouthWestEngland(String value) {
    within30milesSouthWestEngland.add(value);
  }

  void removeFromWithin30milesSouthWestEngland(String value) {
    within30milesSouthWestEngland.remove(value);
  }

  void removeAtIndexFromWithin30milesSouthWestEngland(int index) {
    within30milesSouthWestEngland.removeAt(index);
  }

  void updateWithin30milesSouthWestEnglandAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    within30milesSouthWestEngland[index] =
        updateFn(_within30milesSouthWestEngland[index]);
  }

  void insertAtIndexInWithin30milesSouthWestEngland(int index, String value) {
    within30milesSouthWestEngland.insert(index, value);
  }

  List<String> _within30milesEastofEngland = [
    'bedfordshire',
    'buckinghamshire',
    'cambridgeshire',
    'hertfordshire',
    'northamptonshire',
    'rutland',
    'essex',
    'london',
    'kent',
    'suffolk',
    'buckinghamshire'
  ];
  List<String> get within30milesEastofEngland => _within30milesEastofEngland;
  set within30milesEastofEngland(List<String> value) {
    _within30milesEastofEngland = value;
  }

  void addToWithin30milesEastofEngland(String value) {
    within30milesEastofEngland.add(value);
  }

  void removeFromWithin30milesEastofEngland(String value) {
    within30milesEastofEngland.remove(value);
  }

  void removeAtIndexFromWithin30milesEastofEngland(int index) {
    within30milesEastofEngland.removeAt(index);
  }

  void updateWithin30milesEastofEnglandAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    within30milesEastofEngland[index] =
        updateFn(_within30milesEastofEngland[index]);
  }

  void insertAtIndexInWithin30milesEastofEngland(int index, String value) {
    within30milesEastofEngland.insert(index, value);
  }

  List<String> _within30milesWestMidlands = [
    'herefordshire',
    'gloucestershire',
    'worcestershire',
    'shropshire',
    'staffordshire',
    'cheshire',
    'birmingham',
    'derbyshire',
    'warwickshire',
    'leicestershire',
    'northamptonshire'
  ];
  List<String> get within30milesWestMidlands => _within30milesWestMidlands;
  set within30milesWestMidlands(List<String> value) {
    _within30milesWestMidlands = value;
  }

  void addToWithin30milesWestMidlands(String value) {
    within30milesWestMidlands.add(value);
  }

  void removeFromWithin30milesWestMidlands(String value) {
    within30milesWestMidlands.remove(value);
  }

  void removeAtIndexFromWithin30milesWestMidlands(int index) {
    within30milesWestMidlands.removeAt(index);
  }

  void updateWithin30milesWestMidlandsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    within30milesWestMidlands[index] =
        updateFn(_within30milesWestMidlands[index]);
  }

  void insertAtIndexInWithin30milesWestMidlands(int index, String value) {
    within30milesWestMidlands.insert(index, value);
  }

  List<String> _within30milesEastMidlands = [
    'derbyshire',
    'staffordshire',
    'birmingham',
    'leicestershire',
    'nottinghamshire',
    'rutland',
    'south yorkshire',
    'warwickshire',
    'northamptonshire',
    'lincolnshire',
    'buckinghamshire',
    'oxfordshire',
    'bedfordshire'
  ];
  List<String> get within30milesEastMidlands => _within30milesEastMidlands;
  set within30milesEastMidlands(List<String> value) {
    _within30milesEastMidlands = value;
  }

  void addToWithin30milesEastMidlands(String value) {
    within30milesEastMidlands.add(value);
  }

  void removeFromWithin30milesEastMidlands(String value) {
    within30milesEastMidlands.remove(value);
  }

  void removeAtIndexFromWithin30milesEastMidlands(int index) {
    within30milesEastMidlands.removeAt(index);
  }

  void updateWithin30milesEastMidlandsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    within30milesEastMidlands[index] =
        updateFn(_within30milesEastMidlands[index]);
  }

  void insertAtIndexInWithin30milesEastMidlands(int index, String value) {
    within30milesEastMidlands.insert(index, value);
  }

  List<String> _within30milesNorthWestEngland = [
    'cheshire',
    'shropshire',
    'greater manchester',
    'merseyside',
    'cumbria',
    'lancashire',
    'south yorkshire',
    'west yorkshire'
  ];
  List<String> get within30milesNorthWestEngland =>
      _within30milesNorthWestEngland;
  set within30milesNorthWestEngland(List<String> value) {
    _within30milesNorthWestEngland = value;
  }

  void addToWithin30milesNorthWestEngland(String value) {
    within30milesNorthWestEngland.add(value);
  }

  void removeFromWithin30milesNorthWestEngland(String value) {
    within30milesNorthWestEngland.remove(value);
  }

  void removeAtIndexFromWithin30milesNorthWestEngland(int index) {
    within30milesNorthWestEngland.removeAt(index);
  }

  void updateWithin30milesNorthWestEnglandAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    within30milesNorthWestEngland[index] =
        updateFn(_within30milesNorthWestEngland[index]);
  }

  void insertAtIndexInWithin30milesNorthWestEngland(int index, String value) {
    within30milesNorthWestEngland.insert(index, value);
  }

  List<String> _within30milesYorkshireandtheHumber = [
    'east riding of yorkshire',
    'north yorkshire',
    'west yorkshire',
    'county durham',
    'south yorkshire',
    'derbyshire',
    'nottinghamshire',
    'greater manchester'
  ];
  List<String> get within30milesYorkshireandtheHumber =>
      _within30milesYorkshireandtheHumber;
  set within30milesYorkshireandtheHumber(List<String> value) {
    _within30milesYorkshireandtheHumber = value;
  }

  void addToWithin30milesYorkshireandtheHumber(String value) {
    within30milesYorkshireandtheHumber.add(value);
  }

  void removeFromWithin30milesYorkshireandtheHumber(String value) {
    within30milesYorkshireandtheHumber.remove(value);
  }

  void removeAtIndexFromWithin30milesYorkshireandtheHumber(int index) {
    within30milesYorkshireandtheHumber.removeAt(index);
  }

  void updateWithin30milesYorkshireandtheHumberAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    within30milesYorkshireandtheHumber[index] =
        updateFn(_within30milesYorkshireandtheHumber[index]);
  }

  void insertAtIndexInWithin30milesYorkshireandtheHumber(
      int index, String value) {
    within30milesYorkshireandtheHumber.insert(index, value);
  }

  List<String> _within30milesNorthEastEngland = [
    'county Durham',
    'north yorkshire',
    'northumberland',
    'tyne and wear'
  ];
  List<String> get within30milesNorthEastEngland =>
      _within30milesNorthEastEngland;
  set within30milesNorthEastEngland(List<String> value) {
    _within30milesNorthEastEngland = value;
  }

  void addToWithin30milesNorthEastEngland(String value) {
    within30milesNorthEastEngland.add(value);
  }

  void removeFromWithin30milesNorthEastEngland(String value) {
    within30milesNorthEastEngland.remove(value);
  }

  void removeAtIndexFromWithin30milesNorthEastEngland(int index) {
    within30milesNorthEastEngland.removeAt(index);
  }

  void updateWithin30milesNorthEastEnglandAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    within30milesNorthEastEngland[index] =
        updateFn(_within30milesNorthEastEngland[index]);
  }

  void insertAtIndexInWithin30milesNorthEastEngland(int index, String value) {
    within30milesNorthEastEngland.insert(index, value);
  }

  bool _chatseen = false;
  bool get chatseen => _chatseen;
  set chatseen(bool value) {
    _chatseen = value;
  }

  DocumentReference? _currentChat;
  DocumentReference? get currentChat => _currentChat;
  set currentChat(DocumentReference? value) {
    _currentChat = value;
  }

  bool _isScreenActive = false;
  bool get isScreenActive => _isScreenActive;
  set isScreenActive(bool value) {
    _isScreenActive = value;
  }
}

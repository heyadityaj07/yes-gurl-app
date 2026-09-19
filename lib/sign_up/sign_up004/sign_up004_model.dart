import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'sign_up004_widget.dart' show SignUp004Widget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUp004Model extends FlutterFlowModel<SignUp004Widget> {
  ///  Local state fields for this page.

  List<String> londonlist = ['London'];
  void addToLondonlist(String item) => londonlist.add(item);
  void removeFromLondonlist(String item) => londonlist.remove(item);
  void removeAtIndexFromLondonlist(int index) => londonlist.removeAt(index);
  void insertAtIndexInLondonlist(int index, String item) =>
      londonlist.insert(index, item);
  void updateLondonlistAtIndex(int index, Function(String) updateFn) =>
      londonlist[index] = updateFn(londonlist[index]);

  List<String> southeastengland = [
    'Berkshire',
    'Buckinghamshire',
    'East Sussex',
    'Hampshire',
    'Isle of Wight',
    'Kent',
    'Oxfordshire',
    'Surrey',
    'West Sussex'
  ];
  void addToSoutheastengland(String item) => southeastengland.add(item);
  void removeFromSoutheastengland(String item) => southeastengland.remove(item);
  void removeAtIndexFromSoutheastengland(int index) =>
      southeastengland.removeAt(index);
  void insertAtIndexInSoutheastengland(int index, String item) =>
      southeastengland.insert(index, item);
  void updateSoutheastenglandAtIndex(int index, Function(String) updateFn) =>
      southeastengland[index] = updateFn(southeastengland[index]);

  List<String> southwestengland = [
    'Bristol',
    'Cornwall',
    'Devon',
    'Dorset',
    'Gloucestershire',
    'Somerset',
    'Wiltshire'
  ];
  void addToSouthwestengland(String item) => southwestengland.add(item);
  void removeFromSouthwestengland(String item) => southwestengland.remove(item);
  void removeAtIndexFromSouthwestengland(int index) =>
      southwestengland.removeAt(index);
  void insertAtIndexInSouthwestengland(int index, String item) =>
      southwestengland.insert(index, item);
  void updateSouthwestenglandAtIndex(int index, Function(String) updateFn) =>
      southwestengland[index] = updateFn(southwestengland[index]);

  List<String> eastofengland = [
    'Bedfordshire',
    'Cambridgeshire',
    'Essex',
    'Hertfordshire',
    'Norfolk',
    'Suffolk'
  ];
  void addToEastofengland(String item) => eastofengland.add(item);
  void removeFromEastofengland(String item) => eastofengland.remove(item);
  void removeAtIndexFromEastofengland(int index) =>
      eastofengland.removeAt(index);
  void insertAtIndexInEastofengland(int index, String item) =>
      eastofengland.insert(index, item);
  void updateEastofenglandAtIndex(int index, Function(String) updateFn) =>
      eastofengland[index] = updateFn(eastofengland[index]);

  List<String> westmidlands = ['Herefordshire', 'Shropshire'];
  void addToWestmidlands(String item) => westmidlands.add(item);
  void removeFromWestmidlands(String item) => westmidlands.remove(item);
  void removeAtIndexFromWestmidlands(int index) => westmidlands.removeAt(index);
  void insertAtIndexInWestmidlands(int index, String item) =>
      westmidlands.insert(index, item);
  void updateWestmidlandsAtIndex(int index, Function(String) updateFn) =>
      westmidlands[index] = updateFn(westmidlands[index]);

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for selectCountry widget.
  String? selectCountryValue;
  FormFieldController<String>? selectCountryValueController;
  // State field(s) for regioncountry widget.
  String? regioncountryValue;
  FormFieldController<String>? regioncountryValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}

import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserRecord extends FirestoreRecord {
  UserRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "time_created" field.
  DateTime? _timeCreated;
  DateTime? get timeCreated => _timeCreated;
  bool hasTimeCreated() => _timeCreated != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "age" field.
  int? _age;
  int get age => _age ?? 0;
  bool hasAge() => _age != null;

  // "date_of_birth" field.
  DateTime? _dateOfBirth;
  DateTime? get dateOfBirth => _dateOfBirth;
  bool hasDateOfBirth() => _dateOfBirth != null;

  // "location" field.
  LatLng? _location;
  LatLng? get location => _location;
  bool hasLocation() => _location != null;

  // "display_image" field.
  String? _displayImage;
  String get displayImage => _displayImage ?? '';
  bool hasDisplayImage() => _displayImage != null;

  // "privacy_policy" field.
  bool? _privacyPolicy;
  bool get privacyPolicy => _privacyPolicy ?? false;
  bool hasPrivacyPolicy() => _privacyPolicy != null;

  // "personality_type" field.
  String? _personalityType;
  String get personalityType => _personalityType ?? '';
  bool hasPersonalityType() => _personalityType != null;

  // "relationship_status" field.
  String? _relationshipStatus;
  String get relationshipStatus => _relationshipStatus ?? '';
  bool hasRelationshipStatus() => _relationshipStatus != null;

  // "meet_offline" field.
  List<String>? _meetOffline;
  List<String> get meetOffline => _meetOffline ?? const [];
  bool hasMeetOffline() => _meetOffline != null;

  // "more_about" field.
  List<String>? _moreAbout;
  List<String> get moreAbout => _moreAbout ?? const [];
  bool hasMoreAbout() => _moreAbout != null;

  // "recommended_personality" field.
  List<String>? _recommendedPersonality;
  List<String> get recommendedPersonality =>
      _recommendedPersonality ?? const [];
  bool hasRecommendedPersonality() => _recommendedPersonality != null;

  // "potential_personality" field.
  List<String>? _potentialPersonality;
  List<String> get potentialPersonality => _potentialPersonality ?? const [];
  bool hasPotentialPersonality() => _potentialPersonality != null;

  // "challenging_personality" field.
  List<String>? _challengingPersonality;
  List<String> get challengingPersonality =>
      _challengingPersonality ?? const [];
  bool hasChallengingPersonality() => _challengingPersonality != null;

  // "matches" field.
  List<String>? _matches;
  List<String> get matches => _matches ?? const [];
  bool hasMatches() => _matches != null;

  // "rejects" field.
  List<String>? _rejects;
  List<String> get rejects => _rejects ?? const [];
  bool hasRejects() => _rejects != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "second_name" field.
  String? _secondName;
  String get secondName => _secondName ?? '';
  bool hasSecondName() => _secondName != null;

  // "woman" field.
  bool? _woman;
  bool get woman => _woman ?? false;
  bool hasWoman() => _woman != null;

  // "chldren" field.
  String? _chldren;
  String get chldren => _chldren ?? '';
  bool hasChldren() => _chldren != null;

  // "personality_pref" field.
  String? _personalityPref;
  String get personalityPref => _personalityPref ?? '';
  bool hasPersonalityPref() => _personalityPref != null;

  // "desired_personality" field.
  String? _desiredPersonality;
  String get desiredPersonality => _desiredPersonality ?? '';
  bool hasDesiredPersonality() => _desiredPersonality != null;

  // "children_pref" field.
  String? _childrenPref;
  String get childrenPref => _childrenPref ?? '';
  bool hasChildrenPref() => _childrenPref != null;

  // "desired_children" field.
  String? _desiredChildren;
  String get desiredChildren => _desiredChildren ?? '';
  bool hasDesiredChildren() => _desiredChildren != null;

  // "prompt1question" field.
  String? _prompt1question;
  String get prompt1question => _prompt1question ?? '';
  bool hasPrompt1question() => _prompt1question != null;

  // "prompt1answer" field.
  String? _prompt1answer;
  String get prompt1answer => _prompt1answer ?? '';
  bool hasPrompt1answer() => _prompt1answer != null;

  // "prompt2question" field.
  String? _prompt2question;
  String get prompt2question => _prompt2question ?? '';
  bool hasPrompt2question() => _prompt2question != null;

  // "prompt2nswer" field.
  String? _prompt2nswer;
  String get prompt2nswer => _prompt2nswer ?? '';
  bool hasPrompt2nswer() => _prompt2nswer != null;

  // "prompt3question" field.
  String? _prompt3question;
  String get prompt3question => _prompt3question ?? '';
  bool hasPrompt3question() => _prompt3question != null;

  // "prompt3answer" field.
  String? _prompt3answer;
  String get prompt3answer => _prompt3answer ?? '';
  bool hasPrompt3answer() => _prompt3answer != null;

  // "interest1" field.
  String? _interest1;
  String get interest1 => _interest1 ?? '';
  bool hasInterest1() => _interest1 != null;

  // "interest2" field.
  String? _interest2;
  String get interest2 => _interest2 ?? '';
  bool hasInterest2() => _interest2 != null;

  // "interest3" field.
  String? _interest3;
  String get interest3 => _interest3 ?? '';
  bool hasInterest3() => _interest3 != null;

  // "interest4" field.
  String? _interest4;
  String get interest4 => _interest4 ?? '';
  bool hasInterest4() => _interest4 != null;

  // "messageSent" field.
  List<DocumentReference>? _messageSent;
  List<DocumentReference> get messageSent => _messageSent ?? const [];
  bool hasMessageSent() => _messageSent != null;

  // "chatRequestUser" field.
  List<DocumentReference>? _chatRequestUser;
  List<DocumentReference> get chatRequestUser => _chatRequestUser ?? const [];
  bool hasChatRequestUser() => _chatRequestUser != null;

  // "isDeactivated" field.
  bool? _isDeactivated;
  bool get isDeactivated => _isDeactivated ?? false;
  bool hasIsDeactivated() => _isDeactivated != null;

  // "blocked_users" field.
  List<DocumentReference>? _blockedUsers;
  List<DocumentReference> get blockedUsers => _blockedUsers ?? const [];
  bool hasBlockedUsers() => _blockedUsers != null;

  // "city" field.
  String? _city;
  String get city => _city ?? '';
  bool hasCity() => _city != null;

  // "bio" field.
  String? _bio;
  String get bio => _bio ?? '';
  bool hasBio() => _bio != null;

  // "hideProfile" field.
  bool? _hideProfile;
  bool get hideProfile => _hideProfile ?? false;
  bool hasHideProfile() => _hideProfile != null;

  // "nickname" field.
  String? _nickname;
  String get nickname => _nickname ?? '';
  bool hasNickname() => _nickname != null;

  // "isPromptPass" field.
  bool? _isPromptPass;
  bool get isPromptPass => _isPromptPass ?? false;
  bool hasIsPromptPass() => _isPromptPass != null;

  // "isInterestPass" field.
  bool? _isInterestPass;
  bool get isInterestPass => _isInterestPass ?? false;
  bool hasIsInterestPass() => _isInterestPass != null;

  // "Signup001Done" field.
  bool? _signup001Done;
  bool get signup001Done => _signup001Done ?? false;
  bool hasSignup001Done() => _signup001Done != null;

  // "ChildrenDone" field.
  bool? _childrenDone;
  bool get childrenDone => _childrenDone ?? false;
  bool hasChildrenDone() => _childrenDone != null;

  // "selectedAgeRange" field.
  List<int>? _selectedAgeRange;
  List<int> get selectedAgeRange => _selectedAgeRange ?? const [];
  bool hasSelectedAgeRange() => _selectedAgeRange != null;

  // "selectedChildren" field.
  List<String>? _selectedChildren;
  List<String> get selectedChildren => _selectedChildren ?? const [];
  bool hasSelectedChildren() => _selectedChildren != null;

  // "selectedLocation" field.
  List<String>? _selectedLocation;
  List<String> get selectedLocation => _selectedLocation ?? const [];
  bool hasSelectedLocation() => _selectedLocation != null;

  // "selectedRelationship" field.
  List<String>? _selectedRelationship;
  List<String> get selectedRelationship => _selectedRelationship ?? const [];
  bool hasSelectedRelationship() => _selectedRelationship != null;

  // "profilePrefLocationEdit" field.
  bool? _profilePrefLocationEdit;
  bool get profilePrefLocationEdit => _profilePrefLocationEdit ?? false;
  bool hasProfilePrefLocationEdit() => _profilePrefLocationEdit != null;

  // "ProfilePrefRelEdit" field.
  bool? _profilePrefRelEdit;
  bool get profilePrefRelEdit => _profilePrefRelEdit ?? false;
  bool hasProfilePrefRelEdit() => _profilePrefRelEdit != null;

  // "ProfilePrefAgeEdit" field.
  bool? _profilePrefAgeEdit;
  bool get profilePrefAgeEdit => _profilePrefAgeEdit ?? false;
  bool hasProfilePrefAgeEdit() => _profilePrefAgeEdit != null;

  // "ProfilePrefChildrenEdit" field.
  bool? _profilePrefChildrenEdit;
  bool get profilePrefChildrenEdit => _profilePrefChildrenEdit ?? false;
  bool hasProfilePrefChildrenEdit() => _profilePrefChildrenEdit != null;

  // "latest_user_list" field.
  List<DocumentReference>? _latestUserList;
  List<DocumentReference> get latestUserList => _latestUserList ?? const [];
  bool hasLatestUserList() => _latestUserList != null;

  // "updated_time" field.
  String? _updatedTime;
  String get updatedTime => _updatedTime ?? '';
  bool hasUpdatedTime() => _updatedTime != null;

  // "today_user_list" field.
  List<DocumentReference>? _todayUserList;
  List<DocumentReference> get todayUserList => _todayUserList ?? const [];
  bool hasTodayUserList() => _todayUserList != null;

  // "sub_city" field.
  String? _subCity;
  String get subCity => _subCity ?? '';
  bool hasSubCity() => _subCity != null;

  // "preferrred_location" field.
  String? _preferrredLocation;
  String get preferrredLocation => _preferrredLocation ?? '';
  bool hasPreferrredLocation() => _preferrredLocation != null;

  // "IsNotificationEnabled" field.
  bool? _isNotificationEnabled;
  bool get isNotificationEnabled => _isNotificationEnabled ?? false;
  bool hasIsNotificationEnabled() => _isNotificationEnabled != null;

  // "reporteventlist" field.
  List<DocumentReference>? _reporteventlist;
  List<DocumentReference> get reporteventlist => _reporteventlist ?? const [];
  bool hasReporteventlist() => _reporteventlist != null;

  // "comment_repor_list" field.
  List<DocumentReference>? _commentReporList;
  List<DocumentReference> get commentReporList => _commentReporList ?? const [];
  bool hasCommentReporList() => _commentReporList != null;

  // "banned" field.
  bool? _banned;
  bool get banned => _banned ?? false;
  bool hasBanned() => _banned != null;

  // "offline_user_time" field.
  DateTime? _offlineUserTime;
  DateTime? get offlineUserTime => _offlineUserTime;
  bool hasOfflineUserTime() => _offlineUserTime != null;

  // "potential_profile_read" field.
  bool? _potentialProfileRead;
  bool get potentialProfileRead => _potentialProfileRead ?? false;
  bool hasPotentialProfileRead() => _potentialProfileRead != null;

  // "disconnected_users" field.
  List<DocumentReference>? _disconnectedUsers;
  List<DocumentReference> get disconnectedUsers =>
      _disconnectedUsers ?? const [];
  bool hasDisconnectedUsers() => _disconnectedUsers != null;

  // "block_user_list" field.
  List<DocumentReference>? _blockUserList;
  List<DocumentReference> get blockUserList => _blockUserList ?? const [];
  bool hasBlockUserList() => _blockUserList != null;

  // "we_meet_user_list" field.
  List<DocumentReference>? _weMeetUserList;
  List<DocumentReference> get weMeetUserList => _weMeetUserList ?? const [];
  bool hasWeMeetUserList() => _weMeetUserList != null;

  // "last_active" field.
  DateTime? _lastActive;
  DateTime? get lastActive => _lastActive;
  bool hasLastActive() => _lastActive != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _timeCreated = snapshotData['time_created'] as DateTime?;
    _uid = snapshotData['uid'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _age = castToType<int>(snapshotData['age']);
    _dateOfBirth = snapshotData['date_of_birth'] as DateTime?;
    _location = snapshotData['location'] as LatLng?;
    _displayImage = snapshotData['display_image'] as String?;
    _privacyPolicy = snapshotData['privacy_policy'] as bool?;
    _personalityType = snapshotData['personality_type'] as String?;
    _relationshipStatus = snapshotData['relationship_status'] as String?;
    _meetOffline = getDataList(snapshotData['meet_offline']);
    _moreAbout = getDataList(snapshotData['more_about']);
    _recommendedPersonality =
        getDataList(snapshotData['recommended_personality']);
    _potentialPersonality = getDataList(snapshotData['potential_personality']);
    _challengingPersonality =
        getDataList(snapshotData['challenging_personality']);
    _matches = getDataList(snapshotData['matches']);
    _rejects = getDataList(snapshotData['rejects']);
    _photoUrl = snapshotData['photo_url'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _secondName = snapshotData['second_name'] as String?;
    _woman = snapshotData['woman'] as bool?;
    _chldren = snapshotData['chldren'] as String?;
    _personalityPref = snapshotData['personality_pref'] as String?;
    _desiredPersonality = snapshotData['desired_personality'] as String?;
    _childrenPref = snapshotData['children_pref'] as String?;
    _desiredChildren = snapshotData['desired_children'] as String?;
    _prompt1question = snapshotData['prompt1question'] as String?;
    _prompt1answer = snapshotData['prompt1answer'] as String?;
    _prompt2question = snapshotData['prompt2question'] as String?;
    _prompt2nswer = snapshotData['prompt2nswer'] as String?;
    _prompt3question = snapshotData['prompt3question'] as String?;
    _prompt3answer = snapshotData['prompt3answer'] as String?;
    _interest1 = snapshotData['interest1'] as String?;
    _interest2 = snapshotData['interest2'] as String?;
    _interest3 = snapshotData['interest3'] as String?;
    _interest4 = snapshotData['interest4'] as String?;
    _messageSent = getDataList(snapshotData['messageSent']);
    _chatRequestUser = getDataList(snapshotData['chatRequestUser']);
    _isDeactivated = snapshotData['isDeactivated'] as bool?;
    _blockedUsers = getDataList(snapshotData['blocked_users']);
    _city = snapshotData['city'] as String?;
    _bio = snapshotData['bio'] as String?;
    _hideProfile = snapshotData['hideProfile'] as bool?;
    _nickname = snapshotData['nickname'] as String?;
    _isPromptPass = snapshotData['isPromptPass'] as bool?;
    _isInterestPass = snapshotData['isInterestPass'] as bool?;
    _signup001Done = snapshotData['Signup001Done'] as bool?;
    _childrenDone = snapshotData['ChildrenDone'] as bool?;
    _selectedAgeRange = getDataList(snapshotData['selectedAgeRange']);
    _selectedChildren = getDataList(snapshotData['selectedChildren']);
    _selectedLocation = getDataList(snapshotData['selectedLocation']);
    _selectedRelationship = getDataList(snapshotData['selectedRelationship']);
    _profilePrefLocationEdit = snapshotData['profilePrefLocationEdit'] as bool?;
    _profilePrefRelEdit = snapshotData['ProfilePrefRelEdit'] as bool?;
    _profilePrefAgeEdit = snapshotData['ProfilePrefAgeEdit'] as bool?;
    _profilePrefChildrenEdit = snapshotData['ProfilePrefChildrenEdit'] as bool?;
    _latestUserList = getDataList(snapshotData['latest_user_list']);
    _updatedTime = snapshotData['updated_time'] as String?;
    _todayUserList = getDataList(snapshotData['today_user_list']);
    _subCity = snapshotData['sub_city'] as String?;
    _preferrredLocation = snapshotData['preferrred_location'] as String?;
    _isNotificationEnabled = snapshotData['IsNotificationEnabled'] as bool?;
    _reporteventlist = getDataList(snapshotData['reporteventlist']);
    _commentReporList = getDataList(snapshotData['comment_repor_list']);
    _banned = snapshotData['banned'] as bool?;
    _offlineUserTime = snapshotData['offline_user_time'] as DateTime?;
    _potentialProfileRead = snapshotData['potential_profile_read'] as bool?;
    _disconnectedUsers = getDataList(snapshotData['disconnected_users']);
    _blockUserList = getDataList(snapshotData['block_user_list']);
    _weMeetUserList = getDataList(snapshotData['we_meet_user_list']);
    _lastActive = snapshotData['last_active'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('user');

  static Stream<UserRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserRecord.fromSnapshot(s));

  static Future<UserRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UserRecord.fromSnapshot(s));

  static UserRecord fromSnapshot(DocumentSnapshot snapshot) => UserRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserRecordData({
  String? email,
  DateTime? timeCreated,
  String? uid,
  String? displayName,
  int? age,
  DateTime? dateOfBirth,
  LatLng? location,
  String? displayImage,
  bool? privacyPolicy,
  String? personalityType,
  String? relationshipStatus,
  String? photoUrl,
  DateTime? createdTime,
  String? phoneNumber,
  String? secondName,
  bool? woman,
  String? chldren,
  String? personalityPref,
  String? desiredPersonality,
  String? childrenPref,
  String? desiredChildren,
  String? prompt1question,
  String? prompt1answer,
  String? prompt2question,
  String? prompt2nswer,
  String? prompt3question,
  String? prompt3answer,
  String? interest1,
  String? interest2,
  String? interest3,
  String? interest4,
  bool? isDeactivated,
  String? city,
  String? bio,
  bool? hideProfile,
  String? nickname,
  bool? isPromptPass,
  bool? isInterestPass,
  bool? signup001Done,
  bool? childrenDone,
  bool? profilePrefLocationEdit,
  bool? profilePrefRelEdit,
  bool? profilePrefAgeEdit,
  bool? profilePrefChildrenEdit,
  String? updatedTime,
  String? subCity,
  String? preferrredLocation,
  bool? isNotificationEnabled,
  bool? banned,
  DateTime? offlineUserTime,
  bool? potentialProfileRead,
  DateTime? lastActive,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'time_created': timeCreated,
      'uid': uid,
      'display_name': displayName,
      'age': age,
      'date_of_birth': dateOfBirth,
      'location': location,
      'display_image': displayImage,
      'privacy_policy': privacyPolicy,
      'personality_type': personalityType,
      'relationship_status': relationshipStatus,
      'photo_url': photoUrl,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'second_name': secondName,
      'woman': woman,
      'chldren': chldren,
      'personality_pref': personalityPref,
      'desired_personality': desiredPersonality,
      'children_pref': childrenPref,
      'desired_children': desiredChildren,
      'prompt1question': prompt1question,
      'prompt1answer': prompt1answer,
      'prompt2question': prompt2question,
      'prompt2nswer': prompt2nswer,
      'prompt3question': prompt3question,
      'prompt3answer': prompt3answer,
      'interest1': interest1,
      'interest2': interest2,
      'interest3': interest3,
      'interest4': interest4,
      'isDeactivated': isDeactivated,
      'city': city,
      'bio': bio,
      'hideProfile': hideProfile,
      'nickname': nickname,
      'isPromptPass': isPromptPass,
      'isInterestPass': isInterestPass,
      'Signup001Done': signup001Done,
      'ChildrenDone': childrenDone,
      'profilePrefLocationEdit': profilePrefLocationEdit,
      'ProfilePrefRelEdit': profilePrefRelEdit,
      'ProfilePrefAgeEdit': profilePrefAgeEdit,
      'ProfilePrefChildrenEdit': profilePrefChildrenEdit,
      'updated_time': updatedTime,
      'sub_city': subCity,
      'preferrred_location': preferrredLocation,
      'IsNotificationEnabled': isNotificationEnabled,
      'banned': banned,
      'offline_user_time': offlineUserTime,
      'potential_profile_read': potentialProfileRead,
      'last_active': lastActive,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserRecordDocumentEquality implements Equality<UserRecord> {
  const UserRecordDocumentEquality();

  @override
  bool equals(UserRecord? e1, UserRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.timeCreated == e2?.timeCreated &&
        e1?.uid == e2?.uid &&
        e1?.displayName == e2?.displayName &&
        e1?.age == e2?.age &&
        e1?.dateOfBirth == e2?.dateOfBirth &&
        e1?.location == e2?.location &&
        e1?.displayImage == e2?.displayImage &&
        e1?.privacyPolicy == e2?.privacyPolicy &&
        e1?.personalityType == e2?.personalityType &&
        e1?.relationshipStatus == e2?.relationshipStatus &&
        listEquality.equals(e1?.meetOffline, e2?.meetOffline) &&
        listEquality.equals(e1?.moreAbout, e2?.moreAbout) &&
        listEquality.equals(
            e1?.recommendedPersonality, e2?.recommendedPersonality) &&
        listEquality.equals(
            e1?.potentialPersonality, e2?.potentialPersonality) &&
        listEquality.equals(
            e1?.challengingPersonality, e2?.challengingPersonality) &&
        listEquality.equals(e1?.matches, e2?.matches) &&
        listEquality.equals(e1?.rejects, e2?.rejects) &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.secondName == e2?.secondName &&
        e1?.woman == e2?.woman &&
        e1?.chldren == e2?.chldren &&
        e1?.personalityPref == e2?.personalityPref &&
        e1?.desiredPersonality == e2?.desiredPersonality &&
        e1?.childrenPref == e2?.childrenPref &&
        e1?.desiredChildren == e2?.desiredChildren &&
        e1?.prompt1question == e2?.prompt1question &&
        e1?.prompt1answer == e2?.prompt1answer &&
        e1?.prompt2question == e2?.prompt2question &&
        e1?.prompt2nswer == e2?.prompt2nswer &&
        e1?.prompt3question == e2?.prompt3question &&
        e1?.prompt3answer == e2?.prompt3answer &&
        e1?.interest1 == e2?.interest1 &&
        e1?.interest2 == e2?.interest2 &&
        e1?.interest3 == e2?.interest3 &&
        e1?.interest4 == e2?.interest4 &&
        listEquality.equals(e1?.messageSent, e2?.messageSent) &&
        listEquality.equals(e1?.chatRequestUser, e2?.chatRequestUser) &&
        e1?.isDeactivated == e2?.isDeactivated &&
        listEquality.equals(e1?.blockedUsers, e2?.blockedUsers) &&
        e1?.city == e2?.city &&
        e1?.bio == e2?.bio &&
        e1?.hideProfile == e2?.hideProfile &&
        e1?.nickname == e2?.nickname &&
        e1?.isPromptPass == e2?.isPromptPass &&
        e1?.isInterestPass == e2?.isInterestPass &&
        e1?.signup001Done == e2?.signup001Done &&
        e1?.childrenDone == e2?.childrenDone &&
        listEquality.equals(e1?.selectedAgeRange, e2?.selectedAgeRange) &&
        listEquality.equals(e1?.selectedChildren, e2?.selectedChildren) &&
        listEquality.equals(e1?.selectedLocation, e2?.selectedLocation) &&
        listEquality.equals(
            e1?.selectedRelationship, e2?.selectedRelationship) &&
        e1?.profilePrefLocationEdit == e2?.profilePrefLocationEdit &&
        e1?.profilePrefRelEdit == e2?.profilePrefRelEdit &&
        e1?.profilePrefAgeEdit == e2?.profilePrefAgeEdit &&
        e1?.profilePrefChildrenEdit == e2?.profilePrefChildrenEdit &&
        listEquality.equals(e1?.latestUserList, e2?.latestUserList) &&
        e1?.updatedTime == e2?.updatedTime &&
        listEquality.equals(e1?.todayUserList, e2?.todayUserList) &&
        e1?.subCity == e2?.subCity &&
        e1?.preferrredLocation == e2?.preferrredLocation &&
        e1?.isNotificationEnabled == e2?.isNotificationEnabled &&
        listEquality.equals(e1?.reporteventlist, e2?.reporteventlist) &&
        listEquality.equals(e1?.commentReporList, e2?.commentReporList) &&
        e1?.banned == e2?.banned &&
        e1?.offlineUserTime == e2?.offlineUserTime &&
        e1?.potentialProfileRead == e2?.potentialProfileRead &&
        listEquality.equals(e1?.disconnectedUsers, e2?.disconnectedUsers) &&
        listEquality.equals(e1?.blockUserList, e2?.blockUserList) &&
        listEquality.equals(e1?.weMeetUserList, e2?.weMeetUserList) &&
        e1?.lastActive == e2?.lastActive;
  }

  @override
  int hash(UserRecord? e) => const ListEquality().hash([
        e?.email,
        e?.timeCreated,
        e?.uid,
        e?.displayName,
        e?.age,
        e?.dateOfBirth,
        e?.location,
        e?.displayImage,
        e?.privacyPolicy,
        e?.personalityType,
        e?.relationshipStatus,
        e?.meetOffline,
        e?.moreAbout,
        e?.recommendedPersonality,
        e?.potentialPersonality,
        e?.challengingPersonality,
        e?.matches,
        e?.rejects,
        e?.photoUrl,
        e?.createdTime,
        e?.phoneNumber,
        e?.secondName,
        e?.woman,
        e?.chldren,
        e?.personalityPref,
        e?.desiredPersonality,
        e?.childrenPref,
        e?.desiredChildren,
        e?.prompt1question,
        e?.prompt1answer,
        e?.prompt2question,
        e?.prompt2nswer,
        e?.prompt3question,
        e?.prompt3answer,
        e?.interest1,
        e?.interest2,
        e?.interest3,
        e?.interest4,
        e?.messageSent,
        e?.chatRequestUser,
        e?.isDeactivated,
        e?.blockedUsers,
        e?.city,
        e?.bio,
        e?.hideProfile,
        e?.nickname,
        e?.isPromptPass,
        e?.isInterestPass,
        e?.signup001Done,
        e?.childrenDone,
        e?.selectedAgeRange,
        e?.selectedChildren,
        e?.selectedLocation,
        e?.selectedRelationship,
        e?.profilePrefLocationEdit,
        e?.profilePrefRelEdit,
        e?.profilePrefAgeEdit,
        e?.profilePrefChildrenEdit,
        e?.latestUserList,
        e?.updatedTime,
        e?.todayUserList,
        e?.subCity,
        e?.preferrredLocation,
        e?.isNotificationEnabled,
        e?.reporteventlist,
        e?.commentReporList,
        e?.banned,
        e?.offlineUserTime,
        e?.potentialProfileRead,
        e?.disconnectedUsers,
        e?.blockUserList,
        e?.weMeetUserList,
        e?.lastActive
      ]);

  @override
  bool isValidKey(Object? o) => o is UserRecord;
}

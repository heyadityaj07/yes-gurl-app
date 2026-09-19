import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

bool? ageCheck(DateTime dob) {
  DateTime todayDate = DateTime.now();
  int age = todayDate.year - dob.year;
  if (age >= 18) {
    return true;
  } else {
    return false;
  }
}

String? getSummaryasFriend(String type) {
  if (type.toLowerCase() == "intj") {
    return "INTJS see the world around them as one big complex puzzle they can solve. They tend to be ambitious and enjoy strategising using logic. They think big and strive towards their goals, but prefer to keep their visionary plans to thenmselves.";
  } else if (type.toLowerCase() == "intp") {
    return "INTPs are highly reflective and analytical. They’ll analyse everything and are often found deep in thought, solving countless problems and puzzles. They’ll mull over past events and over-analyse people’s actions and behaviours. This constant thinking can sometimes turn negative, leaving an INTP dissatisfied with their actions or life.";
  } else if (type.toLowerCase() == "entj") {
    return "ENTJs are leaders by nature. Confident and charismatic, they can rally a group to work towards a single shared goal. But their dogged determination can marginalise more timid and sensitive types. ENTJs are likely to assert their presence in anything they set their mind, heart, and soul to.";
  } else if (type.toLowerCase() == "entp") {
    return "ENTPs are natural visionaries and debaters. They like to draw on a broad base of knowledge to prove a point and will happily play the devil’s advocate in any discussion. While likely to clash with more conflict-averse personality types, their charisma and conversational nature work well in business environments.";
  } else if (type.toLowerCase() == "infj") {
    return "An INFJ is idealistic. Seeing the positives in the world and other people, they believe they can create a happier, more harmonious environment. Their tendency for altruism means they care deeply for other people’s feelings. An INFJ has a strong moral code. Personal integrity is important to them.";
  } else if (type.toLowerCase() == "infp") {
    return "INFPs are often quiet, introspective souls. Their beautiful sensitivity, empathetic and introspective nature, lend themselves perfectly to artistic pursuits. They make fantastic writers, poets and artists and can create highly emotional and touching art. It’s key for them to follow their heart and pursue meaningful goals.";
  } else if (type.toLowerCase() == "enfj") {
    return "ENFJS are full of idealism, aiming to make a difference in the world and in the lives of people close to them. They are natural-born leaders and love doing good, using their charisma and passion to motivate others.";
  } else if (type.toLowerCase() == "enfp") {
    return "ENFPs are warm, passionate, and people-focused individuals. Helping others express and explore their creativity is their thing. They tend to enjoy content creation and idea generation, but may struggle with finishing what they start. Art’s ability to express and create is appealing to the ENFP personality type.";
  } else if (type.toLowerCase() == "istj") {
    return "ISTJs can come across as serious people. They are sometimes referred to as logisticians with no-frills aesthetics and a no-nonsense approach to life. They’re respectful and good at remembering small details. ISTJs would rather follow rules than make them and appreciate structure in their lives.";
  } else if (type.toLowerCase() == "isfj") {
    return "ISFJs are natural helpers who assist others wherever they can. They tend to be humble, practical and compassionate. They are valued by family and friends for taking on others’ issues as if they were their own. An ISFJ’s quiet passion will burn bright for those they are close to.";
  } else if (type.toLowerCase() == "estj") {
    return "ESTJs are traditional and orderly. Organising, managing and regulating are their specialities. They tend to have clear rules on how best to navigate oneself through the world in a systematic, methodical way. ESTJs are good at taking charge and tend to embrace traditional values of honesty, industry, and conscientious dignity.";
  } else if (type.toLowerCase() == "esfj") {
    return "ESFJs are highly attuned to the needs of others. They navigate emotions well and can quickly tell how others are feeling. ESFJs are dutiful and loyal, readily giving time to their friends and family when needed, but often take on others’ problems, sometimes burdening themselves with the responsibility.";
  } else if (type.toLowerCase() == "istp") {
    return "ISTPs are inquisitive, curious learners and adventurers. Discoveries and inventions hold their attention, and they are driven to find ways to improve the way things work. They typically love to unearth life’s mysteries and forever seek new adventures and answers. Their industriousness and confidence make them great achievers.";
  } else if (type.toLowerCase() == "isfp") {
    return "ISFPs are peaceful, caring and open individuals. Happy to love by their own set of rules, they carve their path in the world. An ISFP’s hidden creativity will take many people by surprise. They are modest in their quiet achievements and will harness their imaginative creativity as an outlet for expression.";
  } else if (type.toLowerCase() == "estp") {
    return "An ESTP is the soul of the party and loves to be the centre of attention. They relish an action-packed life full of adventure and obstacles and enjoy living in the moment. People often gravitate towards ESTPs because of their charisma and strong social skills.";
  } else if (type.toLowerCase() == "esfp") {
    return "ESFPs are extroverted and observant, making them great entertainers. They tend to be talkative, spontaneous and always up for a good activity. ESFPs are often the centre of attention as they employ humour and a playful attitude while speaking to others. This helps them get on with most other personality types.";
  }
}

int? convertedAge() {
  DateTime dob = DateTime(1995, 10, 10);
  DateTime todayDate = DateTime.now();
  int age = todayDate.year - dob.year;
  if (todayDate.month < dob.month ||
      (todayDate.month == dob.month && todayDate.day < dob.day)) {
    age--;
  }
  return age;
}

int? additionCopy(
  List<NotificationRecord> notificationdocument,
  List<NotificationRecord>? adminnotification,
  DocumentReference? currentuserreference,
) {
  int value = 0;

  // Count all user notifications
  value += notificationdocument.length;

  // Count admin notifications seen by this user
  for (NotificationRecord element in adminnotification ?? []) {
    if (!element.seenList.contains(currentuserreference)) {
      value += 1;
    }
  }

  return value;
  // if (num1 == null || num2 == null) return null; // Check for null values
  // return num1 + num2;
}

List<DocumentReference> createChatUserList(
  DocumentReference userRef1,
  DocumentReference userRef2,
) {
  return [userRef1, userRef2];
}

List<String> combineLists(
  List<String>? matches,
  List<String>? rejects,
) {
  // combine matches and rejects lists
  List<String> combinedList = [];
  if (matches != null) {
    combinedList.addAll(matches);
  }
  if (rejects != null) {
    combinedList.addAll(rejects);
  }
  return combinedList;
}

int calculateAge(DateTime birthDate) {
  int age = 0;

  final currentDate = DateTime.now();
  age = currentDate.year - birthDate.year;
  if (currentDate.month < birthDate.month ||
      (currentDate.month == birthDate.month &&
          currentDate.day < birthDate.day)) {
    age--;
  }
  return age;
}

List<ChatMessageModelStruct>? groupByDateTime(
    List<ChatMessageRecord>? chatRecord) {
  String dateTimeFormat(String format, DateTime? dateTime, {String? locale}) {
    if (dateTime == null) {
      return '';
    }
    if (format == 'relative') {
      return timeago.format(dateTime, locale: locale, allowFromNow: true);
    }
    return DateFormat(format, locale).format(dateTime);
  }

  var list = chatRecord
      ?.fold({}, (previousValue, element) {
        Map val = previousValue;
        String date = dateTimeFormat('yyyy-MM-dd', element.textTime!);
        if (!val.containsKey(date)) {
          val[date] = [];
        }

        val[date]?.add(element);
        return val;
      })
      .entries
      .map((e) => {e.key: e.value})
      .toList();
  List<ChatMessageModelStruct> messageList = [];
  for (var element in list ?? []) {
    var message = ChatMessageModelStruct(
        dateTime: DateTime.parse(element.entries.toList()[0].key.toString()),
        messageList: []);
    var messageSortList = element.entries.toList()[0].value.toList();
    messageSortList.sort((a, b) => DateTime.parse(a.textTime.toString())
        .compareTo(DateTime.parse(b.textTime.toString())));
    for (var element1 in messageSortList) {
      message.messageList.add(MessageModelStruct(
          chatRef: element1.chatRef,
          chatText: element1.chatText,
          textTime: element1.textTime,
          userRef: element1.userRef,
          eventImage: element1.eventImage,
          eventreference: element1.eventReference != null
              ? element1.eventReference
              : null));
    }

    messageList.add(message);
  }
  return messageList.reversed.toList();
}

String? formatTimestamp(DateTime timestamp) {
  final now = DateTime.now();
  final difference = now.difference(timestamp);

  if (difference.inDays < 1) {
    return 'Today';
  } else if (difference.inDays == 1) {
    return 'yesterday';
  } else {
    return DateFormat('yMMMd').format(timestamp);
  }
}

bool? timeComparison(
  DateTime time1,
  DateTime timeb,
) {
  // time a is 9:00 pm and time b is 10:00 pm, if time b is less than time a return false; if time b is greater than time a return trun
  if (timeb.isBefore(time1)) {
    return false;
  } else {
    return true;
  }
}

DateTime nextDay(DateTime currentDay) {
  // return a day ahead from the current date, and the return value time should be 00:00Am
  return DateTime(currentDay.year, currentDay.month, currentDay.day + 1, 0, 0);
}

bool searchUser(
  String searchQuery,
  String userName,
) {
  return userName.toLowerCase().startsWith(searchQuery.toLowerCase());
}

bool? checkDate(
  List<SelectUserResponseStruct>? listofmodel,
  DocumentReference? userdocumentreference,
) {
  if (listofmodel?.isNotEmpty ?? false) {
    return listofmodel
        ?.firstWhere(
          (elemment) => elemment.userReference?.id == userdocumentreference?.id,
          orElse: () => SelectUserResponseStruct(
              responseCreatedTime: DateTime.now().add(Duration(days: 1))),
        )
        .responseCreatedTime
        ?.isBefore(DateTime.now());
  } else {
    return false;
  }
}

DateTime addDate() {
  return DateTime.now().add(Duration(days: 7));
}

bool checkcountfunction(
  int chatcount,
  int messagecount,
) {
  int value = chatcount - messagecount;

  if (value == 12) {
    return true;
  } else {
    return false;
  }
}

int getLengthByIndex(int number) {
  return number - 1;
}

double? getProgressValue(
  int length,
  int index,
) {
  return index / length;
}

String? getSummary(String type) {
  if (type.toLowerCase() == "intj") {
    return "INTJS see the world around them as one big complex puzzle they can solve. They tend to be ambitious and enjoy strategising using logic. They think big and strive towards their goals, but prefer to keep their visionary plans to thenmselves.";
  } else if (type.toLowerCase() == "intp") {
    return "INTPs are highly reflective and analytical. They’ll analyse everything and are often found deep in thought, solving countless problems and puzzles. They’ll mull over past events and over-analyse people’s actions and behaviours. This constant thinking can sometimes turn negative, leaving an INTP dissatisfied with their actions or life.";
  } else if (type.toLowerCase() == "entj") {
    return "ENTJs are leaders by nature. Confident and charismatic, they can rally a group to work towards a single shared goal. But their dogged determination can marginalise more timid and sensitive types. ENTJs are likely to assert their presence in anything they set their mind, heart, and soul to.";
  } else if (type.toLowerCase() == "entp") {
    return "ENTPs are natural visionaries and debaters. They like to draw on a broad base of knowledge to prove a point and will happily play the devil’s advocate in any discussion. While likely to clash with more conflict-averse personality types, their charisma and conversational nature work well in business environments.";
  } else if (type.toLowerCase() == "infj") {
    return "An INFJ is idealistic. Seeing the positives in the world and other people, they believe they can create a happier, more harmonious environment. Their tendency for altruism means they care deeply for other people’s feelings. An INFJ has a strong moral code. Personal integrity is important to them.";
  } else if (type.toLowerCase() == "infp") {
    return "INFPs are often quiet, introspective souls. Their beautiful sensitivity, empathetic and introspective nature, lend themselves perfectly to artistic pursuits. They make fantastic writers, poets and artists and can create highly emotional and touching art. It’s key for them to follow their heart and pursue meaningful goals.";
  } else if (type.toLowerCase() == "enfj") {
    return "ENFJS are full of idealism, aiming to make a difference in the world and in the lives of people close to them. They are natural-born leaders and love doing good, using their charisma and passion to motivate others.";
  } else if (type.toLowerCase() == "enfp") {
    return "ENFPs are warm, passionate, and people-focused individuals. Helping others express and explore their creativity is their thing. They tend to enjoy content creation and idea generation, but may struggle with finishing what they start. Art’s ability to express and create is appealing to the ENFP personality type.";
  } else if (type.toLowerCase() == "istj") {
    return "ISTJs can come across as serious people. They are sometimes referred to as logisticians with no-frills aesthetics and a no-nonsense approach to life. They’re respectful and good at remembering small details. ISTJs would rather follow rules than make them and appreciate structure in their lives.";
  } else if (type.toLowerCase() == "isfj") {
    return "ISFJs are natural helpers who assist others wherever they can. They tend to be humble, practical and compassionate. They are valued by family and friends for taking on others’ issues as if they were their own. An ISFJ’s quiet passion will burn bright for those they are close to.";
  } else if (type.toLowerCase() == "estj") {
    return "ESTJs are traditional and orderly. Organising, managing and regulating are their specialities. They tend to have clear rules on how best to navigate oneself through the world in a systematic, methodical way. ESTJs are good at taking charge and tend to embrace traditional values of honesty, industry, and conscientious dignity.";
  } else if (type.toLowerCase() == "esfj") {
    return "ESFJs are highly attuned to the needs of others. They navigate emotions well and can quickly tell how others are feeling. ESFJs are dutiful and loyal, readily giving time to their friends and family when needed, but often take on others’ problems, sometimes burdening themselves with the responsibility.";
  } else if (type.toLowerCase() == "istp") {
    return "ISTPs are inquisitive, curious learners and adventurers. Discoveries and inventions hold their attention, and they are driven to find ways to improve the way things work. They typically love to unearth life’s mysteries and forever seek new adventures and answers. Their industriousness and confidence make them great achievers.";
  } else if (type.toLowerCase() == "isfp") {
    return "ISFPs are peaceful, caring and open individuals. Happy to love by their own set of rules, they carve their path in the world. An ISFP’s hidden creativity will take many people by surprise. They are modest in their quiet achievements and will harness their imaginative creativity as an outlet for expression.";
  } else if (type.toLowerCase() == "estp") {
    return "An ESTP is the soul of the party and loves to be the centre of attention. They relish an action-packed life full of adventure and obstacles and enjoy living in the moment. People often gravitate towards ESTPs because of their charisma and strong social skills.";
  } else if (type.toLowerCase() == "esfp") {
    return "ESFPs are extroverted and observant, making them great entertainers. They tend to be talkative, spontaneous and always up for a good activity. ESFPs are often the centre of attention as they employ humour and a playful attitude while speaking to others. This helps them get on with most other personality types.";
  }
}

bool checkFourLetter(
  String str,
  String value,
) {
  return str.contains(value);
}

String? getNickName(String personality) {
  if (personality == "intj") {
    return "architect";
  } else if (personality == "intp") {
    return "logician";
  } else if (personality == "entj") {
    return "commander";
  } else if (personality == "entp") {
    return "debater";
  } else if (personality == "infj") {
    return "advocate";
  } else if (personality == "infp") {
    return "mediator";
  } else if (personality == "enfj") {
    return "protagonist";
  } else if (personality == "enfp") {
    return "campaigner";
  } else if (personality == "istj") {
    return "logistician";
  } else if (personality == "isfj") {
    return "defender";
  } else if (personality == "estj") {
    return "executive";
  } else if (personality == "esfj") {
    return "consul";
  } else if (personality == "istp") {
    return "virtuoso";
  } else if (personality == "isfp") {
    return "adventurer";
  } else if (personality == "estp") {
    return "entrepreneur";
  } else if (personality == "esfp") {
    return "entertainer";
  } else {
    return "Unknown"; // In case an invalid personality type is passed.
  }
}

int getRecommendation(
  String userPersonalityType,
  String currentUserPersonalityType,
) {
  Map<String, Map<String, List<String>>> personalityCompatibility = {
    'intj': {
      'compatible': ['entp', 'entj', 'enfp'],
      'potential': ['intp', 'enfj', 'infj', 'infp', 'estp'],
      'try your luck': [
        'intj',
        'isfp',
        'isfj',
        'esfp',
        'esfj',
        'istp',
        'istj',
        'estj'
      ],
    },
    'intp': {
      'compatible': ['entj', 'entp', 'enfj'],
      'potential': ['intj', 'intp', 'enfp', 'infj', 'infp', 'estj'],
      'try your luck': ['isfp', 'isfj', 'esfp', 'esfj', 'istp', 'istj', 'estp'],
    },
    'entj': {
      'compatible': ['intp', 'intj', 'infp'],
      'potential': ['entp', 'enfj', 'enfp', 'infj', 'isfj', 'istp'],
      'try your luck': ['entj', 'isfp', 'esfp', 'esfj', 'istj', 'estp', 'estj'],
    },
    'entp': {
      'compatible': ['intj', 'intp', 'infj'],
      'potential': ['entj', 'enfj', 'enfp', 'infp', 'istj'],
      'try your luck': [
        'entp',
        'isfp',
        'isfj',
        'esfp',
        'esfj',
        'istp',
        'estp',
        'estj'
      ],
    },
    'infj': {
      'compatible': ['enfp', 'enfj', 'entp'],
      'potential': [
        'entj',
        'intj',
        'intp',
        'infj',
        'infp',
        'esfj',
        'esfp',
        'isfp',
        'estj',
        'estp'
      ],
      'try your luck': ['isfj', 'istp', 'istj'],
    },
    'infp': {
      'compatible': ['enfj', 'enfp', 'entj'],
      'potential': [
        'entp',
        'intj',
        'intp',
        'infj',
        'infp',
        'esfj',
        'isfp',
        'estj'
      ],
      'try your luck': ['isfj', 'esfp', 'istp', 'istj', 'estp'],
    },
    'enfj': {
      'compatible': ['infp', 'infj', 'intp'],
      'potential': [
        'entj',
        'entp',
        'intj',
        'enfj',
        'enfp',
        'esfj',
        'esfp',
        'isfj',
        'isfp'
      ],
      'try your luck': ['istp', 'istj', 'estp', 'estj'],
    },
    'enfp': {
      'compatible': ['infj', 'infp', 'intj'],
      'potential': [
        'entj',
        'entp',
        'intp',
        'enfj',
        'enfp',
        'esfj',
        'esfp',
        'isfj',
        'istj'
      ],
      'try your luck': ['isfp', 'istp', 'estp', 'estj'],
    },
    'istj': {
      'compatible': ['estp', 'estj', 'esfp'],
      'potential': ['entp', 'enfp', 'esfj', 'isfj', 'isfp', 'istp'],
      'try your luck': ['infp', 'infj', 'enfj', 'intp', 'intj', 'entj', 'istj'],
    },
    'isfj': {
      'compatible': ['esfp', 'esfj', 'estp'],
      'potential': ['entj', 'enfj', 'enfp', 'isfp', 'estj', 'istj', 'istp'],
      'try your luck': ['infp', 'infj', 'intp', 'intj', 'entp', 'isfj'],
    },
    'estj': {
      'compatible': ['istp', 'istj', 'isfp'],
      'potential': ['intp', 'infj', 'infp', 'esfj', 'esfp', 'isfj', 'estp'],
      'try your luck': ['enfp', 'enfj', 'intj', 'entp', 'entj', 'estj'],
    },
    'esfj': {
      'compatible': ['isfp', 'isfj', 'istp'],
      'potential': [
        'enfj',
        'enfp',
        'infj',
        'infp',
        'esfp',
        'estj',
        'estp',
        'istj'
      ],
      'try your luck': ['intp', 'intj', 'entp', 'entj', 'esfj'],
    },
    'istp': {
      'compatible': ['estj', 'estp', 'esfj'],
      'potential': ['entj', 'esfp', 'isfj', 'isfp', 'istj'],
      'try your luck': [
        'infp',
        'infj',
        'enfp',
        'enfj',
        'intp',
        'intj',
        'entp',
        'istp'
      ],
    },
    'isfp': {
      'compatible': ['esfj', 'esfp', 'estj'],
      'potential': ['enfj', 'infj', 'infp', 'isfj', 'estp', 'istj', 'istp'],
      'try your luck': ['enfp', 'intp', 'intj', 'entp', 'entj', 'isfp'],
    },
    'estp': {
      'compatible': ['istj', 'istp', 'isfj'],
      'potential': ['intj', 'infj', 'esfj', 'esfp', 'isfp', 'estj'],
      'try your luck': ['infp', 'enfp', 'enfj', 'intp', 'entp', 'entj', 'estp'],
    },
    'esfp': {
      'compatible': ['isfj', 'isfp', 'istj'],
      'potential': ['enfj', 'enfp', 'infj', 'esfj', 'estj', 'estp', 'istp'],
      'try your luck': ['infp', 'intp', 'intj', 'entp', 'entj', 'esfp'],
    },
  };
  for (var type in personalityCompatibility.keys) {
    if (currentUserPersonalityType.contains(type)) {
      var category = personalityCompatibility[type];

      // Check if userPersonalityType contains any compatible personality type
      if (category!['compatible']!.contains(userPersonalityType)) {
        return 0; // Compatible
      }
      // Check if userPersonalityType contains any potential personality type
      else if (category['potential']!.contains(userPersonalityType)) {
        return 1; // Potential
      }
      // Check if userPersonalityType contains any "try your luck" personality type
      else if (category['try your luck']!.contains(userPersonalityType)) {
        return 2; // Try your luck
      }
    }
  }

  return -1; // If no match found
}

String nickname(String name) {
  name = name.toLowerCase();

  // Modify the function to return the correct nickname based on the personality type
  if (name == "intj") {
    return "Architect";
  } else if (name == "intp") {
    return "Logician";
  } else if (name == "entj") {
    return "Commander";
  } else if (name == "entp") {
    return "Debater";
  } else if (name == "infj") {
    return "Advocate";
  } else if (name == "infp") {
    return "Mediator";
  } else if (name == "enfj") {
    return "Protagonist";
  } else if (name == "enfp") {
    return "Campaigner";
  } else if (name == "istj") {
    return "Logistician";
  } else if (name == "isfj") {
    return "Defender";
  } else if (name == "estj") {
    return "Executive";
  } else if (name == "esfj") {
    return "Consul";
  } else if (name == "istp") {
    return "Consul";
  } else if (name == "isfp") {
    return "Adventurer";
  } else if (name == "estp") {
    return "Entrepreneur";
  } else if (name == "esfp") {
    return "Entertainer";
  } else {
    return "Unknown Personality Type"; // In case the name doesn't match any of the types
  }
}

bool? ageCalculation(
  int? age,
  int? start,
  int? end,
) {
  if (age == null || start == null || end == null) {
    return false;
  }
  return age >= start && age <= end;
}

String? lowertext(String? message) {
  return message?.toLowerCase();
}

List<UserRecord>? usercheckversion(
  List<UserRecord>? userlist,
  DocumentReference? userreference,
  List<UserRecord>? todayuserlist,
  List<DocumentReference>? senmessagelist,
  List<String> within30milesLondon,
  List<String> within30milesSouthEastEngland,
  List<String> within30milesSouthWestEngland,
  List<String> within30milesEastofEngland,
  List<String> within30milesWestMidlands,
  List<String> within30milesEastMidlands,
  List<String> within30milesNorthWestEngland,
  List<String> within30milesYorkshireandtheHumber,
  List<String> within30milesNorthEastEngland,
) {
  List<UserRecord> lastuserlist = [];
  List<UserRecord> newUserList = [];

  for (UserRecord element in todayuserlist ?? []) {
    if (!(senmessagelist?.contains(element.reference) ?? false)) {
      newUserList.add(element);
    } else {
      lastuserlist.add(element);
    }
    // if (element.messageSent.isNotEmpty) {
    //   if (!element.messageSent.contains(userreference)) {
    //     newUserList.add(element);
    //   } else {
    //     lastuserlist.add(element);
    //   }
    // } else {
    //   lastuserlist.add(element);
    // }
  }

  // newUserList.addAll(lastuserlist);

  // List<UserRecord> value = [];

  // for (var element in newUserList) {
  //   if (currentUserDocument?.preferrredLocation == 'only my location') {
  //     if (currentUserDocument?.city == element?.subCity) {
  //       value.add(element);
  //     }
  //   }
  // }

  // return newUserList;
  //
  // Merge them: new first, then last
  List<UserRecord> orderedList = [...newUserList, ...lastuserlist];

  if (currentUserDocument?.preferrredLocation == 'anywhere in the uk') {
    return orderedList;
  }

  // Apply location filter if required
  if (currentUserDocument?.preferrredLocation == 'only my location') {
    var value = orderedList
        .where((element) => element.subCity == currentUserDocument?.subCity)
        .toList();
    return value;
  }

  if (currentUserDocument?.preferrredLocation ==
      'locations within a 30 mile radius') {
    String? city = currentUserDocument?.city;

    return orderedList.where((element1) {
      if (city == 'london') {
        return within30milesLondon.contains(element1.subCity);
      } else if (city == 'south east england') {
        return within30milesSouthEastEngland.contains(element1.subCity);
      } else if (city == 'south west england') {
        return within30milesSouthWestEngland.contains(element1.subCity);
      } else if (city == 'east of england') {
        return within30milesEastofEngland.contains(element1.subCity);
      } else if (city == 'west midlands') {
        return within30milesWestMidlands.contains(element1.subCity);
      } else if (city == 'east midlands') {
        return within30milesEastMidlands.contains(element1.subCity);
      } else if (city == 'north west england') {
        return within30milesNorthWestEngland.contains(element1.subCity);
      } else if (city == 'yorkshire and the humber') {
        return within30milesYorkshireandtheHumber.contains(element1.subCity);
      } else if (city == 'north east england') {
        return within30milesNorthEastEngland.contains(element1.subCity);
      }
      return false;
    }).toList();
  }

  return orderedList;
}

String? messageTimeDateCalculator(DateTime messageTime) {
  final now = DateTime.now();
  final difference = now.difference(messageTime);

  if (difference.inHours < 24) {
    // Show time like 3:45 PM
    return DateFormat.jm().format(messageTime);
  } else {
    // Show date like Jun 22, 2025
    return DateFormat('dd/MM/yyyy').format(messageTime);
  }
}

bool? newCustomFunction(List<ChatRecord>? datalist) {
  if (datalist?.isNotEmpty ?? false) {
    return true;
  } else {
    return false;
  }
}

bool? usercountfunction(
  UserRecord? userlist,
  List<String> within30milesLondon,
  List<String> within30milesSouthEastEngland,
  List<String> within30milesSouthWestEngland,
  List<String> within30milesEastofEngland,
  List<String> within30milesWestMidlands,
  List<String> within30milesEastMidlands,
  List<String> within30milesNorthWestEngland,
  List<String> within30milesYorkshireandtheHumber,
  List<String> within30milesNorthEastEngland,
) {
  if ((currentUserDocument?.preferrredLocation == 'anywhere in the uk')) {
    return true;
  } else if (currentUserDocument?.preferrredLocation == 'only my location') {
    if (currentUserDocument?.subCity == userlist?.subCity) {
      return true;
    }
  } else if (currentUserDocument?.preferrredLocation ==
      'locations within a 30 mile radius') {
    if (currentUserDocument?.city == 'london') {
      if (within30milesLondon.contains(userlist?.subCity)) {
        return true;
      }
    } else if (currentUserDocument?.city == 'south east england') {
      if (within30milesSouthEastEngland.contains(userlist?.subCity)) {
        return true;
      }
    } else if (currentUserDocument?.city == 'south west england') {
      if (within30milesSouthWestEngland.contains(userlist?.subCity)) {
        return true;
      }
    } else if (currentUserDocument?.city == 'east of england') {
      if (within30milesEastofEngland.contains(userlist?.subCity)) {
        return true;
      }
    } else if (currentUserDocument?.city == 'west midlands') {
      if (within30milesWestMidlands.contains(userlist?.subCity)) {
        return true;
      }
    } else if (currentUserDocument?.city == 'east midlands') {
      if (within30milesEastMidlands.contains(userlist?.subCity)) {
        return true;
      }
    } else if (currentUserDocument?.city == 'north west england') {
      if (within30milesNorthWestEngland.contains(userlist?.subCity)) {
        return true;
      }
    } else if (currentUserDocument?.city == 'yorkshire and the humber') {
      if (within30milesYorkshireandtheHumber.contains(userlist?.subCity)) {
        return true;
      }
    } else if (currentUserDocument?.city == 'north east england') {
      if (within30milesNorthEastEngland.contains(userlist?.subCity)) {
        return true;
      }
    } else {
      return false;
    }
  }
}

bool isUserActiveForRecommendation(String lastOpenedDate) {
  try {
    if (lastOpenedDate == null || lastOpenedDate.trim().isEmpty) {
      return false;
    }

    final parsedDate = DateFormat('MMM d, yyyy').parse(lastOpenedDate);

    final now = DateTime.now();

    final diffInDays = now.difference(parsedDate).inDays;

    if (diffInDays <= 3) {
      return true;
    } else if (diffInDays >= 4 && diffInDays <= 7) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print('Error parsing date: $e');
    return false;
  }
  // try {
  //   if (lastOpenedDate == null) return false;

  //   DateTime parsedDate;

  //   // Handle Firestore Timestamp type
  //   if (lastOpenedDate is Timestamp) {
  //     parsedDate = lastOpenedDate.toDate();
  //   }
  //   // Handle legacy or string format
  //   else if (lastOpenedDate is String && lastOpenedDate.trim().isNotEmpty) {
  //     parsedDate = DateFormat('MMM d, yyyy').parse(lastOpenedDate);
  //   } else {
  //     return false;
  //   }

  //   final diffInDays = DateTime.now().difference(parsedDate).inDays;

  //   // Active if opened within 7 days
  //   return diffInDays <= 7;
  // } catch (e) {
  //   print('⚠️ Error parsing date: $e');
  //   return false;
  // }
}

bool? manageseenfunction(bool? seen) {
  if (seen == null || seen == false) {
    return true;
  } else {
    return false;
  }
}

List<NotificationRecord>? managenotificationtime(
  List<NotificationRecord>? notificationdata,
  String? choicechip,
) {
  if (notificationdata == null || notificationdata.isEmpty) return [];

  if (choicechip == null || choicechip.isEmpty) return notificationdata;

  final now = DateTime.now();
  final yesterday = now.subtract(const Duration(days: 1));
  final filter = choicechip.toLowerCase();

  bool isSameDate(DateTime d1, DateTime d2) =>
      d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;

  return notificationdata.where((notification) {
    final sentAt = notification.sentAt;

    if (sentAt == null) return false;

    if (notification.forAdmin == true) return false;

    final diff = now.difference(sentAt).inDays;

    switch (filter) {
      case 'today':
        return isSameDate(sentAt, now);

      case 'yesterday':
        return isSameDate(sentAt, yesterday);

      case 'last 7 days':
        return diff > 1 && diff <= 7;
      // Today & yesterday removed

      case 'last 30 days':
        return diff > 7 && diff <= 30;
      // Today, yesterday & 7 days removed

      case 'older':
        return diff > 30;

      default:
        return false;
    }
  }).toList();
}

List<NotificationRecord>? checkseencount(
  List<NotificationRecord>? notificationdata,
  DocumentReference? currentuserreference,
) {
  List<NotificationRecord>? valuelist = [];
  for (NotificationRecord element in notificationdata ?? []) {
    if (element.manage == 'admin') {
      if (!element.seenList.contains(currentuserreference)) {
        valuelist.add(element);
      }
    } else if ((element.seen == false &&
        element.user == currentuserreference)) {
      valuelist.add(element);
    }
  }

  return valuelist;
}

int? managedatetimefunction(List<DateTime>? notificationdate) {
  //
  int value = 0;
  for (DateTime element in notificationdate ?? []) {
    if (DateTime(element.year, element.month, element.day) ==
        DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day)) {
      value += 1;
    }
  }

  return value;
}

bool? searchUserfunction(
  String searchQuery,
  String userName,
) {
  return userName.toLowerCase().contains(searchQuery.toLowerCase());
}

DateTime? adddays(
  int? days,
  DateTime? date,
) {
  // add days to given date
  if (days == null || date == null) {
    return null;
  }
  return date.add(Duration(days: days));
}

int? addition(
  int? num1,
  int? num2,
) {
  if (num1 == null || num2 == null) return null; // Check for null values
  return num1 + num2;
}

bool canEditEvent(DateTime eventCreatedTime) {
  final now = DateTime.now();

  // Difference in hours
  final diffInHours = now.difference(eventCreatedTime).inHours;

  // Allow edit only if difference is 4 hours or less
  return diffInHours <= 4;
}

DateTime? event24hours(DateTime eventCreatedTime) {
  return eventCreatedTime.add(const Duration(hours: 24));
}

int? unseenfunctioncount(List<ChatMessageRecord>? chatmessagelist) {
  int value = 0;

  for (ChatMessageRecord element in chatmessagelist ?? []) {
    if (element.isseen == false) {
      value += 1;
    }
  }
  return value;
}

int getNotificationCount(
  List<NotificationRecord> notifications,
  DocumentReference? user,
  DateTime? createdTime,
) {
  // if (notifications.isEmpty || user == null || createdTime == null) {
  //   return 0;
  // }

  // return notifications.where((element) {
  //   final sentAt = element.sentAt;
  //   if (sentAt == null) return false;

  //   if (element.forAdmin == true) return false;

  //   final isNew = sentAt.isAfter(createdTime);

  //   final isForUser = (element.user != null &&
  //       element.user!.path == user.path &&
  //       (element.seen ?? false) == false);

  //   final seenList = element.seenList ?? [];
  //   final deleteList = element.deleteList ?? [];
  //   final isAdminUnseen = (element.manage != null &&
  //       element.manage!.toLowerCase() == 'admin' &&
  //       !seenList.contains(user) &&
  //       !deleteList.contains(user));

  //   return isNew && (isForUser || isAdminUnseen);
  // }).length;
  if (notifications.isEmpty || user == null || createdTime == null) {
    return 0;
  }

  return notifications.where((element) {
    final sentAt = element.sentAt;
    if (sentAt == null) return false;

    if (element.forAdmin == true) return false;

    final isNew = sentAt.isAfter(createdTime);

    final isAdmin = element.manage.toLowerCase() == 'admin';
    final isSeen = isAdmin
        ? (element.seenList.contains(user) || element.deleteList.contains(user))
        : element.seen;

    return isNew && !isSeen && (isAdmin || element.user == user);
  }).length;

  // return notifications!.where((element) {
  //   final sentAt = element.sentAt;

  //   if (sentAt == null) return false;

  //   if (element.forAdmin == true) return false;

  //   // Must be after createdTime
  //   final isNew = sentAt.isAfter(createdTime!);

  //   // User-specific notification AND seen == true
  //   final isForUser = (element.user != null &&
  //       element.user!.path == user!.path &&
  //       element.seen == false);

  //   // Admin notification NOT SEEN by this user
  //   final isAdminUnseen = (element.manage != null &&
  //       element.manage!.toLowerCase() == 'admin' &&
  //       !element.seenList.contains(user) &&
  //       !element.deleteList.contains(user));

  //   return isNew && (isForUser || isAdminUnseen);
  // }).length;
}

String generateDateFormateForLinkup(DateTime date) {
  String weekday = DateFormat('E').format(date);

  // Day with suffix
  int day = date.day;
  String suffix;

  if (day >= 11 && day <= 13) {
    suffix = "th";
  } else {
    switch (day % 10) {
      case 1:
        suffix = "st";
        break;
      case 2:
        suffix = "nd";
        break;
      case 3:
        suffix = "rd";
        break;
      default:
        suffix = "th";
    }
  }

  // Month name
  String month = DateFormat('MMMM').format(date);

  // Final formatted string
  return "$weekday, $day$suffix $month";
}

List<DocumentReference> mergeBlockdUserList(
  List<DocumentReference> block1,
  List<DocumentReference> block2,
) {
  return {
    ...block1,
    ...block2,
  }.toList();
}

String getChatTimeText(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final messageDate = DateTime(date.year, date.month, date.day);

  final difference = today.difference(messageDate).inDays;

  if (difference == 0) {
    return 'TODAY';
  } else if (difference == 1) {
    return 'YESTERDAY';
  } else if (difference < 7) {
    return DateFormat('EEEE')
        .format(date)
        .toUpperCase(); // Day name (MONDAY, TUESDAY, etc.)
  } else if (date.year == now.year) {
    return DateFormat('MMMM d').format(date).toUpperCase(); // Month and day
  } else {
    return DateFormat('MMMM d, yyyy').format(date).toUpperCase(); // Full date
  }
}

String? formatUrl(String input) {
  // if (input.trim().isEmpty) {
  //   return null;
  // }

  // String url = input.trim();

  // // Add https if missing
  // if (!url.startsWith('http://') && !url.startsWith('https://')) {
  //   url = 'https://$url';
  // }

  // try {
  //   final uri = Uri.parse(url);

  //   // Basic validation
  //   if (uri.hasScheme && uri.host.isNotEmpty) {
  //     return uri.toString();
  //   } else {
  //     return null;
  //   }
  // } catch (e) {
  //   return null;
  // }

  if (input.trim().isEmpty) return null;

  String url = input.trim();

  // Remove spaces inside URL
  url = url.replaceAll(' ', '');

  // Add https if missing
  if (!url.startsWith(RegExp(r'https?:\/\/'))) {
    url = 'https://$url';
  }

  final uri = Uri.tryParse(url);

  if (uri == null) return null;

  // Must have a valid host like instagram.com
  if (uri.host.isEmpty || !uri.host.contains('.')) {
    return null;
  }

  return uri.toString();
}

bool? isValidUrl(String? url) {
  if (url == null) return false;

  final value = url.trim();
  if (value.isEmpty) return false;

  final uri = Uri.tryParse(value);
  if (uri == null) return false;

  // Must have http/https and a non-empty host
  final hasValidScheme =
      uri.scheme.toLowerCase() == 'http' || uri.scheme.toLowerCase() == 'https';

  return hasValidScheme && uri.host.isNotEmpty;
}

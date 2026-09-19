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

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PotentialWidget extends StatefulWidget {
  PotentialWidget({
    super.key,
    this.width,
    this.height,
    required this.type,
    required this.type2,
  });
  double? width;
  double? height;
  final String type; // This is the primary personality type (e.g., 'ENFJ')
  final String
      type2; // This is used to determine the category (e.g., 'compatible', 'potential', etc.)

  @override
  State<PotentialWidget> createState() => _PotentialWidgetState();
}

class _PotentialWidgetState extends State<PotentialWidget> {
  // This function will determine the category based on the type2
  List<String> getPersonalityCategory(String type2) {
    // Define the categories in a map for each personality type
    Map<String, Map<String, List<String>>> personalityCategories = {
      'intj': {
        'compatible': ['entp', 'entj', 'enfp'],
        'potential': ['intp', 'enfj', 'infj', 'infp', 'estp'],
        'try your luck': [
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
        'try your luck': [
          'isfp',
          'isfj',
          'esfp',
          'esfj',
          'istp',
          'istj',
          'estp'
        ],
      },
      'entj': {
        'compatible': ['intp', 'intj', 'infp'],
        'potential': ['entp', 'enfj', 'enfp', 'infj', 'isfj', 'istp'],
        'try your luck': [
          'entj',
          'isfp',
          'esfp',
          'esfj',
          'istj',
          'estp',
          'estj'
        ],
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
        'try your luck': [
          'infp',
          'infj',
          'enfj',
          'intp',
          'intj',
          'entj',
          'istj'
        ],
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
        'try your luck': [
          'infp',
          'enfp',
          'enfj',
          'intp',
          'entp',
          'entj',
          'estp'
        ],
      },
      'esfp': {
        'compatible': ['isfj', 'isfp', 'istj'],
        'potential': ['enfj', 'enfp', 'infj', 'esfj', 'estj', 'estp', 'istp'],
        'try your luck': ['infp', 'intp', 'intj', 'entp', 'entj', 'esfp'],
      },
    };

    // Return the categories for the passed type2
    return personalityCategories[widget.type.toLowerCase()]?[type2] ?? [];
  }

  Map<String, Map<String, dynamic>> personalityDetails = {
    'intj': {
      'icon': Icons.architecture,
      'description': 'Strategic and insightful planners.',
    },
    'intp': {
      'icon': Icons.science_outlined,
      'description': 'Logical thinkers and problem solvers.',
    },
    'entj': {
      'icon': FontAwesomeIcons.handPointLeft,
      'description': 'Natural leaders and decisive.',
    },
    'entp': {
      'icon': FontAwesomeIcons.microphoneAlt,
      'description': 'Creative and curious idea generators.',
    },
    'infj': {
      'icon': Icons.tips_and_updates_outlined,
      'description': 'Insightful and empathetic individuals.',
    },
    'infp': {
      'icon': Icons.balance_rounded,
      'description': 'Idealistic and deeply introspective.',
    },
    'enfj': {
      'icon': Icons.waving_hand_outlined,
      'description': 'Charismatic and supportive leaders.',
    },
    'enfp': {
      'icon': Icons.campaign_outlined,
      'description': 'Energetic and passionate innovators.',
    },
    'istj': {
      'icon': Icons.inventory_rounded,
      'description': 'Practical and reliable problem solvers.',
    },
    'isfj': {
      'icon': Icons.health_and_safety_outlined,
      'description': 'Caring and detail-oriented individuals.',
    },
    'estj': {
      'icon': Icons.calculate_outlined,
      'description': 'Organized and goal-driven leaders.',
    },
    'esfj': {
      'icon': Icons.handshake_outlined,
      'description': 'Warm and cooperative individuals.',
    },
    'istp': {
      'icon': Icons.build_outlined,
      'description': 'Adaptable and skilled in problem-solving.',
    },
    'isfp': {
      'icon': Icons.format_paint_outlined,
      'description': 'Creative and sensitive individuals.',
    },
    'estp': {
      'icon': Icons.bolt_rounded,
      'description': 'Energetic and action-oriented people.',
    },
    'esfp': {
      'icon': Icons.celebration_rounded,
      'description': 'Fun-loving and spontaneous individuals.',
    },
  };
  @override
  Widget build(BuildContext context) {
    // Get the personality types based on the passed type2 argument
    List<String> personalities =
        getPersonalityCategory(widget.type2.toLowerCase());

    return Container(
      height: widget.height, // Fixed height for the container
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Enable horizontal scroll
          child: Row(
            children: [
              for (var personalityType in personalities)
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0), // spacing between items
                  child: PersonalityTypeWidget(
                    personalityType: personalityType,
                    icon: personalityDetails[personalityType]?['icon'],
                    description: 'Description for $personalityType',
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class PersonalityTypeWidget extends StatelessWidget {
  final String personalityType;
  final IconData icon;
  final String description;

  PersonalityTypeWidget(
      {required this.personalityType,
      required this.icon,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 50, color: Color(0xFF57636C)),
        SizedBox(height: 8),
        Text(personalityType,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Color(0xFF57636C))),
      ],
    );
  }
}

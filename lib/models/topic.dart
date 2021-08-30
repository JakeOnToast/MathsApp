import 'dart:math';

import 'package:flutter/material.dart';
import '../constants/shared_prefs.dart';
import './question.dart';

class Topic {
  final String name;
  final IconData iconData;
  final MaterialColor color;
  final Question Function(int) questionBuilder;
  final int numLevels;

  Topic({
    required this.name,
    required this.iconData,
    required this.color,
    required this.questionBuilder,
    required this.numLevels,
  });

  bool get isLocked => name == "Matrices";

  int _selectedLevel = 0;

  set selectedLevel(int level){
    // just to make sure that the level is in the correct range
    _selectedLevel = max(0, min(numLevels - 1, level));
  }

  int get selectedLevel => _selectedLevel;

  int _maxLevelUnlocked = 0;

  set maxLevelUnlocked(int level){
    _maxLevelUnlocked = max(0, min(level, numLevels));
    prefs.setInt(maxLevelUnlockedKey, _maxLevelUnlocked);
  }

  int get maxLevelUnlocked => _maxLevelUnlocked;

  String get maxLevelUnlockedKey => "${name}_maxLevelUnlocked";

  int endlessHighScore = 0;

  List<Question> generateQuestions(final int level, final double numQuestions,
      {bool useLowerLevels = true, double maxLevelProportion = 3/5}){

    final random = Random();
    final List<Question> questions = [];

    for(var i = 0; i<numQuestions; i++){

      if(useLowerLevels && (i+1)/numQuestions > maxLevelProportion){
        questions.add(questionBuilder(random.nextInt(level+1)));
      }
      else{
        questions.add(questionBuilder(level));
      }

    }

    return questions..shuffle(random);
  }



}

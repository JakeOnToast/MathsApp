import 'dart:math';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mathsapp/models/maths_app_error.dart';
import '../constants/question_builders.dart';
import './question.dart';

part "topic.g.dart";

// these keys can't ever be changed as they will be used to store
// the topics on the firebase server.
// display names can be altered and will not affect the storage.
const Map<String, ConstantTopicData> topicDataKeys = {
  "addition": ConstantTopicData.addition,
  "subtraction": ConstantTopicData.subtraction,
  "multiplication": ConstantTopicData.multiplication,
  "division": ConstantTopicData.division,
  "exponents": ConstantTopicData.exponents,
  "roots": ConstantTopicData.roots,
  "fake": ConstantTopicData.fake,
};

@HiveType(typeId: 1)
class Topic extends HiveObject {
  @HiveField(0)
  final ConstantTopicData topicData;

  @HiveField(1)
  late int _selectedLevel;

  @HiveField(2)
  late int _maxLevelUnlocked;

  @HiveField(3)
  late int _endlessHighScore;

  Topic({
    required this.topicData,
    int? selectedLevel,
    int? maxLevelUnlocked,
    int? endlessHighScore,
  })  : _selectedLevel = selectedLevel ?? 0,
        _maxLevelUnlocked = maxLevelUnlocked ?? 0,
        _endlessHighScore = endlessHighScore ?? 0;

  Map<String, dynamic> toMap() {
    return {
      "topicDataTypeKey": topicData.mapKey,
      "selectedLevel": _selectedLevel,
      "maxLevelUnlocked": _maxLevelUnlocked,
      "endlessHighScore": _endlessHighScore,
    };
  }

  factory Topic.fromMap(Map<String, dynamic> map) {
    // TODO add all extra fields
    return Topic(
      topicData:
          topicDataKeys[map["topicDataTypeKey"]] ?? ConstantTopicData.addition,
      selectedLevel: map["selectedLevel"],
      maxLevelUnlocked: map["maxLevelUnlocked"],
      endlessHighScore: map["endlessHighScore"],
    );
  }

  void merge(Topic other){
    if(topicData != other.topicData){
      throw MathsAppError("Topics must have the same type to combine");
    }
    _selectedLevel = other.selectedLevel;
    _maxLevelUnlocked = other.maxLevelUnlocked;
    _endlessHighScore = other.endlessHighScore;
    save();
  }

  set selectedLevel(int level) {
    // just to make sure that the level is in the correct range
    _selectedLevel = max(0, min(numLevels - 1, level));
    // save();
  }

  set maxLevelUnlocked(int level) {
    _maxLevelUnlocked = max(0, min(level, numLevels));
    save();
  }

  set endlessHighScore(int highScore) {
    if (highScore <= _endlessHighScore) {
      return;
    }
    _endlessHighScore = highScore;
    save();
  }

  int get selectedLevel => _selectedLevel;
  int get maxLevelUnlocked => _maxLevelUnlocked;
  int get endlessHighScore => _endlessHighScore;
  String get maxLevelUnlockedKey => "${name}_maxLevelUnlocked";

  List<Question> generateQuestions(final int level, final double numQuestions,
      {bool useLowerLevels = true, double maxLevelProportion = 3 / 5}) {
    final random = Random();
    final List<Question> questions = [];

    for (var i = 0; i < numQuestions; i++) {
      if (useLowerLevels && (i + 1) / numQuestions > maxLevelProportion) {
        questions.add(questionBuilder(random.nextInt(level + 1)));
      } else {
        questions.add(questionBuilder(level));
      }
    }
    return questions..shuffle(random);
  }

  String get name => topicData.name;
  IconData get iconData => topicData.iconData;
  MaterialColor get color => topicData.color;
  Question Function(int) get questionBuilder => topicData.questionBuilder;
  int get numLevels => topicData.numLevels;

  String get constantName{
    return topicDataKeys.entries.singleWhere((entry) => entry.value == topicData).key;
  }
}

@HiveType(typeId: 2)
enum ConstantTopicData {
  @HiveField(0)
  addition,
  @HiveField(1)
  subtraction,
  @HiveField(2)
  multiplication,
  @HiveField(3)
  division,
  @HiveField(4)
  exponents,
  @HiveField(5)
  roots,
  @HiveField(6)
  fake,
}

extension ConstantTopicDataExtension on ConstantTopicData {
  String get name {
    // add switch statements to use custom display name
    switch (this) {
      case ConstantTopicData.roots:
        return "Nth Root";
      default:
        return describeEnum(this).titleCase;
    }
  }

  IconData get iconData {
    switch (this) {
      case ConstantTopicData.addition:
        return CommunityMaterialIcons.plus;

      case ConstantTopicData.subtraction:
        return CommunityMaterialIcons.minus;

      case ConstantTopicData.multiplication:
        return Icons.close_rounded;

      case ConstantTopicData.division:
        return CommunityMaterialIcons.slash_forward;

      case ConstantTopicData.exponents:
        return CommunityMaterialIcons.exponent;

      case ConstantTopicData.roots:
        return CommunityMaterialIcons.square_root;

      default:
        return Icons.error_outline;
    }
  }

  MaterialColor get color {
    switch (this) {
      case ConstantTopicData.addition:
        return Colors.blue;
      case ConstantTopicData.subtraction:
        return Colors.cyan;
      case ConstantTopicData.multiplication:
        return Colors.teal;
      case ConstantTopicData.division:
        return Colors.green;
      case ConstantTopicData.exponents:
        return Colors.brown;
      case ConstantTopicData.roots:
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  QuestionBuilder get questionBuilder {
    switch (this) {
      case ConstantTopicData.addition:
        return addQuestionBuilder;
      case ConstantTopicData.subtraction:
        return minusQuestionBuilder;
      case ConstantTopicData.multiplication:
        return multiplyQuestionBuilder;
      default:
        return fakeQuestionBuilder;
    }
  }

  int get numLevels {
    switch (this) {
      case ConstantTopicData.addition:
        return 6;
      default:
        return 6;
    }
  }

  String get mapKey {
    return topicDataKeys.entries
        .singleWhere((entry) => entry.value == this)
        .key;
  }
}

extension StringExtension on String{
  String get titleCase{
    final words = split(" ");
    for(var i = 0; i<words.length; i++){
      final word = words[i];
      words[i] = "${word[0].toUpperCase()}${word.substring(1).toLowerCase()}";
    }
    return words.join(" ");
  }
}
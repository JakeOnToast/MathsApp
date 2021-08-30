import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import './question_builders.dart';
import '../models/topic.dart';

final topics = [
  Topic(
    name: "Addition",
    iconData: CommunityMaterialIcons.plus_minus_variant,
    color: Colors.blue,
    questionBuilder: addQuestionBuilder,
    numLevels: 6,
  ),
  Topic(
    name: "Multiplication",
    iconData: Icons.close,
    color: Colors.cyan,
    questionBuilder: fakeQuestionBuilder,
    numLevels: 6,
  ),
  Topic(
    name: "Division",
    iconData: CommunityMaterialIcons.slash_forward,
    color: Colors.teal,
    questionBuilder: fakeQuestionBuilder,
    numLevels: 6,
  ),
  Topic(
    name: "Exponents",
    iconData: CommunityMaterialIcons.exponent,
    color: Colors.green,
    questionBuilder: fakeQuestionBuilder,
    numLevels: 6,
  ),
  Topic(
    name: "Logarithms",
    iconData: CommunityMaterialIcons.math_log,
    color: Colors.brown,
    questionBuilder: fakeQuestionBuilder,
    numLevels: 6,
  ),
  Topic(
    name: "Integrals",
    iconData: CommunityMaterialIcons.math_integral,
    color: Colors.orange,
    questionBuilder: fakeQuestionBuilder,
    numLevels: 6,
  ),
  Topic(
    name: "Matrices",
    iconData: CommunityMaterialIcons.matrix,
    color: Colors.red,
    questionBuilder: fakeQuestionBuilder,
    numLevels: 6,
  ),
  Topic(
    name: "Trigonometry",
    iconData: CommunityMaterialIcons.angle_acute,
    color: Colors.pink,
    questionBuilder: fakeQuestionBuilder,
    numLevels: 6,
  ),
  Topic(
    name: "CEP YOCK",
    iconData: CommunityMaterialIcons.variable,
    color: Colors.purple,
    questionBuilder: fakeQuestionBuilder,
    numLevels: 6,
  ),
  Topic(
    name: "Vectors",
    iconData: CommunityMaterialIcons.vector_line,
    color: Colors.deepPurple,
    questionBuilder: fakeQuestionBuilder,
    numLevels: 6,
  ),
  Topic(
    name: "CEP YOCK",
    iconData: CommunityMaterialIcons.unicorn_variant,
    color: Colors.indigo,
    questionBuilder: fakeQuestionBuilder,
    numLevels: 6,
  ),
];

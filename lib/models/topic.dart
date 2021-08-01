import 'package:flutter/material.dart';

class Topic {
  final String name;
  final IconData iconData;
  final MaterialColor color;

  const Topic({
    required this.name,
    required this.iconData,
    required this.color,
  });

  bool get isLocked => name == "Matrices";

}

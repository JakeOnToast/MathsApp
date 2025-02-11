import 'package:flutter/foundation.dart';

enum Mode{
  play,
  practice,
  learn,
  endless,
}

extension ModeExtension on Mode{
  String get name => describeEnum(this);
}
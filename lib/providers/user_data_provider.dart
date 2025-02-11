import 'package:flutter/foundation.dart';
import '../models/modes.dart';

class UserDataProvider with ChangeNotifier {
  int _level = 0;
  int get level => _level;

  Mode _mode = Mode.play;
  Mode get mode => _mode;

  int _temporaryLevel = 1;
  int get temporaryLevel => _temporaryLevel;

  set temporaryLevel(int level) {
    if (level < 0 || level > 6) return;
    _temporaryLevel = level;
    notifyListeners();
  }

  final topicProgression = {};

  set mode(Mode mode) {
    _mode = mode;
    notifyListeners();
  }

  set level(int level) {
    _level = level;
    notifyListeners();
  }
}

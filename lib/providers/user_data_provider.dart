

import 'package:flutter/foundation.dart';
import 'package:mathsapp/models/modes.dart';

class UserDataProvider with ChangeNotifier{

  int _level = 0;
  int get level => _level;

  Mode _mode = Mode.play;
  Mode get mode => _mode;

  final topicProgression = {

  };


  set mode(Mode mode){
    _mode = mode;
    notifyListeners();
  }

  set level(int level){
    _level = level;
    notifyListeners();
  }

}
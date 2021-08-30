
import 'package:flutter/foundation.dart';
import '../constants/topics.dart';
import '../models/topic.dart';

class TopicProvider with ChangeNotifier{

  Topic _selectedTopic = topics[0];

  Topic get selectedTopic => _selectedTopic;

  set selectedTopic(Topic topic){
    _selectedTopic = topic;
    notifyListeners();
  }

  set selectedLevel(int level){
    _selectedTopic.selectedLevel = level;
    notifyListeners();
  }

  int get selectedLevel => _selectedTopic.selectedLevel;

  void notifyTopicListeners(){
    notifyListeners();
  }

}
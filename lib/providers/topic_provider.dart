import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/topic.dart';
import '../storage_helper.dart';

class TopicProvider with ChangeNotifier {
  List<Topic> _topics = [];

  Topic _selectedTopic = Topic(topicData: ConstantTopicData.addition);

  Topic get selectedTopic => _selectedTopic;

  TopicProvider() {
    // TODO this may need to get disposed
    HiveHelper.topicsBox().then((Box<Topic> topicsBox) =>
        topicsBox.listenable().addListener(topicChangeListener));
  }

  void topicChangeListener() {
    // TODO remove this
    print("topic listener triggered");
    notifyListeners();
  }

  void mergeTopics(List<Topic> newTopics){
    for(final topic in newTopics){
      _topics.singleWhere((oldTopic) => oldTopic.topicData == topic.topicData).merge(topic);
    }
  }

  set topics(List<Topic> topics) {
    _topics = topics;
    _selectedTopic = topics[0];
    notifyListeners();
  }

  set selectedTopic(Topic topic) {
    _selectedTopic = topic;
    notifyListeners();
  }

  set selectedLevel(int level) {
    _selectedTopic.selectedLevel = level;
    notifyListeners();
  }

  int get selectedLevel => _selectedTopic.selectedLevel;

  // A shallow copy of the list may be a better option =^) IDK
  List<Topic> get topics => _topics;

  Map<String, Map<String, dynamic>> packageTopicsForUpload() {
    return {}..addEntries(
        _topics.map((topic) => MapEntry(topic.constantName, topic.toMap())));
  }
}

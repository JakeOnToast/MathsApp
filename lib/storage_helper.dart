import 'package:hive_flutter/hive_flutter.dart';
import './models/user.dart';
import './models/topic.dart';

class HiveHelper {
  static bool _isInitialized = false;

  static Future<void> initializeHive() async {
    await Hive.initFlutter();

    // register adapters
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(TopicAdapter());
    Hive.registerAdapter(ConstantTopicDataAdapter());

    _isInitialized = true;
  }

  static void _requireInitialized() {
    if (!_isInitialized) {
      throw Error();
    }
  }

  static Future<Box<User>> userBox() {
    _requireInitialized();
    return Hive.openBox("user");
  }

  static Future<Box<Topic>> topicsBox() {
    _requireInitialized();
    return Hive.openBox("topics");
  }

  static Future<User> loadUser() async {
    _requireInitialized();
    final userBox = await HiveHelper.userBox();
    final topicBox = await HiveHelper.topicsBox();

    var user = userBox.get("user");

    if (user == null) {
      // create user and topics
      user = User();
      userBox.put("user", user);

      // create all topics and add to box
      topicBox.addAll(ConstantTopicData.values.map((topicData) => Topic(topicData: topicData)));
    }

    return user;
  }

  static Future<List<Topic>> loadTopics() async {
    _requireInitialized();
    final topicBox = await HiveHelper.topicsBox();
    final topics = topicBox.values.toList();
    if (topics.length < ConstantTopicData.values.length) {
      // add missing topics
      print("Topics are missing ${topics.length} < ${ConstantTopicData.values.length}");
      final currentTopics = topics.map((topic) => topic.topicData).toList();
      // find missing topic data objects then create topic objects from them
      final missingTopics = ConstantTopicData.values
          .where((topicData) => !currentTopics.contains(topicData))
          .map((topicData) => Topic(topicData: topicData));

      // add them to the box so that they can be saved
      topicBox.addAll(missingTopics);

      // get the updated list from storage
      return topicBox.values.toList();
    }
    return topics;
  }
}

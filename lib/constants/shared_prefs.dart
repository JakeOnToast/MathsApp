import './topics.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences prefs;

bool prefsLoaded = false;

void setupPrefs() async{
  prefs = await SharedPreferences.getInstance();
  print("prefs done");
  prefsLoaded = true;
  loadUnlockedLevels();
}

void loadUnlockedLevels() async{
  final keys = prefs.getKeys();
  for (final topic in topics) {
    if(keys.contains(topic.maxLevelUnlockedKey)){
      topic.maxLevelUnlocked = prefs.getInt(topic.maxLevelUnlockedKey) ?? 0;
    }
  }
}
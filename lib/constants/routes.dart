import '../screens/timed_question_screen.dart';
import '../screens/home_screen.dart';
import '../screens/mode_selection_screen.dart';
import '../screens/topic_screen.dart';

final routes = {
  TopicScreen.routeName: (ctx) => const TopicScreen(),
  HomeScreen.routeName: (ctx) => const HomeScreen(),
  ModeSelectionScreen.routeName: (ctx) => const ModeSelectionScreen(),
  TimedQuestionScreen.routeName: (ctx) => const TimedQuestionScreen(),
};
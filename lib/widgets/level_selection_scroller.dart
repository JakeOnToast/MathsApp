import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/topic.dart';
import '../providers/topic_provider.dart';
import '../screens/timed_question_screen.dart';
import './card_button.dart';
import 'package:provider/provider.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topicProvider = Provider.of<TopicProvider>(context);
    final topic = topicProvider.selectedTopic;
    final isLight = Theme.of(context).brightness == Brightness.light;

    final pageController = PageController(
      initialPage: topicProvider.selectedLevel,
      viewportFraction: 0.5,
    );

    return AspectRatio(
      aspectRatio: 2,
      child: PageView.builder(
        itemCount: topic.numLevels,
        onPageChanged: (int index) => topicProvider.selectedLevel = index,
        controller: pageController,
        itemBuilder: (_, i) {
          final selected = topicProvider.selectedLevel == i;
          final levelUnlocked = i <= topic.maxLevelUnlocked;
          // final question = addQuestionBuilder(i);
          return AnimatedScale(
            scale: selected ? 1 : 0.92,
            duration: const Duration(milliseconds: 400),
            curve: Curves.decelerate,
            child: AspectRatio(
              aspectRatio: 1,
              child: CardButton(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.linear,
                  decoration: BoxDecoration(
                    // this is a hacky solution to add color animation to the cards
                    // I use opacity at 0.7 to maintain the splash affect
                    color: selected
                        ? topic.color.withOpacity(0.65)
                        : topic.color[isLight ? 200 : 800] ?? Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: levelUnlocked
                      ? Center(
                          child: Text("${i + 1}",
                              style: Theme.of(context).textTheme.headline4),
                        )
                      : const Icon(Icons.lock),
                ),
                onPressed: selected
                    ? levelUnlocked
                        ? () => openLevel(topic, i, context)
                        : () => showLevelLockedMessage(topic, context)
                    : () {
                        topicProvider.selectedLevel = i;
                        pageController.animateToPage(i,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.decelerate);
                      },
                color: selected ? topic.color : Colors.transparent,
                splashColor: selected
                    ? topic.color[isLight ? 300 : 700] ?? Colors.black
                    : Colors.transparent,
              ),
            ),
          );
        },
      ),
    );
  }

  void openLevel(
      final Topic topic, final int level, final BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return TimedQuestionScreen(
          topic: topic,
          level: level,
        );
      },
      transitionsBuilder:
          (___, Animation<double> animation, ____, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    ));
  }

  void showLevelLockedMessage(final Topic topic, final BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Level Locked"),
        backgroundColor: topic.color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(20),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

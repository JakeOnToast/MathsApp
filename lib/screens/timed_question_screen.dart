import 'package:flutter/material.dart';

import '../models/question.dart';
import '../widgets/gradient_background_timer.dart';
import '../models/topic.dart';

const numQuestions = 5.0;

class TimedQuestionScreen extends StatefulWidget {
  static const routeName = "/timesQuestionScreen";

  final Topic topic;
  final int level;
  late final List<Question> questions;

  TimedQuestionScreen({Key? key, required this.topic, required this.level})
      : questions = topic.generateQuestions(level, numQuestions),
        super(key: key);

  @override
  State<TimedQuestionScreen> createState() => _TimedQuestionScreenState();
}

class _TimedQuestionScreenState extends State<TimedQuestionScreen> {
  final GlobalKey<GradientBackgroundTimerState> timerKey = GlobalKey();

  int questionIndex = 0;

  @override
  Widget build(BuildContext context) {
    final topic = widget.topic;
    final isLight = Theme.of(context).brightness == Brightness.light;

    final topicColor = topic.color;
    final topicAccentColor = topic.color[isLight ? 200 : 800] ?? Colors.white;

    // final monoColor =
    //     Theme.of(context).textTheme.headline5!.color ?? Colors.white;

    final question = widget.questions[questionIndex];

    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        backgroundColor: topicColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: topicAccentColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text("$questionIndex / ${numQuestions.toInt()}"),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FractionallySizedBox(
              widthFactor: 0.6,
              child: AspectRatio(
                aspectRatio: 3,
                child: GradientBackgroundTimer(
                  key: timerKey,
                  onComplete: () {
                    timerKey.currentState!.resetTimer();
                  },
                  fullColor: topicColor,
                  emptyColor: topicAccentColor.withOpacity(0.45),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: topicAccentColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        question.question,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AspectRatio(
              aspectRatio: 2 * question.answerChoices.length + 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: question.answerChoices
                    .map(
                      (answer) => AspectRatio(
                        aspectRatio: 1,
                        child: InkWell(
                          onTap: () => guess(answer, question),
                          splashColor: topicColor,
                          splashFactory: InkRipple.splashFactory,
                          customBorder: const CircleBorder(),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // color: topicAccentColor,
                              border: Border.all(color: topicColor, width: 4),
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                answer,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline6!.copyWith(color: topicColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void guess(String answer, Question question) {
    if (question.correctAnswer == answer) {
      if (questionIndex == numQuestions - 1) {
        successfulExit();
        return;
      }
      setState(() {
        questionIndex++;
      });
      timerKey.currentState!.resetTimer();
    }
  }

  void successfulExit() {
    final topic = widget.topic;

    if (topic.selectedLevel == topic.maxLevelUnlocked && topic.selectedLevel < topic.numLevels - 1) {
      topic.maxLevelUnlocked++;
    }
    Navigator.of(context).pop();
  }
}

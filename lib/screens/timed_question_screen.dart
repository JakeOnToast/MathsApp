import 'package:flutter/material.dart';
import '../widgets/circular_timer.dart';
import '../models/topic.dart';

class TimedQuestionScreen extends StatefulWidget {
  static const routeName = "/timesQuestionScreen";
  const TimedQuestionScreen({Key? key}) : super(key: key);

  @override
  _TimedQuestionScreenState createState() => _TimedQuestionScreenState();
}

class _TimedQuestionScreenState extends State<TimedQuestionScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
        setState(() {});
      });
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topic = ModalRoute.of(context)!.settings.arguments as Topic;
    final isLight = Theme.of(context).brightness == Brightness.light;

    final topicColor = topic.color;
    final topicAccentColor = topic.color[isLight ? 200 : 800] ?? Colors.white;

    final monoColor = Theme.of(context).textTheme.headline5!.color ?? Colors.white;

    if (_controller.isCompleted) {
      // Show game over dialog/screen
      print("done");
    }
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
          child: const Text("0 / 5"),
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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ShaderMask(
                    blendMode: BlendMode.srcATop,
                    shaderCallback: (bounds) => LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [topicAccentColor.withOpacity(0.45), topicColor],
                      stops: [_controller.value, _controller.value],
                    ).createShader(bounds),
                    child: AspectRatio(
                      aspectRatio: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Theme.of(context).canvasColor,
                        ),
                      ),
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: topicAccentColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          "80 + 2",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: topicColor, width: 4),
                  ),
                  child: Text(
                    "72",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: topicColor),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        width: 4,
                        color: monoColor),
                  ),
                  child: CircleAvatar(
                    backgroundColor: topicColor,
                    child: Text(
                      "82",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        width: 4,
                        color: topicAccentColor),
                  ),
                  child: CircleAvatar(
                    backgroundColor: topicColor,
                    child: Text(
                      "81",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Theme.of(context).canvasColor),
                    ),
                  ),
                ),
              ],
            ),
            FractionallySizedBox(
              widthFactor: 0.3,
              child: CircularTimer(
                progress: _controller.value,
                maxTime: 10,
                color: topicColor,
              ),
            ),
            // ElevatedButton(
            //   onPressed: _controller.isAnimating || _controller.isCompleted
            //       ? null
            //       : () => _controller.forward(),
            //   child: const Text("Start"),
            // ),
            // ElevatedButton(
            //   onPressed: () => Navigator.of(context).pop(),
            //   child: const Text("Quit"),
            // ),
          ],
        ),
      ),
    );
  }
}

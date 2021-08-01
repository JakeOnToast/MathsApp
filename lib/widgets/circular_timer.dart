import 'package:flutter/material.dart';

class CircularTimer extends StatelessWidget {
  final double maxTime;
  final double progress;
  final MaterialColor color;

  const CircularTimer({
    Key? key,
    required this.maxTime,
    required this.progress,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                  value: progress,
                  color: color[isLight ? 200 : 800],
                  backgroundColor: color,
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "${(maxTime.toInt() - (maxTime * progress).floor())}",
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 46,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

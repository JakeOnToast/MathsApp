import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientBackgroundTimer extends StatefulWidget {
  final Widget child;
  final Function onComplete;
  final Color fullColor;
  final Color emptyColor;
  final double borderRadius;
  final double padding;


  const GradientBackgroundTimer({
    Key? key,
    required this.child,
    required this.onComplete,
    required this.fullColor,
    required this.emptyColor,
    this.borderRadius = 25.0,
    this.padding = 8.0,
  }) : super(key: key);

  @override
  GradientBackgroundTimerState createState() =>
      GradientBackgroundTimerState();
}

class GradientBackgroundTimerState extends State<GradientBackgroundTimer>
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

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (_controller.isCompleted) {
        widget.onComplete();
      }
    });

    return Container(
      padding: EdgeInsets.all(widget.padding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [widget.emptyColor, widget.fullColor],
          stops: [_controller.value, _controller.value],
        ),
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: widget.child,
    );
  }

  void resetTimer() => _controller..reset()..forward();
}

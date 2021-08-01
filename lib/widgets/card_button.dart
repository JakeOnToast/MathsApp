import 'package:flutter/material.dart';

class CardButton extends StatefulWidget {
  final Widget child;
  final void Function() onPressed;
  final MaterialColor color;

  const CardButton({
    Key? key,
    required this.child,
    required this.onPressed,
    required this.color,
  }) : super(key: key);

  @override
  State<CardButton> createState() => _CardButtonState();
}

class _CardButtonState extends State<CardButton> {
  static const _pressedScale = 0.92;

  double _scale = 1;

  void _changeScale(newScale) {
    setState(() => _scale = newScale);
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTapDown: (_) => _changeScale(_pressedScale),
      onTapUp: (_) => _changeScale(1.0),
      onTapCancel: () => _changeScale(1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 80),
        curve: Curves.easeOutQuad,
        child: Card(
          color: widget.color[isLight ? 200 : 800],
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: InkWell(
            splashColor: widget.color[isLight ? 300 : 700],
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(20),
            splashFactory: InkRipple.splashFactory,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BorderedIcon extends StatelessWidget {
  final IconData iconData;
  final Color bgColor;
  final double maxSize;

  const BorderedIcon({
    Key? key,
    required this.iconData,
    required this.bgColor,
    required this.maxSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // get min of available width and height to make biggest circle
    return CircleAvatar(
      radius: maxSize / 2,
      backgroundColor: Theme.of(context).textTheme.headline5!.color,
      child: CircleAvatar(
        radius: (maxSize * 0.9) / 2,
        backgroundColor: bgColor,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Icon(
              iconData,
              color: Theme.of(context).textTheme.headline5!.color,
              size: maxSize,
            ),
          ),
        ),
      ),
    );
  }
}

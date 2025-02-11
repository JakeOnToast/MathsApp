import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class IconTabItem extends StatelessWidget {
  final dynamic value;

  final IconData iconData;

  const IconTabItem({
    Key? key,
    required this.value,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: describeEnum(value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          // this keeps the gesture detectors hit-box consistent
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(iconData, size: 28),
      ),
    );
  }
}

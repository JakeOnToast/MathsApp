import 'package:flutter/material.dart';
import './icon_tab_item.dart';

class IconTabBar extends StatelessWidget {
  final List<IconTabItem> children;
  final void Function(dynamic) onTap;
  final MaterialColor color;
  final dynamic variable;

  const IconTabBar({
    Key? key,
    required this.variable,
    required this.children,
    required this.onTap,
    required this.color,
  })  : assert(children.length > 1, "Needs at least two children"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final selectedIndex =
        children.indexWhere((item) => item.value == variable);
    final numItems = children.length;
    late final double alignmentStepSize;
    if (numItems == 2) {
      alignmentStepSize = 2.0;
    } else {
      alignmentStepSize = (numItems - 2) / (2 * numItems - 5);
    }


    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: color[isLight ? 200 : 800],
        // border: Border.all(color: Theme.of(context).textTheme.headline5!.color!, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: Alignment(-1.0 + selectedIndex * alignmentStepSize, 0.0),
            duration: const Duration(milliseconds: 200),
            child: FractionallySizedBox(
              heightFactor: 1,
              widthFactor: 1 / numItems,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Row(
            children: children
                .map(
                  (IconTabItem iconTabItem) => Expanded(
                    child: GestureDetector(
                      onTap: () => onTap(iconTabItem.value),
                      child: iconTabItem,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

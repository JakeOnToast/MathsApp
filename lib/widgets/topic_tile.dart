import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/topic.dart';
import '../screens/mode_selection_screen.dart';
import './bordered_icon.dart';
import './card_button.dart';

class TopicTile extends StatelessWidget {
  final Topic topic;

  const TopicTile({
    Key? key,
    required this.topic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      heightFactor: 0.9,
      child: CardButton(
        color: topic.color,
        onPressed: () => Navigator.of(context).pushNamed(ModeSelectionScreen.routeName, arguments: topic),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  topic.name,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                  child: LayoutBuilder(
                    builder: (ctx, BoxConstraints constraints) {
                      final maxSize =
                          min(constraints.maxHeight, constraints.maxWidth);
                      return BorderedIcon(
                        iconData: topic.iconData,
                        bgColor: topic.color,
                        maxSize: maxSize,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

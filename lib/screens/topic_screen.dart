import 'package:flutter/material.dart';
import '../constants/topics.dart';
import '../models/topic.dart';
import '../widgets/topic_tile.dart';

class TopicScreen extends StatelessWidget {
  static const routeName = "/topicScreen";

  const TopicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Select Topic"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        children:
            topics.map((Topic topic) => TopicTile(topic: topic)).toList(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mathsapp/widgets/firebase_dialog.dart';
import '../providers/admob_state_provider.dart';
import '../providers/topic_provider.dart';
import 'package:provider/provider.dart';
import '../models/topic.dart';
import '../widgets/topic_tile.dart';

class TopicScreen extends StatelessWidget {
  static const routeName = "/topicScreen";

  const TopicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topicProvider = Provider.of<TopicProvider>(context, listen: false);
    final topics = topicProvider.topics;

    // final adProvider = Provider.of<AdState>(context);

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
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            icon: const Icon(Icons.cloud),
            onPressed: () => showDialog(
                context: context,
                barrierDismissible: false,
                builder: (ctx) {
                  return const FirebaseDialog();
                }),
          ),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        children: topics.map((Topic topic) => TopicTile(topic: topic)).toList(),
      ),
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../providers/topic_provider.dart';
import '../widgets/level_selection_scroller.dart';
import '../models/modes.dart';
import '../providers/user_data_provider.dart';
import '../widgets/icon_tab_bar.dart';
import '../widgets/icon_tab_item.dart';
import 'package:provider/provider.dart';

class ModeSelectionScreen extends StatelessWidget {
  static const routeName = "/modeSelectionScreen";

  // final ref = FirebaseFirestore.instance.collection("users/secret/topics");

  const ModeSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topicProvider = Provider.of<TopicProvider>(context, listen: false);
    final topic = topicProvider.selectedTopic;
    final userDataProvider = Provider.of<UserDataProvider>(context);

    // final isLight = Theme.of(context).brightness == Brightness.light;
    // final monoColor =
    //     Theme.of(context).textTheme.headline6!.color ?? Colors.white;

    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        backgroundColor: topic.color,
        title: Text(
          topic.name,
        ),
        centerTitle: true,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          // FractionallySizedBox(
          //   widthFactor: 0.4,
          //   child: Container(
          //     alignment: Alignment.center,
          //     padding: const EdgeInsets.symmetric(vertical: 4),
          //     decoration: BoxDecoration(
          //       color: topic.color[isLight ? 200 : 800],
          //       borderRadius: const BorderRadius.only(
          //         topRight: Radius.circular(20),
          //         topLeft: Radius.circular(20),
          //       ),
          //     ),
          //     child: Text(getModeName(userDataProvider.mode), style: Theme.of(context).textTheme.headline6,),
          //   ),
          // ),
          FractionallySizedBox(
            widthFactor: 0.65,
            child: IconTabBar(
              variable: userDataProvider.mode,
              color: topic.color,
              onTap: (mode) => userDataProvider.mode = mode,
              children: const [
                IconTabItem(
                  value: Mode.play,
                  iconData: Icons.timer_rounded,
                ),
                IconTabItem(
                  value: Mode.practice,
                  iconData: CommunityMaterialIcons.bullseye_arrow,
                ),
                IconTabItem(
                  value: Mode.learn,
                  iconData: Icons.menu_book_rounded,
                ),
              ],
            ),
          ),
          const Spacer(flex: 2),
          const FractionallySizedBox(
            widthFactor: 1,
            child: LevelSelectionScreen(),
          ),
          const Spacer(
            flex: 3,
          ),
          // ElevatedButton(
          //   onPressed: () async {
          //     final userCredentials = await signInWithGoogle();
          //     if(userCredentials == null){
          //       print("No user");
          //       return;
          //     }
          //     print("User uid = ${userCredentials.user!.uid}");
          //   },
          //   child: const Text("google"),
          // ),
          // StreamBuilder(
          //   stream: ref.doc("addition").snapshots(),
          //   builder: (ctx, AsyncSnapshot<DocumentSnapshot> snapshot) {
          //     if(snapshot.hasData){
          //       print(snapshot.data!.data());
          //       final data = snapshot.requireData.data()! as Map<String, dynamic>;
          //       return Text("max level ${data["maxLevelUnlocked"]}");
          //     }else{
          //       return const CircularProgressIndicator.adaptive();
          //     }
          //   },
          // ),
          // ElevatedButton(onPressed: () {
          //   ref.doc("addition").update({"maxLevelUnlocked": ++userDataProvider.temporaryLevel});
          // },
          //   child: const Text("press"),
          // ),
        ],
      ),
    );
  }
}

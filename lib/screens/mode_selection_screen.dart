import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:mathsapp/screens/timed_question_screen.dart';
import '../models/modes.dart';
import '../providers/user_data_provider.dart';
import '../widgets/icon_tab_bar.dart';
import '../widgets/icon_tab_item.dart';
import 'package:provider/provider.dart';
import '../models/topic.dart';

class ModeSelectionScreen extends StatelessWidget {
  static const routeName = "/modeSelectionScreen";

  const ModeSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topic = ModalRoute.of(context)!.settings.arguments as Topic;
    final userDataProvider = Provider.of<UserDataProvider>(context);
    // final isLight = Theme.of(context).brightness == Brightness.light;

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
          //       color: topic.iconBgColor[isLight ? 200 : 800],
          //       borderRadius: const BorderRadius.only(
          //         topRight: Radius.circular(10),
          //         topLeft: Radius.circular(10),
          //       ),
          //     ),
          //     child: Text(getModeName(userDataProvider.mode), style: Theme.of(context).textTheme.headline6,),
          //   ),
          // ),
          FractionallySizedBox(
            widthFactor: 0.65,
            child: IconTabBar(
              color: topic.color,
              onTap: (mode) => userDataProvider.mode = mode,
              children: [
                IconTabItem(
                  value: Mode.play,
                  variable: userDataProvider.mode,
                  iconData: Icons.timer_rounded,
                ),
                IconTabItem(
                  value: Mode.practice,
                  variable: userDataProvider.mode,
                  iconData: CommunityMaterialIcons.bullseye_arrow,
                ),
                IconTabItem(
                  value: Mode.learn,
                  variable: userDataProvider.mode,
                  iconData: Icons.menu_book_rounded,
                ),
              ],
            ),
          ),

          const Spacer(
            flex: 2,
          ),
          Flexible(
            child: Center(
              child: CircleAvatar(
                radius: 30,
                backgroundColor: topic.color,
                child: IconButton(
                    tooltip: "Play",
                    padding: EdgeInsets.zero,
                    color: Theme.of(context).canvasColor,
                    iconSize: 50,
                    icon: const Icon(Icons.play_arrow_rounded),
                    onPressed: () {
                      // ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text(
                      //         "${getModeName(userDataProvider.mode)} ${topic.name}"),
                      //   ),
                      // );
                      Navigator.of(context).pushNamed(TimedQuestionScreen.routeName, arguments: topic);
                    }),
              ),
            ),
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}

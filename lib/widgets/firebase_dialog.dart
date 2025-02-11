import 'package:community_material_icon/community_material_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../models/cloud_action.dart';
import './rewarded_ad_dialog.dart';
import './icon_tab_bar.dart';
import './icon_tab_item.dart';
// import '../models/user.dart';
// import 'package:provider/provider.dart';

class FirebaseDialog extends StatefulWidget {
  const FirebaseDialog({Key? key}) : super(key: key);

  @override
  State<FirebaseDialog> createState() => _FirebaseDialogState();
}

class _FirebaseDialogState extends State<FirebaseDialog> {
  CloudAction _cloudAction = CloudAction.download;

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<User>(context, listen: false);
    // final canUpload = user.canUserUpload;

    final user = FirebaseAuth.instance.currentUser;
    if(user == null){
      signInWithGoogle().then((value) => Navigator.of(context).pop());
    }

    return AlertDialog(
      title: const Text("Cloud Storage"),
      content: IconTabBar(
        variable: _cloudAction,
        children: const [
          IconTabItem(
            value: CloudAction.download,
            iconData: CommunityMaterialIcons.cloud_download,
          ),
          IconTabItem(
            value: CloudAction.upload,
            iconData: CommunityMaterialIcons.cloud_upload,
          ),
        ],
        onTap: (downloadSelected) {
          setState(() {
            _cloudAction = downloadSelected;
          });
        },
        color: Colors.purple,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () {
            showDialog(
              barrierDismissible: false,
              barrierColor: null,
              context: context,
              builder: (context) => RewardedAdDialog(
                action: _cloudAction,
              ),
            ).then((_) => Navigator.of(context).pop());
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            reverseDuration: Duration.zero,
            switchInCurve: Curves.elasticOut,
            transitionBuilder: (child, animation) {
              return SlideTransition(
                child: child,
                position: Tween<Offset>(
                  begin: const Offset(0.0, -0.8),
                  end: Offset.zero,
                ).animate(animation),
              );
            },
            child: Text(
              _cloudAction.name,
              key: ValueKey(_cloudAction),
              style: const TextStyle(color: Colors.purple),
            ),
          ),
        ),
      ],
    );
  }

  // adProvider.isInitialized && adProvider.uploadRewardAdLoaded ? () {
  // adProvider.rewardedAd.show(onUserEarnedReward: (ad, reward) {
  // print("reward: $reward");
  // });
  // } : null,
}



// it is important that when the user either uploads or downloads data, the user.uuid is set the authenticated user uuid

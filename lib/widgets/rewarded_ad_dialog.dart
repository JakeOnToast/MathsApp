import 'package:flutter/material.dart';
import '../providers/admob_state_provider.dart';
import 'package:provider/provider.dart';
import '../models/cloud_action.dart';

class RewardedAdDialog extends StatelessWidget {
  final CloudAction action;
  const RewardedAdDialog({Key? key, required this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final adProvider = Provider.of<AdState>(context);
    final adReady = adProvider.uploadRewardAdLoaded;
    if (!adReady) {
      adProvider.loadUploadRewardedAd();
    }
    return AlertDialog(
      title: const Text("One Step Away!"),
      content: Text(action.adDialogMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.red),
          ),
        ),
        adReady
            ? TextButton(
                onPressed: () {

                  adProvider.rewardedAd.show(
                    onUserEarnedReward: (ad, item) =>
                        action.cloudFunction(context),
                  );
                },
                child: const Text("Watch"),
              )
            : const CircularProgressIndicator.adaptive(),
      ],
    );
  }
}

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState with ChangeNotifier {
  static const _useFakeAds = true;

  final Future<InitializationStatus> initialization;

  bool _isInitialized = false;
  bool _uploadRewardAdLoaded = false;
  bool _uploadRewardedAdLoading = false;
  late RewardedAd _rewardedAd;

  AdState(this.initialization) {
    initialization.then((value) {
      _isInitialized = true;
      notifyListeners();
      loadUploadRewardedAd();
    });
  }

  bool get isInitialized => _isInitialized;

  bool get uploadRewardAdLoaded => _uploadRewardAdLoaded;

  bool get isUploadRewardedAdLoading => _uploadRewardedAdLoading;

  RewardedAd get rewardedAd => _rewardedAd;

  String get uploadRewardAdUnitId {
    if (_useFakeAds) {
      return RewardedAd.testAdUnitId;
    } else {
      return Platform.isAndroid ? "ca-app-pub-1944113978730118/4939858223" : "ios code here";
    }
  }

  void loadUploadRewardedAd() {
    if (_uploadRewardedAdLoading || !_isInitialized) return;
    _uploadRewardedAdLoading = true;
    RewardedAd.load(
      adUnitId: RewardedAd.testAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          print('$ad loaded.');
          // Keep a reference to the ad so you can show it later.
          _rewardedAd = ad;
          _uploadRewardedAdLoading = false;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: null,
            onAdDismissedFullScreenContent: (RewardedAd ad) {
              ad.dispose();
              _uploadRewardAdLoaded = false;
            },
            onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
              print('$ad onAdFailedToShowFullScreenContent: $error');
              ad.dispose();
              _uploadRewardAdLoaded = false;
            },
            onAdImpression: (RewardedAd ad) => print('$ad impression occurred.'),
          );
          _uploadRewardAdLoaded = true;
          notifyListeners();
        },
        onAdFailedToLoad: (LoadAdError error) {
          _uploadRewardedAdLoading = false;
          // TODO add notifications to user. For example if the error is based
          //  on internet connection let them know
          print('RewardedAd failed to load: $error');
        },
      ),
    );
  }
}

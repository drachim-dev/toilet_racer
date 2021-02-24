import 'package:firebase_admob/firebase_admob.dart';
import 'package:toilet_racer/app/ad_manager.dart';

class AdService {
  Future<AdService> init() async {
    await FirebaseAdMob.instance.initialize(appId: AdManager.appId);
    return this;
  }

  //InterstitialAd _buildAd() {
  // return InterstitialAd(
  //   adUnitId: AdManager.interstitialAdUnitId,
  //   listener: (MobileAdEvent event) {
  //     if (event == MobileAdEvent.failedToLoad) {
  //       _ad..load();
  //     } else if (event == MobileAdEvent.closed) {
  //       _ad = _buildAd()..load();
  //     }
  //   },
  // );
  //}
}

class WebAdService implements AdService {
  @override
  Future<AdService> init() async {
    return this;
  }
}

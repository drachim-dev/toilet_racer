import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  Future<AdService> init() async {
    await MobileAds.instance.initialize();
    return this;
  }

  // InterstitialAd _buildAd() {
  //  return InterstitialAd(
  //      adUnitId: _interstitialAdUnitId,
  //      request: AdRequest(),
  //      listener: AdListener());
  // }

}

class WebAdService implements AdService {
  @override
  Future<AdService> init() async {
    return this;
  }
}

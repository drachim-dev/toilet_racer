import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:toilet_racer/app/ad_manager.dart';
import 'package:toilet_racer/app/constants.dart';

class AdService {
  final int _interval = kDefaultAdInterval;

  InterstitialAd _interstitialAd;
  int _counter = 0;

  Future<AdService> init() async {
    await MobileAds.instance.initialize();
    return this;
  }

  void load() {
    _interstitialAd ??= InterstitialAd(
      adUnitId: AdManager.interstitialAdUnitId,
      request: AdRequest(testDevices: AdManager.testDeviceId),
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          print('$NativeAd loaded.');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          _interstitialAd = null;
          load();
          print('$NativeAd failedToLoad: $error');
        },
        onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) {
          ad.dispose();
          _interstitialAd = null;
          load();
          print('$NativeAd onAdClosed.');
        },
        onApplicationExit: (Ad ad) => print('$NativeAd onApplicationExit.'),
      ),
    )..load();
  }

  /// Shows an ad every [interval] times or [force] to show an ad
  Future<void> mayShow({bool force = false}) async {
    if (force || ++_counter % _interval == 0) {
      _counter = 0;
      return _interstitialAd?.show();
    }
  }

  void dispose() {
    _interstitialAd.dispose();
  }
}

class WebAdService implements AdService {
  @override
  InterstitialAd _interstitialAd;

  @override
  int _interval;

  @override
  int _counter;

  @override
  Future<AdService> init() async {
    return this;
  }

  @override
  void dispose() {}

  @override
  void load() {}

  @override
  Future<void> mayShow({bool force = false}) async {}
}

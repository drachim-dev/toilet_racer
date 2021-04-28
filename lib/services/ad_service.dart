import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toilet_racer/app/ad_manager.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';

abstract class AdService {
  Future<AdService> init();

  void dispose();

  void load();

  /// May show an ad or [force] to show an ad
  Future<void> mayShow({bool force = false});
}

class MobileAdService implements AdService {
  final SharedPreferences _prefService = locator<SharedPreferences>();

  final int _interval = kDefaultAdInterval;
  int _counter = 0;

  InterstitialAd _interstitialAd;

  @override
  Future<AdService> init() async {
    await MobileAds.instance.initialize();
    _counter = _prefService.getInt(kPrefKeyAdIntervalCounter) ?? _counter;
    return this;
  }

  @override
  void dispose() {
    _interstitialAd.dispose();
  }

  @override
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

  /// Shows an ad every [_interval] times according to [_counter]
  /// or [force] to show an ad.
  @override
  Future<void> mayShow({bool force = false}) async {
    await _prefService.setInt(kPrefKeyAdIntervalCounter, ++_counter);

    if (force || _counter % _interval == 0) {
      _counter = 0;
      return _interstitialAd?.show();
    }
  }
}

class WebAdService implements AdService {
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

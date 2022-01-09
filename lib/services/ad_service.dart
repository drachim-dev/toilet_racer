import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toilet_racer/app/ad_manager.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';

const int maxFailedLoadAttempts = 3;

abstract class AdService {
  Future<AdService> init();

  void dispose();

  void load();

  /// May show an ad or [force] to show an ad
  Future<void> mayShow(
      {bool force = false, VoidCallback onAdClosed, VoidCallback onAdShown});
}

class MobileAdService implements AdService {
  final SharedPreferences _prefService = locator<SharedPreferences>();

  final int _interval = kDefaultAdInterval;
  int _counter = 0;

  InterstitialAd _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  @override
  Future<AdService> init() async {
    await MobileAds.instance.initialize();
    await MobileAds.instance.updateRequestConfiguration(
        RequestConfiguration(testDeviceIds: AdManager.testDeviceIds));

    _counter = _prefService.getInt(kPrefKeyAdIntervalCounter) ?? _counter;
    return this;
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
  }

  @override
  void load() {
    InterstitialAd.load(
        adUnitId: AdManager.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            debugPrint('$ad loaded');

            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
              load();
            }
          },
        ));
  }

  void _showInterstitialAd(
      {@required VoidCallback onAdClosed, @required VoidCallback onAdShown}) {
    if (_interstitialAd == null) {
      debugPrint('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {
        debugPrint('ad onAdShowedFullScreenContent.');
        onAdShown();
      },
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        debugPrint('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        onAdClosed();
        load();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        load();
      },
    );
    _interstitialAd.show();
    _interstitialAd = null;
  }

  /// Shows an ad every [_interval] times according to [_counter]
  /// or [force] to show an ad.
  @override
  Future<void> mayShow(
      {bool force = false,
      VoidCallback onAdClosed,
      VoidCallback onAdShown}) async {
    // disable ads in debug
    if (kDebugMode) return;

    await _prefService.setInt(kPrefKeyAdIntervalCounter, ++_counter);

    if (force || _counter % _interval == 0) {
      _counter = 0;
      _showInterstitialAd(onAdClosed: onAdClosed, onAdShown: onAdShown);
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
  Future<void> mayShow(
      {bool force = false,
      VoidCallback onAdClosed,
      VoidCallback onAdShown}) async {}
}

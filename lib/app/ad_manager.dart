import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  static String interstitialAdUnitId = String.fromEnvironment(
      'ADMOB_INTERSTITIAL_AD_ID',
      defaultValue: InterstitialAd.testAdUnitId);
}

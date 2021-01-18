import 'package:firebase_admob/firebase_admob.dart';

class AdManager {
  static String appId = String.fromEnvironment('ADMOB_APP_ID',
      defaultValue: FirebaseAdMob.testAppId);

  static String interstitialAdUnitId = String.fromEnvironment(
      'ADMOB_INTERSTITIAL_AD_ID',
      defaultValue: InterstitialAd.testAdUnitId);
}

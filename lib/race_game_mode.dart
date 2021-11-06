import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:toilet_racer/app/constants.dart';

import 'app/locator.dart';

class RaceGameMode {
  final SharedPreferences _prefService = locator<SharedPreferences>();

  final Random _random = Random();

  double get _currentHighscore =>
      _prefService.getDouble(kPrefKeyHighscore) ?? 0;

  bool inHelpMode() {
    return _currentHighscore < 5;
  }

  bool inGhostMode() {
    return _currentHighscore > 20.0 && _random.nextInt(10) == 0;
  }

  bool inSurpriseLevel() {
    return _currentHighscore > 20.0 && _random.nextInt(5) == 0;
  }
}

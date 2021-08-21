import 'package:shared_preferences/shared_preferences.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';

class GameService {
  final SharedPreferences _prefService = locator<SharedPreferences>();
  
  void getHighscores() {}

  Future<void> submitScore(double score) {
    _updateLocalScore(score);
  }

  /// Saves highscore in shared preferences to enable some features based on the user experience.
  void _updateLocalScore(double score) {
    if (score > (_prefService.getDouble(kPrefKeyHighscore) ?? 0)) {
      _prefService.setDouble(kPrefKeyHighscore, score);
    }
  }
}

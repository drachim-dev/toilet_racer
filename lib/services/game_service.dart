import 'package:shared_preferences/shared_preferences.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';

class GameService {
  final SharedPreferences _prefService = locator<SharedPreferences>();

  void getHighscores() {
    // TODO: get scores from firebase?
  }

  double getLocalHighscore() {
    return _prefService.getDouble(kPrefKeyGlobalHighscore) ?? 0;
  }

  Future<void> submitScore(double score) {
    // TODO: submit score to firebase?
    _updateLocalScore(score);
  }

  /// Saves highscore in shared preferences to enable some features based on the user experience.
  void _updateLocalScore(double score) {
    if (score > (getLocalHighscore())) {
      _prefService.setDouble(kPrefKeyGlobalHighscore, score);
    }
  }
}

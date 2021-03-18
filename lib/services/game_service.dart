import 'package:games_services/games_services.dart';

class GameService {
  bool _signedIn = false;
  bool get signedIn => _signedIn;

  Future<String> signIn() {
    return GamesServices.signIn()
        ..then((result) => _signedIn = result == 'success');
  }

  Future<void> showLeaderboards(final String leaderboardId) =>
      _signedIn ? GamesServices.showLeaderboards() : signIn();

  Future<String> showAchievements() =>
      _signedIn ? GamesServices.showAchievements() : signIn();

  Future<String> submitScore(final String leaderboardId, final int score) =>
      GamesServices.submitScore(
          score: Score(androidLeaderboardID: leaderboardId, value: score));

  Future<String> unlockAchievement(final String id) =>
      GamesServices.unlock(achievement: Achievement(androidID: id));

  Future<String> incrementAchievement(final String id,
          {final int stepsToIncrement = 1}) =>
      GamesServices.increment(
          achievement: Achievement(androidID: id, steps: stepsToIncrement));
}

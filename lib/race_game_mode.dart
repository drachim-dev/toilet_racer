import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/components/player.dart';
import 'package:toilet_racer/game/level.dart';

import 'app/locator.dart';

enum GameModeIdentifier { career, random }

extension GameModeIdentifierExtension on GameModeIdentifier {
  GameMode gameMode(int selectedLevel) {
    final _prefService = locator<SharedPreferences>();

    switch (this) {
      case GameModeIdentifier.career:
        final levelIndex = selectedLevel ??
            _prefService.getInt(kCareerLastUnlockedLevel) ??
            kCareerLastUnlockedLevelDefault;
        return CareerGameMode(levelIndex);
        break;
      case GameModeIdentifier.random:
        return RandomGameMode();
        break;
      default:
        return null;
    }
  }
}

abstract class GameMode {
  final SharedPreferences _prefService = locator<SharedPreferences>();

  final GameModeIdentifier identifier;

  GameMode(this.identifier);

  bool helpNeeded();
  bool ghostMode() => false;

  Level getLevel();
  Player getPlayer();

  void updateScoreAndAchievements(double score);
}

extension GameModeExtension on GameMode {
  bool get isCareer => identifier == GameModeIdentifier.career;
  bool get isRandom => identifier == GameModeIdentifier.random;
}

class CareerGameMode extends GameMode {
  Iterator<Level> levels;

  CareerGameMode(int selectedLevelIndex)
      : levels = Level.allLevels.skip(selectedLevelIndex).iterator..moveNext(),
        super(GameModeIdentifier.career);

  double get _currentHighscore =>
      _prefService.getDouble(kPrefKeyHighscore) ?? 0;

  /// Returns the next unlocked [Level].
  @override
  Level getLevel() {
    return levels.current;
  }

  @override
  Player getPlayer() {
    final playerIdentifier = PlayerIdentifier.fly;
    return playerIdentifier.player;
  }

  @override
  bool helpNeeded() => _currentHighscore < 5;

  @override
  void updateScoreAndAchievements(double score) {
    // Set level as won and unlock next level
    if (score >= levels.current.goal) {
      levels.moveNext();

      final levelIndex = Level.allLevels.indexOf(levels.current);
      _prefService.setInt(kCareerLastUnlockedLevel, levelIndex);
    }
  }
}

class RandomGameMode extends GameMode {
  RandomGameMode() : super(GameModeIdentifier.random);

  double get _currentHighscore =>
      _prefService.getDouble(kPrefKeyHighscore) ?? 0;

  @override
  bool helpNeeded() => _currentHighscore < 5;

  /// Returns a random unlocked [Level].
  @override
  Level getLevel() {
    final levelIndex = _prefService.getInt(kCareerLastUnlockedLevel) ??
        kCareerLastUnlockedLevelDefault;

    final unlockedLevels = Level.allLevels.take(levelIndex + 1).toList();
    final randomIndex = Random().nextInt(unlockedLevels.length);
    return unlockedLevels[randomIndex];
  }

  @override
  Player getPlayer() {
    if (ghostMode()) return PlayerIdentifier.larva.player;

    final allPlayers = PlayerIdentifier.values;
    final randomIndex = Random().nextInt(allPlayers.length);
    return allPlayers[randomIndex].player;
  }

  @override
  bool ghostMode() {
    return _currentHighscore > 20.0 && Random().nextInt(10) == 0;
  }

  @override
  void updateScoreAndAchievements(double score) {
    // TODO: implement updateScore
  }
}

import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/models/level.dart';
import 'package:toilet_racer/repos/level_repository.dart';
import 'package:toilet_racer/repos/map_repository.dart';

import 'app/locator.dart';

enum GameModeIdentifier { career, shuffle }

extension GameModeIdentifierExtension on GameModeIdentifier {
  GameMode gameMode(int? selectedLevel) {
    final _prefService = locator<SharedPreferences>();

    switch (this) {
      case GameModeIdentifier.career:
        final levelIndex =
            selectedLevel ?? _prefService.getInt(kPrefKeyUnlockedIndex) ?? 0;
        return CareerGameMode(selectedLevelIndex: levelIndex);
      case GameModeIdentifier.shuffle:
        return ShuffleGameMode();
    }
  }
}

abstract class GameMode {
  final SharedPreferences _prefService = locator<SharedPreferences>();
  final LevelRepository _levelRepository = locator<LevelRepository>();

  final GameModeIdentifier identifier;

  GameMode(this.identifier);

  double get globalHighscore =>
      _prefService.getDouble(kPrefKeyGlobalHighscore) ?? 0;

  bool get helpNeeded => globalHighscore < 5;
  bool get ghostMode => false;
  bool get canPlayNext;
  bool get hasCompleted => false;
  bool get animateNextLevel;

  String? get levelHelpText => null;
  Level getLevel();

  Future<bool> updateScoreAndAchievements(double score);
  bool shouldAskForReview() => false;

  void resetProgress() {}
}

extension GameModeExtension on GameMode {
  bool get isCareer => identifier == GameModeIdentifier.career;
  bool get isShuffle => identifier == GameModeIdentifier.shuffle;
}

class CareerGameMode extends GameMode {
  late Iterator<Level> _levelsIterator;

  CareerGameMode({required int selectedLevelIndex})
      : super(GameModeIdentifier.career) {
    if (hasCompleted) {
      resetProgress();
    } else {
      _init(selectedLevelIndex: selectedLevelIndex);
    }
  }

  void _init({required int selectedLevelIndex}) {
    _levelsIterator = _levelRepository
        .getAllLevels()
        .skip(selectedLevelIndex)
        .iterator
      ..moveNext();
  }

  @override
  bool get canPlayNext {
    final allLevels = _levelRepository.getAllLevels();
    final nextLevelIndex =
        allLevels.indexWhere((lvl) => lvl.id == _levelsIterator.current.id) + 1;

    return nextLevelIndex < allLevels.length &&
        allLevels[nextLevelIndex].status == LevelStatus.unlocked;
  }

  @override
  bool get hasCompleted {
    final unlockedLevelIndexd = _prefService.getInt(kPrefKeyUnlockedIndex) ?? 0;
    return unlockedLevelIndexd > _levelRepository.getAllLevels().length - 1;
  }

  @override
  bool get animateNextLevel => true;

  @override
  String? get levelHelpText => _levelsIterator.current.helpText;

  /// Returns the next unlocked [Level].
  @override
  Level getLevel() {
    // Move to next level; If there is no next, reset to first level
    if (_levelsIterator.current.hasWon && !_levelsIterator.moveNext()) {
      _levelsIterator.moveNext();
    }

    return _levelsIterator.current;
  }

  @override
  Future<bool> updateScoreAndAchievements(double score) async {
    if (score >= _levelsIterator.current.goal) {
      final allLevels = _levelRepository.getAllLevels();

      // Set level to won
      _levelsIterator.current.status = LevelStatus.won;

      final nextLevelIndex =
          allLevels.indexWhere((lvl) => lvl.id == _levelsIterator.current.id) +
              1;
      final unlockedLevelIndex =
          _prefService.getInt(kPrefKeyUnlockedIndex) ?? 0;

      // Update last unlocked level index
      if (nextLevelIndex > unlockedLevelIndex &&
          _levelsIterator.current != allLevels.last) {
        await _prefService.setInt(kPrefKeyUnlockedIndex, nextLevelIndex);
      }
    }

    return score >= _levelsIterator.current.goal;
  }

  @override
  void resetProgress() {
    _prefService.setInt(kPrefKeyUnlockedIndex, 0);
    _init(selectedLevelIndex: 0);
  }

  @override
  bool shouldAskForReview() {
    final MapRepository _mapRepository = locator<MapRepository>();

    var timesAskedForReview =
        _prefService.getInt(kPrefKeyTimesAskedForReview) ?? 0;
    final unlockedLevelIndex = _prefService.getInt(kPrefKeyUnlockedIndex) ?? 0;
    final completedLastMap =
        unlockedLevelIndex % _mapRepository.getAllMaps.length == 0;

    return timesAskedForReview < kMaxTimesAskForReview &&
        (unlockedLevelIndex == kMinProgressAskForReview || completedLastMap);
  }
}

class ShuffleGameMode extends GameMode {
  ShuffleGameMode() : super(GameModeIdentifier.shuffle);

  @override
  bool get ghostMode {
    return globalHighscore > 20.0 && Random().nextInt(10) == 0;
  }

  @override
  bool get canPlayNext => true;

  @override
  bool get animateNextLevel => false;

  /// Returns a random unlocked [Level].
  @override
  Level getLevel() {
    final unlockedLevelIndex = _prefService.getInt(kPrefKeyUnlockedIndex) ?? 0;

    final unlockedLevels =
        _levelRepository.getAllLevels().take(unlockedLevelIndex + 1);
    final randomIndex = Random().nextInt(unlockedLevels.length);
    return unlockedLevels.elementAt(randomIndex);
  }

  @override
  Future<bool> updateScoreAndAchievements(double score) async {
    // TODO: implement updateScore
    return false;
  }

}

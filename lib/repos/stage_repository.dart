import 'package:shared_preferences/shared_preferences.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';
import 'package:toilet_racer/app/utils.dart';
import 'package:toilet_racer/models/achievement.dart';
import 'package:toilet_racer/models/level.dart';

import '../generated/l10n.dart';
import '../models/stage.dart';
import 'map_repository.dart';
import 'player_repository.dart';

class StageRepository {
  final MapRepository _mapRepository = locator<MapRepository>();
  final PlayerRepository _playerRepository = locator<PlayerRepository>();
  final SharedPreferences _prefsService = locator<SharedPreferences>();

  List<Stage> getAllStages() {
    final maps = _mapRepository.getAllMaps;
    final players = _playerRepository.getAllPlayers();
    final unlockedIndex = _prefsService.getInt(kPrefKeyUnlockedLevelIndex) ?? 0;

    
    var levelIndex = 0;
    final stages = players.map((player) {
      final stageIndex = players.indexOf(player);

      /// Minimum score required to win the level
      final goal = kInitialGoal + (stageIndex * 2.5);
      final helpText = S.current.overlayHelpSurviveText(goal.formatDecimal(2));

      final levels = <Level>[];
      for (var map in maps) {
        var status = unlockedIndex >= levelIndex
            ? LevelStatus.unlocked
            : LevelStatus.locked;

        final level = Level(
            id: levelIndex++,
            map: map,
            player: player,
            status: status,
            helpText: levelIndex == 0 ? helpText : null,
            goal: goal);
        levels.add(level);
      }

      return Stage(
        stageIndex,
        name: 'Lorem',
        levels: levels,
        achievements: [Achievement(type: AchievementType.player, id: 1)],
      );
    }).toList();

    return stages;
  }

  Stage getStage(int index) {
    return getAllStages().firstWhere((stage) => stage.index == index);
  }

  Stage getStageByLevel(int levelId) {
    return getAllStages().firstWhere(
        (stage) => stage.levels.any((level) => level.id == levelId));
  }

  List<Level> getAllLevels() {
    return getAllStages().expand((stage) => stage.levels).toList();
  }

  Level getLevel(int id) {
    return getAllLevels().firstWhere((level) => level.id == id);
  }
}

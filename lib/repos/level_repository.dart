import 'package:shared_preferences/shared_preferences.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';
import 'package:toilet_racer/app/utils.dart';
import 'package:toilet_racer/generated/l10n.dart';
import 'package:toilet_racer/models/level.dart';

import 'map_repository.dart';
import 'player_repository.dart';

class LevelRepository {
  final MapRepository _mapRepository = locator<MapRepository>();
  final PlayerRepository _playerRepository = locator<PlayerRepository>();
  final SharedPreferences _prefsService = locator<SharedPreferences>();

  List<Level> getAllLevels() {
    final maps = _mapRepository.getAllMaps();
    final players = _playerRepository.getAllPlayers();
    final unlockedIndex = _prefsService.getInt(kPrefKeyUnlockedIndex) ?? 0;

    final levels = <Level>[];
    var levelIndex = 0;
    players.asMap().forEach((playerIndex, player) {
      for (var map in maps) {
        var status = unlockedIndex >= levelIndex
            ? LevelStatus.unlocked
            : LevelStatus.locked;

        // increase goal by 2.5 sec for each iteration
        final goal = 15.0 + playerIndex * 2.5;

        // set help text for each first map
        String? helpText;
        if (maps.first == map) {
          helpText = S.current.overlayHelpSurviveText(goal.formatDecimal(2));
        }

        var level = Level(
            id: levelIndex++,
            map: map,
            player: player,
            helpText: helpText,
            goal: goal,
            status: status);
        levels.add(level);
      }
    });

    return levels;
  }
}

import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/components/player.dart';
import 'package:toilet_racer/game/level.dart';

import 'app/locator.dart';

enum GameModeIdentifier { random, career }

abstract class GameMode {
  final SharedPreferences _prefService = locator<SharedPreferences>();

  final GameModeIdentifier identifier;

  GameMode(this.identifier);

  bool helpNeeded();
  bool ghostMode() => false;

  Level getLevel();
  Player getPlayer();
}

class RandomGameMode extends GameMode {
  final Random _random = Random();

  RandomGameMode() : super(GameModeIdentifier.random);

  double get _currentHighscore =>
      _prefService.getDouble(kPrefKeyHighscore) ?? 0;

  @override
  bool helpNeeded() => _currentHighscore < 5;

  @override
  Level getLevel() {
    final i = Random().nextInt(Level.levels.length);
    return Level.levels[i];
  }

  @override
  Player getPlayer() {
    if (ghostMode()) return PlayerIdentifier.larva.player;

    final allPlayers = PlayerIdentifier.values;
    final i = Random().nextInt(allPlayers.length);
    return allPlayers[i].player;
  }

  @override
  bool ghostMode() {
    return _currentHighscore > 20.0 && _random.nextInt(10) == 0;
  }
}

import 'package:flame/components.dart';

import 'map.dart';
import 'player.dart';

class Level {
  /// This is the reference width to calculate the world scaling factor.
  static const double kReferenceWidth = 320.0;

  final int id;
  final GameMap map;
  final Player player;

  final String? helpText;

  /// Minimum score required to win the level
  final double goal;

  final double? highscore;

  LevelStatus status;

  Level({
    required this.id,
    required this.map,
    required this.player,
    this.helpText,
    required this.goal,
    this.highscore,
    required this.status,
  });

  Vector2 get startPosition => map.track.bottomPosition;
}

enum LevelStatus { hidden, locked, unlocked, won }

extension LevelExtension on Level {
  bool get isHidden => status == LevelStatus.hidden;
  bool get hasWon => status == LevelStatus.won;
}
/* 
  TODO: Not used yet
  bool get isLocked => status == LevelStatus.locked;
  bool get isUnlocked => status == LevelStatus.unlocked;
   */
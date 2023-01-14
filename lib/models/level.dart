import 'package:flame/components.dart';

import 'map.dart';
import 'player.dart';

class Level {
  /// This is the reference width to calculate the world scaling factor.
  static const double kReferenceWidth = 320.0;

  final int id;
  final GameMap map;
  final Player player;

  final double? highscore;

  LevelStatus status;

  String? helpText;

  final double goal;

  Level({
    required this.id,
    required this.map,
    required this.player,
    this.highscore,
    required this.status,
    required this.goal,
    this.helpText,
  });

  Vector2 get startPosition => map.track.bottomPosition;
}

enum LevelStatus { hidden, locked, unlocked, won }

extension LevelExtension on Level {
  bool get isHidden => status == LevelStatus.hidden;
  bool get isLocked => status == LevelStatus.locked;
  bool get isUnlocked => status == LevelStatus.unlocked;
  bool get hasWon => status == LevelStatus.won;
}
/* 
  TODO: Not used yet
  bool get isLocked => status == LevelStatus.locked;
  bool get isUnlocked => status == LevelStatus.unlocked;
   */
import 'dart:math';

import 'package:toilet_racer/models/achievement.dart';

import '../app/constants.dart';
import 'level.dart';

class Stage {
  /// Index of stage starting with 0
  final int index;

  final String name;

  final List<Level> levels;

  final List<Achievement> achievements;

  Stage(
    this.index, {
    required this.name,
    required this.levels,
    required this.achievements,
  });

  /// Coins will be doubled stage by stage starting with [minimumCoints] for first stage
  int get coins => max(kMinimumCoins, kMinimumCoins * 2 * index);
}

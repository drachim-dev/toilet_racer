class Achievement {
  final String? name;
  final AchievementType type;
  final AchievementState state;
  final int id;

  Achievement(
      {this.name,
      required this.type,
      this.state = AchievementState.locked,
      required this.id});
}

enum AchievementType { player, powerUp, map }

enum AchievementState { locked, unlocked }

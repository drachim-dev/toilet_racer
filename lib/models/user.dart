import 'package:flutter/widgets.dart';

class User {
  final UniqueKey id = UniqueKey();

  Set<UniqueKey> unlockedPlayers = {};
  Set<UniqueKey> unlockedMaps = {};
}

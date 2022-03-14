import 'package:flutter/widgets.dart';

import 'track.dart';

class GameMap {
  final UniqueKey id = UniqueKey();
  final String name;
  final String filePath;
  final Track track;

  GameMap({required this.name, required this.filePath, required this.track});
}

import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';

abstract class Track {
  static const maxSizeOnScreen = 600.0;

  /// The zone in the image that contains the relevant track for the level.
  Rect get zone;
  List<Vector2> get innerBoundary;
  List<Vector2> get outerBoundary;
}

class EllipseTrack extends Track {
  static const int _numEdges = 50;
  Vector2 innerCenter;
  Radius innerRadii;
  Vector2 outerCenter;
  Radius outerRadii;

  EllipseTrack(
      {@required this.innerCenter,
      @required this.innerRadii,
      @required this.outerCenter,
      @required this.outerRadii})
      : assert(innerCenter != null),
        assert(innerRadii != null),
        assert(outerCenter != null),
        assert(outerRadii != null);

  @override
  List<Vector2> get innerBoundary =>
      calculateVertices(innerCenter, innerRadii, _numEdges);

  @override
  List<Vector2> get outerBoundary =>
      calculateVertices(outerCenter, outerRadii, _numEdges);

  @override
  Rect get zone => Rect.fromCenter(
      center: outerCenter.toOffset(),
      width: outerRadii.x * 2,
      height: outerRadii.y * 2);

  static List<Vector2> calculateVertices(
      Vector2 center, Radius radii, int count) {
    final vertices = <Vector2>[];

    for (var i = 0; i < count; i++) {
      final t = i * 2 * math.pi / count;
      final vertex =
          Vector2(radii.x * math.cos(t), radii.y * math.sin(t)) + center;
      vertices.add(vertex);
    }

    return vertices;
  }
}

class Level {
  static Level toilet3 = Level(
      filePath: 'roads/toilet3.webp',
      startPosition: Vector2(362, 906),
      track: EllipseTrack(
          innerCenter: Vector2(366, 765),
          innerRadii: Radius.elliptical(100, 105),
          outerCenter: Vector2(366, 755),
          outerRadii: Radius.elliptical(160, 190)));

  final String filePath;
  final Track track;

  /// The start position of the player
  final Vector2 startPosition;

  Image image;

  Level(
      {@required this.filePath,
      @required this.track,
      @required this.startPosition})
      : assert(filePath != null),
        assert(track != null),
        assert(startPosition != null);

  Future<void> onLoad() async {
    image = await Flame.images.load(filePath);
  }
}

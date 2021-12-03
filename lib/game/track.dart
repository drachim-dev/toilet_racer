import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

abstract class Track {
  static const maxSizeOnScreen = 400.0;

  /// The zone in the image that contains the relevant track for the level.
  Rect get zone;
  List<Vector2> get innerBoundary;
  List<Vector2> get outerBoundary;
}

class EllipseTrack extends Track {
  static const int _numEdges = 50;
  Vector2 innerCenter, outerCenter;
  Radius innerRadii, outerRadii;

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

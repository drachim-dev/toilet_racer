import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/components.dart';

class Track {
  static const maxSizeOnScreen = 400.0;

  /// The boundaries of the track.
  final Boundary innerBoundary;
  final Boundary outerBoundary;

  Track({required this.innerBoundary, required this.outerBoundary});

  List<Vector2> get middleBoundary =>
      _getMiddleVertices(innerBoundary.vertices, outerBoundary.vertices);

  Vector2 get bottomPosition =>
      middleBoundary.reduce((currentVector, nextVector) =>
          currentVector.y > nextVector.y ? currentVector : nextVector);

  /// calculates the middle vertices between [first] and [second]
  /// [first] and [second] must be of equal size
  List<Vector2> _getMiddleVertices(List<Vector2> first, List<Vector2> second) {

    if (first.length != second.length) {
      throw RangeError(
          'first (size: ${first.length}) != second (size: ${second.length})');
    }

    var middle = List<Vector2>.from(first);
    for (var i = 0; i < first.length; i++) {
      middle[i].add(second[i]);
      middle[i].scale(0.5);
    }
    return middle;
  }

  Rect get zone {
    final double minX = outerBoundary.vertices
        .reduce((currentVector, nextVector) =>
            currentVector.x < nextVector.x ? currentVector : nextVector)
        .x;
    final double maxX = outerBoundary.vertices
        .reduce((currentVector, nextVector) =>
            currentVector.x > nextVector.x ? currentVector : nextVector)
        .x;
    final double minY = outerBoundary.vertices
        .reduce((currentVector, nextVector) =>
            currentVector.y < nextVector.y ? currentVector : nextVector)
        .y;
    final double maxY = outerBoundary.vertices
        .reduce((currentVector, nextVector) =>
            currentVector.y > nextVector.y ? currentVector : nextVector)
        .y;

    return Rect.fromLTRB(minX, minY, maxX, maxY);
  }
}

abstract class Boundary {
  List<Vector2> get vertices;
}

class EllipseBoundary extends Boundary {
  static const int _numEdges = 50;

  Vector2 center;
  Radius radii;

  EllipseBoundary({required this.center, required this.radii});

  @override
  List<Vector2> get vertices => _calculateVertices(center, radii, _numEdges);

  static List<Vector2> _calculateVertices(
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

class PolygonBoundary extends Boundary {
  @override
  List<Vector2> vertices;

  PolygonBoundary({required this.vertices});
}

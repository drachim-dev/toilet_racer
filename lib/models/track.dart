import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/components.dart';

class Track {
  static const maxSizeOnScreen = 400.0;

  /// The boundaries of the track.
  final Boundary innerBoundary;
  final Boundary outerBoundary;

  Track({required this.innerBoundary, required this.outerBoundary});

  List<Vector2>? get middleBoundary {
    if (innerBoundary.vertices.length == outerBoundary.vertices.length) {
      return _getMiddleVertices(innerBoundary.vertices, outerBoundary.vertices);
    }

    return null;
  }

  Vector2 get bottomPosition {
    if (middleBoundary == null) {
      final Vector2 innerMaxY = innerBoundary.maxY();
      final Vector2 outerMaxY = outerBoundary.maxY();

      return innerMaxY + outerMaxY
        ..scale(0.5);
    }

    return middleBoundary!.reduce((currentVector, nextVector) =>
        currentVector.y > nextVector.y ? currentVector : nextVector);
  }

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
    final double minX = outerBoundary.minX().x;
    final double maxX = outerBoundary.maxX().x;
    final double minY = outerBoundary.minY().y;
    final double maxY = outerBoundary.maxY().y;

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

extension VerticesExtension on Boundary {
  Vector2 minX() => vertices.reduce((currentVector, nextVector) =>
      currentVector.x < nextVector.x ? currentVector : nextVector);

  Vector2 maxX() => vertices.reduce((currentVector, nextVector) =>
      currentVector.x > nextVector.x ? currentVector : nextVector);

  Vector2 minY() => vertices.reduce((currentVector, nextVector) =>
      currentVector.y < nextVector.y ? currentVector : nextVector);

  Vector2 maxY() => vertices.reduce((currentVector, nextVector) =>
      currentVector.y > nextVector.y ? currentVector : nextVector);
}

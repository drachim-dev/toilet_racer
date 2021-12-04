import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

abstract class Track {
  static const maxSizeOnScreen = 400.0;

  /// The boundaries of the track.
  List<Vector2> get innerBoundary;
  List<Vector2> get outerBoundary;
  List<Vector2> get middleBoundary;

  /// A position on the middleBoundary which may be used as the startPosition for the player.
  Vector2 get bottomPosition;

  /// The zone in the image that contains the relevant track for the level.
  Rect get zone;
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
      _calculateVertices(innerCenter, innerRadii, _numEdges);

  @override
  List<Vector2> get outerBoundary =>
      _calculateVertices(outerCenter, outerRadii, _numEdges);

  @override
  List<Vector2> get middleBoundary =>
      _getMiddleVertices(innerBoundary, outerBoundary);

  @override
  Vector2 get bottomPosition =>
      middleBoundary.reduce((currentVector, nextVector) =>
          currentVector.y > nextVector.y ? currentVector : nextVector);

  @override
  Rect get zone => Rect.fromCenter(
      center: outerCenter.toOffset(),
      width: outerRadii.x * 2,
      height: outerRadii.y * 2);

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

  /// calculates the middle vertices between [first] and [second]
  /// [first] and [second] must be of equal size
  static List<Vector2> _getMiddleVertices(
      List<Vector2> first, List<Vector2> second) {
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
}

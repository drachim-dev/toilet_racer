import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'dart:math' as math;

abstract class Track {
  /// The zone in the image that contains the relevant track for the game.
  Rect get zone;
  List<Vector2> get innerBoundary;
  List<Vector2> get outerBoundary;
}

class EllipseTrack extends Track {
  Vector2 innerCenter;
  Radius innerRadii;
  Vector2 outerCenter;
  Radius outerRadii;

  EllipseTrack(
      {this.innerCenter, this.innerRadii, this.outerCenter, this.outerRadii});

  @override
  List<Vector2> get innerBoundary =>
      calculateVertices(innerCenter, innerRadii, 50);

  @override
  List<Vector2> get outerBoundary =>
      calculateVertices(outerCenter, outerRadii, 50);

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
      filePath: 'roads/toilet3.jpg',
      startPosition: Vector2(362, 906),
      track: EllipseTrack(
          innerCenter: Vector2(366, 765),
          innerRadii: Radius.elliptical(100, 105),
          outerCenter: Vector2(366, 755),
          outerRadii: Radius.elliptical(160, 190)));

  final Track track;
  final Vector2 startPosition;
  final String filePath;

  Image image;

  Level({this.filePath, this.startPosition, this.track});

  Future<void> onLoad() async {
    image = await Flame.images.load(filePath);
  }
}

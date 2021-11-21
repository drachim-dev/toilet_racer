import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
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

class Level {
  /// The first designed reference level.
  /// The size of this levels track is used to calculate the world scaling factor.
  static Level toilet0 = Level(
      status: LevelStatus.hidden,
      filePath: 'level/toilet0.webp',
      startPosition: Vector2(362, 906),
      track: EllipseTrack(
          innerCenter: Vector2(366, 765),
          innerRadii: Radius.elliptical(100, 105),
          outerCenter: Vector2(366, 755),
          outerRadii: Radius.elliptical(160, 190)));

  static Level toilet1 = Level(
      status: LevelStatus.unlocked,
      filePath: 'level/toilet1.webp',
      startPosition: Vector2(767, 1695),
      track: EllipseTrack(
          innerCenter: Vector2(767, 1415),
          innerRadii: Radius.elliptical(200, 210),
          outerCenter: Vector2(767, 1405),
          outerRadii: Radius.elliptical(320, 360)));

  static Level toiletPaper = Level(
      filePath: 'level/toilet_paper.webp',
      startPosition: Vector2(725, 1330),
      track: EllipseTrack(
          innerCenter: Vector2(730, 1162),
          innerRadii: Radius.elliptical(93, 98),
          outerCenter: Vector2(730, 1155),
          outerRadii: Radius.elliptical(220, 260)));

  static Level toiletTrain = Level(
      filePath: 'level/toilet_train.webp',
      startPosition: Vector2(715, 1725),
      track: EllipseTrack(
          innerCenter: Vector2(715, 1520),
          innerRadii: Radius.elliptical(145, 165),
          outerCenter: Vector2(715, 1520),
          outerRadii: Radius.elliptical(245, 256)));

  static Level toiletRed = Level(
      filePath: 'level/toilet_red.webp',
      startPosition: Vector2(784, 1943),
      track: EllipseTrack(
          innerCenter: Vector2(784, 1632),
          innerRadii: Radius.elliptical(194, 238),
          outerCenter: Vector2(784, 1648),
          outerRadii: Radius.elliptical(320, 380)));

  static Level donut1 = Level(
      filePath: 'level/donut1.webp',
      startPosition: Vector2(500, 915),
      track: EllipseTrack(
          innerCenter: Vector2(505, 800),
          innerRadii: Radius.elliptical(75, 70),
          outerCenter: Vector2(500, 795),
          outerRadii: Radius.elliptical(185, 185)));

  static Level floatingPool = Level(
      filePath: 'level/floating_pool.webp',
      startPosition: Vector2(966, 1675),
      track: EllipseTrack(
          innerCenter: Vector2(1000, 1368),
          innerRadii: Radius.elliptical(198, 198),
          outerCenter: Vector2(996, 1368),
          outerRadii: Radius.elliptical(455, 455)));

  static Level footBath = Level(
      filePath: 'level/foot_bath.webp',
      startPosition: Vector2(780, 1786),
      track: EllipseTrack(
          innerCenter: Vector2(798, 1337),
          innerRadii: Radius.elliptical(365, 365),
          outerCenter: Vector2(818, 1352),
          outerRadii: Radius.elliptical(560, 560)));

  static Level vinyl = Level(
      filePath: 'level/vinyl.webp',
      startPosition: Vector2(934, 1209),
      track: EllipseTrack(
          innerCenter: Vector2(934, 938),
          innerRadii: Radius.elliptical(139, 139),
          outerCenter: Vector2(934, 938),
          outerRadii: Radius.elliptical(375, 375)));

  static Level friedEgg = Level(
      filePath: 'level/fried_egg.webp',
      startPosition: Vector2(380, 1838),
      track: EllipseTrack(
          innerCenter: Vector2(437, 1591),
          innerRadii: Radius.elliptical(146, 155),
          outerCenter: Vector2(417, 1615),
          outerRadii: Radius.elliptical(310, 320)));

  static Level abstractEye = Level(
      filePath: 'level/abstract_eye.webp',
      startPosition: Vector2(667, 1422),
      track: EllipseTrack(
          innerCenter: Vector2(695, 1040),
          innerRadii: Radius.elliptical(235, 235),
          outerCenter: Vector2(690, 1120),
          outerRadii: Radius.elliptical(525, 465)));

  static Level candles = Level(
      filePath: 'level/candles.webp',
      startPosition: Vector2(710, 1241),
      track: EllipseTrack(
          innerCenter: Vector2(715, 1108),
          innerRadii: Radius.elliptical(66, 60),
          outerCenter: Vector2(719, 1112),
          outerRadii: Radius.elliptical(218, 218)));

  static Level coffee = Level(
      filePath: 'level/coffee.webp',
      startPosition: Vector2(684, 1670),
      track: EllipseTrack(
          innerCenter: Vector2(688, 1269),
          innerRadii: Radius.elliptical(325, 325),
          outerCenter: Vector2(691, 1271),
          outerRadii: Radius.elliptical(471, 471)));

  static List<Level> allLevels = [
    toilet1,
    toiletPaper,
    toiletTrain,
    toiletRed,
    donut1,
    floatingPool,
    footBath,
    vinyl,
    friedEgg,
    abstractEye,
    candles,
    coffee,
  ];
  LevelStatus status;

  /// Minimum score required to win the level
  final double goal;

  final String filePath;
  final Track track;

  /// The start position of the player
  final Vector2 startPosition;

  Image image;

  Level(
      {this.status = LevelStatus.locked,
      this.goal = 25,
      @required this.filePath,
      @required this.track,
      @required this.startPosition})
      : assert(status != null),
        assert(goal != null),
        assert(filePath != null),
        assert(track != null),
        assert(startPosition != null);

  Future<void> onLoad() async {
    image = await Flame.images.load(filePath);
  }
}

enum LevelStatus { hidden, locked, unlocked, won }

extension LevelExtension on Level {
  bool get isHidden => status == LevelStatus.hidden;

/* 
  TODO: Not used yet
  bool get isLocked => status == LevelStatus.locked;
  bool get isUnlocked => status == LevelStatus.unlocked;
  bool get hasWon => status == LevelStatus.won; */
}

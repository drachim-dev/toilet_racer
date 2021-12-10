import 'dart:ui';

import 'package:flame/components.dart';
import 'package:toilet_racer/models/track.dart';
import 'package:toilet_racer/models/map.dart';

class MapRepository {
  static final _toilet1 = GameMap(
      name: 'Need a seat',
      filePath: 'level/toilet1.webp',
      track: EllipseTrack(
          innerCenter: Vector2(767, 1415),
          innerRadii: Radius.elliptical(200, 210),
          outerCenter: Vector2(767, 1405),
          outerRadii: Radius.elliptical(320, 360)));

  static final _toiletPaper = GameMap(
      name: 'Paper Guy',
      filePath: 'level/toilet_paper.webp',
      track: EllipseTrack(
          innerCenter: Vector2(730, 1162),
          innerRadii: Radius.elliptical(93, 98),
          outerCenter: Vector2(730, 1155),
          outerRadii: Radius.elliptical(220, 260)));

  static final _toiletTrain = GameMap(
      name: 'Trip to toilet',
      filePath: 'level/toilet_train.webp',
      track: EllipseTrack(
          innerCenter: Vector2(715, 1520),
          innerRadii: Radius.elliptical(145, 165),
          outerCenter: Vector2(715, 1520),
          outerRadii: Radius.elliptical(245, 256)));

  static final _toiletRed = GameMap(
      name: 'Red wedding',
      filePath: 'level/toilet_red.webp',
      track: EllipseTrack(
          innerCenter: Vector2(784, 1632),
          innerRadii: Radius.elliptical(194, 238),
          outerCenter: Vector2(784, 1648),
          outerRadii: Radius.elliptical(320, 380)));

  static final _donut1 = GameMap(
      name: 'Let me taste it',
      filePath: 'level/donut1.webp',
      track: EllipseTrack(
          innerCenter: Vector2(505, 800),
          innerRadii: Radius.elliptical(75, 70),
          outerCenter: Vector2(500, 795),
          outerRadii: Radius.elliptical(185, 185)));

  static final _floatingPool = GameMap(
      name: 'Floating',
      filePath: 'level/floating_pool.webp',
      track: EllipseTrack(
          innerCenter: Vector2(1000, 1368),
          innerRadii: Radius.elliptical(198, 198),
          outerCenter: Vector2(996, 1368),
          outerRadii: Radius.elliptical(455, 455)));

  static final _footBath = GameMap(
      name: 'Footbath',
      filePath: 'level/foot_bath.webp',
      track: EllipseTrack(
          innerCenter: Vector2(798, 1337),
          innerRadii: Radius.elliptical(365, 365),
          outerCenter: Vector2(818, 1352),
          outerRadii: Radius.elliptical(560, 560)));

  static final _vinyl = GameMap(
      name: 'Turn it up',
      filePath: 'level/vinyl.webp',
      track: EllipseTrack(
          innerCenter: Vector2(934, 938),
          innerRadii: Radius.elliptical(139, 139),
          outerCenter: Vector2(934, 938),
          outerRadii: Radius.elliptical(375, 375)));

  static final _friedEgg = GameMap(
      name: 'Fried egg',
      filePath: 'level/fried_egg.webp',
      track: EllipseTrack(
          innerCenter: Vector2(437, 1591),
          innerRadii: Radius.elliptical(146, 155),
          outerCenter: Vector2(417, 1615),
          outerRadii: Radius.elliptical(310, 320)));

  static final _robotVacuumCleaner = GameMap(
      name: 'Robot',
      filePath: 'level/robot_vacuum_cleaner.webp',
      track: EllipseTrack(
          innerCenter: Vector2(672, 1235),
          innerRadii: Radius.elliptical(120, 118),
          outerCenter: Vector2(713, 1319),
          outerRadii: Radius.elliptical(423, 422)));

  static final _trafficSign = GameMap(
      name: 'Slow down',
      filePath: 'level/traffic_sign.webp',
      track: EllipseTrack(
          innerCenter: Vector2(919, 1605),
          innerRadii: Radius.elliptical(384, 380),
          outerCenter: Vector2(922, 1610),
          outerRadii: Radius.elliptical(570, 578)));

  static final _tubDrain = GameMap(
      name: 'Drain',
      filePath: 'level/tub_drain.webp',
      track: EllipseTrack(
          innerCenter: Vector2(665, 1222),
          innerRadii: Radius.elliptical(170, 170),
          outerCenter: Vector2(665, 1222),
          outerRadii: Radius.elliptical(280, 280)));

  static final _abstractEye = GameMap(
      name: 'Abstract eye',
      filePath: 'level/abstract_eye.webp',
      track: EllipseTrack(
          innerCenter: Vector2(695, 1040),
          innerRadii: Radius.elliptical(235, 235),
          outerCenter: Vector2(690, 1120),
          outerRadii: Radius.elliptical(525, 465)));

  static final _candles = GameMap(
      name: 'Romantic Evening',
      filePath: 'level/candles.webp',
      track: EllipseTrack(
          innerCenter: Vector2(715, 1108),
          innerRadii: Radius.elliptical(66, 60),
          outerCenter: Vector2(719, 1112),
          outerRadii: Radius.elliptical(218, 218)));

  static final _coffee = GameMap(
      name: 'Time for coffee',
      filePath: 'level/coffee.webp',
      track: EllipseTrack(
          innerCenter: Vector2(688, 1273),
          innerRadii: Radius.elliptical(314, 320),
          outerCenter: Vector2(693, 1273),
          outerRadii: Radius.elliptical(472, 472)));

  final List<GameMap> _allMaps = [
    _toilet1,
    _toiletPaper,
    _toiletTrain,
    _toiletRed,
    _donut1,
    _floatingPool,
    _footBath,
    _vinyl,
    _friedEgg,
    _trafficSign,
    _tubDrain,
    _robotVacuumCleaner,
    _abstractEye,
    _candles,
    _coffee,
  ];

  List<GameMap> getAllMaps() {
    return _allMaps;
  }
}

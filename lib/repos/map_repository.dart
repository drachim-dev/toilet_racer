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
          innerRadii: const Radius.elliptical(200, 210),
          outerCenter: Vector2(767, 1405),
          outerRadii: const Radius.elliptical(320, 360)));

  static final _toiletPaper = GameMap(
      name: 'Paper Guy',
      filePath: 'level/toilet_paper.webp',
      track: EllipseTrack(
          innerCenter: Vector2(730, 1162),
          innerRadii: const Radius.elliptical(93, 98),
          outerCenter: Vector2(730, 1155),
          outerRadii: const Radius.elliptical(220, 260)));

  static final _toiletTrain = GameMap(
      name: 'Trip to toilet',
      filePath: 'level/toilet_train.webp',
      track: EllipseTrack(
          innerCenter: Vector2(715, 1520),
          innerRadii: const Radius.elliptical(145, 165),
          outerCenter: Vector2(715, 1520),
          outerRadii: const Radius.elliptical(245, 256)));

  static final _toiletRed = GameMap(
      name: 'Red wedding',
      filePath: 'level/toilet_red.webp',
      track: EllipseTrack(
          innerCenter: Vector2(784, 1632),
          innerRadii: const Radius.elliptical(194, 238),
          outerCenter: Vector2(784, 1648),
          outerRadii: const Radius.elliptical(320, 380)));

  static final _donut1 = GameMap(
      name: 'Let me taste it',
      filePath: 'level/donut1.webp',
      track: EllipseTrack(
          innerCenter: Vector2(505, 800),
          innerRadii: const Radius.elliptical(75, 70),
          outerCenter: Vector2(500, 795),
          outerRadii: const Radius.elliptical(185, 185)));

  static final _toiletAirplane1 = GameMap(
      name: 'Time to travel',
      filePath: 'level/toilet_airplane_1.webp',
      track: EllipseTrack(
          innerCenter: Vector2(830, 1730),
          innerRadii: const Radius.elliptical(186, 243),
          outerCenter: Vector2(835, 1745),
          outerRadii: const Radius.elliptical(325, 375)));

  static final _toiletBerlinBrettSpielPlatz = GameMap(
      name: "Let's play a game",
      filePath: 'level/toilet_berlin_brettspielplatz.webp',
      track: EllipseTrack(
          innerCenter: Vector2(808, 1832),
          innerRadii: const Radius.elliptical(170, 225),
          outerCenter: Vector2(808, 1832),
          outerRadii: const Radius.elliptical(275, 335)));

  static final _floatingPool = GameMap(
      name: 'Floating',
      filePath: 'level/floating_pool.webp',
      track: EllipseTrack(
          innerCenter: Vector2(1000, 1368),
          innerRadii: const Radius.elliptical(198, 198),
          outerCenter: Vector2(996, 1368),
          outerRadii: const Radius.elliptical(455, 455)));

  static final _footBath = GameMap(
      name: 'Footbath',
      filePath: 'level/foot_bath.webp',
      track: EllipseTrack(
          innerCenter: Vector2(798, 1337),
          innerRadii: const Radius.elliptical(365, 365),
          outerCenter: Vector2(818, 1352),
          outerRadii: const Radius.elliptical(560, 560)));

  static final _toiletBerlinUwe = GameMap(
      name: "I'm the Uwe",
      filePath: 'level/toilet_berlin_uwe.webp',
      track: EllipseTrack(
          innerCenter: Vector2(824, 1708),
          innerRadii: const Radius.elliptical(225, 275),
          outerCenter: Vector2(833, 1715),
          outerRadii: const Radius.elliptical(357, 438)));

  static final _toiletEgyptAirportSharmElSheikh = GameMap(
      name: 'Airport Sharm El Sheikh',
      filePath: 'level/toilet_egypt_airport_sharmelsheikh.webp',
      track: EllipseTrack(
          innerCenter: Vector2(787, 1754),
          innerRadii: const Radius.elliptical(170, 240),
          outerCenter: Vector2(787, 1770),
          outerRadii: const Radius.elliptical(285, 360)));

  // TODO: Ellipse doesn't fit form
  static final _toiletEgyptCoralReefDahab = GameMap(
      name: 'Coral Reef Hotel Dahab',
      filePath: 'level/toilet_egypt_coral_reef.webp',
      track: EllipseTrack(
          innerCenter: Vector2(824, 1758),
          innerRadii: const Radius.elliptical(165, 240),
          outerCenter: Vector2(824, 1758),
          outerRadii: const Radius.elliptical(280, 365)));

  static final _vinyl = GameMap(
      name: 'Turn it up',
      filePath: 'level/vinyl.webp',
      track: EllipseTrack(
          innerCenter: Vector2(934, 938),
          innerRadii: const Radius.elliptical(139, 139),
          outerCenter: Vector2(934, 938),
          outerRadii: const Radius.elliptical(375, 375)));

  static final _toiletEgyptDirty = GameMap(
      name: 'What a mess',
      filePath: 'level/toilet_egypt_dirty.webp',
      track: EllipseTrack(
          innerCenter: Vector2(790, 1720),
          innerRadii: const Radius.elliptical(220, 260),
          outerCenter: Vector2(790, 1700),
          outerRadii: const Radius.elliptical(318, 394)));

  // TODO: Ellipse doesn't fit form
  static final _toiletEgyptHole = GameMap(
      name: 'Fire in the hole',
      filePath: 'level/toilet_egypt_hole.webp',
      track: EllipseTrack(
          innerCenter: Vector2(800, 1395),
          innerRadii: const Radius.elliptical(55, 65),
          outerCenter: Vector2(800, 1570),
          outerRadii: const Radius.elliptical(182, 335)));

  static final _friedEgg = GameMap(
      name: 'Fried egg',
      filePath: 'level/fried_egg.webp',
      track: EllipseTrack(
          innerCenter: Vector2(437, 1591),
          innerRadii: const Radius.elliptical(146, 155),
          outerCenter: Vector2(417, 1615),
          outerRadii: const Radius.elliptical(310, 320)));

  static final _robotVacuumCleaner = GameMap(
      name: 'Robot',
      filePath: 'level/robot_vacuum_cleaner.webp',
      track: EllipseTrack(
          innerCenter: Vector2(672, 1235),
          innerRadii: const Radius.elliptical(120, 118),
          outerCenter: Vector2(713, 1319),
          outerRadii: const Radius.elliptical(423, 422)));

  static final _trafficSign = GameMap(
      name: 'Slow down',
      filePath: 'level/traffic_sign.webp',
      track: EllipseTrack(
          innerCenter: Vector2(919, 1605),
          innerRadii: const Radius.elliptical(384, 380),
          outerCenter: Vector2(922, 1610),
          outerRadii: const Radius.elliptical(570, 578)));

  static final _tubDrain = GameMap(
      name: 'Drain',
      filePath: 'level/tub_drain.webp',
      track: EllipseTrack(
          innerCenter: Vector2(665, 1222),
          innerRadii: const Radius.elliptical(170, 170),
          outerCenter: Vector2(665, 1222),
          outerRadii: const Radius.elliptical(280, 280)));

  static final _toiletForDisabled = GameMap(
      name: 'Wooden flavour',
      filePath: 'level/toilet_for_disabled.webp',
      track: EllipseTrack(
          innerCenter: Vector2(820, 1835),
          innerRadii: const Radius.elliptical(157, 200),
          outerCenter: Vector2(820, 1845),
          outerRadii: const Radius.elliptical(285, 360)));

  static final _abstractEye = GameMap(
      name: 'Abstract eye',
      filePath: 'level/abstract_eye.webp',
      track: EllipseTrack(
          innerCenter: Vector2(695, 1040),
          innerRadii: const Radius.elliptical(235, 235),
          outerCenter: Vector2(690, 1120),
          outerRadii: const Radius.elliptical(525, 465)));

  static final _candles = GameMap(
      name: 'Romantic Evening',
      filePath: 'level/candles.webp',
      track: EllipseTrack(
          innerCenter: Vector2(715, 1108),
          innerRadii: const Radius.elliptical(66, 60),
          outerCenter: Vector2(719, 1112),
          outerRadii: const Radius.elliptical(218, 218)));

  static final _coffee = GameMap(
      name: 'Time for coffee',
      filePath: 'level/coffee.webp',
      track: EllipseTrack(
          innerCenter: Vector2(688, 1273),
          innerRadii: const Radius.elliptical(314, 320),
          outerCenter: Vector2(693, 1273),
          outerRadii: const Radius.elliptical(472, 472)));

  final List<GameMap> _allMaps = [
    _toilet1,
    _toiletPaper,
    _toiletTrain,
    _toiletRed,
    _donut1,
    _toiletAirplane1,
    _toiletBerlinBrettSpielPlatz,
    _floatingPool,
    _footBath,
    _toiletBerlinUwe,
    _toiletEgyptAirportSharmElSheikh,
    // _toiletEgyptCoralReefDahab,
    _vinyl,
    _toiletEgyptDirty,
    // _toiletEgyptHole,
    _friedEgg,
    _trafficSign,
    _tubDrain,
    _toiletForDisabled,
    _robotVacuumCleaner,
    _abstractEye,
    _candles,
    _coffee,
  ];

  List<GameMap> getAllMaps() {
    return _allMaps;
  }
}

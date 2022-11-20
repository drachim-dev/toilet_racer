import 'dart:ui';

import 'package:flame/components.dart';
import 'package:toilet_racer/models/track.dart';
import 'package:toilet_racer/models/map.dart';

class MapRepository {
  static final _toilet1 = GameMap(
      name: 'Need a seat',
      filePath: 'level/toilet1.webp',
      track: Track(
          innerBoundary: EllipseBoundary(
            center: Vector2(767, 1415),
            radii: const Radius.elliptical(200, 210),
          ),
          outerBoundary: EllipseBoundary(
              center: Vector2(767, 1405),
              radii: const Radius.elliptical(320, 360))));

  static final _toiletPaper = GameMap(
      name: 'Paper Guy',
      filePath: 'level/toilet_paper.webp',
      track: Track(
          innerBoundary: EllipseBoundary(
            center: Vector2(730, 1162),
            radii: const Radius.elliptical(93, 98),
          ),
          outerBoundary: EllipseBoundary(
              center: Vector2(730, 1155),
              radii: const Radius.elliptical(220, 260))));

  static final _toiletTrain = GameMap(
    name: 'Trip to toilet',
    filePath: 'level/toilet_train.webp',
    track: Track(
        innerBoundary: EllipseBoundary(
          center: Vector2(715, 1520),
          radii: const Radius.elliptical(145, 165),
        ),
        outerBoundary: EllipseBoundary(
            center: Vector2(715, 1520),
            radii: const Radius.elliptical(245, 256))),
  );

  static final _toiletRed = GameMap(
    name: 'Red wedding',
    filePath: 'level/toilet_red.webp',
    track: Track(
        innerBoundary: EllipseBoundary(
          center: Vector2(784, 1632),
          radii: const Radius.elliptical(194, 238),
        ),
        outerBoundary: EllipseBoundary(
            center: Vector2(784, 1648),
            radii: const Radius.elliptical(320, 380))),
  );

  static final _donut1 = GameMap(
    name: 'Let me taste it',
    filePath: 'level/donut1.webp',
    track: Track(
        innerBoundary: EllipseBoundary(
          center: Vector2(505, 800),
          radii: const Radius.elliptical(75, 70),
        ),
        outerBoundary: EllipseBoundary(
            center: Vector2(500, 795),
            radii: const Radius.elliptical(185, 185))),
  );

  static final _toiletAirplane1 = GameMap(
    name: 'Time to travel',
    filePath: 'level/toilet_airplane_1.webp',
    track: Track(
        innerBoundary: EllipseBoundary(
          center: Vector2(830, 1730),
          radii: const Radius.elliptical(186, 243),
        ),
        outerBoundary: EllipseBoundary(
            center: Vector2(835, 1745),
            radii: const Radius.elliptical(325, 375))),
  );

  static final _toiletBerlinBrettSpielPlatz = GameMap(
    name: "Let's play a game",
    filePath: 'level/toilet_berlin_brettspielplatz.webp',
    track: Track(
        innerBoundary: EllipseBoundary(
          center: Vector2(808, 1832),
          radii: const Radius.elliptical(170, 225),
        ),
        outerBoundary: EllipseBoundary(
            center: Vector2(808, 1832),
            radii: const Radius.elliptical(275, 335))),
  );

  static final _floatingPool = GameMap(
    name: 'Floating',
    filePath: 'level/floating_pool.webp',
    track: Track(
        innerBoundary: EllipseBoundary(
          center: Vector2(1000, 1368),
          radii: const Radius.elliptical(198, 198),
        ),
        outerBoundary: EllipseBoundary(
            center: Vector2(996, 1368),
            radii: const Radius.elliptical(455, 455))),
  );

  static final _footBath = GameMap(
    name: 'Footbath',
    filePath: 'level/foot_bath.webp',
    track: Track(
        innerBoundary: EllipseBoundary(
          center: Vector2(798, 1337),
          radii: const Radius.elliptical(365, 365),
        ),
        outerBoundary: EllipseBoundary(
            center: Vector2(818, 1352),
            radii: const Radius.elliptical(560, 560))),
  );

  static final _toiletBerlinUwe = GameMap(
    name: "I'm the Uwe",
    filePath: 'level/toilet_berlin_uwe.webp',
    track: Track(
        innerBoundary: EllipseBoundary(
          center: Vector2(824, 1708),
          radii: const Radius.elliptical(225, 275),
        ),
        outerBoundary: EllipseBoundary(
            center: Vector2(833, 1715),
            radii: const Radius.elliptical(357, 438))),
  );

  static final _toiletEgyptAirportSharmElSheikh = GameMap(
    name: 'Airport Sharm El Sheikh',
    filePath: 'level/toilet_egypt_airport_sharmelsheikh.webp',
    track: Track(
      innerBoundary: EllipseBoundary(
        center: Vector2(787, 1754),
        radii: const Radius.elliptical(170, 240),
      ),
      outerBoundary: PolygonBoundary(vertices: [
        Vector2(570, 1402),
        Vector2(560, 1474),
        Vector2(552, 1520),
        Vector2(537, 1564),
        Vector2(521, 1618),
        Vector2(511, 1675),
        Vector2(506, 1722),
        Vector2(506, 1771),
        Vector2(508, 1820),
        Vector2(518, 1869),
        Vector2(534, 1918),
        Vector2(552, 1954),
        Vector2(575, 1993),
        Vector2(599, 2026),
        Vector2(624, 2055),
        Vector2(660, 2078),
        Vector2(699, 2096),
        Vector2(748, 2109),
        Vector2(795, 2109),
        Vector2(844, 2101),
        Vector2(898, 2083),
        Vector2(942, 2055),
        Vector2(978, 2021),
        Vector2(1009, 1982),
        Vector2(1035, 1941),
        Vector2(1053, 1890),
        Vector2(1063, 1851),
        Vector2(1074, 1802),
        Vector2(1079, 1753),
        Vector2(1076, 1701),
        Vector2(1068, 1644),
        Vector2(1058, 1582),
        Vector2(1045, 1520),
        Vector2(1037, 1448),
        Vector2(1035, 1389),
        Vector2(991, 1376),
        Vector2(957, 1371),
        Vector2(955, 1412),
        Vector2(898, 1409),
        Vector2(841, 1409),
        Vector2(784, 1407),
        Vector2(707, 1404),
        Vector2(642, 1407),
        Vector2(642, 1365),
        Vector2(593, 1373),
        Vector2(568, 1383),
      ]),
    ),
  );

  static final _toiletEgyptCoralReefDahab = GameMap(
    name: 'Coral Reef Hotel Dahab',
    filePath: 'level/toilet_egypt_coral_reef.webp',
    track: Track(
      innerBoundary: PolygonBoundary(vertices: [
        Vector2(818, 2003),
        Vector2(769, 1990),
        Vector2(730, 1957),
        Vector2(697, 1902),
        Vector2(679, 1838),
        Vector2(663, 1773),
        Vector2(653, 1701),
        Vector2(648, 1636),
        Vector2(653, 1587),
        Vector2(676, 1554),
        Vector2(715, 1531),
        Vector2(769, 1523),
        Vector2(828, 1523),
        Vector2(885, 1525),
        Vector2(934, 1536),
        Vector2(973, 1562),
        Vector2(996, 1605),
        Vector2(996, 1657),
        Vector2(991, 1717),
        Vector2(983, 1776),
        Vector2(968, 1833),
        Vector2(955, 1882),
        Vector2(934, 1928),
        Vector2(906, 1967),
        Vector2(867, 1993),
      ]),
      outerBoundary: PolygonBoundary(vertices: [
        Vector2(537, 1758),
        Vector2(531, 1696),
        Vector2(531, 1626),
        Vector2(531, 1544),
        Vector2(549, 1479),
        Vector2(578, 1404),
        Vector2(666, 1404),
        Vector2(668, 1340),
        Vector2(699, 1337),
        Vector2(699, 1381),
        Vector2(955, 1386),
        Vector2(955, 1345),
        Vector2(991, 1345),
        Vector2(991, 1404),
        Vector2(1076, 1409),
        Vector2(1112, 1518),
        Vector2(1117, 1593),
        Vector2(1117, 1678),
        Vector2(1110, 1773),
        Vector2(1094, 1861),
        Vector2(1063, 1954),
        Vector2(1019, 2024),
        Vector2(968, 2078),
        Vector2(895, 2114),
        Vector2(818, 2124),
        Vector2(730, 2106),
        Vector2(658, 2060),
        Vector2(611, 2008),
        Vector2(575, 1946),
        Vector2(547, 1871),
        Vector2(537, 1815),
      ]),
    ),
  );

  static final _vinyl = GameMap(
    name: 'Turn it up',
    filePath: 'level/vinyl.webp',
    track: Track(
        innerBoundary: EllipseBoundary(
          center: Vector2(934, 938),
          radii: const Radius.elliptical(139, 139),
        ),
        outerBoundary: EllipseBoundary(
            center: Vector2(934, 938),
            radii: const Radius.elliptical(375, 375))),
  );

  static final _toiletEgyptDirty = GameMap(
    name: 'What a mess',
    filePath: 'level/toilet_egypt_dirty.webp',
    track: Track(
        innerBoundary: EllipseBoundary(
          center: Vector2(790, 1720),
          radii: const Radius.elliptical(220, 260),
        ),
        outerBoundary: EllipseBoundary(
            center: Vector2(790, 1700),
            radii: const Radius.elliptical(318, 394))),
  );

  static final _toiletEgyptHole = GameMap(
    name: 'Fire in the hole',
    filePath: 'level/toilet_egypt_hole.webp',
    track: Track(
      innerBoundary: EllipseBoundary(
        center: Vector2(800, 1395),
        radii: const Radius.elliptical(55, 65),
      ),
      outerBoundary: PolygonBoundary(vertices: [
        Vector2(632, 1580),
        Vector2(624, 1510),
        Vector2(611, 1417),
        Vector2(606, 1319),
        Vector2(635, 1249),
        Vector2(725, 1213),
        Vector2(828, 1200),
        Vector2(919, 1210),
        Vector2(981, 1254),
        Vector2(1001, 1311),
        Vector2(996, 1482),
        Vector2(988, 1595),
        Vector2(988, 1722),
        Vector2(975, 1825),
        Vector2(988, 1861),
        Vector2(926, 1905),
        Vector2(846, 1926),
        Vector2(766, 1910),
        Vector2(699, 1890),
        Vector2(663, 1799),
        Vector2(648, 1732),
        Vector2(658, 1704),
        Vector2(650, 1644),
      ]),
    ),
  );

  static final _friedEgg = GameMap(
    name: 'Fried egg',
    filePath: 'level/fried_egg.webp',
    track: Track(
        innerBoundary: EllipseBoundary(
          center: Vector2(437, 1591),
          radii: const Radius.elliptical(146, 155),
        ),
        outerBoundary: EllipseBoundary(
            center: Vector2(417, 1615),
            radii: const Radius.elliptical(310, 320))),
  );

  static final _robotVacuumCleaner = GameMap(
    name: 'Robot',
    filePath: 'level/robot_vacuum_cleaner.webp',
    track: Track(
        innerBoundary: EllipseBoundary(
          center: Vector2(672, 1235),
          radii: const Radius.elliptical(120, 118),
        ),
        outerBoundary: EllipseBoundary(
            center: Vector2(713, 1319),
            radii: const Radius.elliptical(423, 422))),
  );

  static final _trafficSign = GameMap(
    name: 'Slow down',
    filePath: 'level/traffic_sign.webp',
    track: Track(
        innerBoundary: EllipseBoundary(
          center: Vector2(919, 1605),
          radii: const Radius.elliptical(384, 380),
        ),
        outerBoundary: EllipseBoundary(
            center: Vector2(922, 1610),
            radii: const Radius.elliptical(570, 578))),
  );

  static final _tubDrain = GameMap(
    name: 'Drain',
    filePath: 'level/tub_drain.webp',
    track: Track(
        innerBoundary: EllipseBoundary(
          center: Vector2(665, 1222),
          radii: const Radius.elliptical(170, 170),
        ),
        outerBoundary: EllipseBoundary(
            center: Vector2(665, 1222),
            radii: const Radius.elliptical(280, 280))),
  );

  static final _toiletForDisabled = GameMap(
    name: 'Wooden flavour',
    filePath: 'level/toilet_for_disabled.webp',
    track: Track(
        innerBoundary: EllipseBoundary(
          center: Vector2(820, 1835),
          radii: const Radius.elliptical(157, 200),
        ),
        outerBoundary: EllipseBoundary(
            center: Vector2(820, 1845),
            radii: const Radius.elliptical(285, 360))),
  );

  static final _abstractEye = GameMap(
    name: 'Abstract eye',
    filePath: 'level/abstract_eye.webp',
    track: Track(
        innerBoundary: EllipseBoundary(
          center: Vector2(695, 1040),
          radii: const Radius.elliptical(235, 235),
        ),
        outerBoundary: EllipseBoundary(
            center: Vector2(690, 1120),
            radii: const Radius.elliptical(525, 465))),
  );

  static final _candles = GameMap(
    name: 'Romantic Evening',
    filePath: 'level/candles.webp',
    track: Track(
        innerBoundary: EllipseBoundary(
          center: Vector2(715, 1108),
          radii: const Radius.elliptical(66, 60),
        ),
        outerBoundary: EllipseBoundary(
            center: Vector2(719, 1112),
            radii: const Radius.elliptical(218, 218))),
  );

  static final _coffee = GameMap(
    name: 'Time for coffee',
    filePath: 'level/coffee.webp',
    track: Track(
        innerBoundary: EllipseBoundary(
          center: Vector2(688, 1273),
          radii: const Radius.elliptical(314, 320),
        ),
        outerBoundary: EllipseBoundary(
            center: Vector2(693, 1273),
            radii: const Radius.elliptical(472, 472))),
  );

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
    _toiletEgyptCoralReefDahab,
    _vinyl,
    _toiletEgyptDirty,
    _toiletEgyptHole,
    _friedEgg,
    _trafficSign,
    _tubDrain,
    _toiletForDisabled,
    _robotVacuumCleaner,
    _abstractEye,
    _candles,
    _coffee,
  ];

  List<GameMap> get getAllMaps => _allMaps;
}

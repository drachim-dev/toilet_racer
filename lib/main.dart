import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toilet_racer/screens/race_game.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var flameUtils = Util();
  await flameUtils.fullScreen();
  await flameUtils.setOrientation(DeviceOrientation.portraitUp);
  final gameSize = await flameUtils.initialDimensions();

  final game = RaceGame(gameSize);
  runApp(game.widget);
}

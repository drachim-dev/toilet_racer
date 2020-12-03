import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toilet_racer/app/locator.dart';
import 'package:toilet_racer/race_game.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  var flameUtils = Util();
  await flameUtils.fullScreen();
  await flameUtils.setOrientation(DeviceOrientation.portraitUp);
  final gameSize = await flameUtils.initialDimensions();

  final game = RaceGame(gameSize);
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'NerkoOne'),
    home: Material(child: game.widget),
  ));
}

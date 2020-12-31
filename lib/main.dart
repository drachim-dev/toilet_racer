import 'package:flame/flame.dart';
import 'package:flame/game/game_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';
import 'package:toilet_racer/race_game.dart';
import 'package:toilet_racer/views/overlay_ui.dart';
import 'package:toilet_racer/views/start_menu.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  Flame.initializeWidget();
  await Flame.util.fullScreen();
  await Flame.util.setOrientation(DeviceOrientation.portraitUp);
  final size = await Flame.util.initialDimensions();
  final game = RaceGame(size);

  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'NerkoOne'),
    home: Material(
      child: GameWidget(
        game: game,
        overlayBuilderMap: {
          startMenu: (_, game) => StartMenu(game),
          overlayUi: (_, game) => OverlayUi(),
        },
        initialActiveOverlays: const [startMenu],
      ),
    ),
  ));
}
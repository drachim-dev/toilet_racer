import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';
import 'package:toilet_racer/race_game.dart';
import 'package:toilet_racer/services/game_service.dart';
import 'package:toilet_racer/views/game_over_menu.dart';
import 'package:toilet_racer/views/overlay_ui.dart';
import 'package:toilet_racer/views/start_menu.dart';

import 'app/theme.dart';

Future<void> main() async {
  await Flame.init(orientation: DeviceOrientation.portraitUp);

  setupLocator();
  await locator.allReady();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  RaceGame _game;

  @override
  void initState() {
    super.initState();

    _game = RaceGame(roundEndCallback: _roundEndCallback);
    locator<GameService>().signIn();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: toiletTheme,
      home: Material(
        child: GameWidget(
          game: _game,
          overlayBuilderMap: {
            startMenu: (_, RaceGame game) => StartMenu(game),
            overlayUi: (_, RaceGame game) => OverlayUi(),
            gameOverMenu: (_, RaceGame game) => GameOverMenu(
                  game.onBackToMenuButtonPressed,
                  game.onPlayButtonPressed,
                  game.score,
                ),
          },
          initialActiveOverlays: const [startMenu],
        ),
      ),
    );
  }

  Future<void> _roundEndCallback() async {
    //await _showAd();
  }
}

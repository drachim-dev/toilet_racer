import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:games_services/games_services.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';
import 'package:toilet_racer/race_game.dart';
import 'package:toilet_racer/views/overlay_ui.dart';
import 'package:toilet_racer/views/start_menu.dart';

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
    GamesServices.signIn();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'NerkoOne'),
      home: Material(
        child: GameWidget(
          game: _game,
          overlayBuilderMap: {
            startMenu: (_, game) => StartMenu(game),  
            overlayUi: (_, game) => OverlayUi(),
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

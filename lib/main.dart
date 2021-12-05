import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';
import 'package:toilet_racer/race_game.dart';
import 'package:toilet_racer/services/ad_service.dart';
import 'package:toilet_racer/services/audio_service.dart';
import 'package:toilet_racer/views/countdown_overlay.dart';
import 'package:toilet_racer/views/credits_menu.dart';
import 'package:toilet_racer/views/game_over_menu.dart';
import 'package:toilet_racer/views/leaderboard_menu.dart';
import 'package:toilet_racer/views/overlay_ui.dart';
import 'package:toilet_racer/views/start_menu.dart';

import 'app/theme.dart';
import 'race_game_mode.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Flame.device.fullScreen();
  await Flame.device.setOrientation(DeviceOrientation.portraitUp);

  setupLocator();
  await locator.allReady();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AdService _adService = locator<AdService>();
  final AudioService _audioService = locator<AudioService>();

  RaceGame _game;

  @override
  void initState() {
    super.initState();

    _game = RaceGame(gameOverCallback: _onGameOver);

    _adService.load();
  }

  @override
  void dispose() {
    _adService.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: toiletTheme,
      home: Material(
        child: WillPopScope(
          onWillPop: () {
            final startMenuShown = _game.overlays.isActive(kStartMenu);
            final gameRunning = _game.overlays.isActive(kOverlayUi);

            // Exit to homescreen when in game or in startMenu
            if (startMenuShown || gameRunning) {
              return Future.value(true);
            } else {
              _game.showStartMenu();
              return Future.value(false);
            }
          },
          child: GameWidget(
            game: _game,
            overlayBuilderMap: {
              kStartMenu: (_, RaceGame game) => StartMenu(
                    onPlayPressed: (GameModeIdentifier gameModeIdentifier) =>
                        game.prepareStartGame(
                            gameModeIdentifier: gameModeIdentifier),
                    onCreditsPressed: game.showCreditsMenu,
                    onLeaderboardPressed: game.showLeaderboardMenu,
                  ),
              kCreditsMenu: (_, RaceGame game) =>
                  CreditsMenu(game.showStartMenu),
              kLeaderboardMenu: (_, RaceGame game) =>
                  LeaderboardMenu(game.showStartMenu),
              kOverlayUi: (_, RaceGame game) => OverlayUi(),
              kCountDownOverlay: (_, RaceGame game) => CountDownOverlay(
                    onCountDownFinished: game.startGame,
                  ),
              kGameOverMenu: (_, RaceGame game) => GameOverMenu(
                    onBackToMenuPressed: game.showStartMenu,
                    onPlayPressed: (bool resetProgress) =>
                        game.prepareStartGame(resetProgress: resetProgress),
                    score: game.score,
                    canPlayNext: game.gameMode.canPlayNext,
                    hasCompletedGameMode: game.gameMode.hasCompleted,
                  ),
            },
            initialActiveOverlays: const [kStartMenu],
          ),
        ),
      ),
    );
  }

  Future<void> _onGameOver() => _adService?.mayShow(
      onAdClosed: () => _audioService.playBackgroundMusic(menu: true),
      onAdShown: () => _audioService.stopBackgroundMusic());
}

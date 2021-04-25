import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';
import 'package:toilet_racer/components/background.dart';
import 'package:toilet_racer/components/boundary.dart';
import 'package:toilet_racer/components/controller.dart';
import 'package:toilet_racer/components/help_text.dart';
import 'package:toilet_racer/components/player_body.dart';
import 'package:toilet_racer/services/audio_service.dart';
import 'package:toilet_racer/services/game_service.dart';
import 'package:toilet_racer/services/timer_service.dart';
import 'package:vector_math/vector_math_64.dart';

import 'components/player.dart';
import 'game/level.dart';

typedef AsyncCallback = Future<void> Function();

class RaceGame extends Forge2DGame with HasTapableComponents {
  static const double defaultScale = 4.0;

  final AudioService _audioService = locator<AudioService>();
  final SharedPreferences _prefService = locator<SharedPreferences>();
  final TimerService _timerService = locator<TimerService>();

  @override
  bool debugMode = kDebugMode;

  bool _musicEnabled = true;
  bool _showHelp = true;
  bool _collisionDetected = false;

  AsyncCallback onGameOver;

  HelpText controlHelpText;

  int get score => _timerService?.seconds?.value ?? 0;

  Set<Component> gameComponents;

  Background background;
  Level level;

  BoundaryContactCallback contactCallback;

  RaceGame({this.onGameOver})
      : super(scale: defaultScale, gravity: Vector2(0, 0)) {
    _init();
  }

  @override
  Future<void> onLoad() async {
    level = Level.toilet3;
    await level.onLoad();
    await add(background = Background(level));

    overlays.add(kStartMenu);
  }

  @override
  void onResize(Vector2 size) {
    super.onResize(size);

    if (background != null) {
      viewport.scale = defaultScale * background.scale;
    }
  }

  void _init() {
    _musicEnabled = _prefService.getBool(kPrefKeyMusicEnabled) ?? _musicEnabled;
    _showHelp = _prefService.getBool(kPrefKeyShowHelp) ?? _showHelp;

    if (_musicEnabled) {
      _audioService.playBgMusic();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_collisionDetected) {
      gameOver();
      _collisionDetected = false;
    }
  }

  void onBackToMenuButtonPressed() {
    _removeActiveOverlays();
    overlays.add(kStartMenu);
  }

  void onPlayButtonPressed() {
    // remove all active overlays
    final activeOverlays = overlays.value.toSet();
    activeOverlays.forEach((overlay) {
      overlays.remove(overlay);
    });

    // add game overlays
    overlays.add(kOverlayUi);

    // add help text
    if (_showHelp) {
      add(controlHelpText = HelpText());
      _showHelp = false;
      _prefService.setBool(kPrefKeyShowHelp, _showHelp);
    }

    // start the game
    _startGame();
  }

  void _registerGameComponents() async {
    PlayerBody playerBody;
    Boundary innerBoundary;
    Boundary outerBoundary;
    Controller controller;

    final player = await Fly().onLoad();
    await add(playerBody =
        PlayerBody(player, background.getImageToScreen(level.startPosition)));
    await add(controller = Controller(playerBody));

    //final player = await Stinkbug().onLoad();

    await add(outerBoundary = Boundary(level.track.outerBoundary
        .map((vertex) => background.getImageToScreen(vertex))
        .toList()));
    await add(innerBoundary = Boundary(level.track.innerBoundary
        .map((vertex) => background.getImageToScreen(vertex))
        .toList()));

    addContactCallback(
        contactCallback = BoundaryContactCallback(collisionDetected));

    gameComponents = {playerBody, outerBoundary, innerBoundary, controller};
  }

  void _startGame() {
    _registerGameComponents();

    // TODO: wait for all components beeing added?
    _timerService.start();
  }

  void gameOver() async {
    gameComponents.forEach((component) => remove(component));
    removeContactCallback(contactCallback);

    if (_showHelp) {
      remove(controlHelpText);
    }

    _removeActiveOverlays();

    await onGameOver();
    overlays.add(kGameOverMenu);
  }

  void collisionDetected() {
    _collisionDetected = true;
    _timerService.cancel();

    _audioService.playDropSound(kAudioToiletDropSound);

    _updateScoreAndAchievements();
  }

  /// Updates score and achievement status async in background.
  void _updateScoreAndAchievements() async {
    final _gameService = locator<GameService>();

    if (_gameService.signedIn) {
      // submit score
      await _gameService.submitScore(
          kAndroidLeaderBoard, _timerService.seconds.value);

      // update duration achievement
      kDurationAchievements.forEach((duration, id) {
        if (_timerService.seconds.value > duration) {
          _gameService.unlockAchievement(id);
        }
      });

      // update play count
      kPlayCountAchievements
          .forEach((id) => _gameService.incrementAchievement(id));
    }
  }

  void _removeActiveOverlays() {
    final activeOverlays = overlays.value.toSet();
    activeOverlays.forEach((overlay) {
      overlays.remove(overlay);
    });
  }
}

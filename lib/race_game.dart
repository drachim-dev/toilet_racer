import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/gestures.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';
import 'package:toilet_racer/components/background.dart';
import 'package:toilet_racer/components/boundary.dart';
import 'package:toilet_racer/components/game_help.dart';
import 'package:toilet_racer/components/player_body.dart';
import 'package:toilet_racer/services/audio_service.dart';
import 'package:toilet_racer/services/game_service.dart';
import 'package:toilet_racer/services/timer_service.dart';
import 'package:vector_math/vector_math_64.dart';

import 'app/utils.dart';
import 'components/player.dart';
import 'game/level.dart';

typedef AsyncCallback = Future<void> Function();

class RaceGame extends Forge2DGame with TapDetector {
  static const double defaultScale = 4.0;

  final AudioService _audioService = locator<AudioService>();
  final SharedPreferences _prefService = locator<SharedPreferences>();
  final TimerService _timerService = locator<TimerService>();

  final AsyncCallback onGameOver;

  @override
  bool debugMode = kDebugMode;

  bool _musicEnabled = true;
  bool _isFirstLaunch = true;
  bool _collisionDetected = false;

  Background background;
  Level level;
  BoundaryContactCallback contactCallback;

  Set<Component> gameComponents;
  PlayerBody _playerBody;
  Iterator<GameHelp> gameHelper;

  int get score => _timerService?.seconds?.value ?? 0;

  RaceGame({this.onGameOver})
      : super(scale: defaultScale, gravity: Vector2(0, 0)) {
    _init();
  }

  @override
  Future<void> onLoad() async {
    level = Level.toilet3;
    await level.onLoad();
    await add(background = Background(level));
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
    _isFirstLaunch =
        _prefService.getBool(kPrefKeyIsFirstLaunch) ?? _isFirstLaunch;

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

  @override
  void onTapDown(TapDownDetails details) {
    // Iterate over GameHelpers on firstLaunch
    if (_isFirstLaunch) {
      remove(gameHelper.current);
      if (gameHelper.moveNext()) {
        add(gameHelper.current);
        return;
      }
      _prefService.setBool(kPrefKeyIsFirstLaunch, _isFirstLaunch = false);
      _startGame();
      return;
    }

    _playerBody?.spin();
    return super.onTapDown(details);
  }

  void onBackToMenuButtonPressed() {
    _swapMenuOverlay(kStartMenu);
  }

  void onPlayButtonPressed() {
    _removeOverlays();

    _isFirstLaunch ? _initGameHelp() : _startGame();
  }

  void _registerGameComponents() async {
    Boundary innerBoundary, outerBoundary;

    final player = await Fly().onLoad();
    await add(_playerBody =
        PlayerBody(player, background.getImageToScreen(level.startPosition)));

    // final player = await Stinkbug().onLoad();

    await add(outerBoundary = Boundary(level.track.outerBoundary
        .map((vertex) => background.getImageToScreen(vertex))
        .toList()));
    await add(innerBoundary = Boundary(level.track.innerBoundary
        .map((vertex) => background.getImageToScreen(vertex))
        .toList()));

    addContactCallback(
        contactCallback = BoundaryContactCallback(collisionDetected));

    gameComponents = {_playerBody, outerBoundary, innerBoundary};
  }

  void _startGame() {
    _registerGameComponents();
    _swapMenuOverlay(kOverlayUi);

    // TODO: wait for all components beeing added?
    _timerService.start();
  }

  void gameOver() async {
    gameComponents.forEach((component) => remove(component));
    removeContactCallback(contactCallback);

    await onGameOver();

    _swapMenuOverlay(kGameOverMenu);
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

  /// Removes all active overlays in favor of [overlayName]
  void _swapMenuOverlay(String overlayName) {
    _removeOverlays();
    overlays.add(overlayName);
  }

  /// Removes all active overlays
  void _removeOverlays() {
    final activeOverlays = overlays.value.toSet();
    activeOverlays.forEach((overlay) {
      overlays.remove(overlay);
    });
  }

  void _initGameHelp() {
    final middleBoundary = getMiddleVertices(
      level.track.outerBoundary
          .map((e) => background.getImageToScreen(e))
          .toList(),
      level.track.innerBoundary
          .map((e) => background.getImageToScreen(e))
          .toList(),
    );

    gameHelper = [
      GameHelp(
        boundary: middleBoundary,
        bottomArrow: true,
        topArrow: true,
        helpText: 'Stay on the\ntoilet',
      ),
      GameHelp(
        boundary: middleBoundary,
        bottomArrow: true,
        helpText: 'Tap anywhere\nto turn',
      )
    ].iterator;

    // show first gameHelp
    gameHelper.moveNext();
    add(gameHelper.current);
  }
}

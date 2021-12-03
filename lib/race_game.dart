import 'dart:async';

import 'package:flame/components.dart' hide Timer;
import 'package:flame/gestures.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flutter/foundation.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';
import 'package:toilet_racer/components/background.dart';
import 'package:toilet_racer/components/boundary.dart';
import 'package:toilet_racer/components/game_help.dart';
import 'package:toilet_racer/components/player_body.dart';
import 'package:toilet_racer/race_game_mode.dart';
import 'package:toilet_racer/services/audio_service.dart';
import 'package:toilet_racer/services/game_service.dart';
import 'package:toilet_racer/services/timer_service.dart';

import 'app/utils.dart';
import 'components/player.dart';
import 'game/level.dart';

typedef AsyncCallback = Future<void> Function();

class RaceGame extends Forge2DGame with TapDetector {
  /// This is the default world scaling factor that was used in an older version of forge.
  static const double defaultScale = 4.0;

  final AudioService _audioService = locator<AudioService>();
  final TimerService _timerService = locator<TimerService>();

  final AsyncCallback gameOverCallback;

  GameMode gameMode;

  @override
  bool debugMode = kDebugMode;

  bool _gameHelpShown = false;
  bool _collisionDetected = false;

  Background background;
  Level currentLevel = Level.toilet1;
  BoundaryContactCallback contactCallback;

  Set<Component> gameComponents;
  PlayerBody _playerBody;
  Iterator<GameHelp> gameHelper;

  double get score => _timerService?.seconds?.value ?? 0;

  RaceGame({this.gameOverCallback}) : super(gravity: Vector2.zero());

  @override
  Future<void> onLoad() async {
    await _audioService.playBackgroundMusic(menu: true);
    await initLevel(currentLevel);
  }

  @override
  void onResize(Vector2 canvasSize) {
    super.onResize(canvasSize);

    if (background != null) {
      camera.zoom = defaultScale * background.worldScale;
    }
  }

  Future<void> initLevel(Level level) async {
    if (components.contains(background)) {
      background.remove();
    }

    await level.onLoad();
    await add(background = Background(level));
  }

  /// Init and show game help
  Future<void> prepareStartGame({GameModeIdentifier gameModeIdentifier}) async {
    _removeOverlays();

    if (gameModeIdentifier != null) {
      gameMode = gameModeIdentifier.gameMode(null);
    }

    if (gameMode == null) {
      throw '_gameMode has not been initialized.';
    }

    if (gameMode.helpNeeded()) {
      await _initGameHelp();
      await add(gameHelper.current);
      _gameHelpShown = true;
    } else {
      startGame();
    }
  }

  void startGame() async {
    await _audioService.playBackgroundMusic(menu: false);
    await _addGameComponents();
    _swapMenuOverlay(kOverlayUi);
    _timerService.start();
  }

  Future<void> _initGameHelp() async {
    final middleBoundary = getMiddleVertices(
      currentLevel.track.outerBoundary
          .map((e) => background.getImageToScreen(e))
          .toList(),
      currentLevel.track.innerBoundary
          .map((e) => background.getImageToScreen(e))
          .toList(),
    );

    final player = await Fly().onLoad();
    final _playerBody = PlayerBody(
        player, background.getImageToScreen(currentLevel.startPosition),
        preview: true);

    gameHelper = [
      GameHelp(
          boundary: middleBoundary,
          rightArrow: true,
          helpText: 'Tap to turn',
          imagePath: 'icons/ic_gesture_tap.png',
          player: _playerBody),
      GameHelp(
        boundary: middleBoundary,
        bottomArrow: true,
        topArrow: true,
        helpText: 'Stay on the\ntoilet',
      ),
      if (gameMode.isCareer)
        GameHelp(
          helpText:
              'Survive at\nleast ${currentLevel.goal.formatDecimal(2)} sec',
          textPosition: GamePosition.CENTER,
        ),
      GameHelp(
        helpText: 'Tap to begin',
        textPosition: GamePosition.CENTER,
      ),
    ].iterator
      ..moveNext();
  }

  Future<void> _addGameComponents() async {
    Boundary innerBoundary, outerBoundary;

    currentLevel = gameMode.getLevel();
    await initLevel(currentLevel);

    final ghostMode = gameMode.ghostMode();
    final player = gameMode.getPlayer();
    await add(_playerBody = PlayerBody(await player.onLoad(),
        background.getImageToScreen(currentLevel.startPosition),
        counterclockwise: !ghostMode));

    await add(outerBoundary = Boundary(currentLevel.track.outerBoundary
        .map((vertex) => background.getImageToScreen(vertex))
        .toList()));
    await add(innerBoundary = Boundary(currentLevel.track.innerBoundary
        .map((vertex) => background.getImageToScreen(vertex))
        .toList()));

    addContactCallback(
        contactCallback = BoundaryContactCallback(_onCollisionDetected));

    gameComponents = {_playerBody, outerBoundary, innerBoundary};
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_collisionDetected) {
      _onGameOver();
      _collisionDetected = false;
    }
  }

  @override
  void onTapDown(TapDownInfo details) {
    // Iterate over GameHelpers on firstLaunch
    if (_gameHelpShown) {
      gameHelper.current.remove();
      if (gameHelper.moveNext()) {
        add(gameHelper.current);
        return;
      }
      _swapMenuOverlay(kCountDownOverlay);
      _gameHelpShown = false;
      return;
    }

    _playerBody?.spin();
    return super.onTapDown(details);
  }

  void _onCollisionDetected() {
    _collisionDetected = true;
    _timerService.cancel();

    _audioService.playDropSound(kAudioToiletDropSound);

    _updateScoreAndAchievements();
  }

  void _onGameOver() async {
    gameComponents.forEach((c) => c.remove());
    removeContactCallback(contactCallback);

    // Start menu background music before gameOverCallback because ads should be able to stop music again.
    await _audioService.playBackgroundMusic(menu: true);
    await gameOverCallback();

    // Short delay to prevent possible game start before ad is shown
    await Future.delayed(Duration(milliseconds: 150));

    _swapMenuOverlay(kGameOverMenu);
  }

  /// Updates score and achievement status async in background.
  void _updateScoreAndAchievements() async {
    final _gameService = locator<GameService>();
    final score = _timerService.seconds.value;

    gameMode.updateScoreAndAchievements(score);

    // submit score
    await _gameService.submitScore(score);
  }

  void showStartMenu() => _swapMenuOverlay(kStartMenu);
  void showCreditsMenu() => _swapMenuOverlay(kCreditsMenu);
  void showLeaderboardMenu() => _swapMenuOverlay(kLeaderboardMenu);

  /// Removes all active overlays
  void _removeOverlays() {
    final activeOverlays = overlays.value.toSet();
    activeOverlays.forEach((overlay) {
      overlays.remove(overlay);
    });
  }

  /// Removes all active overlays in favor of [overlayName]
  void _swapMenuOverlay(String overlayName) {
    _removeOverlays();
    overlays.add(overlayName);
  }
}

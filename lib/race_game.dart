import 'dart:async';

import 'package:flame/components.dart' hide Timer;
import 'package:flame/flame.dart';
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

import 'components/player_component.dart';
import 'generated/l10n.dart';
import 'models/level.dart';
import 'repos/level_repository.dart';

typedef AsyncCallback = Future<void> Function();

class RaceGame extends Forge2DGame with TapDetector {
  /// This is the default world scaling factor that was used in an older version of forge.
  static const double _defaultScale = 4.0;

  final AudioService _audioService = locator<AudioService>();
  final TimerService _timerService = locator<TimerService>();
  final LevelRepository _levelRepository = locator<LevelRepository>();

  final AsyncCallback gameOverCallback;

  GameMode gameMode;

  @override
  bool debugMode = kDebugMode;

  bool _gameHelpShown = false;
  bool _collisionDetected = false;

  Background _background;
  Level _currentLevel;
  BoundaryContactCallback _contactCallback;

  Set<Component> _gameComponents;
  PlayerBody _playerBody;
  Iterator<GameHelp> _gameHelper;

  double get score => _timerService?.seconds?.value ?? 0;

  RaceGame({this.gameOverCallback}) : super(gravity: Vector2.zero());

  @override
  Future<void> onLoad() async {
    await _audioService.playBackgroundMusic(menu: true);
    await _initLevel(_levelRepository.getAllLevels().first);
    return super.onLoad();
  }

  @override
  void onResize(Vector2 canvasSize) {
    super.onResize(canvasSize);

    if (_background != null) {
      camera.zoom = _defaultScale * _background.worldScale;
    }
  }

  Future<void> _initLevel(Level level) async {
    _currentLevel = level;

    if (components.contains(_background)) {
      _background.remove();
    }

    /// Should load image in onLoad() of component,
    /// but somehow this leads to the gameRef beeing null sometimes.
    final image = await Flame.images.load(level.map.filePath);
    await add(_background = Background(level.map, image));
  }

  /// Init and show game help
  Future<void> prepareStartGame(
      {GameModeIdentifier gameModeIdentifier,
      bool resetProgress = false}) async {
    _removeOverlays();

    if (gameModeIdentifier != null) {
      gameMode = gameModeIdentifier.gameMode(null);
    }

    if (gameMode == null) {
      throw '_gameMode has not been initialized.';
    }

    if (resetProgress) {
      gameMode.resetProgress();
    }

    await _initLevel(gameMode.getLevel());
    await _initGameHelper();

    if (_gameHelper.moveNext()) {
      await add(_gameHelper.current);
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

  Future<void> _initGameHelper() async {
    final helper = <GameHelp>[];
    if (gameMode.helpNeeded) {
      final middleBoundary = _currentLevel.map.track.middleBoundary
          .map((e) => _background.getImageToScreen(e))
          .toList();

      final player = await PlayerComponent(_currentLevel.player).onLoad();
      final _playerBody = PlayerBody(
          player, _background.getImageToScreen(_currentLevel.startPosition),
          preview: true);

      final movementHelp = GameHelp(
          boundary: middleBoundary,
          rightArrow: true,
          helpText: S.of(buildContext).overlayHelpTapToTurnText,
          imagePath: 'icons/ic_gesture_tap.png',
          player: _playerBody);

      final gamePlayHelp = GameHelp(
        boundary: middleBoundary,
        bottomArrow: true,
        topArrow: true,
        helpText: S.of(buildContext).overlayHelpStayOnMapText,
      );

      helper.add(movementHelp);
      helper.add(gamePlayHelp);
    }

    if (gameMode.levelHelpText != null) {
      final goalHelp = GameHelp(
        helpText: gameMode.levelHelpText,
        textPosition: GamePosition.CENTER,
      );

      helper.add(goalHelp);
    }

    if (helper.isNotEmpty) {
      final tapToBegin = GameHelp(
        helpText: S.of(buildContext).overlayHelpTapToStartText,
        textPosition: GamePosition.CENTER,
      );

      helper.add(tapToBegin);
    }

    _gameHelper = helper.iterator;
  }

  Future<void> _addGameComponents() async {
    Boundary innerBoundary, outerBoundary;

    final ghostMode = gameMode.ghostMode;
    final player = PlayerComponent(_currentLevel.player);
    await add(_playerBody = PlayerBody(await player.onLoad(),
        _background.getImageToScreen(_currentLevel.startPosition),
        counterclockwise: !ghostMode));

    await add(outerBoundary = Boundary(_currentLevel.map.track.outerBoundary
        .map((vertex) => _background.getImageToScreen(vertex))
        .toList()));
    await add(innerBoundary = Boundary(_currentLevel.map.track.innerBoundary
        .map((vertex) => _background.getImageToScreen(vertex))
        .toList()));

    addContactCallback(
        _contactCallback = BoundaryContactCallback(_onCollisionDetected));

    _gameComponents = {_playerBody, outerBoundary, innerBoundary};
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
      _gameHelper.current.remove();
      if (_gameHelper.moveNext()) {
        add(_gameHelper.current);
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
    _gameComponents.forEach((c) => c.remove());
    removeContactCallback(_contactCallback);

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

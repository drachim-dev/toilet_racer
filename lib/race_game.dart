import 'dart:async';

import 'package:flame/components.dart' hide Timer;
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flutter/foundation.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';
import 'package:toilet_racer/components/background.dart';
import 'package:toilet_racer/components/boundary.dart';
import 'package:toilet_racer/components/game_help.dart';
import 'package:toilet_racer/components/player_body.dart';
import 'package:toilet_racer/models/play_option.dart';
import 'package:toilet_racer/race_game_mode.dart';
import 'package:toilet_racer/services/ad_service.dart';
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

  final AdService _adService = locator<AdService>();
  final AudioService _audioService = locator<AudioService>();
  final LevelRepository _levelRepository = locator<LevelRepository>();
  final SharedPreferences _prefService = locator<SharedPreferences>();
  final TimerService _timerService = locator<TimerService>();

  GameMode? gameMode;

  @override
  // ignore: overridden_fields
  bool debugMode = kDebugMode;

  bool _gameHelpShown = false;
  bool _collisionDetected = false;

  Background? _background;
  Level? _currentLevel;

  Set<Component> _gameComponents = {};
  PlayerBody? _playerBody;
  Iterator<GameHelp>? _gameHelper;

  double? get score => _timerService.seconds.value;

  RaceGame() : super(gravity: Vector2.zero());

  @override
  Future<void> onLoad() async {
    await _audioService.playBackgroundMusic(menu: true);
    await _initLevel(_levelRepository.getAllLevels().first);
    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);

    if (_background != null) {
      camera.zoom = _defaultScale * _background!.worldScale;
    }
  }

  Future<void> _initLevel(Level level) async {
    if (children.contains(_background) && _background != null) {
      remove(_background!);
    }

    final showAnimation = gameMode?.animateNextLevel == true;

    _currentLevel = level;

    /// Should load image in onLoad() of component,
    /// but somehow this leads to the gameRef beeing null sometimes.
    final image = await Flame.images.load(level.map.filePath);

    _background = Background(
        map: level.map, image: image, animationEnabled: showAnimation);

    await add(_background!);
    await _background!.animationFuture;
  }

  /// Init and show game help
  Future<void> prepareStartGame(
      {GameModeIdentifier? gameModeIdentifier,
      required PlayOption playOption}) async {
    overlays.clear();

    if (gameModeIdentifier != null) {
      gameMode = gameModeIdentifier.gameMode(null);
    }

    if (gameMode == null) {
      throw '_gameMode has not been initialized.';
    }

    Level nextLevel;
    switch (playOption) {
      case PlayOption.repeat:
        nextLevel = _currentLevel ?? gameMode!.getLevel();
        break;
      case PlayOption.next:
        nextLevel = gameMode!.getLevel();
        break;
      case PlayOption.restart:
        gameMode!.resetProgress();
        nextLevel = gameMode!.getLevel();
        break;
    }

    final isNewLevel = _currentLevel == null || nextLevel != _currentLevel;
    if (isNewLevel) {
      await _initLevel(nextLevel);
    }

    await _initGameHelper(isNewLevel);

    if (_gameHelper?.moveNext() == true) {
      await add(_gameHelper!.current);
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

  Future<void> _initGameHelper(bool isNewLevel) async {
    if (buildContext == null ||
        gameMode == null ||
        _currentLevel == null ||
        _background == null) {
      return;
    }

    final helper = <GameHelp>[];
    if (gameMode!.helpNeeded) {
      final middleBoundary = _currentLevel!.map.track.middleBoundary
          ?.map((e) => _background!.getImageToScreen(e))
          .toList();

      final player = PlayerComponent(_currentLevel!.player);
      final _playerBody = PlayerBody(await player.onLoad(),
          _background!.getImageToScreen(_currentLevel!.startPosition),
          preview: true);

      final movementHelp = GameHelp(
        boundary: middleBoundary,
        rightArrow: true,
        helpText: S.of(buildContext!).overlayHelpTapToTurnText,
        imagePath: 'icons/ic_gesture_tap.png',
        // player: _playerBody // TODO: Position and scale is wrong
      );

      final gamePlayHelp = GameHelp(
        boundary: middleBoundary,
        bottomArrow: true,
        topArrow: true,
        helpText: S.of(buildContext!).overlayHelpStayOnMapText,
      );

      helper.add(movementHelp);
      helper.add(gamePlayHelp);
    } else if (gameMode!.isCareer && isNewLevel) {
      // Show name of new level in career mode
      final levelIndex =
          S.of(buildContext!).overlayHelpLevelName(_currentLevel!.id + 1);
      final mapName = _currentLevel!.map.name;
      final levelName = GameHelp(
        helpText: '$levelIndex: $mapName',
        textPosition: GamePosition.top,
      );

      helper.add(levelName);
    }

    // Add level specific help
    if (gameMode!.levelHelpText != null) {
      final goalHelp = GameHelp(
        helpText: gameMode!.levelHelpText,
        textPosition: GamePosition.center,
      );

      helper.add(goalHelp);
    }

    // Show tap to begin only for first gameplay
    if (gameMode!.helpNeeded) {
      final tapToBegin = GameHelp(
        helpText: S.of(buildContext!).overlayHelpTapToStartText,
        textPosition: GamePosition.center,
      );

      helper.add(tapToBegin);
    }

    _gameHelper = helper.iterator;
  }

  Future<void> _addGameComponents() async {
    Boundary innerBoundary, outerBoundary;

    if (_currentLevel == null) return;
    if (_background == null) return;
    if (gameMode == null) return;

    final ghostMode = gameMode!.ghostMode;
    final player = PlayerComponent(_currentLevel!.player);
    await add(_playerBody = PlayerBody(await player.onLoad(),
        _background!.getImageToScreen(_currentLevel!.startPosition),
        counterclockwise: !ghostMode));

    await add(outerBoundary = Boundary(
        collisionDetected: _onCollisionDetected,
        vertices: _currentLevel!.map.track.outerBoundary.vertices
            .map((vertex) => _background!.getImageToScreen(vertex))
            .toList()));
    await add(innerBoundary = Boundary(
        collisionDetected: _onCollisionDetected,
        vertices: _currentLevel!.map.track.innerBoundary.vertices
            .map((vertex) => _background!.getImageToScreen(vertex))
            .toList()));

    _gameComponents = {_playerBody!, outerBoundary, innerBoundary};
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_collisionDetected) {
      _collisionDetected = false;
      _timerService.cancel();
      _onGameOver();
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (_currentLevel == null) return;

    // Ignore tap during zoom effect
    if (_background?.animationEnabled == true &&
        _background?.animationCompleted == false) {
      return;
    }

    // Iterate over GameHelpers on firstLaunch
    if (_gameHelpShown && _gameHelper != null) {
      remove(_gameHelper!.current);
      if (_gameHelper!.moveNext()) {
        add(_gameHelper!.current);
        return;
      }

      // Show countdown only for first gameplay or for level specific help
      if (gameMode?.helpNeeded == true ||
          _currentLevel!.helpText?.isNotEmpty == true) {
        _swapMenuOverlay(kCountDownOverlay);
      } else {
        startGame();
      }

      _gameHelpShown = false;
      return;
    }

    _playerBody?.spin();
    return super.onTapDown(info);
  }

  void _onCollisionDetected() {
    _collisionDetected = true;
    _audioService.playDropSound(kAudioToiletDropSound);
  }

  Future<void> _onGameOver() async {
    for (var c in _gameComponents) {
      remove(c);
    }

    // Start menu background music before gameOverCallback because ads should be able to stop music again.
    await _audioService.playBackgroundMusic(menu: true);

    await _updateScoreAndAchievements().then((hasWon) async {
      // ask for review
      if (hasWon && gameMode?.shouldAskForReview() == true) {
        await mayShowInAppReview();
      } else {
        // show ad
        await _adService.mayShow(
            onAdClosed: () => _audioService.playBackgroundMusic(menu: true),
            onAdShown: () => _audioService.stopBackgroundMusic());

        // Short delay to prevent possible game start before ad is shown
        await Future.delayed(const Duration(milliseconds: 150));
      }

      _swapMenuOverlay(kGameOverMenu);
    });
  }

  /// Updates score and achievement status async in background.
  Future<bool> _updateScoreAndAchievements() async {
    final _gameService = locator<GameService>();
    final score = _timerService.seconds.value;

    if (score != null) {
      var hasWon = await gameMode?.updateScoreAndAchievements(score) ?? false;
      await _gameService.submitScore(score);
      return hasWon;
    }

    return false;
  }

  /// Ask user for review if his progress is at [kMinProgressAskForReview]
  /// and he was not asked more than [kMaxTimesAskForReview].
  Future<void> mayShowInAppReview() async {
    final InAppReview inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      // ignore: unawaited_futures
      inAppReview.requestReview().then((_) async {
        var timesAskedForReview =
            _prefService.getInt(kPrefKeyTimesAskedForReview) ?? 0;
        await _prefService.setInt(
            kPrefKeyTimesAskedForReview, ++timesAskedForReview);
      });
    }
  }

  void showStartMenu() => _swapMenuOverlay(kStartMenu);
  void showCreditsMenu() => _swapMenuOverlay(kCreditsMenu);
  void showLeaderboardMenu() => _swapMenuOverlay(kLeaderboardMenu);

  /// Removes all active overlays in favor of [overlayName]
  void _swapMenuOverlay(String overlayName) {
    overlays.clear();
    overlays.add(overlayName);
  }
}

import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flutter/foundation.dart';
import 'package:games_services/games_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';
import 'package:toilet_racer/components/background.dart';
import 'package:toilet_racer/components/boundary.dart';
import 'package:toilet_racer/components/controller.dart';
import 'package:toilet_racer/components/help_text.dart';
import 'package:toilet_racer/components/player.dart';
import 'package:toilet_racer/services/audio_service.dart';
import 'package:toilet_racer/services/timer_service.dart';
import 'package:vector_math/vector_math_64.dart';

import 'components/removable_sprite_animation_component.dart';
import 'game/level.dart';

typedef AsyncCallback = Future<void> Function();

class RaceGame extends Forge2DGame with HasTapableComponents {
  static const double defaultScale = 4.0;

  final SharedPreferences _prefService = locator<SharedPreferences>();
  final AudioService _audioService = locator<AudioService>();
  final TimerService _timerService = locator<TimerService>();

  @override
  bool debugMode = kDebugMode;

  bool _musicEnabled = true;
  bool _showHelp = true;
  bool _collisionDetected = false;

  AsyncCallback roundEndCallback;

  Player player;
  Controller controller;
  HelpText controlHelpText;

  List<Sprite> flySprites;

  Boundary innerBoundary;
  Boundary outerBoundary;

  Background background;
  Level level;

  BoundaryContactCallback contactCallback;

  RaceGame({this.roundEndCallback})
      : super(scale: defaultScale, gravity: Vector2(0, 0)) {
    _init();
  }

  PositionComponent flyComponent() {
    final flySpriteAnimation =
        SpriteAnimation.spriteList(flySprites, stepTime: 0.1);
    return RemovableSpriteAnimationComponent(
        Vector2(172, 116) * 20 / 172, flySpriteAnimation);
  }

  @override
  Future<void> onLoad() async {
    final flyImages = await Flame.images
        .loadAll(['players/fly_1@2x.png', 'players/fly_2@2x.png']);
    flySprites = flyImages.map((image) => Sprite(image)).toList();

    level = Level.toilet3;
    await level.onLoad();
    await add(background = Background(level));

    _showMenu();
  }

  @override
  void onResize(Vector2 size) {
    super.onResize(size);

    if (background != null) {
      viewport.scale = defaultScale * background.scale;
    }
  }

  void _init() {
    _musicEnabled = _prefService.getBool(prefKeyMusicEnabled) ?? _musicEnabled;
    _showHelp = _prefService.getBool(prefKeyShowHelp) ?? _showHelp;

    if (_musicEnabled) {
      _audioService.playBgMusic();
    }
  }

  void _showMenu() {
    overlays.add(startMenu);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_collisionDetected) {
      pauseGame();
      _collisionDetected = false;
    }
  }

  void startGame() async {
    await add(player = Player(
        flyComponent(), background.getImageToScreen(level.startPosition)));
    await add(outerBoundary = Boundary(level.track.outerBoundary
        .map((vertex) => background.getImageToScreen(vertex))
        .toList()));
    await add(innerBoundary = Boundary(level.track.innerBoundary
        .map((vertex) => background.getImageToScreen(vertex))
        .toList()));

    addContactCallback(
        contactCallback = BoundaryContactCallback(collisionDetected));
    await add(controller = Controller(player));

    if (_showHelp) {
      await add(controlHelpText = HelpText());
      _showHelp = false;
      await _prefService.setBool(prefKeyShowHelp, _showHelp);
    }

    overlays.remove(startMenu);
    overlays.add(overlayUi);
    _timerService.start();
  }

  void pauseGame() async {
    remove(player);
    remove(innerBoundary);
    remove(outerBoundary);
    remove(controller);
    removeContactCallback(contactCallback);

    if (_showHelp) {
      remove(controlHelpText);
    }
    overlays.remove(overlayUi);

    await roundEndCallback();
    _showMenu();
  }

  void collisionDetected() async {
    _collisionDetected = true;
    _timerService.cancel();

    await GamesServices.submitScore(
      score: Score(
        androidLeaderboardID: kAndroidLeaderBoard,
        value: _timerService.seconds.value,
      ),
    );

    [kPlayCountLevel1, kPlayCountLevel2, kPlayCountLevel3]
        .forEach((achievementId) {
      GamesServices.increment(
        achievement: Achievement(androidID: achievementId, steps: 1),
      );
    });

    // Bug in audioplayers https://github.com/luanpotter/audioplayers/issues/738
    _audioService.playDropSound(audioToiletDropSound);
  }
}

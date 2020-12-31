import 'dart:ui';

import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/components/sprite_component.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';
import 'package:toilet_racer/components/controller.dart';
import 'package:toilet_racer/components/driver.dart';
import 'package:toilet_racer/components/help_text.dart';
import 'package:toilet_racer/services/audio_service.dart';
import 'package:vector_math/vector_math_64.dart';

class RaceGame extends Forge2DGame with HasTapableComponents {
  final SharedPreferences _prefService = locator<SharedPreferences>();
  bool _musicEnabled = true;
  bool _showHelp = true;

  Driver driver;
  Controller controller;
  HelpText controlHelpText;

  Image driverImage;

  RaceGame(Vector2 screenSize) : super(scale: 4.0, gravity: Vector2(0, 0)) {
    size.setFrom(screenSize);
    _init();

    _showMenu();
  }

  @override
  Future<void> onLoad() async {
    driverImage = await Flame.images.load('drivers/tomato_anim.png');
    await add(SpriteComponent.fromImage(
        size, await Flame.images.load('roads/toilet.jpg')));
  }

  void _init() {
    _musicEnabled = _prefService.getBool(prefKeyMusicEnabled) ?? _musicEnabled;
    _showHelp = _prefService.getBool(prefKeyShowHelp) ?? _showHelp;

    FlameAudio.bgm.initialize();
    if (_musicEnabled) {
      AudioService().playMusic();
    }
  }

  void _showMenu() {
    overlays.add(startMenu);
  }

  void startGame() {
    add(driver = Driver(driverImage, pauseGame));
    add(controller = Controller(driver));

    if (_showHelp) {
      add(controlHelpText = HelpText());
      _showHelp = false;
      _prefService.setBool(prefKeyShowHelp, _showHelp);
    }

    overlays.remove(startMenu);
    overlays.add(overlayUi);
  }

  void pauseGame() {
    remove(driver);
    remove(controller);

    if (_showHelp) {
      remove(controlHelpText);
    }
    overlays.remove(overlayUi);
    _showMenu();
  }

  void quitGame() =>
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
}

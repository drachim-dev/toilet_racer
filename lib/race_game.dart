import 'dart:ui';

import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/game/base_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';
import 'package:toilet_racer/services/audio_service.dart';
import 'package:toilet_racer/components/background.dart';
import 'package:toilet_racer/components/controller.dart';
import 'package:toilet_racer/components/driver.dart';
import 'package:toilet_racer/views/start_menu.dart';
import 'package:toilet_racer/views/overlay_ui.dart';

// Extend Box2DGame class to use a physics engine
class RaceGame extends BaseGame with HasTapableComponents, HasWidgetsOverlay {
  final SharedPreferences _prefService = locator<SharedPreferences>();
  final Size gameSize;
  bool _musicEnabled = true;

  Driver driver;
  Controller controller;

  RaceGame(this.gameSize) {
    Flame.bgm.initialize();

    _musicEnabled = _prefService.getBool(prefKeyMusicEnabled) ??
        _musicEnabled;
    if (_musicEnabled) {
      AudioService().playMusic();
    }

    add(Background(gameSize));
    _showMenu();
  }

  void _showMenu() {
    addWidgetOverlay(
        startMenu,
        StartMenu(
          startGame: _startGame,
          quitGame: _quitGame,
        ));
  }

  void _startGame() {
    add(driver = Driver(gameSize, _pauseGame));
    add(controller = Controller(gameSize, driver));

    removeWidgetOverlay(startMenu);
    addWidgetOverlay(
      overlayUi,
      OverlayUi(soundEnabled: _musicEnabled),
    );
  }

  void _pauseGame() {
    markToRemove(controller);
    markToRemove(driver);
    removeWidgetOverlay(overlayUi);
    _showMenu();
  }

  void _quitGame() =>
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
}

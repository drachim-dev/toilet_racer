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
import 'package:toilet_racer/components/background.dart';
import 'package:toilet_racer/components/controller.dart';
import 'package:toilet_racer/components/driver.dart';
import 'package:toilet_racer/components/help_text.dart';
import 'package:toilet_racer/services/audio_service.dart';
import 'package:toilet_racer/views/overlay_ui.dart';
import 'package:toilet_racer/views/start_menu.dart';

// Extend Box2DGame class to use a physics engine
class RaceGame extends BaseGame with HasTapableComponents, HasWidgetsOverlay {
  final SharedPreferences _prefService = locator<SharedPreferences>();
  final Size gameSize;
  bool _musicEnabled = true;
  bool _showHelp = true;

  Driver driver;
  Controller controller;
  HelpText controlHelpText;

  RaceGame(this.gameSize) {
    _init();

    add(Background(gameSize));
    _showMenu();
  }

  void _init() {
    _musicEnabled = _prefService.getBool(prefKeyMusicEnabled) ?? _musicEnabled;
    _showHelp = _prefService.getBool(prefKeyShowHelp) ?? _showHelp;

    Flame.bgm.initialize();
    if (_musicEnabled) {
      AudioService().playMusic();
    }
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

    if (_showHelp) {
      add(controlHelpText = HelpText(gameSize));
      _showHelp = false;
      _prefService.setBool(prefKeyShowHelp, _showHelp);
    }

    removeWidgetOverlay(startMenu);
    addWidgetOverlay(
      overlayUi,
      OverlayUi(soundEnabled: _musicEnabled),
    );
  }

  void _pauseGame() {
    markToRemove(driver);
    markToRemove(controller);
    markToRemove(controlHelpText);
    removeWidgetOverlay(overlayUi);
    _showMenu();
  }

  void _quitGame() =>
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
}

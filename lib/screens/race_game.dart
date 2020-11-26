import 'dart:ui';

import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/game.dart';
import 'package:flame/game/base_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toilet_racer/constants.dart';
import 'package:toilet_racer/views/background.dart';
import 'package:toilet_racer/views/controller.dart';
import 'package:toilet_racer/views/driver.dart';
import 'package:toilet_racer/views/game_menu.dart';

// Extend Box2DGame class to use a physics engine
class RaceGame extends BaseGame with HasTapableComponents, HasWidgetsOverlay {
  final Size gameSize;
  Driver driver;
  Controller controller;

  RaceGame(this.gameSize) {
    add(Background(gameSize));

    _showMenu();
  }

  void _showMenu() {
    addWidgetOverlay(
        gameMenu,
        GameMenu(
          startGame: _startGame,
          quitGame: _quitGame,
        ));
  }

  void _startGame() {
    add(driver = Driver(gameSize, _pauseGame));
    add(controller = Controller(gameSize, driver));

    removeWidgetOverlay(gameMenu);
  }

  void _pauseGame() {
    markToRemove(controller);
    markToRemove(driver);
    _showMenu();
  }

  void _quitGame() =>
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
}



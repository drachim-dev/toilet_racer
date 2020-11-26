import 'dart:ui';

import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/game/base_game.dart';
import 'package:toilet_racer/views/background.dart';
import 'package:toilet_racer/views/controller.dart';
import 'package:toilet_racer/views/driver.dart';

// Extend Box2DGame class to use a physics engine
class RaceGame extends BaseGame with HasTapableComponents {
  Driver driver;
  Controller controller;

  RaceGame(Size gameSize) {
    add(Background(gameSize));
    add(driver = Driver(gameSize));
    add(controller = Controller(gameSize, driver));
  }

}

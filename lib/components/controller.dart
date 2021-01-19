import 'dart:ui';

import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/components/position_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:toilet_racer/components/player.dart';

class Controller extends PositionComponent with Tapable {
  static final Paint _paint = Paint()..color = Colors.transparent;
  static const double _height = 140.0;

  Vector2 _gameSize;
  final Driver driver;
  final Player player;

  Controller(this.driver, this.player);

  @override
  void render(Canvas c) {
    super.render(c);
    c.drawRect(
        Rect.fromLTWH(0, _gameSize.y - _height, _gameSize.x, _height), _paint);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_gameSize == null) {
      return;
    }
  }

  @override
  Rect toRect() {
    return Rect.fromLTWH(0, _gameSize.y - _height, _gameSize.x, _height);
  }

  @override
  bool onTapDown(TapDownDetails details) {
    //driver.move();
    player.body.applyAngularImpulse(200);
    return super.onTapDown(details);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    _gameSize = gameSize;
  }
}

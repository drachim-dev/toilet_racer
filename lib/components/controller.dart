import 'dart:ui';

import 'package:flame/components/position_component.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flutter/material.dart';
import 'package:toilet_racer/components/driver.dart';

class Controller extends Component with Tapable {
  static final Paint _paint = Paint()..color = Colors.transparent;
  static const double _height = 140.0;

  final Size gameSize;
  final Driver driver;

  Controller(this.gameSize, this.driver);

  @override
  void render(Canvas c) {
    c.drawRect(
        Rect.fromLTWH(0, gameSize.height - _height, gameSize.width, _height),
        _paint);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }

  @override
  Rect toRect() {
    return Rect.fromLTWH(0, gameSize.height - _height, gameSize.width, _height);
  }

  @override
  void onTapDown(TapDownDetails details) {
    super.onTapDown(details);

    driver.move();
  }
}

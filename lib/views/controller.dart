import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flutter/material.dart';
import 'package:toilet_racer/views/driver.dart';

class Controller extends Component with Tapable {
  static final Paint _paint = Paint()..color = Colors.black.withAlpha(50);

  final Size gameSize;
  final Driver driver;

  Controller(this.gameSize, this.driver);

  @override
  void render(Canvas c) {
    c.drawOval(
        Rect.fromLTWH(0, gameSize.height - 100, gameSize.width, 100), _paint);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }

  @override
  Rect toRect() {
    return Rect.fromLTWH(0, gameSize.height - 100, gameSize.width, 100);
  }

  @override
  void onTapDown(TapDownDetails details) {
    super.onTapDown(details);

    driver.move();
  }

}

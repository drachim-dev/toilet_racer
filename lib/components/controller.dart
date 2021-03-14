import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:toilet_racer/components/player_body.dart';

class Controller extends PositionComponent with Tapable, HasGameRef {
  static final Paint _paint = Paint()..color = Colors.transparent;
  static const double _height = 140.0;

  final PlayerBody playerBody;

  Controller(this.playerBody);

  @override
  void render(Canvas c) {
    super.render(c);
    c.drawRect(
        Rect.fromLTWH(0, gameRef.size.y - _height, gameRef.size.x, _height),
        _paint);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameRef.size == null) {
      return;
    }
  }

  @override
  Rect toRect() {
    return Rect.fromLTWH(0, gameRef.size.y - _height, gameRef.size.x, _height);
  }

  @override
  bool onTapDown(TapDownDetails details) {
    playerBody.spin();
    return super.onTapDown(details);
  }
}

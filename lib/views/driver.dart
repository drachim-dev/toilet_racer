import 'dart:math';
import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/mixins/resizable.dart';

class Driver extends AnimationComponent with Resizable {
  static const ACCELERATION = 20.0;

  bool frozen = true;
  double speed = 10;

  @override
  double angle = 0;

  Size gameSize;

  Driver(this.gameSize)
      : super.sequenced(96, 96, 'drivers/tomato_anim.png', 100,
            textureWidth: 96, textureHeight: 96) {
    anchor = Anchor.center;
  }

  void reset() {
    x = gameSize.width / 2;
    y = gameSize.height / 1.4;

    speed = 10;
    angle = 0;

    frozen = true;
  }

  @override
  void resize(Size size) {
    super.resize(size);

    reset();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!frozen) {
      x += (speed * dt) * cos(angle);
      y += (speed * dt) * sin(angle);

      speed += ACCELERATION * dt;

      if (y > gameSize.height || y < 0 || x > gameSize.width || x < 0) reset();
    }
  }

  void move() {
    if (frozen) {
      frozen = false;
    } else {
      turn();
    }
  }

  void turn() {
    angle -= 0.4;
  }
}

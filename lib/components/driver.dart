import 'dart:math';
import 'dart:ui';

import 'package:vector_math/vector_math_64.dart';
import 'package:flame/anchor.dart';
import 'package:flame/components/sprite_animation_component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/extensions/vector2.dart';
import 'package:toilet_racer/app/locator.dart';
import 'package:toilet_racer/services/audio_service.dart';

class Driver extends SpriteAnimationComponent with Resizable {
  static const ACCELERATION = 20.0;

  final Function pauseGame;
  final AudioService _audioService = locator<AudioService>();

  bool frozen = true;
  double speed = 10;

  @override
  double angle = 0;

  Driver(Image image, this.pauseGame)
      : super.sequenced(Vector2(96, 96), image, 135,
            textureSize: Vector2(96, 96), stepTime: 0.1) {
    //'drivers/tomato_anim.png'
    anchor = Anchor.center;
  }

  void reset() {
    x = gameSize.toSize().width / 2;
    y = gameSize.toSize().height / 1.4;

    speed = 10;
    angle = 0;

    frozen = true;
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);

    reset();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!frozen) {
      x += (speed * dt) * cos(angle);
      y += (speed * dt) * sin(angle);

      speed += ACCELERATION * dt;

      if (y > gameSize.toSize().height ||
          y < 0 ||
          x > gameSize.toSize().width ||
          x < 0) {
        _audioService.playDropSound('fart.mp3');
        reset();
        pauseGame();
      }
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

import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flame/sprite_animation.dart';
import 'package:flame_forge2d/contact_callbacks.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_forge2d/sprite_body_component.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:flame/anchor.dart';
import 'package:flame/components/sprite_animation_component.dart';
import 'package:flame/extensions/vector2.dart';
import 'package:toilet_racer/app/locator.dart';
import 'package:toilet_racer/services/audio_service.dart';
import 'package:flutter/material.dart' as material;

import 'boundary.dart';

class Player extends SpriteBodyComponent {
  double angle = math.pi / 2;
  bool shouldDestroy = false;

  Player(Image image) : super(Sprite(image), Vector2(15, 12));

  @override
  Body createBody() {
    final shape = CircleShape();
    shape.radius = 3;
    final fixtureDef = FixtureDef()
      ..shape = shape
      ..restitution = 0.8
      ..density = 1.0
      ..friction = 0.1;

    final bodyDef = BodyDef()
      ..userData = this
      // To be able to determine object in collision
      //..setUserData(this)
      ..position = Vector2(0, -35)
      ..type = BodyType.DYNAMIC
      ..angularDamping = 5
      ..linearDamping = 1
      //..linearVelocity = Vector2(5, 0)
      ..angle = math.pi / 2;
    //..angularVelocity = 1
    //..angularDamping = 0.5;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void renderCircle(Canvas c, Offset center, double radius) {
    super.renderCircle(c, center, radius);
    final angle = body.getAngle();
    final lineRotation =
        Offset(math.sin(angle) * radius, math.cos(angle) * radius);
    c.drawLine(center, center + lineRotation, Paint()..strokeWidth = 2);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (shouldDestroy) {
      //gameRef.remove(this);
      //world.destroyBody(body);
      //remove();
    } else {
      final force = Rot.mulVec2(
          Rot.withAngle(body.getAngle()), Vector2(0, -1)..scale(300));
      body.applyForce(force);
      //body.applyForceToCenter(force);
    }
  }
}

class BoundaryContactCallback extends ContactCallback<Player, Boundary> {
  final Function collisionDetected;

  BoundaryContactCallback(this.collisionDetected);

  @override
  void begin(Player player, Boundary boundary, Contact contact) {
    boundary.paint.color = material.Colors.red;
    //player.shouldDestroy = true;
    collisionDetected();
  }

  @override
  void end(Player player, Boundary boundary, Contact contact) {}
}

class Driver extends SpriteAnimationComponent {
  static const ACCELERATION = 20.0;

  final Function pauseGame;
  final AudioService _audioService = locator<AudioService>();

  Vector2 _gameSize;

  bool frozen = true;
  double speed = 10;

  @override
  double angle = 0;

  Driver(Image image, this.pauseGame)
      : super.fromFrameData(
            Vector2(96, 96),
            image,
            SpriteAnimationData.sequenced(
              amount: 135,
              amountPerRow: 135,
              textureSize: Vector2(96, 96),
              stepTime: 0.1,
              loop: true,
            )) {
    //'drivers/tomato_anim.png'
    anchor = Anchor.center;
  }

  void reset() {
    x = _gameSize.x / 2;
    y = _gameSize.y / 1.4;

    speed = 10;
    angle = 0;

    frozen = true;
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    _gameSize = gameSize;

    reset();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_gameSize == null) {
      return;
    }

    if (!frozen) {
      x += (speed * dt) * math.cos(angle);
      y += (speed * dt) * math.sin(angle);

      speed += ACCELERATION * dt;

      if (y > _gameSize.y || y < 0 || x > _gameSize.toSize().width || x < 0) {
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

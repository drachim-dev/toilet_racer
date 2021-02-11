import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_forge2d/contact_callbacks.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_forge2d/sprite_body_component.dart';
import 'package:flutter/foundation.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:flutter/material.dart' as material;

import 'boundary.dart';

class Player extends SpriteBodyComponent {
  final Vector2 startPosition;
  final double ACCELERATION = 60;
  double speed = 300.0;
  double angle = math.pi / 2;
  bool shouldDestroy = false;

  Player({@required Image image, @required this.startPosition})
      : assert(image != null),
        assert(startPosition != null),
        super(Sprite(image), Vector2(15, 12));

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
      ..position = viewport.getScreenToWorld(startPosition)
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
      speed += ACCELERATION * dt;
      final force = Rot.mulVec2(
          Rot.withAngle(body.getAngle()), Vector2(0, -1)..scale(speed));
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

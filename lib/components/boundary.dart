import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/contact_callbacks.dart';
import 'package:forge2d/forge2d.dart';
import 'package:flutter/material.dart';
import 'package:toilet_racer/components/player_body.dart';

import 'package:flutter/material.dart' as material;

class Boundary extends BodyComponent with ContactCallbacks {
  final Function collisionDetected;
  final List<Vector2> vertices;

  Boundary({required this.collisionDetected, required this.vertices});

  @override
  Future<void> onLoad() {
    debugMode = gameRef.debugMode;

    return super.onLoad();
  }

  @override
  Color get debugColor => Colors.white.withAlpha(150);

  @override
  Body createBody() {
    paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = debugMode ? debugColor : Colors.transparent
      ..strokeWidth = 1.5;

    final shape = ChainShape()
      ..createLoop(
          vertices.map((vertex) => gameRef.screenToWorld(vertex)).toList());

    final fixtureDef = FixtureDef(shape);
    final bodyDef = BodyDef()..userData = this;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is PlayerBody) {
      paint.color = material.Colors.red;
      collisionDetected();
    }
  }
}

import 'package:flame_forge2d/body_component.dart';
import 'package:flutter/rendering.dart';
import 'package:forge2d/forge2d.dart';
import 'package:flutter/material.dart';

class Boundary extends BodyComponent {
  final double _factor;

  Boundary(this._factor);

  @override
  Body createBody() {
    paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white.withAlpha(100)
      ..strokeWidth = 2;

    final shape = ChainShape();
    final f = _factor;
    shape.createLoop([
      Vector2(-1 * f, -2 * f),
      Vector2(-2 * f, -1 * f),
      Vector2(-2 * f, 1 * f),
      Vector2(-1 * f, 2 * f),
      Vector2(1 * f, 2 * f),
      Vector2(2 * f, 1 * f),
      Vector2(2 * f, -1 * f),
      Vector2(1 * f, -2 * f)
    ]);
    final fixtureDef = FixtureDef()..shape = shape;
    final bodyDef = BodyDef()..userData = this;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

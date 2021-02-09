import 'package:flame_forge2d/body_component.dart';
import 'package:flutter/rendering.dart';
import 'package:forge2d/forge2d.dart';
import 'package:flutter/material.dart';

class Boundary extends BodyComponent {
  final List<Vector2> _vertices;

  Boundary(this._vertices);

  @override
  Body createBody() {
    paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white.withAlpha(200)
      ..strokeWidth = 2;

    final shape = ChainShape()
      ..createLoop(_vertices
          .map((vertex) => viewport.getScreenToWorld(vertex))
          .toList());

    final fixtureDef = FixtureDef()..shape = shape;
    final bodyDef = BodyDef()..userData = this;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

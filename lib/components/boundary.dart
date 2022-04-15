import 'package:flame_forge2d/body_component.dart';
import 'package:forge2d/forge2d.dart';
import 'package:flutter/material.dart';

class Boundary extends BodyComponent {
  final List<Vector2> _vertices;

  Boundary(this._vertices);

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
          _vertices.map((vertex) => gameRef.screenToWorld(vertex)).toList());

    final fixtureDef = FixtureDef(shape);
    final bodyDef = BodyDef()..userData = this;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

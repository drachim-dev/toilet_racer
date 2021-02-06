import 'package:flame_forge2d/body_component.dart';
import 'package:flutter/rendering.dart';
import 'package:forge2d/forge2d.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Boundary extends BodyComponent {
  final double _width, _height, _scaleFactor;

  Boundary(this._width, this._height, this._scaleFactor);

  @override
  Body createBody() {
    paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white.withAlpha(200)
      ..strokeWidth = 2;

    final shape = createEllipse(_width, _height, 16);
    final fixtureDef = FixtureDef()..shape = shape;
    final bodyDef = BodyDef()..userData = this;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  ChainShape createEllipse(double width, double height, int steps) {
    var ellipse = ChainShape();
    var verts = <Vector2>[];

    for (var i = 0; i < steps; i++) {
      var t = (i * 2 * math.pi) / steps;

      var x = width * _scaleFactor;
      var y = height * _scaleFactor;

      var vert = Vector2(x * math.cos(t), y * math.sin(t));
      verts.add(vert);
    }

    ellipse.createLoop(verts);
    return ellipse;
  }
}
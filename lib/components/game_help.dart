import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

class GameHelp extends Component {
  static final TextConfig _textConfig = TextConfig(
    fontSize: 56.0,
    color: Colors.white,
    fontFamily: 'NerkoOne',
    textAlign: TextAlign.center,
  );

  static final Paint _paint = Paint()
    ..color = Colors.white
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..strokeWidth = 10.0
    ..style = PaintingStyle.stroke;

  final List<Vector2> boundary;
  final bool darken, bottomArrow, topArrow;
  final String helpText;

  Vector2 _gameSize;

  GameHelp({
    this.boundary,
    this.darken = true,
    this.bottomArrow = false,
    this.topArrow = false,
    this.helpText,
  });

  @override
  void render(Canvas c) {
    // darken background
    if (darken) {
      c.drawColor(Colors.black26, BlendMode.darken);
    }

    if (bottomArrow || topArrow) {
      // calculate middle y position
      boundary.sort((a, b) => a.y.compareTo(b.y));
      final middleY = (boundary.first.y + boundary.last.y) / 2;

      if (bottomArrow) {
        _drawBottomArrow(c, middleY);
      }

      if (topArrow) {
        _drawTopArrow(c, middleY);
      }
    }

    // draw hint text
    if (helpText.isNotEmpty) {
      final position = Vector2(_gameSize.x / 2, kGameScreenMargin);
      _textConfig.render(c, helpText, position, anchor: Anchor.topCenter);
    }
  }

  void _drawBottomArrow(Canvas c, double middleY) {
    // get lower half and sort by x asc
    final vertices = boundary.where((element) => element.y > middleY).toList()
      ..sort((a, b) => a.x.compareTo(b.x));

    _drawArrow(c, vertices);
  }

  void _drawTopArrow(Canvas c, double middleY) {
    // get upper half and sort by x desc
    final vertices = boundary.where((element) => element.y < middleY).toList()
      ..sort((a, b) => b.x.compareTo(a.x));

    _drawArrow(c, vertices);
  }

  void _drawArrow(Canvas c, List<Vector2> vertices) {
    final path = Path();
    for (var i = 0; i < vertices.length - 1; i++) {
      var element = vertices[i];
      var nextElement = vertices[i + 1];
      
      path.moveTo(element.x, element.y);
      path.quadraticBezierTo(
          element.x, element.y, nextElement.x, nextElement.y);

      if (nextElement == vertices.last) {
        _drawArrowHead(c, element, nextElement, 40.0);
      }
    }

    c.drawPath(path, _paint);
  }

  void _drawArrowHead(Canvas c, Vector2 from, Vector2 to, double length) {
    final dx = to.x - from.x;
    final dy = to.y - from.y;
    final angle = atan2(dy, dx);

    final p1 = Offset(to.x - length * cos(angle + pi / 6),
        to.y - length * sin(angle + pi / 6));
    final p2 = Offset(to.x, to.y);
    final p3 = Offset(to.x - length * cos(angle - pi / 6),
        to.y - length * sin(angle - pi / 6));

    final head = Path()..addPolygon([p1, p2, p3], false);
    c.drawPath(head, _paint);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_gameSize == null) {
      return;
    }
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    _gameSize = gameSize;
  }
}

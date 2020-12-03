import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

class HelpText extends Component {
  static final TextConfig helpTextConfig =
      TextConfig(fontSize: 36.0, color: Colors.white, fontFamily: 'NerkoOne');

  static final Paint _paint = Paint()
    ..color = Colors.white
    ..strokeWidth = 5.0
    ..style = PaintingStyle.stroke;

  final Size gameSize;

  HelpText(this.gameSize);

  @override
  void render(Canvas c) {
    var p1 = Offset(gameSize.width, gameSize.height - 225);
    var bend1 = Offset(p1.dx - 20, p1.dy + 120);
    var p2 = Offset(gameSize.width / 2 + 70, p1.dy + 150);

    var path = Path()
      ..moveTo(p1.dx, p1.dy)
      ..quadraticBezierTo(bend1.dx, bend1.dy, p2.dx, p2.dy)
      ..moveTo(p2.dx + 5, p2.dy - 25)
      ..quadraticBezierTo(p2.dx, p2.dy - 3, p2.dx - 15, p2.dy + 3)
      ..moveTo(p2.dx + 12, p2.dy + 20)
      ..quadraticBezierTo(p2.dx, p2.dy + 3, p2.dx - 15, p2.dy + 3);

    c.drawPath(path, _paint);

    helpTextConfig.render(c, 'Tap here', Vector2(p2.dx - 40, p2.dy + 5),
        anchor: Anchor.centerRight);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}

import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/components/player_body.dart';

class GameHelp extends PositionComponent with HasGameRef {
  static const baseTextConfig = TextStyle(
    fontSize: 56.0,
    color: Colors.white,
    fontFamily: 'NerkoOne',
  );

  static final Paint _paint = Paint()
    ..color = Colors.white
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..strokeWidth = 10.0
    ..style = PaintingStyle.stroke;

  static const double _arrowLength = 40.0;

  final List<Vector2>? boundary;
  final bool darken, bottomArrow, topArrow, leftArrow, rightArrow;
  final String? helpText;
  final GamePosition textPosition;
  final String? imagePath;

  final PlayerBody? player;

  late Vector2 _screenSize;

  GameHelp({
    this.boundary,
    this.darken = true,
    this.bottomArrow = false,
    this.topArrow = false,
    this.leftArrow = false,
    this.rightArrow = false,
    this.helpText,
    this.imagePath,
    this.textPosition = GamePosition.top,
    this.player,
  }) {
    positionType = PositionType.viewport;
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    _screenSize = gameRef.camera.viewport.effectiveSize.clone();
  }

  @override
  Future<void> onLoad() async {
    if (imagePath != null) {
      final image = await Flame.images.load(imagePath!);
      final component =
          SpriteComponent.fromImage(image, size: Vector2(192, 192))
            ..position = Vector2(_screenSize.x / 2 - kGameScreenMargin,
                _screenSize.y - kGameScreenMargin)
            ..anchor = Anchor.centerLeft
            ..angle = -pi / 6;

      await add(component);
    }

    if (player != null) {
      await add(player!);
    }
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // darken background
    if (darken) {
      canvas.drawColor(Colors.black54, BlendMode.darken);
    }

    if (boundary != null) {
      if (bottomArrow || topArrow) {
        // calculate middle y position
        boundary!.sort((a, b) => a.y.compareTo(b.y));
        final middleY = (boundary!.first.y + boundary!.last.y) / 2;

        if (bottomArrow) {
          _drawBottomArrow(boundary!, canvas, middleY);
        }
        if (topArrow) {
          _drawTopArrow(boundary!, canvas, middleY);
        }
      }

      if (leftArrow || rightArrow) {
        // calculate middle x position
        boundary!.sort((a, b) => a.x.compareTo(b.x));
        final middleX = (boundary!.first.x + boundary!.last.x) / 2;

        if (leftArrow) {
          _drawLeftArrow(boundary!, canvas, middleX);
        }

        if (rightArrow) {
          _drawRightArrow(boundary!, canvas, middleX);
        }
      }
    }

    // draw hint text
    if (helpText?.isNotEmpty == true) {
      Vector2 position;
      switch (textPosition) {
        case GamePosition.top:
          position = Vector2(_screenSize.x / 2, _screenSize.y / 6);
          break;
        case GamePosition.center:
          position = Vector2(_screenSize.x / 2, _screenSize.y / 2);
          break;
        case GamePosition.bottom:
          position = Vector2(_screenSize.x / 2, _screenSize.y / 6 * 5);
          break;
      }

      final context = gameRef.buildContext;
      if (context != null) {
        final textPaint = TextPaint(
            style: baseTextConfig, textDirection: Directionality.of(context));

        // TextBoxComponent can't align text within itself yet:
        // https://github.com/flame-engine/flame/issues/1088

/*       final textBoxComponent = TextBoxComponent(
          text: helpText,
          textRenderer: textPaint,
          boxConfig: TextBoxConfig(maxWidth: _screenSize.x - kGameScreenMargin),
          position: position)
        ..anchor = Anchor.center;

      add(textBoxComponent); */

        // text must be wrapped manually via linebreaks
        textPaint.render(canvas, helpText!, position, anchor: Anchor.center);
      }
    }
  }

  void _drawBottomArrow(List<Vector2> boundary, Canvas c, double middleY) {
    // get lower half and sort by x asc
    final vertices = boundary.where((element) => element.y > middleY).toList()
      ..sort((a, b) => a.x.compareTo(b.x));

    _drawArrow(boundary, c, vertices);
  }

  void _drawTopArrow(List<Vector2> boundary, Canvas c, double middleY) {
    // get upper half and sort by x desc
    final vertices = boundary.where((element) => element.y < middleY).toList()
      ..sort((a, b) => b.x.compareTo(a.x));

    _drawArrow(boundary, c, vertices);
  }

  void _drawLeftArrow(List<Vector2> boundary, Canvas c, double middleX) {
    // get left half and sort by y asc
    final vertices = boundary.where((element) => element.x < middleX).toList()
      ..sort((a, b) => a.y.compareTo(b.y));

    _drawArrow(boundary, c, vertices);
  }

  void _drawRightArrow(List<Vector2> boundary, Canvas c, double middleX) {
    // get right half and sort by y desc
    final vertices = boundary.where((element) => element.x > middleX).toList()
      ..sort((a, b) => b.y.compareTo(a.y));

    _drawArrow(boundary, c, vertices);
  }

  void _drawArrow(List<Vector2> boundary, Canvas c, List<Vector2> vertices) {
    final reducedArrow =
        vertices.skip((boundary.length * 0.05).round()).toList();

    final path = Path();
    for (var i = 0; i < reducedArrow.length - 1; i++) {
      final element = reducedArrow[i];
      final nextElement = reducedArrow[i + 1];

      path
        ..moveTo(element.x, element.y)
        ..quadraticBezierTo(element.x, element.y, nextElement.x, nextElement.y);

      if (nextElement == reducedArrow.last) {
        _drawArrowHead(c, element, nextElement, _arrowLength);
        c.drawPath(path, _paint);
      }
    }
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
}

enum GamePosition { top, center, bottom }

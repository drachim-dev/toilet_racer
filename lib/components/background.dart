import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart' hide Image;

class Level {
  static Level toilet = Level('roads/toilet.png',
      Rect.fromLTRB(15, 91, 190, 290), Vector2(0, 0)); // todo center
  static Level toilet2 = Level('roads/toilet2.jpg',
      Rect.fromLTRB(623, 470, 969, 828), Vector2(780, 670));

  /// The zone in the image that contains the relevant track for the game.
  final Rect trackZone;
  final String filePath;
  final Vector2 center;

  Image image;

  Level(this.filePath, this.trackZone, this.center);

  Future<void> onLoad() async {
    image = await Flame.images.load(filePath);
  }
}

class Background extends SpriteComponent with HasGameRef {
  final Level level;
  double scaleFactor;
  Vector2 center;

  Background(this.level) {
    sprite = Sprite(level.image);
  }

  @override
  void renderDebugMode(Canvas canvas) {
    super.renderDebugMode(canvas);
    overridePaint = Paint()..color = Colors.red.withAlpha(100);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);

    var trackDisplayZone = Rect.fromCenter(
        center: gameSize.toOffset() * 0.5, width: 300, height: 300);

    scaleFactor = trackDisplayZone.width / level.trackZone.width;
    size = sprite.srcSize * scaleFactor;

    var offset =
        trackDisplayZone.topLeft - level.trackZone.topLeft * scaleFactor;
    position = Vector2(offset.dx, offset.dy);
    center = position + level.center * scaleFactor;
  }
}

import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:toilet_racer/game/level.dart';

class Background extends SpriteComponent with HasGameRef {
  final Level level;
  double scale;

  Background(this.level) {
    assert(level.image != null);
    sprite = Sprite(level.image);
  }

  /// Calculates the corresponding screen coordinates from image pixel coordinates.
  Vector2 getImageToScreen(Vector2 imageCoordinates) {
    return imageCoordinates * scale + absoluteTopLeftPosition;
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);

    /// Defines where the track of the level is rendered on the screen.
    var trackScreenZone = Rect.fromCenter(
        center: gameSize.toOffset() * 0.5, width: 300, height: 300);

    scale = trackScreenZone.width / level.track.zone.width;
    size = sprite.srcSize * scale;

    var offset = trackScreenZone.topLeft - level.track.zone.topLeft * scale;
    position = Vector2(offset.dx, offset.dy);
  }
}

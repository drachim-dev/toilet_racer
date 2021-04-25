import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:toilet_racer/app/constants.dart';
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

    final minScreenSide =
        math.min(gameSize.toSize().width, gameSize.toSize().height) -
            kGameScreenMargin;

    /// Enlarge track to fill display size, but not more than Track.maxSize.
    final trackSize = minScreenSide > Track.maxSizeOnScreen
        ? Track.maxSizeOnScreen
        : minScreenSide;

    /// The track of the level that is rendered on the screen.
    final trackScreenZone = Rect.fromCenter(
        center: gameSize.toOffset() * 0.5, width: trackSize, height: trackSize);

    scale = trackScreenZone.width / level.track.zone.width;
    size = sprite.srcSize * scale;

    final offset = trackScreenZone.topLeft - level.track.zone.topLeft * scale;
    position = Vector2(offset.dx, offset.dy);
  }
}

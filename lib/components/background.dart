import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/game/level.dart';

class Background extends SpriteComponent with HasGameRef<Forge2DGame> {
  final Level level;
  double _imageScale;
  double worldScale;

  Background(this.level) {
    assert(level.image != null);
    sprite = Sprite(level.image);
    isHud = true;
  }

  /// Calculates the corresponding screen coordinates from image pixel coordinates.
  Vector2 getImageToScreen(Vector2 imageCoordinates) {
    return imageCoordinates * _imageScale + absoluteTopLeftPosition;
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);

    final screenSize = gameRef.viewport.effectiveSize.clone();

    final minScreenSide =
        math.min(screenSize.toSize().width, screenSize.toSize().height) -
            kGameScreenMargin;

    // Enlarge track to fill display size, but not more than Track.maxSize.
    final trackSize = minScreenSide > Track.maxSizeOnScreen
        ? Track.maxSizeOnScreen
        : minScreenSide;

    // The track of the level that is rendered on the screen.
    final trackScreenZone = Rect.fromCenter(
        center: screenSize.toOffset() * 0.5,
        width: trackSize,
        height: trackSize);

    // The scale factor the image has to be scaled with
    // to fit the track into the track track zone on the screen.
    _imageScale = trackScreenZone.width / level.track.zone.width;

    // Apply the scale to the background image
    size = sprite.srcSize * _imageScale;

    // Move the image so that the track lies in the track zone of the screen.
    final offset =
        trackScreenZone.topLeft - level.track.zone.topLeft * _imageScale;
    position = Vector2(offset.dx, offset.dy);

    // Use the size of the first designed level as reference size for scaling the world coordinates.
    // Using this scale factor instead of the imageScale to scale the worlds viewport
    // ensures that the players have the same size and physics in all levels.
    // In other words the size of the background image has no influence on the player's size and movement.
    worldScale = trackScreenZone.width / Level.toilet0.track.zone.width;
  }
}

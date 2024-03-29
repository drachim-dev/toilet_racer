import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/models/level.dart';
import 'package:toilet_racer/models/map.dart';
import 'package:toilet_racer/models/track.dart';

class Background extends SpriteComponent with HasGameRef {
  final GameMap map;
  final bool animationEnabled;

  Future<void>? animationFuture;
  bool animationCompleted = false;
  bool isAnimating = false;

  late Rect _trackScreenZone;
  double _imageScale = 1.0;
  double worldScale = 1.0;

  Background(
      {required this.map,
      required Image image,
      required this.animationEnabled}) {
    positionType = PositionType.viewport;
    sprite = Sprite(image);
  }

  Vector2 get _calcTargetSize => sprite!.srcSize * _imageScale;
  Vector2 get _calcTargetPosition {
    final offset =
        _trackScreenZone.topLeft - map.track.zone.topLeft * _imageScale;
    return Vector2(offset.dx, offset.dy);
  }

  /// Calculates the corresponding screen coordinates from image pixel coordinates.
  Vector2 getImageToScreen(Vector2 imageCoordinates) {
    return imageCoordinates * _imageScale + absoluteTopLeftPosition;
  }

  @override
  Future<void>? onLoad() {
    // gameRef.camera.followComponent(this);
    // sprite = await Sprite.load(map.filePath);

    if (!animationEnabled || animationCompleted) {
      size = _calcTargetSize;
      position = _calcTargetPosition;
    } else {
      size = gameRef.camera.viewport.effectiveSize;
    }

    animationFuture = animationEnabled ? _playAnimation() : Future.value(null);
    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    if (isAnimating) {
      return;
    }

    final screenSize = gameRef.camera.viewport.effectiveSize.clone();

    final minScreenSide =
        math.min(screenSize.toSize().width, screenSize.toSize().height) -
            kGameScreenMargin;

    // Enlarge track to fill display size, but not more than Track.maxSize.
    final trackSize = minScreenSide > Track.maxSizeOnScreen
        ? Track.maxSizeOnScreen
        : minScreenSide;

    // The track of the level that is rendered on the screen.
    _trackScreenZone = Rect.fromCenter(
        center: screenSize.toOffset() * 0.5,
        width: trackSize,
        height: trackSize);

    // The scale factor the image has to be scaled with
    // to fit the track into the track track zone on the screen.
    _imageScale = _trackScreenZone.width / map.track.zone.width;

    // Use the size of the first designed level as reference size for scaling the world coordinates.
    // Using this scale factor instead of the imageScale to scale the worlds viewport
    // ensures that the players have the same size and physics in all levels.
    // In other words the size of the background image has no influence on the player's size and movement.
    worldScale = _trackScreenZone.width / Level.kReferenceWidth;

    if (!animationEnabled || animationCompleted) {
      // size = _calcTargetSize;
      // position = _calcTargetPosition;
    }
  }

  Future<void> _playAnimation() async {
    isAnimating = true;

    const effectDuration = 2.5;
    final effectController = EffectController(duration: effectDuration);

    // Scale the background image
    final sizeEffect = SizeEffect.to(_calcTargetSize, effectController);
    final sizeEffectFuture = add(sizeEffect);

    // Move the image so that the track lies in the track zone of the screen.
    final moveEffect = MoveEffect.to(_calcTargetPosition, effectController);
    final moveEffectFuture = add(moveEffect);

    await Future.wait([
      if (sizeEffectFuture != null) sizeEffectFuture,
      if (moveEffectFuture != null) moveEffectFuture,
      Future.delayed(Duration(milliseconds: (effectDuration * 1000).toInt())),
    ]).then((_) {
      isAnimating = false;
      animationCompleted = true;
    });
  }
}

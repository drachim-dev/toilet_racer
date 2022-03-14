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
  late double _imageScale;
  late double worldScale;

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

    animationFuture = animationEnabled ? _playAnimation() : Future.value(null);
    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);

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

    if (animationEnabled && !animationCompleted) {
      // Fit image in screen
      size = screenSize;
    } else {
      size = _calcTargetSize;
      position = _calcTargetPosition;
    }
  }

  Future<void> _playAnimation() async {
    isAnimating = true;

    const effectDuration = 2.5;
    final effectController = EffectController(duration: effectDuration);

    // Scale the background image
    final sizeEffect = SizeEffect.to(_calcTargetSize, effectController);

    // Move the image so that the track lies in the track zone of the screen.
    final moveEffect = MoveEffect.to(_calcTargetPosition, effectController);

    // TODO: Workaround until onCompleted callback can be provided to effect
    return Future.wait([
      add(sizeEffect),
      add(moveEffect),
      Future.delayed(Duration(milliseconds: (effectDuration * 1000).toInt())),
    ]).then((_) {
      isAnimating = false;
      animationCompleted = true;
    });
  }
}

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:toilet_racer/components/removable_sprite_animation_component.dart';

class Fly extends Player {
  static const maxVelocity = 100;

  static const minAnimationStepTime = 0.01;
  static const maxAnimationStepTime = 0.15;

  SpriteAnimationComponent _spriteAnimationComponent;

  @override
  PositionComponent get positionComponent => _spriteAnimationComponent;

  @override
  Future<Player> onLoad() async {
    final sprites = await Player.loadSprites(
        ['player/fly/fly_1@2x.png', 'player/fly/fly_2@2x.png']);
    final spriteAnimation =
        SpriteAnimation.spriteList(sprites, stepTime: maxAnimationStepTime);

    _spriteAnimationComponent = RemovableSpriteAnimationComponent(
        Player.scaleSpriteSize(spriteAnimation.getSprite().originalSize),
        spriteAnimation);
    return this;
  }

  @override
  void update({double velocity}) {
    _spriteAnimationComponent.animation.stepTime = Player.calculateStepTime(
        velocity: velocity,
        maxVelocity: maxVelocity,
        minAnimationStepTime: minAnimationStepTime,
        maxAnimationStepTime: maxAnimationStepTime);
  }
}

class Larva extends Player {
  static const maxVelocity = 100;

  static const minAnimationStepTime = 0.02;
  static const maxAnimationStepTime = 0.1;

  SpriteAnimationComponent _spriteAnimationComponent;

  @override
  PositionComponent get positionComponent => _spriteAnimationComponent;

  @override
  Future<Player> onLoad() async {
    final filePaths = Iterable<int>.generate(8)
        .map((index) => index + 2)
        .map((index) => index.toString().padLeft(3, '0'))
        .map((index) => 'player/larva/__lava_move_$index.png')
        .toList();
    final sprites = await Player.loadSprites(filePaths);
    final spriteAnimation =
        SpriteAnimation.spriteList(sprites, stepTime: maxAnimationStepTime);
    _spriteAnimationComponent = RemovableSpriteAnimationComponent(
        Player.scaleSpriteSize(spriteAnimation.getSprite().originalSize,
            newWidth: 17),
        spriteAnimation);
    return this;
  }

  @override
  void update({double velocity}) {
    _spriteAnimationComponent.animation.stepTime = Player.calculateStepTime(
        velocity: velocity,
        maxVelocity: maxVelocity,
        minAnimationStepTime: minAnimationStepTime,
        maxAnimationStepTime: maxAnimationStepTime);
  }

  double calculateStepTime({
    double velocity,
  }) {
    return velocity *
            ((minAnimationStepTime - maxAnimationStepTime) / maxVelocity) +
        maxAnimationStepTime;
  }
}

abstract class Player {
  PositionComponent get positionComponent;

  Future<Player> onLoad();

  void update({double velocity}) {}

  static Future<List<Sprite>> loadSprites(List<String> filePaths) async {
    final images = await Flame.images.loadAll(filePaths);
    return images.map((image) => Sprite(image)).toList();
  }

  static Vector2 scaleSpriteSize(Vector2 originalSize, {double newWidth = 20}) {
    return originalSize * newWidth / originalSize.x;
  }

  static double calculateStepTime({
    double velocity,
    int maxVelocity,
    double minAnimationStepTime,
    double maxAnimationStepTime,
  }) {
    return velocity *
            ((minAnimationStepTime - maxAnimationStepTime) / maxVelocity) +
        maxAnimationStepTime;
  }
}

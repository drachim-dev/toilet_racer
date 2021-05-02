import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:toilet_racer/components/removable_sprite_animation_component.dart';

class Stinkbug extends Player {
  PositionComponent _positionComponent;

  @override
  PositionComponent get positionComponent => _positionComponent;

  @override
  Future<Player> onLoad() async {
    final filePaths = Iterable<int>.generate(5)
        .map((index) => 'player/stinkbug/stinkbug_${index + 1}.png')
        .toList();
    final sprites = await loadSprites(filePaths);
    final spriteAnimation = SpriteAnimation.spriteList(sprites, stepTime: 0.1);
    _positionComponent = RemovableSpriteAnimationComponent(
        scaleSpriteSize(spriteAnimation.getSprite().originalSize),
        spriteAnimation);
    return this;
  }
}

class Fly extends Player {
  static const maxVelocity = 100;

  static const minAnimationStepTime = 0.01;
  static const maxAnimationStepTime = 0.15;

  SpriteAnimationComponent _spriteAnimationComponent;

  @override
  PositionComponent get positionComponent => _spriteAnimationComponent;

  @override
  Future<Player> onLoad() async {
    final sprites = await loadSprites(
        ['player/fly/fly_1@2x.png', 'player/fly/fly_2@2x.png']);
    final spriteAnimation =
        SpriteAnimation.spriteList(sprites, stepTime: maxAnimationStepTime);

    _spriteAnimationComponent = RemovableSpriteAnimationComponent(
        scaleSpriteSize(spriteAnimation.getSprite().originalSize),
        spriteAnimation);
    return this;
  }

  @override
  void update({double velocity}) {
    _spriteAnimationComponent.animation.stepTime = velocity *
            ((minAnimationStepTime - maxAnimationStepTime) / maxVelocity) +
        maxAnimationStepTime;
  }
}

abstract class Player {
  PositionComponent get positionComponent;

  Future<Player> onLoad();

  void update({double velocity}) {}

  Future<List<Sprite>> loadSprites(List<String> filePaths) async {
    final images = await Flame.images.loadAll(filePaths);
    return images.map((image) => Sprite(image)).toList();
  }

  Vector2 scaleSpriteSize(Vector2 originalSize, {double newWidth = 20}) {
    return originalSize * 20 / originalSize.x;
  }
}

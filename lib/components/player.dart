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
        .map((index) => 'players/stinkbug_${index + 1}.png')
        .toList();
    final images = await Flame.images.loadAll(filePaths);
    final sprites = images.map((image) => Sprite(image)).toList();
    final spriteAnimation = SpriteAnimation.spriteList(sprites, stepTime: 0.1);
    _positionComponent = RemovableSpriteAnimationComponent(
        Vector2(220, 280) * 20 / 220, spriteAnimation);
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
    final images = await Flame.images
        .loadAll(['players/fly_1@2x.png', 'players/fly_2@2x.png']);
    final sprites = images.map((image) => Sprite(image)).toList();
    final spriteAnimation =
        SpriteAnimation.spriteList(sprites, stepTime: maxAnimationStepTime);
    _spriteAnimationComponent = RemovableSpriteAnimationComponent(
        Vector2(172, 116) * 20 / 172, spriteAnimation);
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
}

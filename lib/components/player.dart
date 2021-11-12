import 'package:flame/components.dart';
import 'package:flame/flame.dart';

enum PlayerIdentifier { fly, larva, frog, alien }

extension PlayerIdentifierExtension on PlayerIdentifier {

  Player get player {
    switch (this) {
      case PlayerIdentifier.fly:
        return Fly();
        break;
      case PlayerIdentifier.larva:
        return Larva();
        break;
      case PlayerIdentifier.frog:
        return Frog();
        break;
      case PlayerIdentifier.alien:
        return Alien();
        break;
      default:
        return null;
    }
  }
}

class Fly extends Player {
  static const minAnimationStepTime = 0.01;
  static const maxAnimationStepTime = 0.15;

  Fly() : super(acceleration: 1.2);

  SpriteAnimationComponent _spriteAnimationComponent;

  @override
  PositionComponent get positionComponent => _spriteAnimationComponent;

  @override
  Future<Player> onLoad() async {
    final filePaths = Iterable<int>.generate(2)
        .map((index) => 'player/fly/movement/fly_move$index.png')
        .toList();
    final sprites = await Player.loadSprites(filePaths);
    final spriteAnimation =
        SpriteAnimation.spriteList(sprites, stepTime: maxAnimationStepTime);

    _spriteAnimationComponent = SpriteAnimationComponent(
        size: Player.scaleSpriteSize(spriteAnimation.getSprite().originalSize),
        animation: spriteAnimation);
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
  static const minAnimationStepTime = 0.02;
  static const maxAnimationStepTime = 0.1;

  SpriteAnimationComponent _spriteAnimationComponent;

  @override
  PositionComponent get positionComponent => _spriteAnimationComponent;

  @override
  Future<Player> onLoad() async {
    final filePaths = Iterable<int>.generate(8)
        .map((index) => index + 2)
        .map((index) => 'player/larva/movement/larva_move$index.png')
        .toList();
    final sprites = await Player.loadSprites(filePaths);
    final spriteAnimation =
        SpriteAnimation.spriteList(sprites, stepTime: maxAnimationStepTime);
    _spriteAnimationComponent = SpriteAnimationComponent(
        size: Player.scaleSpriteSize(
          spriteAnimation.getSprite().originalSize,
          newWidth: 17,
        ),
        animation: spriteAnimation);
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

class Frog extends Player {
  static const minAnimationStepTime = 0.02;
  static const maxAnimationStepTime = 0.1;

  SpriteAnimationComponent _spriteAnimationComponent;

  @override
  PositionComponent get positionComponent => _spriteAnimationComponent;

  @override
  Future<Player> onLoad() async {
    final filePaths = Iterable<int>.generate(7)
        .map((index) => 'player/frog/movement/frog_move$index.png')
        .toList();
    final sprites = await Player.loadSprites(filePaths);
    final spriteAnimation =
        SpriteAnimation.spriteList(sprites, stepTime: maxAnimationStepTime);
    _spriteAnimationComponent = SpriteAnimationComponent(
        size: Player.scaleSpriteSize(
          spriteAnimation.getSprite().originalSize,
          newWidth: 17,
        ),
        animation: spriteAnimation);
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

class Alien extends Player {
  static const minAnimationStepTime = 0.02;
  static const maxAnimationStepTime = 0.1;

  SpriteAnimationComponent _spriteAnimationComponent;

  @override
  PositionComponent get positionComponent => _spriteAnimationComponent;

  @override
  Future<Player> onLoad() async {
    final filePaths = Iterable<int>.generate(9)
        .map((index) => 'player/alien/movement/alien_move$index.png')
        .toList();
    final sprites = await Player.loadSprites(filePaths);
    final spriteAnimation =
        SpriteAnimation.spriteList(sprites, stepTime: maxAnimationStepTime);
    _spriteAnimationComponent = SpriteAnimationComponent(
        size: Player.scaleSpriteSize(
          spriteAnimation.getSprite().originalSize,
          newWidth: 17,
        ),
        animation: spriteAnimation);
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

  final int maxVelocity;
  final double acceleration;

  Player({this.maxVelocity = 100, this.acceleration = 1.0});

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

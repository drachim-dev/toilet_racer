import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:toilet_racer/models/player.dart';

class PlayerComponent {
  static const minAnimationStepTime = 0.01;
  static const maxAnimationStepTime = 0.15;

  final Player player;

  late SpriteAnimationComponent _spriteAnimationComponent;

  PlayerComponent(this.player);

  PositionComponent get positionComponent => _spriteAnimationComponent;

  Future<PlayerComponent> onLoad() async {
    final sprites = await PlayerComponent.loadSprites(player.filePaths);
    final spriteAnimation =
        SpriteAnimation.spriteList(sprites, stepTime: maxAnimationStepTime);

    _spriteAnimationComponent = SpriteAnimationComponent(
        size: PlayerComponent.scaleSpriteSize(
            spriteAnimation.getSprite().originalSize,
            scale: player.scale),
        animation: spriteAnimation);
    return this;
  }

  void update({required double velocity}) {
    _spriteAnimationComponent.animation?.stepTime =
        PlayerComponent.calculateStepTime(
            velocity: velocity,
            maxVelocity: player.maxVelocity,
            minAnimationStepTime: minAnimationStepTime,
            maxAnimationStepTime: maxAnimationStepTime);
  }

  static Future<List<Sprite>> loadSprites(List<String> filePaths) async {
    final images = await Flame.images.loadAll(filePaths);
    return images.map((image) => Sprite(image)).toList();
  }

  static Vector2 scaleSpriteSize(Vector2 originalSize, {double scale = 1.0}) {
    return originalSize * 17 * scale / originalSize.x;
  }

  static double calculateStepTime({
    required double velocity,
    required int maxVelocity,
    required double minAnimationStepTime,
    required double maxAnimationStepTime,
  }) {
    return velocity *
            ((minAnimationStepTime - maxAnimationStepTime) / maxVelocity) +
        maxAnimationStepTime;
  }
}

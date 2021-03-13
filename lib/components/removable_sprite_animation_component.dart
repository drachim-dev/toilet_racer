import 'package:flame/components.dart';

/// Custom super class to fix bug when removing SpriteAnimationComponent
class RemovableSpriteAnimationComponent extends SpriteAnimationComponent {
  RemovableSpriteAnimationComponent(Vector2 size, SpriteAnimation animation)
      : super.fromSpriteAnimation(size, animation);

  @override
  void remove() {
    super.remove();
    removeOnFinish = true;
  }
}

import 'dart:ui';

import 'package:flame/components.dart';

class Background extends SpriteComponent {
  Background(Image image, Vector2 size) : super.fromImage(size, image);

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    size.setFrom(gameSize);
  }
}

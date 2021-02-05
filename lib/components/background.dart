import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class Level {
  static Level toilet =
      Level('roads/toilet.png', Rect.fromLTRB(15, 91, 190, 290));
  static Level toilet2 =
      Level('roads/toilet2.jpg', Rect.fromLTRB(623, 470, 969, 828));

  /// The zone in the image that contains the relevant track for the game.
  final Rect trackZone;
  final String filePath;

  Image image;

  Level(this.filePath, this.trackZone);

  Future<void> onLoad() async {
    image = await Flame.images.load(filePath);
  }
}

class Background extends SpriteComponent with HasGameRef {
  final Level level;

  Background(this.level) {
    sprite = Sprite(level.image);
  }

  @override
  Future<void> onLoad() async {}

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);

    var trackDisplayZone = Rect.fromCenter(
        center: gameSize.toOffset() * 0.5, width: 300, height: 300);

    var scaleFactor = trackDisplayZone.width / level.trackZone.width;
    size = sprite.srcSize * scaleFactor;

    var offset =
        trackDisplayZone.topLeft - level.trackZone.topLeft * scaleFactor;
    position = Vector2(offset.dx, offset.dy);
  }
}

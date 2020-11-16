import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final game = MyGame();
  runApp(game.widget);
}

// Extend Box2DGame class to use a physics engine
class MyGame extends BaseGame with TapDetector {
  MyPlayer _player;

  MyGame() {
    _init();
    _start();
  }

  void _init() {
    _player = MyPlayer();

    add(_player);
  }

  void _start() {
    // Flame.audio.loop('background.mp3', volume: 0.4);
  }

  @override
  void onTap() {
    final double sizeDiff = 5;
    final double positionDiff = 10;

    // position upwards
    _player.x -= sizeDiff / 2;
    _player.y -= positionDiff;

    // increase size
    _player.width += sizeDiff;
    _player.height += sizeDiff;

    _player.toPosition();
    _player.toSize();
  }

}

class MyPlayer extends SpriteComponent {
  MyPlayer() : super.fromSprite(48, 48, Sprite('tomato.png'));

  @override
  void resize(Size size) {
    // we don't need to set the x and y in the constructor, we can set then here
    this.x = (size.width - this.width) / 2;
    this.y = (size.height - this.height) / 2;
  }
}

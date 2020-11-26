import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class Background extends SpriteComponent {
  Background(Size gameSize)
      : super.fromSprite(
            gameSize.width, gameSize.height, Sprite('roads/toilet.jpg'));
}

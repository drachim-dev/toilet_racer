import 'package:flutter/material.dart';

class Player {
  final UniqueKey id = UniqueKey();

  final String name;
  final int maxVelocity;
  final double acceleration;

  final double scale;
  final List<String> filePaths;

  Player({
    @required this.name,
    this.maxVelocity = 100,
    this.acceleration = 1.0,
    this.scale = 1.0,
    @required this.filePaths,
  });
}

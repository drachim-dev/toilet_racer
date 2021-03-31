import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FlipWidget extends StatelessWidget {
  final Widget background, flippable;

  /// x and y coordinates where the flippable overlays the background widget.
  final Offset _flippablePosition;

  final AnimationController _controller;

  const FlipWidget({
    @required this.background,
    @required this.flippable,
    Offset flippablePosition,
    @required AnimationController controller,
  })  : assert(background != null),
        assert(flippable != null),
        _flippablePosition = flippablePosition ?? const Offset(0, 0),
        _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        background,
        Positioned(
          left: _flippablePosition.dx,
          top: _flippablePosition.dy,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              return Transform(
                transform: Matrix4.rotationX((_controller.value) * math.pi),
                alignment: Alignment.topCenter,
                child: flippable,
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> startAnimation() => _controller.forward();
  Future<void> reverseAnimation() => _controller.reverse();
}

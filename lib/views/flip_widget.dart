import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FlipWidget extends StatelessWidget {
  final Widget background, flippable;

  final AnimationController _controller;

  const FlipWidget({
    @required this.background,
    @required this.flippable,
    @required AnimationController controller,
  })  : assert(background != null),
        assert(flippable != null),
        _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          // original size of background image as reference
          height: 1920,
          width: 1014,
          child: Stack(children: [
            background,
            Positioned(
              // manually found coords and size (width will be set automatically)
              top: 835,
              left: 278,
              height: 475,
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
          ]),
        ),
      ),
    );
  }

  Future<void> startAnimation() => _controller.forward();
  Future<void> reverseAnimation() => _controller.reverse();
}

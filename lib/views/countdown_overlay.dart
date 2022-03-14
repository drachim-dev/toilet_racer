import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CountDownOverlay extends StatefulWidget {
  final VoidCallback onCountDownFinished;

  const CountDownOverlay({Key? key, required this.onCountDownFinished})
      : super(key: key);

  @override
  _CountDownOverlayState createState() => _CountDownOverlayState();
}

class _CountDownOverlayState extends State<CountDownOverlay>
    with SingleTickerProviderStateMixin {
  static const kCountFrom = 3;
  static const kCountTo = 1;

  static const kCountDownTime = Duration(seconds: 2);

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<int> _counterAnimation;

  @override
  void initState() {
    super.initState();

    _initAnimations();
  }

  void _initAnimations() {
    _controller = AnimationController(duration: kCountDownTime, vsync: this);

    _scaleAnimation = TweenSequence(
      List.generate(
        3,
        (index) => TweenSequenceItem<double>(
          tween: Tween(begin: 250.0, end: 50.0),
          weight: 1.0,
        ),
      ),
    ).animate(_controller);

    _counterAnimation =
        StepTween(begin: kCountFrom + 1, end: kCountTo).animate(_controller);

    _controller.forward().then((value) => widget.onCountDownFinished());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedCountdown(
        counterAnimation: _counterAnimation,
        scaleAnimation: _scaleAnimation,
      ),
    );
  }
}

class AnimatedCountdown extends AnimatedWidget {
  const AnimatedCountdown(
      {Key? key, required this.counterAnimation, required this.scaleAnimation})
      : super(key: key, listenable: counterAnimation);

  final Animation<int> counterAnimation;
  final Animation<double> scaleAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scaleAnimation,
      builder: (_, child) => SizedBox(
        height: scaleAnimation.value,
        width: scaleAnimation.value,
        child: child,
      ),
      child: FittedBox(
        child: Text(
          counterAnimation.value.toString(),
          style: const TextStyle(fontSize: 150.0),
        ),
      ),
    );
  }
}

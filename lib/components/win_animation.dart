import 'package:flame_rive/flame_rive.dart';

class WinAnimationComponent extends RiveComponent {
  WinAnimationComponent(Artboard artboard) : super(artboard: artboard);

  bool _isPlaying = false;

  @override
  Future<void>? onLoad() {
    final controller = SimpleAnimation(
      'Animation 1',
      autoplay: true,
    );
    artboard.addController(controller);

    return super.onLoad();
  }
}

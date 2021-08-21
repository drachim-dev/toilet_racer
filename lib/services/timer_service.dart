import 'package:flame/timer.dart';
import 'package:flutter/foundation.dart';

class TimerService {
  final ValueNotifier<double> _seconds = ValueNotifier(null);
  ValueNotifier<double> get seconds => _seconds;
  Timer _timer;

  void start() {
    _seconds.value = 0;
    _timer = Timer(
      0.1,
      callback: () {
        var value = _seconds.value += 0.1;
        return _seconds.value = num.parse(value.toStringAsFixed(1));
      },
      repeat: true,
    );
    _timer.start();
  }

  void cancel() => _timer?.stop();

  void update(double dt) => _timer.update(dt);
}

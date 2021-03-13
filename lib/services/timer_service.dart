import 'dart:async';

import 'package:flutter/cupertino.dart';

class TimerService {
  final ValueNotifier<int> _seconds = ValueNotifier(null);
  ValueNotifier<int> get seconds => _seconds;
  Timer _timer;

  void start() {
    _seconds.value = 0;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds.value += 1;
    });
  }

  void cancel() => _timer?.cancel();
}

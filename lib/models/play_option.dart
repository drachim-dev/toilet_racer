import 'level.dart';

class PlayOption {
  PlayOption._();

  factory PlayOption.repeat() = RepeatOption;
  factory PlayOption.restart() = RestartOption;
  factory PlayOption.next({Level? level}) = NextOption;
}

class RepeatOption extends PlayOption {
  RepeatOption() : super._();
}

class RestartOption extends PlayOption {
  RestartOption() : super._();
}

class NextOption extends PlayOption {
  NextOption({this.level}) : super._();

  final Level? level;
}

import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:toilet_racer/components/player_body.dart';

void main() {
  test('normalizeAngle should produce values in range [0..pi2)', () {
    expect(PlayerBody.normalizeAngle(0), 0);
    expect(PlayerBody.normalizeAngle(pi * 2), 0);
    expect(PlayerBody.normalizeAngle(-pi * 2), 0);

    expect(PlayerBody.normalizeAngle(pi / 2), pi / 2);
    expect(PlayerBody.normalizeAngle(pi), pi);
    expect(PlayerBody.normalizeAngle(pi * 2 + pi), pi);

    expect(PlayerBody.normalizeAngle(-pi), pi);
    expect(PlayerBody.normalizeAngle(-pi / 2), pi * 1.5);
  });

  test('directionalAngle should produce values in range (-pi..pi]', () {
    expect(PlayerBody.directionalAngle(0), 0);
    expect(PlayerBody.directionalAngle(pi * 2), 0);
    expect(PlayerBody.directionalAngle(-pi * 2), 0);

    expect(PlayerBody.directionalAngle(pi), pi);
    expect(PlayerBody.directionalAngle(-pi), pi);

    expect(PlayerBody.directionalAngle(pi / 2), pi / 2);
    expect(PlayerBody.directionalAngle(pi * 1.5), -pi / 2);

    expect(PlayerBody.directionalAngle(-pi / 2), -pi / 2);
    expect(PlayerBody.directionalAngle(-pi * 1.5), pi / 2);
  });
}

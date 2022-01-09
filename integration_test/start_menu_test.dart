import 'package:flutter_test/flutter_test.dart';
import 'package:toilet_racer/main.dart';
import 'package:toilet_racer/generated/l10n.dart';

import 'app_test.dart';

Future<void> startMenuTest() async {
  group('Start Menu Test', () {
    testWidgets('initial startup - show play button - hide continue button',
        (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 1));

      await takeScreenshot(tester, 'menu_start');

      // Verify play button shown
      final Finder playButton = find.text(S.current.pageStartPlayButtonText);
      expect(playButton, findsOneWidget);

      // Verify continue button not shown
      final Finder continueButton =
          find.text(S.current.pageStartContinueButtonText);
      expect(continueButton, findsNothing);
    });
  });
}
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:toilet_racer/app/locator.dart';

import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'start_menu_test.dart';

late IntegrationTestWidgetsFlutterBinding binding;
void main() {
  _ensureInitialized();
  _testAll();
}

Future<void> _testAll() async {
  group('Test all', () {
    startMenuTest();
  });
}

void _ensureInitialized() {
  binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
      as IntegrationTestWidgetsFlutterBinding;
  WidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    setupLocator();
    await locator.allReady();
  });
}

Future<void> takeScreenshot(WidgetTester tester, String fileName) async {
  if (kIsWeb) {
    await binding.takeScreenshot(fileName);
    return;
  } else if (Platform.isAndroid) {
    await binding.convertFlutterSurfaceToImage();
    await tester.pump(const Duration(seconds: 1));
  }
  await binding.takeScreenshot(fileName);
}

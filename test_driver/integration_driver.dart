import 'package:integration_test/integration_test_driver_extended.dart';

import 'dart:io';

Future<void> main() async {
  await integrationDriver(
    onScreenshot: (String screenshotName, List<int> screenshotBytes) async {
      final image = File('screenshots/$screenshotName.png');
      image.writeAsBytesSync(screenshotBytes);
      // Return false if the screenshot is invalid.
      return true;
    },
  );
}
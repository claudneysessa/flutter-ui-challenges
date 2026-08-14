import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

/// Writes the screenshots taken by integration_test/screenshots_test.dart into
/// assets/screenshots/, which is where the README expects them.
///
/// The folder is deliberately a subdirectory: pubspec.yaml declares `assets/`,
/// which only bundles the files directly inside it, so these stay out of the
/// shipped app.
Future<void> main() async {
  await integrationDriver(
    onScreenshot: (String name, List<int> bytes, [Map<String, Object?>? args]) async {
      final file = File('assets/screenshots/$name.png');
      await file.parent.create(recursive: true);
      await file.writeAsBytes(bytes);
      return true;
    },
  );
}

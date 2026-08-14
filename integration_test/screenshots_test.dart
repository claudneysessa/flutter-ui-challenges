import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_challenges/core/data/models/menu.dart';
import 'package:flutter_ui_challenges/core/presentation/routes.dart';
import 'package:integration_test/integration_test.dart';

/// Captures one screenshot per demo, on a real device, for the README.
///
/// This runs the actual app rather than a widget test so the network imagery
/// loads for real. Run it with:
///
///   flutter drive \
///     --driver=test_driver/screenshot_driver.dart \
///     --target=integration_test/screenshots_test.dart \
///     -d <device id>
///
/// The driver writes the PNGs into assets/screenshots/.
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('capture every demo', (tester) async {
    // These screens are drawn for a range of handset sizes and several of them
    // overflow on whatever device this happens to run on. An overflow paints a
    // stripe and carries on, which is fine for a screenshot, but left
    // unhandled it fails the run and no images get written.
    final previousOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails details) {
      final message = details.exceptionAsString();
      const ignorable = [
        'overflowed by',
        'RenderBox was not laid out',
        'NEEDS-LAYOUT',
        'hasSize',
        'Trailing widget consumes the entire tile width',
        'The ListTile is wrapped in a DecoratedBox',
        '_needsLayout',
        'Failed to load network image',
        'Invalid image data',
      ];
      if (ignorable.any(message.contains)) return;
      previousOnError?.call(details);
    };
    addTearDown(() => FlutterError.onError = previousOnError);

    // Required on Android before takeScreenshot can read the surface.
    await binding.convertFlutterSurfaceToImage();

    final sections = pages.cast<MenuItem>();

    // --dart-define=LIMIT=n captures only the first n demos, which is enough to
    // check the pipeline without sitting through the whole catalogue.
    const limit = int.fromEnvironment('LIMIT', defaultValue: 0);
    var captured = 0;

    for (final section in sections) {
      for (final entry in section.items ?? const <SubMenuItem>[]) {
        if (limit > 0 && captured >= limit) return;
        captured++;
        await tester.pumpWidget(
          MaterialApp(
            debugShowCheckedModeBanner: false,
            home: entry.page,
          ),
        );

        // Let the first frame settle, then give the network images time to
        // arrive. pumpAndSettle is not usable here: several demos animate
        // forever by design.
        await tester.pump(const Duration(milliseconds: 100));
        for (var i = 0; i < 24; i++) {
          await tester.pump(const Duration(milliseconds: 250));
        }

        await binding.takeScreenshot(_slug(entry));

        // Unmount between demos so timers and controllers are disposed.
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(milliseconds: 50));
      }
    }
  }, timeout: const Timeout(Duration(minutes: 45)));
}

/// Turns "Login 14" into "login-14", so file names are stable and predictable
/// from the menu entry alone.
String _slug(SubMenuItem entry) {
  return entry.title
      .toLowerCase()
      .replaceAll(RegExp(r"[^a-z0-9]+"), '-')
      .replaceAll(RegExp(r'^-|-$'), '');
}

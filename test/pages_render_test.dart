import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_challenges/core/data/models/menu.dart';
import 'package:flutter_ui_challenges/core/presentation/routes.dart';

import 'test_utils.dart';

/// Builds every screen in the catalogue.
///
/// This is the test that matters for a revival: the analyzer proves the code
/// type checks, but only mounting a widget proves its build method survives the
/// framework it now runs on.
void main() {
  final sections = pages.cast<MenuItem>();

  for (final section in sections) {
    group(section.title, () {
      for (final entry in section.items ?? const <SubMenuItem>[]) {
        testWidgets(entry.title, (tester) async {
          await mockNetworkImages(() async {
            await tester.binding.setSurfaceSize(const Size(414, 896));
            addTearDown(() => tester.binding.setSurfaceSize(null));

            final errors = await buildAndCollectErrors(tester, entry.page);

            expect(
              errors.map((e) => e.exceptionAsString()).toList(),
              isEmpty,
              reason: '${entry.title} (${entry.path}) threw while building',
            );
          });
        });
      }
    });
  }
}

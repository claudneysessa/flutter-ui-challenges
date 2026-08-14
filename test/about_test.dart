import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_challenges/core/constants.dart';
import 'package:flutter_ui_challenges/core/presentation/pages/about.dart';

import 'test_utils.dart';

/// The About screen is where credit lives, so the split between the original
/// authors and this fork is worth pinning down rather than leaving to whoever
/// edits the page next.
void main() {
  testWidgets('credits the maintainer and the original authors', (tester) async {
    await tester.binding.setSurfaceSize(const Size(414, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final errors = await buildAndCollectErrors(tester, AboutPage());
    expect(errors, isEmpty);

    await tester.pumpWidget(wrapForTest(AboutPage()));
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Maintainer'), findsOneWidget);
    expect(find.text(MAINTAINER.name!), findsOneWidget);

    expect(find.text('Original authors'), findsOneWidget);
    for (final dev in DEVELOPERS) {
      expect(find.text(dev.name!), findsOneWidget,
          reason: '${dev.name} is missing from the About screen');
    }
  });

  test('in-app source links point at this fork, not the archived original', () {
    // The preview screen builds a per-demo GitHub link from githubRepo. Pointing
    // it at the upstream repository would send people to code that is not the
    // code they are running.
    expect(githubRepo, contains('claudneysessa'));
    expect(upstreamRepo, contains('lohanidamodar'));
    expect(githubRepo, isNot(equals(upstreamRepo)));
  });
}

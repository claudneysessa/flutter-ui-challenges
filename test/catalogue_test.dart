import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_challenges/core/data/models/menu.dart';
import 'package:flutter_ui_challenges/core/presentation/routes.dart';

/// Checks the catalogue itself rather than any one screen: the menu is the only
/// index of what this project ships, and a demo that falls out of it silently
/// stops being reachable.
void main() {
  final sections = pages.cast<MenuItem>();
  final entries = <SubMenuItem>[
    for (final section in sections) ...?section.items,
  ];

  test('every section carries at least one demo', () {
    for (final section in sections) {
      expect(section.items, isNotNull, reason: '${section.title} has no items');
      expect(section.items, isNotEmpty, reason: '${section.title} is empty');
    }
  });

  test('every demo declares the source file it is built from', () {
    for (final entry in entries) {
      expect(entry.path, isNotNull, reason: '${entry.title} has no path');
      expect(entry.path, isNotEmpty, reason: '${entry.title} has an empty path');
    }
  });

  test('every declared source file exists on disk', () {
    // The app reads these files back to show its own code, so a stale path is a
    // broken page rather than a cosmetic mistake.
    final missing = <String>[
      for (final entry in entries)
        if (!File(entry.path!).existsSync()) '${entry.title} -> ${entry.path}',
    ];

    expect(missing, isEmpty, reason: 'source files not found:\n${missing.join('\n')}');
  });

  test('demo titles are unique within their section', () {
    for (final section in sections) {
      final titles = section.items!.map((item) => item.title).toList();
      expect(
        titles.toSet().length,
        titles.length,
        reason: '${section.title} has duplicate titles',
      );
    }
  });

  test('the catalogue still holds the full set of demos', () {
    // A floor rather than an exact count, so adding a demo does not fail the
    // suite, but a section quietly disappearing does.
    expect(sections.length, greaterThanOrEqualTo(20));
    expect(entries.length, greaterThanOrEqualTo(130));
  });

  test('no demo loads an image from the network', () {
    // The imagery is in this repository on purpose. It used to come from the
    // original author's Firebase bucket, which was withdrawn and now returns
    // 402, and from third-party hosts, two of which have since started
    // returning 403 and one of which no longer resolves. A remote image throws
    // nothing when it fails, it just paints nothing, so nothing else in this
    // suite would notice a URL creeping back in.
    final offenders = <String>[];
    // Word boundary so PNetworkImage, this project's own widget, is not a hit,
    // and a scheme so the host names only match in URLs rather than in prose.
    final remote = RegExp(
      r'''(?<![A-Za-z])(NetworkImage|Image\.network)\(|https?://[^\s'"]*(firebasestorage|picsum\.photos|pravatar|pixabay|pexels|purepng|pngio)''',
    );

    for (final file in Directory('lib').listSync(recursive: true)) {
      if (file is! File || !file.path.endsWith('.dart')) continue;
      if (remote.hasMatch(file.readAsStringSync())) {
        offenders.add(file.path);
      }
    }

    expect(offenders, isEmpty,
        reason: 'remote imagery referenced in: ${offenders.join(', ')}');
  });
}

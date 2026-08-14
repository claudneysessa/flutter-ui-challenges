import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_challenges/core/presentation/pages/about.dart';
import 'package:flutter_ui_challenges/core/presentation/pages/home.dart';
import 'package:flutter_ui_challenges/features/home/presentation/pages/new_home.dart';
import 'package:flutter_ui_challenges/main.dart';

import 'test_utils.dart';

void main() {
  testWidgets('the app boots and lands on the home page', (tester) async {
    await mockNetworkImages(() async {
      await tester.pumpWidget(MyApp());
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(NewHomePage), findsOneWidget);
    });
  });

  testWidgets('the named routes resolve to their pages', (tester) async {
    await mockNetworkImages(() async {
      await tester.pumpWidget(MyApp());
      await tester.pump(const Duration(milliseconds: 100));

      final navigator = tester.state<NavigatorState>(find.byType(Navigator));

      navigator.pushNamed('challenge_home');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.byType(HomePage), findsOneWidget);

      navigator.pop();
      await tester.pump(const Duration(milliseconds: 300));

      navigator.pushNamed('about');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.byType(AboutPage), findsOneWidget);
    });
  });
}

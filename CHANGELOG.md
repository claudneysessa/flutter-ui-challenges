# Changelog

All notable changes to this project are documented in this file.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and this
project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Maintenance of this fork starts at version 3.1.0, the last state published against
Flutter 2.5. Everything below that line is the revival effort.

## [4.0.0] - 2026-08-13

Brings the project forward from Flutter 2.5 (September 2021) to Flutter 3.44.6 /
Dart 3.12.2. It went from 208 analyzer errors and no build on any platform to a clean
analyzer, 141 passing tests, and working release builds for web, Android and Windows.

The major version bump is for the removed onboarding demo and the raised SDK floor;
everything else is compatible.

### Removed

- **The Intro 5 onboarding demo, its `bus.flr` asset and the `flare_flutter`
  dependency.** flare_flutter was archived by Rive in 2021 and cannot run on Dart 3:
  it calls `hashValues()`, deleted from `dart:ui`, and applies a dozen ordinary
  classes as mixins, which Dart 3 only allows for `mixin class` declarations their
  hierarchies make them ineligible for. There is no maintained fork on pub.dev, and
  Rive's current package reads `.riv` files rather than the `.flr` this project ships.
- `preview copy.dart`, an unreferenced duplicate of `preview.dart`.
- `_BottomAppBarClipper`, an unreferenced copy of a Flutter SDK private class.
- A dead `SliverToBoxAdapter` block and the never-called `_buildHeader()` in the first
  dashboard demo.

### Changed

- **SDK floor** raised from `>=2.12.0 <3.0.0` to `>=3.10.0 <4.0.0`, with a Flutter
  floor of 3.38.1. Resolution only worked before because Dart 3 relaxes the upper
  bound for packages that predate it.
- **All dependencies** moved to their current releases, including four with breaking
  APIs: `fl_chart` 0.36 to 1.2, `flutter_speed_dial` 3 to 7,
  `flutter_staggered_grid_view` 0.4 to 0.7 and `font_awesome_flutter` 9 to 11.
- **`share` replaced by `share_plus`**, the former having been discontinued upstream.
- **`string_scanner` and `flutter_lints` are now declared.** Both were used without
  being dependencies: the syntax highlighter imported `string_scanner` transitively,
  and `analysis_options.yaml` included a lint ruleset that was never actually applied.
- **Android toolchain rebuilt** on the current Flutter template: Kotlin DSL build
  scripts, AGP 9.0.1, Kotlin 2.3.20, Gradle 9.1, a declarative plugins block, a
  namespace, Java 17, and SDK levels delegated to the Flutter Gradle plugin. The old
  setup (AGP 4.1, Gradle 7.1, Kotlin 1.3.50, `jcenter()`, `minSdk 16`) could not run
  under JDK 21 at all.
- **Windows and Linux runners regenerated.** `flutter build windows` reported "No
  Windows desktop project configured" because the folder still held the Visual Studio
  `.vcxproj` runner from before Flutter moved desktop builds to CMake.
- **Web bootstrap modernised**, from a direct `main.dart.js` script tag and a manual
  service worker registration to the generated `flutter_bootstrap.js` loader, with a
  `$FLUTTER_BASE_HREF` placeholder for the Pages deploy.
- **The Android manifest** declares `INTERNET` and a `VIEW`/`https` query, both of
  which the showcase needs and neither of which it previously had, and drops the v1
  embedding `FlutterApplication` entry.

### Fixed

Framework API removals, all of them mechanical but pervasive:

- Legacy Material buttons at 103 call sites across 61 files: `RaisedButton` to
  `ElevatedButton`, `FlatButton` to `TextButton`, `OutlineButton` to `OutlinedButton`,
  with their styling arguments folded into a `ButtonStyle`.
- The 2018 `TextTheme` names to their 2021 equivalents.
- `ThemeData.accentColor`, `backgroundColor`, `bottomAppBarColor` and `buttonColor` to
  their `ColorScheme` and theme-extension equivalents.
- `BottomNavigationBarItem.title` to `label` at 38 call sites.
- `Stack(overflow: Overflow.visible)` to `clipBehavior: Clip.none`.
- `Scaffold.of(context).showSnackBar` to `ScaffoldMessenger`.
- `AppBar.brightness` to `systemOverlayStyle`.
- Colon-separated default values in optional parameters, illegal past language
  version 3.0.
- `CenteredRectangularSliderTrackShape.paint`, which had stopped overriding its
  supertype after the signature gained required parameters.

Deprecations, all of them now gone:

- `Radio` and `RadioListTile` groups wrapped in a typed `RadioGroup`.
- `url_launcher`'s `launch`/`canLaunch` to the `Uri`-based `launchUrl`/`canLaunchUrl`.
- `WillPopScope` to `PopScope`. The old code cast a `Future<bool?>` callback to
  `Future<bool>`, which would have thrown on a null.
- `Color.withOpacity` to `withValues`, `Switch.activeColor` to `activeThumbColor`,
  `TickerMode.of` to `TickerMode.valuesOf`, `fl_chart`'s `swapAnimationDuration` and
  `swapAnimationCurve` to `duration` and `curve`, and 24 Font Awesome icons renamed
  between Font Awesome 5 and 7.

Genuine defects, none of them caused by the migration:

- **`LoaderOne`, `LoaderTwo` and the OTP fields called `super.dispose()` before
  disposing their `AnimationController` and `FocusNode`s.** That order marks the State
  defunct while the controller is still live, so its listeners call `setState` on a
  dead element: an assertion on every teardown, plus a leaked ticker.
- **`AlwaysAliveWidget` never called `super.build()`**, which
  `AutomaticKeepAliveClientMixin` requires. Without it the mixin cannot register the
  keep-alive, so the widget it wraps was not in fact being kept alive.
- **The quiz result screen printed its score as a raw double division**, so a
  three-question quiz reported `33.33333333333333%` and overran its tile.
- **Three demos pointed at source files that do not exist**, so the "view code" pane
  showed nothing for them: a misspelled `ecommerece` directory, a `tstory.dart` that
  is really `travelstory.dart`, and the travel UI clone off by a directory.
- `HeaderContainer` and `ButtonWidget` declared mutable fields on `StatelessWidget`
  subclasses.
- Asserts that a required argument was non-null, left over from before null safety.
- A `progress.length == null` check whose fallback branch was unreachable.
- 49 unused imports, plus assorted unused fields, locals and unnecessary casts.

### Added

- **A test suite, where there was none: 141 tests.** `pages_render_test.dart` builds
  all 134 demos, one test each; `catalogue_test.dart` checks the menu and that every
  declared source path exists; `app_smoke_test.dart` boots the app and walks its named
  routes. The suite is what found the dispose ordering, score formatting and broken
  path defects above.
- `docs/MIGRATION-ANALYSIS.md`, recording the Flutter 2.5 baseline, the analyzer
  results at adoption time, the dependency audit and the execution plan.
- This changelog.
- `analysis_options.yaml` now excludes `build/`. The app displays its own source, so
  every demo is declared as an asset and `flutter build` copies it into the bundle,
  where the analyzer was picking the copies up and reporting 190 phantom errors.

### Verified

| Check | Result |
|---|---|
| `flutter analyze` | 0 errors, 0 warnings |
| `flutter test` | 141 passed |
| `flutter build web --release` | success |
| `flutter build apk --release` | success, 59.2 MB |
| `flutter build windows --release` | success |

## [3.1.0] - 2021

Last release against Flutter 2.5, before this fork took over maintenance. See the
[upstream repository](https://github.com/lohanidamodar/flutter_ui_challenges) for its
history.

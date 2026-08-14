# Migration Analysis — Flutter UI Challenges

Baseline captured on 2026-08-13, at the point this fork was adopted for maintenance.

## 1. Starting state

| Item | Value |
|---|---|
| App version | 3.1.0 |
| Declared Dart SDK constraint | `>=2.12.0 <3.0.0` |
| Lockfile SDK floor | Dart 2.15.0 / Flutter 2.5.0 |
| `.metadata` revision | `5391447fae6209bb21a89e6a5a6583cac1af9b4b` (Flutter 2.5.x, stable) |
| Dart files under `lib/` | 248 |
| Lines of Dart | ~34,900 |
| Automated tests | none |

The project was last updated against Flutter 2.5 (September 2021). It is null-safe already,
which is the single most important thing working in our favour: the Dart 3 migration is
therefore an API migration, not a language migration.

## 2. Target state

| Item | Value |
|---|---|
| Flutter | 3.44.6 (stable, 2026-07-08) |
| Dart | 3.12.2 |
| Android toolchain available | SDK 37.0.0, JDK 21 |
| Desktop toolchain available | Visual Studio Community 2026 |
| Web toolchain available | Chrome 151 |

Dart 3 relaxes the upper SDK bound for packages declaring `>=2.12.0 <3.0.0`, so dependency
resolution still succeeds. That is why `flutter pub get` passes while `flutter analyze`
does not: the failures are all Flutter framework API removals accumulated over five years.

## 3. Baseline analyzer result

`flutter analyze` on the unmodified tree:

```
383 issues found
  208 errors
   74 warnings
  101 info
```

Error breakdown by analyzer code:

| Code | Count |
|---|---|
| `undefined_method` | 95 |
| `undefined_named_parameter` | 63 |
| `undefined_getter` | 32 |
| `undefined_identifier` | 17 |
| `invalid_override` | 1 |

## 4. Root causes

Every error traces back to one of eight framework removals.

### 4.1 Legacy Material buttons (removed in Flutter 3.3)

`RaisedButton`, `FlatButton` and `OutlineButton` no longer exist.

| Old | New |
|---|---|
| `RaisedButton` | `ElevatedButton` |
| `FlatButton` | `TextButton` |
| `OutlineButton` | `OutlinedButton` |

Their styling arguments moved into a `ButtonStyle`, so `color:`, `textColor:`,
`padding:`, `shape:`, `elevation:` and `borderSide:` have to be rewritten as
`ElevatedButton.styleFrom(backgroundColor:, foregroundColor:, ...)` and friends.

### 4.2 2018 `TextTheme` names (removed in Flutter 3.x)

| Old | New |
|---|---|
| `headline1` … `headline3` | `displayLarge`, `displayMedium`, `displaySmall` |
| `headline4` … `headline6` | `headlineMedium`, `headlineSmall`, `titleLarge` |
| `subtitle1`, `subtitle2` | `titleMedium`, `titleSmall` |
| `bodyText1`, `bodyText2` | `bodyLarge`, `bodyMedium` |
| `caption`, `button`, `overline` | `bodySmall`, `labelLarge`, `labelSmall` |

### 4.3 `ThemeData` property removals

`accentColor`, `buttonColor`, `bottomAppBarColor` and `ThemeData.brightness`-adjacent
constructor arguments were dropped in favour of `ColorScheme`. `accentColor` reads become
`colorScheme.secondary`; the constructor argument becomes a `colorScheme:` entry.

### 4.4 `BottomNavigationBarItem.title` (removed in Flutter 2.0)

Replaced by `label`, which takes a `String` rather than a `Widget`. Call sites wrapping the
label in `Text(...)` have to be unwrapped.

### 4.5 `Overflow` enum (removed)

`Stack(overflow: Overflow.visible)` becomes `Stack(clipBehavior: Clip.none)`;
`Overflow.clip` becomes `Clip.hardEdge`.

### 4.6 `Scaffold.of(context).showSnackBar` (removed)

Snack bars moved to `ScaffoldMessenger.of(context).showSnackBar`. The associated
`GlobalKey<ScaffoldState>` plumbing becomes unnecessary.

### 4.7 `AppBar.brightness`

Replaced by `systemOverlayStyle: SystemUiOverlayStyle.light/dark`.

### 4.8 Deprecations (non-blocking, cleaned up anyway)

`Color.withOpacity` → `withValues(alpha:)`, `Switch.activeColor` → `activeThumbColor`,
and colon-separated default values in optional parameters, which stop being legal beyond
language version 3.0.

## 5. Dependency audit

Checked against pub.dev on 2026-08-13.

| Package | Pinned | Latest | Status |
|---|---|---|---|
| `animator` | 3.1.0 | 3.3.0 | healthy |
| `bottomreveal` | 2.0.0 | 2.0.0 | stale but compiles |
| `cached_network_image` | 3.2.0 | 3.4.1 | healthy |
| `crop` | 0.5.2 | 0.5.5 | stale but compiles |
| `fl_chart` | 0.36.4 | 1.2.0 | healthy, **breaking API** |
| `flare_flutter` | 3.0.1 | 3.0.2 | stale but compiles |
| `flutter_custom_clippers` | 2.0.0 | 2.1.0 | healthy |
| `flutter_launcher_icons` | 0.9.2 | 0.14.4 | healthy, config key renamed |
| `flutter_speed_dial` | 3.0.5 | 7.0.0 | healthy, **breaking API** |
| `flutter_staggered_grid_view` | 0.4.1 | 0.7.0 | healthy, **breaking API** |
| `flutter_swiper_null_safety` | 1.0.2 | 1.0.2 | stale but compiles (15 call sites) |
| `font_awesome_flutter` | 9.2.0 | 11.0.0 | healthy, icon renames |
| `intl` | 0.17.0 | 0.20.3 | healthy |
| `intro_views_flutter` | 3.1.1 | 3.2.0 | stale but compiles |
| `share` | 2.0.4 | 2.0.4 | **discontinued** → `share_plus` |
| `url_launcher` | 6.0.6 | 6.3.2 | healthy |

Only `share` is formally discontinued. The packages marked "stale" still declare a
`<3.0.0` SDK ceiling, but their sources were checked for removed framework APIs and came
back clean, so they keep working under the Dart 3 bound relaxation.

## 6. Platform folders

The native scaffolding predates the current Flutter templates and is the second half of
the work.

**Android** is the blocker for a real device build:

- Android Gradle Plugin 4.1.0 and Gradle 7.1 — neither runs under JDK 21.
- Kotlin 1.3.50, five major versions behind.
- `jcenter()` repository, shut down in 2022.
- `minSdkVersion 16`, below the Flutter 3.x floor of 21.
- `compileSdkVersion 32`, below what current plugins require.
- No `namespace` declaration, mandatory from AGP 8.
- Imperative `apply plugin:` layout instead of the declarative plugins block.
- `android:name="io.flutter.app.FlutterApplication"` in the manifest, a v1-embedding
  leftover; the `package` attribute is also deprecated in favour of `namespace`.

**Web** uses the pre-3.22 bootstrap: a direct `main.dart.js` script tag plus a manual
service-worker registration. Replaced by the generated `flutter_bootstrap.js` loader.

**Windows / Linux / macOS** runner scaffolding is from the same era and gets regenerated.

## 7. What was actually done

The plan below was followed in order, one commit per step. Two things did not survive
contact with the compiler, both of them because `flutter analyze` does not analyse
dependency sources — only a build does.

1. `chore` — record baseline: this document plus `CHANGELOG.md`.
2. `chore(deps)` — SDK constraint to `>=3.10.0 <4.0.0`, every dependency bumped,
   `share` swapped for `share_plus`.
3. `fix(ui)` — legacy Material buttons, 103 call sites.
4. `fix(theme)` — `ThemeData` and `TextTheme` removals.
5. `fix(ui)` — `BottomNavigationBarItem.label`, 38 call sites.
6. `fix(ui)` — `Overflow` and `ScaffoldMessenger`.
7. `fix(deps)` — staggered grid, slider track shape, colon defaults.
8. `feat(deps)!` — font_awesome_flutter 11 and the removal of flare_flutter.
9. `chore(android)` — Gradle toolchain rebuilt on the current template.
10. `chore(platforms)` — web, Windows and Linux scaffolding regenerated.
11. `chore` — mechanical analyzer fixes; `build/` excluded from analysis.
12. `fix` — the remaining 24 analyzer warnings.
13. `chore` — every deprecated Flutter and package API.
14. `fix` + `test` — the widget suite, and the three defects it exposed.

### The two surprises

**font_awesome_flutter could not be held back.** The first attempt pinned it to 10.12
to avoid rewriting 129 call sites, since version 11 stops `FaIconData` from
implementing `IconData`. That pin analysed clean and then failed to compile:

```
Error: The class 'IconData' can't be extended outside of its library
because it's a final class.
```

Flutter 3.44 marks `IconData` final, which is exactly why the package changed. Version
11 was adopted: `Icon(FontAwesomeIcons.x)` becomes `FaIcon(...)` at 65 sites, and the
64 references feeding an `IconData` typed model field read `.data` off the wrapper.

**Every remote image was dead, and no automated check could see it.** The app
built, analysed clean and passed 141 tests while most screens rendered blank.
The original author's Firebase Storage bucket had been withdrawn from the
no-cost plan and answers HTTP 402, and a failed network image throws nothing —
it simply paints nothing. Only running the app on a device showed it. This is
the clearest argument in the whole migration for finishing on real hardware
rather than on a green test run.

**The imagery had to come into the repository.** Replacing the dead Firebase
bucket with a placeholder service fixed the blank screens but kept the shape of
the problem, and an audit showed it had already spread: of the 55 third-party
image URLs elsewhere in the demos, two returned 403 and one host no longer
resolved. All 135 images are now committed under `assets/images/`, so the app
renders with no network at all.

**flare_flutter could not be saved.** Patching its single `hashValues()` call only
exposed the real blocker: the runtime applies a dozen ordinary classes as mixins,
which Dart 3 rejects unless they are declared `mixin class`, and their hierarchies
make them ineligible. A vendored copy was prepared and then abandoned; the dependency,
the `bus.flr` asset and the Intro 5 demo were removed instead.

### Result

| Check | Before | After |
|---|---|---|
| `flutter analyze` errors | 208 | 0 |
| `flutter analyze` warnings | 74 | 0 |
| `deprecated_member_use` | 128 | 0 |
| Tests | none | 144 passing |
| `flutter build web` | fails | succeeds |
| `flutter build apk` | fails | succeeds |
| `flutter build windows` | not configured | succeeds |

1053 analyzer infos remain. They are stylistic (widget key constructors, doc comment
slashes, `SizedBox` for whitespace, child property ordering) and were left alone on
purpose so the revival diff stayed reviewable. They are the obvious next piece of
work.

### Known trade-offs

- Six dependencies still declare a `<3.0.0` SDK ceiling and rely on Dart 3's bound
  relaxation: `bottomreveal`, `crop`, `flutter_custom_clippers`,
  `flutter_swiper_null_safety` and `intro_views_flutter`. All of them compile today,
  and their sources were checked for removed framework APIs, but none is actively
  maintained. `flutter_swiper_null_safety` is the exposure worth watching: 15 call
  sites depend on it.
- `kotlin.incremental=false` in `android/gradle.properties`. Kotlin 2.3 with AGP 9 on
  Windows fails the plugin modules with "Could not close incremental caches" on a
  clean build. Verified by toggling the flag on a wiped build directory. It costs
  build time, not correctness, and should be removed once the toolchain fixes it.
- iOS and macOS were not rebuilt or verified; neither toolchain is available on this
  machine.

## 8. Definition of done

- `flutter analyze` reports zero errors and zero warnings. **Met.**
- `flutter test` passes. **Met, 144 tests.**
- `flutter build web`, `flutter build windows` and `flutter build apk` all succeed.
  **Met.**
- The app launches and the home menu navigates. **Met.** Verified on a Galaxy Tab
  S9 FE (SM-X510, Android 16, arm64) with the release APK: the home page, the
  catalogue, an authentication demo, the fl_chart dashboard, the staggered
  gallery and the animated loaders all render, and logcat reports no Flutter
  error across the session.

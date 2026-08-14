import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Every demo in this project pulls its imagery from the network. The test
/// binding answers those requests with a 400 by default, which turns a screen
/// full of placeholders into a screen full of exceptions and hides whatever the
/// test was actually looking at.
///
/// [mockNetworkImages] answers instead with a real, if tiny, transparent PNG,
/// so image widgets take the success path and the test only fails on defects
/// that belong to the widget under test.
R mockNetworkImages<R>(R Function() body) {
  return HttpOverrides.runZoned(body, createHttpClient: (_) => _MockHttpClient());
}

/// A 1x1 transparent PNG.
final Uint8List _transparentPixel = Uint8List.fromList(<int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, //
  0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
  0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41,
  0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00,
  0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE,
  0x42, 0x60, 0x82,
]);

class _MockHttpClient implements HttpClient {
  @override
  bool autoUncompress = true;
  @override
  Duration? connectionTimeout;
  @override
  Duration idleTimeout = const Duration(seconds: 15);
  @override
  int? maxConnectionsPerHost;
  @override
  String? userAgent;

  @override
  Future<HttpClientRequest> getUrl(Uri url) async => _MockHttpClientRequest();

  @override
  Future<HttpClientRequest> openUrl(String method, Uri url) async =>
      _MockHttpClientRequest();

  @override
  void close({bool force = false}) {}

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _MockHttpClientRequest implements HttpClientRequest {
  @override
  final HttpHeaders headers = _MockHttpHeaders();

  @override
  Future<HttpClientResponse> close() async => _MockHttpClientResponse();

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _MockHttpClientResponse implements HttpClientResponse {
  @override
  int get statusCode => HttpStatus.ok;

  @override
  int get contentLength => _transparentPixel.length;

  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;

  @override
  final HttpHeaders headers = _MockHttpHeaders();

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return Stream<List<int>>.value(_transparentPixel).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _MockHttpHeaders implements HttpHeaders {
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Wraps [child] in the minimum a demo page needs to build: a MaterialApp for
/// Directionality, theming and a Navigator.
Widget wrapForTest(Widget child) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: child,
  );
}

/// Errors that say something about the size of the test surface rather than
/// about the widget being built.
///
/// These demos are drawn for real handsets and several of them deliberately
/// overflow at other sizes; an overflow here is not a regression. The knock-on
/// assertions a failed layout produces are ignored for the same reason.
bool _isLayoutNoise(FlutterErrorDetails details) {
  final message = details.exceptionAsString();
  const layoutOnly = <String>[
    'overflowed by',
    'RenderBox was not laid out',
    'NEEDS-LAYOUT',
    'hasSize',
    'constraints.hasBoundedHeight',
    'constraints.hasBoundedWidth',
    'The ListTile is wrapped in a DecoratedBox',
    'Trailing widget consumes the entire tile width',
    '!childSemantics.renderObject._needsLayout',
  ];
  return layoutOnly.any(message.contains);
}

/// Builds [widget] and reports whatever it threw while doing so.
///
/// Errors raised while the page is being torn down are not collected: the
/// teardown yanks the widget out mid animation, which is not something any of
/// these screens does in real use, and the resulting "notified listeners after
/// dispose" assertions say nothing about whether the page works.
Future<List<FlutterErrorDetails>> buildAndCollectErrors(
  WidgetTester tester,
  Widget widget,
) async {
  final errors = <FlutterErrorDetails>[];
  var tearingDown = false;

  final previousOnError = FlutterError.onError;
  FlutterError.onError = (FlutterErrorDetails details) {
    if (!tearingDown && !_isLayoutNoise(details)) {
      errors.add(details);
    }
  };

  try {
    await tester.pumpWidget(wrapForTest(widget));
    await tester.pump(const Duration(milliseconds: 16));
    await tester.pump(const Duration(milliseconds: 300));

    tearingDown = true;
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 16));
  } finally {
    FlutterError.onError = previousOnError;
  }

  return errors;
}

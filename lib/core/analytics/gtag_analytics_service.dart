import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:clever_portfolio/core/analytics/analytics_service.dart';

/// External binding to the global `gtag` function injected by `web/index.html`.
/// `@JS('gtag')` ties it to `window.gtag`. All arguments cross as JS types.
@JS('gtag')
external void _gtag(JSAny command, JSAny target, JSAny? params);

/// GA4 implementation backed by the global gtag.js loaded in `web/index.html`.
///
/// Selected by `analytics_factory.dart` on web (`dart:js_interop` available).
/// Every call is guarded by [_ready]: if an adblocker / privacy extension blocks
/// googletagmanager.com, `window.gtag` is undefined and the call is a silent
/// no-op instead of a runtime JS error.
class AnalyticsServiceImpl implements AnalyticsService {
  /// Creates the gtag-backed service.
  const AnalyticsServiceImpl();

  /// True only when gtag.js actually loaded (not blocked).
  bool get _ready => globalContext.has('gtag');

  @override
  void logEvent(String name, {Map<String, Object?> params = const {}}) {
    if (!_ready) return;
    _gtag('event'.toJS, name.toJS, params.isEmpty ? null : params.jsify());
  }

  @override
  void logScreenView(String screenName) {
    if (!_ready) return;
    _gtag(
      'event'.toJS,
      'screen_view'.toJS,
      {'screen_name': screenName}.jsify(),
    );
  }
}

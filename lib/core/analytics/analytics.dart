import 'package:clever_portfolio/core/analytics/analytics_service.dart';
import 'package:clever_portfolio/core/di/injection.dart';

/// Static, null-safe entry point for firing analytics from leaf widgets that
/// have no constructor injection (CV buttons, store buttons).
///
/// Resolves the registered [AnalyticsService] lazily and no-ops when DI isn't
/// configured (e.g. widget tests) — so adding a tracking call to a widget never
/// breaks a test that pumps it without the service locator. Cubits should
/// constructor-inject [AnalyticsService] instead of using this facade.
abstract final class Analytics {
  const Analytics._();

  static AnalyticsService? get _service =>
      getIt.isRegistered<AnalyticsService>() ? getIt<AnalyticsService>() : null;

  /// Logs a CV download triggered from [source] (`hero` / `navbar` / `contact`).
  static void cvDownload(String source) => _service?.cvDownload(source);

  /// Logs opening the [store] listing for [appName].
  static void storeOpen({required String appName, required String store}) =>
      _service?.storeOpen(appName: appName, store: store);
}

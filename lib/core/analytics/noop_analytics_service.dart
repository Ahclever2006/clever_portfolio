import 'package:clever_portfolio/core/analytics/analytics_service.dart';

/// No-op [AnalyticsService] for the Dart VM / tests / any non-web target.
///
/// Selected by `analytics_factory.dart` whenever `dart:js_interop` is NOT
/// available, so non-web compiles never reference JS interop. Named
/// `AnalyticsServiceImpl` to match the web impl behind the conditional import.
class AnalyticsServiceImpl implements AnalyticsService {
  /// Creates the no-op service.
  const AnalyticsServiceImpl();

  @override
  void logEvent(String name, {Map<String, Object?> params = const {}}) {}

  @override
  void logScreenView(String screenName) {}
}

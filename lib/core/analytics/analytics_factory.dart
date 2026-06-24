import 'package:clever_portfolio/core/analytics/analytics_service.dart';
// Compile-time platform selection: the gtag impl on web (where
// `dart:js_interop` exists), the no-op everywhere else. This keeps
// `dart:js_interop` out of VM/test compiles entirely.
import 'package:clever_portfolio/core/analytics/noop_analytics_service.dart'
    if (dart.library.js_interop) 'package:clever_portfolio/core/analytics/gtag_analytics_service.dart';

/// Builds the platform-appropriate [AnalyticsService]. Registered as a
/// lazySingleton in `RegisterModule`.
AnalyticsService createAnalyticsService() => const AnalyticsServiceImpl();

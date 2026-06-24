import 'package:clever_portfolio/core/analytics/analytics_factory.dart';
import 'package:clever_portfolio/core/analytics/analytics_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show AssetBundle, rootBundle;
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Registers third-party singletons that aren't ours to annotate.
@module
abstract class RegisterModule {
  /// The raw Dio instance (wrapped by `DioClient`).
  @lazySingleton
  Dio get dio => Dio();

  /// Analytics (GA4/gtag on web, no-op on VM/tests). The impl is chosen at
  /// compile time by `createAnalyticsService()` (conditional import).
  @lazySingleton
  AnalyticsService get analytics => createAnalyticsService();

  /// The root asset bundle (data sources read bundled JSON from it).
  @lazySingleton
  AssetBundle get assetBundle => rootBundle;

  /// Persisted preferences (theme mode, etc.); pre-resolved at startup.
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}

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

  /// The root asset bundle (data sources read bundled JSON from it).
  @lazySingleton
  AssetBundle get assetBundle => rootBundle;

  /// Persisted preferences (theme mode, etc.); pre-resolved at startup.
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}

import 'package:clever_portfolio/core/error/failures.dart';
import 'package:clever_portfolio/core/theme/domain/theme_repository.dart';
import 'package:clever_portfolio/core/utils/typedefs.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [ThemeRepository] backed by SharedPreferences.
@LazySingleton(as: ThemeRepository)
class ThemeRepositoryImpl implements ThemeRepository {
  /// Creates the impl over injected [SharedPreferences].
  ThemeRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;
  static const String _key = 'theme_mode';

  @override
  ResultFuture<ThemeMode> getThemeMode() async {
    try {
      final stored = _prefs.getString(_key);
      final mode = switch (stored) {
        'light' => ThemeMode.light,
        'system' => ThemeMode.system,
        _ => ThemeMode.dark, // dark-first default
      };
      return Right(mode);
    } on Object {
      return const Left(CacheFailure());
    }
  }

  @override
  ResultVoid saveThemeMode(ThemeMode mode) async {
    try {
      await _prefs.setString(_key, mode.name);
      return const Right(unit);
    } on Object {
      return const Left(CacheFailure());
    }
  }
}

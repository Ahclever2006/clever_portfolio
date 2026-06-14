import 'package:clever_portfolio/core/utils/typedefs.dart';
import 'package:flutter/material.dart' show ThemeMode;

/// Persistence for the user's theme preference.
abstract class ThemeRepository {
  /// Reads the stored [ThemeMode] (dark-first when none stored).
  ResultFuture<ThemeMode> getThemeMode();

  /// Persists [mode].
  ResultVoid saveThemeMode(ThemeMode mode);
}

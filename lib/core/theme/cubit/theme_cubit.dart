import 'package:clever_portfolio/core/abstract/base_cubit.dart';
import 'package:clever_portfolio/core/theme/cubit/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Owns the active [ThemeMode] (dark-first) and persists it.
///
/// M1 reads/writes [SharedPreferences] directly; M2 refactors this behind
/// `Get/SaveThemeMode` use cases + DI (plan.md §5.4).
class ThemeCubit extends BaseCubit<ThemeState> {
  /// Creates the cubit in its [ThemeState.initial] (resolves dark-first).
  ThemeCubit() : super(const ThemeState.initial());

  static const String _key = 'theme_mode';

  /// The resolved mode for `MaterialApp.themeMode` (dark until loaded).
  ThemeMode get mode => switch (state) {
    ThemeLoaded(:final mode) => mode,
    ThemeInitial() => ThemeMode.dark,
  };

  /// Reads the persisted mode; defaults to dark when nothing is stored.
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_key);
    final resolved = switch (stored) {
      'light' => ThemeMode.light,
      'system' => ThemeMode.system,
      _ => ThemeMode.dark,
    };
    emit(ThemeState.loaded(resolved));
  }

  /// Sets and persists [next].
  Future<void> setMode(ThemeMode next) async {
    emit(ThemeState.loaded(next));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, next.name);
  }

  /// Flips between light and dark.
  Future<void> toggle() =>
      setMode(mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
}

import 'package:clever_portfolio/core/abstract/base_cubit.dart';
import 'package:clever_portfolio/core/theme/cubit/theme_state.dart';
import 'package:clever_portfolio/core/theme/domain/usecases/get_theme_mode.dart';
import 'package:clever_portfolio/core/theme/domain/usecases/save_theme_mode.dart';
import 'package:clever_portfolio/core/usecase/usecase.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

/// Owns the active [ThemeMode] (dark-first), via the Get/Save use cases.
@injectable
class ThemeCubit extends BaseCubit<ThemeState> {
  /// Creates the cubit; starts in [ThemeState.initial] (resolves dark-first).
  ThemeCubit(this._getThemeMode, this._saveThemeMode)
    : super(const ThemeState.initial());

  final GetThemeMode _getThemeMode;
  final SaveThemeMode _saveThemeMode;

  /// The resolved mode for `MaterialApp.themeMode` (dark until loaded).
  ThemeMode get mode => switch (state) {
    ThemeLoaded(:final mode) => mode,
    ThemeInitial() => ThemeMode.dark,
  };

  /// Reads the persisted mode (dark-first fallback on failure).
  Future<void> load() async {
    final result = await _getThemeMode(const NoParams());
    result.fold(
      (_) => emit(const ThemeState.loaded(ThemeMode.dark)),
      (m) => emit(ThemeState.loaded(m)),
    );
  }

  /// Sets and persists [next].
  Future<void> setMode(ThemeMode next) async {
    emit(ThemeState.loaded(next));
    await _saveThemeMode(next);
  }

  /// Flips between light and dark.
  Future<void> toggle() =>
      setMode(mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
}

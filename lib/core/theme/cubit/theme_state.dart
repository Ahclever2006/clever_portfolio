import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_state.freezed.dart';

/// State for [ThemeCubit] (plan.md §5.4).
@freezed
sealed class ThemeState with _$ThemeState {
  /// Before the persisted mode has been read (resolves dark-first).
  const factory ThemeState.initial() = ThemeInitial;

  /// A resolved theme [mode].
  const factory ThemeState.loaded(ThemeMode mode) = ThemeLoaded;
}

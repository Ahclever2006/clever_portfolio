import 'package:clever_portfolio/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Material [ColorScheme]s mapped from [AppColors] (plan.md §7).
///
/// Built via `fromSeed` (so every derived M3 role exists) then overridden with
/// the exact design tokens. Canvas background is set on `scaffoldBackgroundColor`
/// in `AppTheme` (M3 deprecated `background`/`onBackground`).
abstract final class AppColorScheme {
  const AppColorScheme._();

  static final ColorScheme light =
      ColorScheme.fromSeed(seedColor: AppColors.lPrimary).copyWith(
        primary: AppColors.lPrimary,
        onPrimary: AppColors.lOnPrimary,
        secondary: AppColors.lSecondary,
        onSecondary: AppColors.lOnPrimary,
        surface: AppColors.lSurface,
        onSurface: AppColors.lOnSurface,
        surfaceContainerHighest: AppColors.lSurfaceVariant,
        surfaceContainerHigh: AppColors.lSurfaceElevated,
        onSurfaceVariant: AppColors.lMuted,
        outline: AppColors.lOutline,
        outlineVariant: AppColors.lOutlineStrong,
        error: AppColors.lDanger,
        onError: AppColors.lOnPrimary,
        surfaceTint: AppColors.lAccent,
      );

  static final ColorScheme dark =
      ColorScheme.fromSeed(
        seedColor: AppColors.dPrimary,
        brightness: Brightness.dark,
      ).copyWith(
        primary: AppColors.dPrimary,
        onPrimary: AppColors.dOnPrimary,
        secondary: AppColors.dSecondary,
        onSecondary: AppColors.dOnPrimary,
        surface: AppColors.dSurface,
        onSurface: AppColors.dOnSurface,
        surfaceContainerHighest: AppColors.dSurfaceVariant,
        surfaceContainerHigh: AppColors.dSurfaceElevated,
        onSurfaceVariant: AppColors.dMuted,
        outline: AppColors.dOutline,
        outlineVariant: AppColors.dOutlineStrong,
        error: AppColors.dDanger,
        onError: AppColors.dOnPrimary,
        surfaceTint: AppColors.dAccent,
      );
}

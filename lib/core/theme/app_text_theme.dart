import 'package:clever_portfolio/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// Builds the Material [TextTheme] from [AppTypography] so default Material
/// widgets inherit the type scale (plan.md §3.2).
///
/// Arabic note: the chosen Arabic face is **Cairo**; M4 swaps in
/// `GoogleFonts.cairoTextTheme` when the active locale is `ar`.
abstract final class AppTextTheme {
  const AppTextTheme._();

  /// Returns a [TextTheme] tinted to [onSurface].
  static TextTheme build(Color onSurface) {
    final base = TextTheme(
      displayLarge: AppTypography.displayHero,
      displayMedium: AppTypography.displaySection,
      headlineMedium: AppTypography.displaySection,
      titleLarge: AppTypography.title,
      titleMedium: AppTypography.title,
      bodyLarge: AppTypography.body,
      bodyMedium: AppTypography.bodySmall,
      labelLarge: AppTypography.label,
      labelMedium: AppTypography.eyebrowMono,
      labelSmall: AppTypography.captionMono,
    );
    return base.apply(bodyColor: onSurface, displayColor: onSurface);
  }
}

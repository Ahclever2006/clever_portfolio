import 'package:clever_portfolio/core/theme/app_color_scheme.dart';
import 'package:clever_portfolio/core/theme/app_colors.dart';
import 'package:clever_portfolio/core/theme/app_text_theme.dart';
import 'package:clever_portfolio/core/theme/app_typography.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';

/// Application themes (light + dark), built entirely from the design system
/// (plan.md §3 & §7). Dark is the default. Widgets read ONLY `colorScheme`,
/// `textTheme`, and the registered ThemeExtensions — never raw values.
abstract final class AppTheme {
  const AppTheme._();

  /// Light theme.
  static ThemeData get light => _build(
    scheme: AppColorScheme.light,
    canvas: AppColors.lBackground,
    extensions: _lightExtensions,
  );

  /// Dark theme (default).
  static ThemeData get dark => _build(
    scheme: AppColorScheme.dark,
    canvas: AppColors.dBackground,
    extensions: _darkExtensions,
  );

  static const List<ThemeExtension<dynamic>> _lightExtensions = [
    AppSpacing(),
    AppRadii(),
    MotionTokens(),
    BrandColors(
      accentSoft: AppColors.lAccentSoft,
      focusRing: AppColors.lFocusRing,
      glow: AppColors.lGlow,
      codeText: AppColors.lCodeText,
      folio: AppColors.lFolio,
      glassTint: AppColors.lGlassTint,
      primaryHover: AppColors.lPrimaryHover,
      primaryPressed: AppColors.lPrimaryPressed,
      success: AppColors.lSuccess,
      warning: AppColors.lWarning,
    ),
    CategoryColors(
      ecommerce: AppColors.lCatEcommerce,
      games: AppColors.lCatGames,
      booking: AppColors.lCatBooking,
      business: AppColors.lCatBusiness,
      food: AppColors.lCatFood,
      services: AppColors.lCatServices,
      medical: AppColors.lCatMedical,
      education: AppColors.lCatEducation,
      travel: AppColors.lCatTravel,
    ),
  ];

  static const List<ThemeExtension<dynamic>> _darkExtensions = [
    AppSpacing(),
    AppRadii(),
    MotionTokens(),
    BrandColors(
      accentSoft: AppColors.dAccentSoft,
      focusRing: AppColors.dFocusRing,
      glow: AppColors.dGlow,
      codeText: AppColors.dCodeText,
      folio: AppColors.dFolio,
      glassTint: AppColors.dGlassTint,
      primaryHover: AppColors.dPrimaryHover,
      primaryPressed: AppColors.dPrimaryPressed,
      success: AppColors.dSuccess,
      warning: AppColors.dWarning,
    ),
    CategoryColors(
      ecommerce: AppColors.dCatEcommerce,
      games: AppColors.dCatGames,
      booking: AppColors.dCatBooking,
      business: AppColors.dCatBusiness,
      food: AppColors.dCatFood,
      services: AppColors.dCatServices,
      medical: AppColors.dCatMedical,
      education: AppColors.dCatEducation,
      travel: AppColors.dCatTravel,
    ),
  ];

  static ThemeData _build({
    required ColorScheme scheme,
    required Color canvas,
    required List<ThemeExtension<dynamic>> extensions,
  }) {
    final textTheme = AppTextTheme.build(scheme.onSurface);
    // Component themes draw radii/spacing from the design tokens (single source).
    const radii = AppRadii();
    const spacing = AppSpacing();
    // plan.md §3.4: button padding V14 / H24 (24 == spacing.lg).
    final buttonPadding = EdgeInsets.symmetric(
      vertical: 14,
      horizontal: spacing.lg,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: scheme.brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: canvas,
      textTheme: textTheme,
      extensions: extensions,
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          textStyle: AppTypography.label,
          padding: buttonPadding,
          // Fixed-px tap-target floor so the box never dwarfs the .sp label.
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radii.button),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.onSurface,
          side: BorderSide(color: scheme.outlineVariant),
          textStyle: AppTypography.label,
          padding: buttonPadding,
          // Fixed-px tap-target floor so the box never dwarfs the .sp label.
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radii.button),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radii.card),
          side: BorderSide(color: scheme.outline),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: scheme.surfaceContainerHighest,
        side: BorderSide(color: scheme.outline),
        labelStyle: AppTypography.label.copyWith(color: scheme.onSurface),
        shape: const StadiumBorder(),
      ),
      appBarTheme: const AppBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      inputDecorationTheme: InputDecorationThemeData(
        filled: true,
        fillColor: scheme.surface,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radii.input),
          borderSide: BorderSide(color: scheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radii.input),
          borderSide: BorderSide(color: scheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radii.input),
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
      ),
    );
  }
}

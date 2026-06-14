import 'package:clever_portfolio/core/theme/tokens/app_radii.dart';
import 'package:clever_portfolio/core/theme/tokens/app_spacing.dart';
import 'package:clever_portfolio/core/theme/tokens/brand_colors.dart';
import 'package:clever_portfolio/core/theme/tokens/category_colors.dart';
import 'package:clever_portfolio/core/theme/tokens/motion_tokens.dart';
import 'package:flutter/material.dart';

export 'tokens/app_radii.dart';
export 'tokens/app_spacing.dart';
export 'tokens/brand_colors.dart';
export 'tokens/category_colors.dart';
export 'tokens/motion_tokens.dart';

/// Ergonomic theme access for widgets — the ONLY way widgets read design
/// tokens (never raw [AppColors] / literals).
extension ThemeExtensionsX on BuildContext {
  /// Material color roles.
  ColorScheme get colors => Theme.of(this).colorScheme;

  /// Named text styles.
  TextTheme get text => Theme.of(this).textTheme;

  /// Spacing + layout scale.
  AppSpacing get spacing => Theme.of(this).extension<AppSpacing>()!;

  /// Corner radii.
  AppRadii get radii => Theme.of(this).extension<AppRadii>()!;

  /// Brand colors not present in [ColorScheme].
  BrandColors get brand => Theme.of(this).extension<BrandColors>()!;

  /// Per-category accent hues.
  CategoryColors get categoryColors =>
      Theme.of(this).extension<CategoryColors>()!;

  /// Motion durations + curves.
  MotionTokens get motion => Theme.of(this).extension<MotionTokens>()!;
}

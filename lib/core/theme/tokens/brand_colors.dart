import 'package:flutter/material.dart';

/// Brand color tokens that have no slot in Material's [ColorScheme]
/// (plan.md §3.1). Widgets read these via `context.brand` rather than touching
/// raw [AppColors].
@immutable
class BrandColors extends ThemeExtension<BrandColors> {
  const BrandColors({
    required this.accentSoft,
    required this.focusRing,
    required this.glow,
    required this.codeText,
    required this.folio,
    required this.glassTint,
    required this.primaryHover,
    required this.primaryPressed,
    required this.success,
    required this.warning,
  });

  final Color accentSoft;
  final Color focusRing;
  final Color glow;
  final Color codeText;
  final Color folio;
  final Color glassTint;
  final Color primaryHover;
  final Color primaryPressed;
  final Color success;
  final Color warning;

  @override
  BrandColors copyWith({
    Color? accentSoft,
    Color? focusRing,
    Color? glow,
    Color? codeText,
    Color? folio,
    Color? glassTint,
    Color? primaryHover,
    Color? primaryPressed,
    Color? success,
    Color? warning,
  }) {
    return BrandColors(
      accentSoft: accentSoft ?? this.accentSoft,
      focusRing: focusRing ?? this.focusRing,
      glow: glow ?? this.glow,
      codeText: codeText ?? this.codeText,
      folio: folio ?? this.folio,
      glassTint: glassTint ?? this.glassTint,
      primaryHover: primaryHover ?? this.primaryHover,
      primaryPressed: primaryPressed ?? this.primaryPressed,
      success: success ?? this.success,
      warning: warning ?? this.warning,
    );
  }

  @override
  BrandColors lerp(ThemeExtension<BrandColors>? other, double t) {
    if (other is! BrandColors) return this;
    return BrandColors(
      accentSoft: Color.lerp(accentSoft, other.accentSoft, t)!,
      focusRing: Color.lerp(focusRing, other.focusRing, t)!,
      glow: Color.lerp(glow, other.glow, t)!,
      codeText: Color.lerp(codeText, other.codeText, t)!,
      folio: Color.lerp(folio, other.folio, t)!,
      glassTint: Color.lerp(glassTint, other.glassTint, t)!,
      primaryHover: Color.lerp(primaryHover, other.primaryHover, t)!,
      primaryPressed: Color.lerp(primaryPressed, other.primaryPressed, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
    );
  }
}

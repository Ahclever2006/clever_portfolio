import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

/// Spacing + layout scale (plan.md §3.3). Raw logical px — apply `.w`/`.h` at
/// use sites for responsive scaling.
@immutable
class AppSpacing extends ThemeExtension<AppSpacing> {
  const AppSpacing({
    this.xs = 4,
    this.sm = 8,
    this.md = 16,
    this.lg = 24,
    this.xl = 40,
    this.xxl = 64,
    this.sectionDesktop = 96,
    this.sectionMobile = 56,
    this.gutterMobile = 24,
    this.gutterDesktop = 64,
    this.maxContentWidth = 1200,
    this.gridGap = 20,
  });

  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  final double sectionDesktop;
  final double sectionMobile;
  final double gutterMobile;
  final double gutterDesktop;
  final double maxContentWidth;
  final double gridGap;

  @override
  AppSpacing copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
    double? sectionDesktop,
    double? sectionMobile,
    double? gutterMobile,
    double? gutterDesktop,
    double? maxContentWidth,
    double? gridGap,
  }) {
    return AppSpacing(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
      sectionDesktop: sectionDesktop ?? this.sectionDesktop,
      sectionMobile: sectionMobile ?? this.sectionMobile,
      gutterMobile: gutterMobile ?? this.gutterMobile,
      gutterDesktop: gutterDesktop ?? this.gutterDesktop,
      maxContentWidth: maxContentWidth ?? this.maxContentWidth,
      gridGap: gridGap ?? this.gridGap,
    );
  }

  @override
  AppSpacing lerp(ThemeExtension<AppSpacing>? other, double t) {
    if (other is! AppSpacing) return this;
    return AppSpacing(
      xs: lerpDouble(xs, other.xs, t)!,
      sm: lerpDouble(sm, other.sm, t)!,
      md: lerpDouble(md, other.md, t)!,
      lg: lerpDouble(lg, other.lg, t)!,
      xl: lerpDouble(xl, other.xl, t)!,
      xxl: lerpDouble(xxl, other.xxl, t)!,
      sectionDesktop: lerpDouble(sectionDesktop, other.sectionDesktop, t)!,
      sectionMobile: lerpDouble(sectionMobile, other.sectionMobile, t)!,
      gutterMobile: lerpDouble(gutterMobile, other.gutterMobile, t)!,
      gutterDesktop: lerpDouble(gutterDesktop, other.gutterDesktop, t)!,
      maxContentWidth: lerpDouble(maxContentWidth, other.maxContentWidth, t)!,
      gridGap: lerpDouble(gridGap, other.gridGap, t)!,
    );
  }
}

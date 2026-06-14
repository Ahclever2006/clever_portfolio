import 'package:clever_portfolio/core/responsive/app_breakpoints.dart';
import 'package:flutter/widgets.dart';

/// A value that varies per [Breakpoint]; missing tiers fall back downward
/// (wide→desktop→tablet→mobile).
class Responsive<T> {
  /// Creates a [Responsive] value; [mobile] is required as the base.
  const Responsive({
    required this.mobile,
    this.tablet,
    this.desktop,
    this.wide,
  });

  /// Base value (always present).
  final T mobile;

  /// Tablet override.
  final T? tablet;

  /// Desktop override.
  final T? desktop;

  /// Wide override.
  final T? wide;

  /// Resolves the value for [bp].
  T resolve(Breakpoint bp) {
    return switch (bp) {
      Breakpoint.mobile => mobile,
      Breakpoint.tablet => tablet ?? mobile,
      Breakpoint.desktop => desktop ?? tablet ?? mobile,
      Breakpoint.wide => wide ?? desktop ?? tablet ?? mobile,
    };
  }
}

/// Breakpoint access for widgets. No widget should read `MediaQuery` for sizing
/// directly — use this (plan.md §8).
extension ResponsiveContextX on BuildContext {
  /// The active [Breakpoint] for the current width.
  Breakpoint get bp => AppBreakpoints.of(MediaQuery.sizeOf(this).width);

  /// True on phones (`< 600`).
  bool get isMobile => bp == Breakpoint.mobile;

  /// True on tablets (`600–1024`).
  bool get isTablet => bp == Breakpoint.tablet;

  /// True on desktop/wide (`> 1024`).
  bool get isDesktop => bp == Breakpoint.desktop || bp == Breakpoint.wide;

  /// Picks a value for the current breakpoint.
  T responsive<T>({required T mobile, T? tablet, T? desktop, T? wide}) {
    return Responsive<T>(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      wide: wide,
    ).resolve(bp);
  }
}

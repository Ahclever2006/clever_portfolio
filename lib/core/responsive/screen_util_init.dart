import 'package:clever_portfolio/core/responsive/app_breakpoints.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The mandated "sizeHelper" boundary: initializes flutter_screenutil so `.w` /
/// `.h` / `.sp` / `.r` resolve everywhere (plan.md §8).
///
/// The design tokens (typography, spacing, radii) were authored against a
/// **1440-wide** desktop canvas. Driving every breakpoint from that single
/// canvas makes `.sp`/`.w` collapse to ~0.27× on a phone (1440 ÷ ~390),
/// rendering text microscopic while `.h` stays near 1.0 — the classic
/// "tiny text + huge gaps + oversized buttons" failure. To avoid it the design
/// size **tracks the active breakpoint**, so the scale factor lands near ~1.0 on
/// each tier. Desktop/wide keep `1440×1024`, so the desktop render is unchanged.
class AppScreenUtilInit extends StatelessWidget {
  /// Creates an [AppScreenUtilInit] that builds [builder] once initialized.
  const AppScreenUtilInit({required this.builder, super.key});

  /// Builds the app subtree (typically `MaterialApp`).
  final Widget Function(BuildContext context, Widget? child) builder;

  /// Representative design size for [bp] — the canvas the tokens scale against.
  static Size _designSizeFor(Breakpoint bp) {
    return switch (bp) {
      Breakpoint.mobile => const Size(390, 844),
      Breakpoint.tablet => const Size(834, 1112),
      Breakpoint.desktop => const Size(1440, 1024),
      Breakpoint.wide => const Size(1440, 1024),
    };
  }

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder gives the window width at the root and rebuilds on resize;
    // ScreenUtilInit re-runs `ScreenUtil.configure` on every build, so the new
    // design size takes effect immediately when the breakpoint changes.
    return LayoutBuilder(
      builder: (context, constraints) {
        final bp = AppBreakpoints.of(constraints.maxWidth);
        return ScreenUtilInit(
          // Force a clean re-init at tier boundaries so theme component styles
          // (which bake `.sp` sizes at build time) refresh too.
          key: ValueKey<Breakpoint>(bp),
          designSize: _designSizeFor(bp),
          minTextAdapt: true,
          builder: builder,
        );
      },
    );
  }
}

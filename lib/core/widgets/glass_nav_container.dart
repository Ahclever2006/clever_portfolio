import 'dart:ui' show ImageFilter;

import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

/// The one glassmorphism surface (reserved for the nav, plan.md §3.6):
/// backdrop blur + `glassTint`, with a hairline bottom border that gains an
/// accent glow once [elevated] (scrolled past the hero).
///
/// On **web** the live [BackdropFilter] is dropped in favour of a higher-alpha
/// tint: the navbar sits over the scrolling page, so its backdrop pixels change
/// every scroll tick and CanvasKit (no Impeller) cannot cache the blur — it
/// re-runs a framebuffer read-back + sigma-18 Gaussian on every scroll frame,
/// the single biggest scroll-path cost. The tint reads as frosted on the dark
/// theme without that per-frame stall. Real blur is kept on non-web targets.
class GlassNavContainer extends StatelessWidget {
  /// Creates a [GlassNavContainer] wrapping [child].
  const GlassNavContainer({
    required this.child,
    this.elevated = false,
    super.key,
  });

  /// Nav contents.
  final Widget child;

  /// Whether the page has scrolled past the hero.
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    // On web, raise the tint alpha so the bar still reads as frosted without a
    // live blur sampling the (constantly scrolling) pixels behind it.
    final tint = kIsWeb
        ? context.brand.glassTint.withValues(alpha: 0.92)
        : context.brand.glassTint;

    final surface = AnimatedContainer(
      duration: context.motion.hover,
      decoration: BoxDecoration(
        color: tint,
        border: Border(
          bottom: BorderSide(
            color: elevated ? context.colors.primary : context.colors.outline,
          ),
        ),
      ),
      child: child,
    );

    if (kIsWeb) return surface;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: surface,
      ),
    );
  }
}

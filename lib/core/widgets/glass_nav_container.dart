import 'dart:ui' show ImageFilter;

import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';

/// The one glassmorphism surface (reserved for the nav, plan.md §3.6):
/// backdrop blur + `glassTint`, with a hairline bottom border that gains an
/// accent glow once [elevated] (scrolled past the hero).
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
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: AnimatedContainer(
          duration: context.motion.hover,
          decoration: BoxDecoration(
            color: context.brand.glassTint,
            border: Border(
              bottom: BorderSide(
                color: elevated
                    ? context.colors.primary
                    : context.colors.outline,
              ),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

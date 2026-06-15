import 'package:clever_portfolio/core/constants/app_strings.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Circular back-to-top button that slides/fades in once scrolled down, with a
/// gentle pulsing glow (frozen under reduced-motion).
class BackToTopButton extends StatelessWidget {
  /// Creates a [BackToTopButton].
  const BackToTopButton({
    required this.visible,
    required this.onTap,
    super.key,
  });

  /// Whether the button is shown.
  final bool visible;

  /// Tap handler (scrolls to top).
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final reduce = MediaQuery.of(context).disableAnimations;

    Widget button = Tooltip(
      message: AppStrings.footerBackToTop.tr(),
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: context.colors.primary.withValues(alpha: 0.55),
              blurRadius: 24,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Material(
          color: context.colors.primary,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: ConstrainedBox(
              // Guarantee a ≥48px tap target regardless of the scale factor.
              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
              child: Padding(
                padding: EdgeInsets.all(context.spacing.md.w),
                child: Icon(
                  Icons.arrow_upward_rounded,
                  color: context.colors.onPrimary,
                  size: 22.r,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (!reduce) {
      button = button
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .scaleXY(
            begin: 1,
            end: 1.08,
            duration: const Duration(milliseconds: 1100),
            curve: Curves.easeInOut,
          );
    }

    return IgnorePointer(
      ignoring: !visible,
      child: AnimatedSlide(
        offset: visible ? Offset.zero : const Offset(0, 1.5),
        duration: context.motion.button,
        curve: context.motion.curveHover,
        child: AnimatedOpacity(
          opacity: visible ? 1 : 0,
          duration: context.motion.button,
          child: button,
        ),
      ),
    );
  }
}

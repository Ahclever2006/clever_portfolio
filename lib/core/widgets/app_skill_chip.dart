import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Translucent "glass" skill pill (plan.md §3.4).
///
/// On pointer hover the chip lifts into the emerald "signal" state: the border
/// ignites to the accent, an outer glow blooms, the surface tints, and the
/// label brightens — the "Production Terminal" hover language.
class AppSkillChip extends StatefulWidget {
  /// Creates an [AppSkillChip].
  const AppSkillChip({required this.label, super.key});

  /// Skill label (already translated).
  final String label;

  @override
  State<AppSkillChip> createState() => _AppSkillChipState();
}

class _AppSkillChipState extends State<AppSkillChip> {
  bool _hovered = false;

  void _setHover(bool value) {
    if (_hovered == value) return;
    setState(() => _hovered = value);
  }

  @override
  Widget build(BuildContext context) {
    final hovered = _hovered;
    final accent = context.colors.primary;
    final labelStyle = (context.text.labelLarge ?? const TextStyle()).copyWith(
      color: hovered ? accent : context.colors.onSurface,
    );

    return MouseRegion(
      onEnter: (_) => _setHover(true),
      onExit: (_) => _setHover(false),
      child: AnimatedScale(
        duration: context.motion.hover,
        curve: context.motion.curveHover,
        scale: hovered ? 1.03 : 1,
        child: AnimatedContainer(
          duration: context.motion.hover,
          curve: context.motion.curveHover,
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: context.spacing.md.w,
            vertical: context.spacing.sm.h,
          ),
          decoration: BoxDecoration(
            color: hovered
                ? context.brand.accentSoft.withValues(alpha: 0.55)
                : context.colors.surfaceContainerHighest.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(context.radii.pill.r),
            border: Border.all(
              color: hovered ? accent : context.colors.outline,
              width: hovered ? 1.5 : 1,
            ),
            boxShadow: hovered
                ? [
                    BoxShadow(
                      color: context.brand.glow,
                      blurRadius: 24.r,
                      spreadRadius: 1.r,
                    ),
                    BoxShadow(
                      color: accent.withValues(alpha: 0.3),
                      blurRadius: 10.r,
                    ),
                  ]
                : null,
          ),
          child: AnimatedDefaultTextStyle(
            duration: context.motion.hover,
            curve: context.motion.curveHover,
            style: labelStyle,
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}

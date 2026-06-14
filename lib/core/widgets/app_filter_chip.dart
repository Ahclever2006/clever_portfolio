import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Category / platform filter pill (plan.md §3.4). Inactive = neutral surface;
/// active = category-hue text on `accentSoft` with a hue border.
class AppFilterChip extends StatelessWidget {
  /// Creates an [AppFilterChip].
  const AppFilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.accent,
    super.key,
  });

  /// Pill label (already translated).
  final String label;

  /// Whether this filter is active.
  final bool selected;

  /// Tap handler.
  final VoidCallback onTap;

  /// Category hue; defaults to the primary accent ("All").
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final hue = accent ?? context.colors.primary;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(context.radii.pill.r),
        child: AnimatedContainer(
          duration: context.motion.button,
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: context.spacing.md.w,
            vertical: context.spacing.sm.w,
          ),
          decoration: BoxDecoration(
            color: selected
                ? context.brand.accentSoft
                : context.colors.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(context.radii.pill.r),
            border: Border.all(color: selected ? hue : context.colors.outline),
          ),
          child: Text(
            label,
            style: context.text.labelLarge?.copyWith(
              color: selected ? hue : context.colors.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}

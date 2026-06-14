import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Translucent "glass" skill pill (plan.md §3.4).
class AppSkillChip extends StatelessWidget {
  /// Creates an [AppSkillChip].
  const AppSkillChip({required this.label, super.key});

  /// Skill label (already translated).
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: context.spacing.md.w,
        vertical: context.spacing.sm.w,
      ),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerHighest.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(context.radii.pill.r),
        border: Border.all(color: context.colors.outline),
      ),
      child: Text(
        label,
        style: context.text.labelLarge?.copyWith(
          color: context.colors.onSurface,
        ),
      ),
    );
  }
}

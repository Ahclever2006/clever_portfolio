import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Small monospace platform badge (iOS / Android), per plan.md §3.4.
class AppPlatformChip extends StatelessWidget {
  /// Creates an [AppPlatformChip].
  const AppPlatformChip({required this.label, this.icon, super.key});

  /// Badge label (e.g. "iOS" / "Android").
  final String label;

  /// Optional leading glyph.
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: context.spacing.sm.w,
        vertical: context.spacing.xs.h,
      ),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(context.radii.chip.r),
        border: Border.all(color: context.colors.outline),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12.sp, color: context.colors.onSurfaceVariant),
            SizedBox(width: context.spacing.xs.w),
          ],
          Text(
            label,
            style: context.text.labelSmall?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

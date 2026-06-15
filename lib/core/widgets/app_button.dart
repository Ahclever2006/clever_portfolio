import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Visual variants for [AppButton].
enum AppButtonVariant { primary, ghost }

/// The app's button — use instead of raw `FilledButton`/`OutlinedButton`.
/// Styling comes entirely from the theme's button themes (plan.md §3.4).
class AppButton extends StatelessWidget {
  /// A filled primary button.
  const AppButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.primary,
    super.key,
  });

  /// A bordered "ghost" button.
  const AppButton.ghost({
    required this.label,
    required this.onPressed,
    this.icon,
    super.key,
  }) : variant = AppButtonVariant.ghost;

  /// Button label (caller passes already-translated text).
  final String label;

  /// Tap handler; `null` disables the button.
  final VoidCallback? onPressed;

  /// Optional leading icon.
  final IconData? icon;

  /// Visual variant.
  final AppButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    final Widget child = icon == null
        ? Text(label)
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18.r),
              SizedBox(width: context.spacing.sm.w),
              Text(label),
            ],
          );
    return switch (variant) {
      AppButtonVariant.primary => FilledButton(
        onPressed: onPressed,
        child: child,
      ),
      AppButtonVariant.ghost => OutlinedButton(
        onPressed: onPressed,
        child: child,
      ),
    };
  }
}

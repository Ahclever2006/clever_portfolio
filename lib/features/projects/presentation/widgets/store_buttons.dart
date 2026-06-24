import 'package:clever_portfolio/core/analytics/analytics.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/core/utils/app_launcher.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Renders store buttons ONLY for the platforms an app actually ships on.
class StoreButtons extends StatelessWidget {
  /// Creates [StoreButtons] for [project].
  const StoreButtons({required this.project, super.key});

  /// The project.
  final AppProject project;

  @override
  Widget build(BuildContext context) {
    final ios = project.iosUrl;
    final android = project.androidUrl;
    return Wrap(
      spacing: context.spacing.sm.w,
      runSpacing: context.spacing.xs.h,
      children: [
        if (ios != null)
          _StoreChip(
            icon: FontAwesomeIcons.appStoreIos,
            label: 'App Store', // no-tr (brand name)
            onTap: () {
              Analytics.storeOpen(appName: project.name, store: 'app_store');
              AppLauncher.open(ios);
            },
          ),
        if (android != null)
          _StoreChip(
            icon: FontAwesomeIcons.googlePlay,
            label: 'Google Play', // no-tr (brand name)
            onTap: () {
              Analytics.storeOpen(appName: project.name, store: 'google_play');
              AppLauncher.open(android);
            },
          ),
      ],
    );
  }
}

class _StoreChip extends StatelessWidget {
  const _StoreChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(context.radii.chip.r),
        child: Container(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: context.spacing.sm.w,
            vertical: context.spacing.xs.w,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.radii.chip.r),
            border: Border.all(color: context.colors.outline),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14.sp, color: context.colors.onSurfaceVariant),
              SizedBox(width: context.spacing.xs.w),
              Text(
                label,
                style: context.text.labelSmall?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

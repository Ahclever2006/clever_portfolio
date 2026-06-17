import 'package:clever_portfolio/core/constants/app_strings.dart';
import 'package:clever_portfolio/core/theme/app_typography.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/shared/navigation/cubit/navigation_cubit.dart';
import 'package:clever_portfolio/shared/navigation/section_id.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Slide-over navigation for mobile widths.
class MobileNavDrawer extends StatelessWidget {
  /// Creates a [MobileNavDrawer]; [onNavTap] scrolls to a section.
  const MobileNavDrawer({required this.onNavTap, super.key});

  /// Anchor navigation callback.
  final void Function(SectionId) onNavTap;

  static const _links = [
    (AppStrings.navAbout, SectionId.about),
    (AppStrings.navSkills, SectionId.skills),
    (AppStrings.navWork, SectionId.work),
    (AppStrings.navFeatured, SectionId.featured),
    (AppStrings.navExperience, SectionId.experience),
    (AppStrings.navContact, SectionId.contact),
  ];

  @override
  Widget build(BuildContext context) {
    const wordmark = 'ahmed.maher';
    final activeSection = context.watch<NavigationCubit>().state.activeSection;
    return Drawer(
      backgroundColor: context.colors.surface,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: context.spacing.lg.w,
            end: context.spacing.lg.w,
            top: context.spacing.lg.h,
            bottom: context.spacing.lg.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                wordmark,
                style: AppTypography.eyebrowMono.copyWith(
                  color: context.colors.primary,
                ),
              ),
              SizedBox(height: context.spacing.xl.h),
              for (var i = 0; i < _links.length; i++) ...[
                _DrawerLink(
                  index: i + 1,
                  label: _links[i].$1.tr(),
                  id: _links[i].$2,
                  active: activeSection == _links[i].$2,
                  onNavTap: onNavTap,
                ),
                if (i < _links.length - 1)
                  Divider(height: 1, color: context.colors.outline),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerLink extends StatelessWidget {
  const _DrawerLink({
    required this.index,
    required this.label,
    required this.id,
    required this.active,
    required this.onNavTap,
  });

  final int index;
  final String label;
  final SectionId id;
  final bool active;
  final void Function(SectionId) onNavTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        onNavTap(id);
      },
      borderRadius: BorderRadius.circular(context.radii.chip),
      child: AnimatedContainer(
        duration: context.motion.hover,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.radii.chip),
          color: active
              ? context.colors.primary.withValues(alpha: 0.06)
              : Colors.transparent,
        ),
        child: Row(
          children: [
            // Active: 2px emerald hairline on the start edge.
            AnimatedContainer(
              duration: context.motion.hover,
              width: 2.w,
              height: 56.h,
              decoration: BoxDecoration(
                color: active ? context.colors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(1.r),
              ),
            ),
            SizedBox(width: context.spacing.md.w),
            // Mono index.
            Text(
              '0$index',
              style: AppTypography.captionMono.copyWith(
                color: active
                    ? context.colors.primary
                    : context.colors.onSurfaceVariant,
              ),
            ),
            SizedBox(width: context.spacing.md.w),
            // Label.
            Expanded(
              child: Text(
                label,
                style: context.text.titleMedium?.copyWith(
                  color: active
                      ? context.colors.onSurface
                      : context.colors.onSurfaceVariant,
                  fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
            // Arrow — visible on active.
            AnimatedOpacity(
              duration: context.motion.hover,
              opacity: active ? 1.0 : 0.0,
              child: Icon(
                Icons.arrow_forward,
                size: 16.sp,
                color: context.colors.primary,
              ),
            ),
            SizedBox(width: context.spacing.md.w),
          ],
        ),
      ),
    );
  }
}

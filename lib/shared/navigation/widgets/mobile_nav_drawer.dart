import 'package:clever_portfolio/core/constants/app_strings.dart';
import 'package:clever_portfolio/core/theme/app_typography.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/shared/navigation/section_id.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Slide-over navigation for mobile widths.
class MobileNavDrawer extends StatelessWidget {
  /// Creates a [MobileNavDrawer]; [onNavTap] scrolls to a section.
  const MobileNavDrawer({required this.onNavTap, super.key});

  /// Anchor navigation callback.
  final void Function(SectionId) onNavTap;

  @override
  Widget build(BuildContext context) {
    const wordmark = 'ahmed.maher';
    return Drawer(
      backgroundColor: context.colors.surface,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(context.spacing.lg.w),
          children: [
            Text(
              wordmark,
              style: AppTypography.eyebrowMono.copyWith(
                color: context.colors.primary,
              ),
            ),
            SizedBox(height: context.spacing.lg.h),
            _DrawerLink(
              label: AppStrings.navAbout.tr(),
              id: SectionId.about,
              onNavTap: onNavTap,
            ),
            _DrawerLink(
              label: AppStrings.navWork.tr(),
              id: SectionId.work,
              onNavTap: onNavTap,
            ),
            _DrawerLink(
              label: AppStrings.navExperience.tr(),
              id: SectionId.experience,
              onNavTap: onNavTap,
            ),
            _DrawerLink(
              label: AppStrings.navContact.tr(),
              id: SectionId.contact,
              onNavTap: onNavTap,
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerLink extends StatelessWidget {
  const _DrawerLink({
    required this.label,
    required this.id,
    required this.onNavTap,
  });

  final String label;
  final SectionId id;
  final void Function(SectionId) onNavTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label, style: context.text.titleMedium),
      onTap: () {
        Navigator.of(context).pop();
        onNavTap(id);
      },
    );
  }
}

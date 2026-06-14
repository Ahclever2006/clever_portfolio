import 'package:clever_portfolio/core/constants/app_assets.dart';
import 'package:clever_portfolio/core/constants/app_strings.dart';
import 'package:clever_portfolio/core/responsive/responsive.dart';
import 'package:clever_portfolio/core/theme/app_typography.dart';
import 'package:clever_portfolio/core/theme/cubit/theme_cubit.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/core/utils/app_launcher.dart';
import 'package:clever_portfolio/core/widgets/app_button.dart';
import 'package:clever_portfolio/core/widgets/glass_nav_container.dart';
import 'package:clever_portfolio/shared/navigation/cubit/navigation_cubit.dart';
import 'package:clever_portfolio/shared/navigation/section_id.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Folio 00 — the fixed glass navbar (the one glassmorphism surface).
class GlassNavBar extends StatelessWidget {
  /// Creates a [GlassNavBar]; [onNavTap] scrolls to a section, [onMenu] opens
  /// the mobile drawer.
  const GlassNavBar({required this.onNavTap, required this.onMenu, super.key});

  /// Anchor navigation callback.
  final void Function(SectionId) onNavTap;

  /// Opens the mobile menu drawer.
  final VoidCallback onMenu;

  @override
  Widget build(BuildContext context) {
    const wordmark = 'ahmed.maher';
    final nav = context.watch<NavigationCubit>().state;
    final hPad = context.responsive(
      mobile: context.spacing.gutterMobile,
      desktop: context.spacing.gutterDesktop,
    );

    return GlassNavContainer(
      elevated: nav.navElevated,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: hPad.w,
            vertical: context.spacing.sm.h,
          ),
          child: Row(
            children: [
              Text(
                wordmark,
                style: AppTypography.eyebrowMono.copyWith(
                  color: context.colors.onSurface,
                ),
              ),
              const Spacer(),
              if (context.isDesktop) ...[
                _NavLink(
                  label: AppStrings.navAbout.tr(),
                  id: SectionId.about,
                  active: nav.activeSection == SectionId.about,
                  onTap: onNavTap,
                ),
                _NavLink(
                  label: AppStrings.navWork.tr(),
                  id: SectionId.work,
                  active: nav.activeSection == SectionId.work,
                  onTap: onNavTap,
                ),
                _NavLink(
                  label: AppStrings.navExperience.tr(),
                  id: SectionId.experience,
                  active: nav.activeSection == SectionId.experience,
                  onTap: onNavTap,
                ),
                _NavLink(
                  label: AppStrings.navContact.tr(),
                  id: SectionId.contact,
                  active: nav.activeSection == SectionId.contact,
                  onTap: onNavTap,
                ),
                SizedBox(width: context.spacing.sm.w),
              ],
              IconButton(
                tooltip: 'EN / ع', // no-tr
                icon: const Icon(Icons.translate),
                onPressed: () {
                  final next = context.locale.languageCode == 'en'
                      ? const Locale('ar')
                      : const Locale('en');
                  context.setLocale(next);
                },
              ),
              IconButton(
                tooltip: 'Theme', // no-tr
                icon: const Icon(Icons.brightness_6_outlined),
                onPressed: () => context.read<ThemeCubit>().toggle(),
              ),
              if (context.isDesktop) ...[
                SizedBox(width: context.spacing.sm.w),
                AppButton.ghost(
                  label: AppStrings.navDownloadCv.tr(),
                  onPressed: () => AppLauncher.open(AppAssets.cvDownloadUrl),
                ),
              ] else
                IconButton(
                  tooltip: 'Menu', // no-tr
                  icon: const Icon(Icons.menu),
                  onPressed: onMenu,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  const _NavLink({
    required this.label,
    required this.id,
    required this.active,
    required this.onTap,
  });

  final String label;
  final SectionId id;
  final bool active;
  final void Function(SectionId) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: context.spacing.sm.w,
      ),
      child: TextButton(
        onPressed: () => onTap(id),
        child: Text(
          label,
          style: context.text.labelLarge?.copyWith(
            color: active
                ? context.colors.primary
                : context.colors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

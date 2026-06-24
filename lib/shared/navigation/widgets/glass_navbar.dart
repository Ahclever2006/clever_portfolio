import 'package:clever_portfolio/core/analytics/analytics.dart';
import 'package:clever_portfolio/core/constants/app_assets.dart';
import 'package:clever_portfolio/core/constants/app_strings.dart';
import 'package:clever_portfolio/core/responsive/responsive.dart';
import 'package:clever_portfolio/core/theme/app_typography.dart';
import 'package:clever_portfolio/core/theme/cubit/theme_cubit.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/core/utils/app_launcher.dart';
import 'package:clever_portfolio/core/widgets/app_button.dart';
import 'package:clever_portfolio/core/widgets/glass_nav_container.dart';
import 'package:clever_portfolio/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:clever_portfolio/features/profile/presentation/cubit/profile_state.dart';
import 'package:clever_portfolio/shared/navigation/cubit/navigation_cubit.dart';
import 'package:clever_portfolio/shared/navigation/section_id.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    final profileState = context.watch<ProfileCubit>().state;
    final phone = profileState is ProfileLoaded
        ? profileState.profile.phone
        : null;
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
                  label: AppStrings.navSkills.tr(),
                  id: SectionId.skills,
                  active: nav.activeSection == SectionId.skills,
                  onTap: onNavTap,
                ),
                _NavLink(
                  label: AppStrings.navWork.tr(),
                  id: SectionId.work,
                  active: nav.activeSection == SectionId.work,
                  onTap: onNavTap,
                ),
                _NavLink(
                  label: AppStrings.navFeatured.tr(),
                  id: SectionId.featured,
                  active: nav.activeSection == SectionId.featured,
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
              // Language toggle hidden for now (English only). The AR
              // translations + Arabic font remain wired for later.
              IconButton(
                tooltip: 'Theme', // no-tr
                icon: const Icon(Icons.brightness_6_outlined),
                onPressed: () => context.read<ThemeCubit>().toggle(),
              ),
              if (phone != null)
                IconButton(
                  tooltip: 'WhatsApp', // no-tr
                  icon: const Icon(FontAwesomeIcons.whatsapp),
                  onPressed: () => AppLauncher.whatsApp(phone),
                ),
              if (context.isDesktop) ...[
                SizedBox(width: context.spacing.sm.w),
                AppButton.ghost(
                  label: AppStrings.navDownloadCv.tr(),
                  onPressed: () {
                    Analytics.cvDownload('navbar');
                    AppLauncher.open(AppAssets.cvDownloadUrl);
                  },
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

class _NavLink extends StatefulWidget {
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
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final lit = widget.active || _hovered;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => widget.onTap(widget.id),
        child: AnimatedContainer(
          duration: context.motion.link,
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: context.spacing.sm.w,
            vertical: 4.h,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: lit ? context.colors.primary : Colors.transparent,
                width: 2.h,
              ),
            ),
          ),
          child: AnimatedDefaultTextStyle(
            duration: context.motion.link,
            style: (context.text.labelLarge ?? const TextStyle()).copyWith(
              color: lit
                  ? context.colors.primary
                  : context.colors.onSurfaceVariant,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}

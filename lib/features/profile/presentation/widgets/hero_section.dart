import 'package:clever_portfolio/core/constants/app_assets.dart';
import 'package:clever_portfolio/core/constants/app_strings.dart';
import 'package:clever_portfolio/core/responsive/responsive.dart';
import 'package:clever_portfolio/core/theme/app_typography.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/core/utils/app_launcher.dart';
import 'package:clever_portfolio/core/widgets/app_button.dart';
import 'package:clever_portfolio/core/widgets/reveal_on_scroll.dart';
import 'package:clever_portfolio/core/widgets/terminal_status_strip.dart';
import 'package:clever_portfolio/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:clever_portfolio/features/profile/presentation/cubit/profile_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Folio 01 — full-viewport hero: mono eyebrow, big name, tagline, CTAs, and
/// the terminal status strip.
class HeroSection extends StatelessWidget {
  /// Creates a [HeroSection]; [onViewWork] scrolls to the Index.
  const HeroSection({required this.onViewWork, super.key});

  /// Tapped by the primary "View Work" CTA.
  final VoidCallback onViewWork;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProfileCubit>().state;
    final name = state is ProfileLoaded ? state.profile.name : 'Ahmed Maher';
    final hPad = context.responsive(
      mobile: context.spacing.gutterMobile,
      desktop: context.spacing.gutterDesktop,
    );
    // Fluid hero headline: clamp(48 -> 88) between mobile and ~desktop width.
    final width = MediaQuery.sizeOf(context).width;
    final t = ((width - 360) / (1024 - 360)).clamp(0.0, 1.0);
    final heroSize = 48 + (88 - 48) * t;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 0.86.sh),
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: hPad.w,
          vertical: context.spacing.xxl.h,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: context.spacing.maxContentWidth,
            ),
            child: RevealOnScroll(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '// ${AppStrings.heroEyebrow.tr()}',
                    style: AppTypography.eyebrowMono.copyWith(
                      color: context.colors.primary,
                    ),
                  ),
                  SizedBox(height: context.spacing.lg.h),
                  Text(
                    name,
                    style: context.text.displayLarge?.copyWith(
                      fontSize: heroSize,
                    ),
                  ),
                  SizedBox(height: context.spacing.lg.h),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 640.w),
                    child: Text(
                      AppStrings.heroTagline.tr(),
                      style: context.text.bodyLarge?.copyWith(
                        color: context.colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                  SizedBox(height: context.spacing.xl.h),
                  Wrap(
                    spacing: context.spacing.md.w,
                    runSpacing: context.spacing.sm.h,
                    children: [
                      AppButton(
                        label: AppStrings.heroViewWork.tr(),
                        onPressed: onViewWork,
                      ),
                      AppButton.ghost(
                        label: AppStrings.heroDownloadResume.tr(),
                        icon: Icons.download_outlined,
                        onPressed: () =>
                            AppLauncher.open(AppAssets.cvDownloadUrl),
                      ),
                    ],
                  ),
                  SizedBox(height: context.spacing.xl.h),
                  const TerminalStatusStrip(
                    text:
                        'apps_shipped: 35 | platforms: ios + android | status: live', // no-tr
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

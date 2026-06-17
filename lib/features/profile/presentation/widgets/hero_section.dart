import 'package:clever_portfolio/core/constants/app_assets.dart';
import 'package:clever_portfolio/core/constants/app_strings.dart';
import 'package:clever_portfolio/core/responsive/responsive.dart';
import 'package:clever_portfolio/core/theme/app_typography.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/core/utils/app_launcher.dart';
import 'package:clever_portfolio/core/widgets/app_button.dart';
import 'package:clever_portfolio/core/widgets/motion_background.dart';
import 'package:clever_portfolio/core/widgets/reveal_on_scroll.dart';
import 'package:clever_portfolio/core/widgets/terminal_status_strip.dart';
import 'package:clever_portfolio/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:clever_portfolio/features/profile/presentation/cubit/profile_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Folio 01 — full-viewport hero: aurora glow background, staggered entrance,
/// mono eyebrow, fluid display name, tagline, CTAs, terminal status strip.
class HeroSection extends StatelessWidget {
  /// Creates a [HeroSection]; [onViewWork] scrolls to the Index.
  const HeroSection({required this.onViewWork, super.key});

  /// Tapped by the primary "View Work" CTA.
  final VoidCallback onViewWork;

  // Stagger offsets — each element enters sequentially on first load.
  static const Duration _d0 = Duration.zero;
  static const Duration _d1 = Duration(milliseconds: 80);
  static const Duration _d2 = Duration(milliseconds: 160);
  static const Duration _d3 = Duration(milliseconds: 240);
  static const Duration _d4 = Duration(milliseconds: 340);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProfileCubit>().state;
    final name = state is ProfileLoaded ? state.profile.name : 'Ahmed Maher';
    final hPad = context.responsive(
      mobile: context.spacing.gutterMobile,
      desktop: context.spacing.gutterDesktop,
    );

    // Fluid hero headline: clamp(48 → 88) between mobile and ~desktop width.
    final width = MediaQuery.sizeOf(context).width;
    final t = ((width - 360) / (1024 - 360)).clamp(0.0, 1.0);
    final heroSize = 48 + (88 - 48) * t;

    return Stack(
      children: [
        // Living aurora glow — RepaintBoundary isolates its 12fps repaints.
        Positioned.fill(child: RepaintBoundary(child: MotionBackground())),

        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: context.responsive(mobile: 0.0, desktop: 0.75.sh),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: hPad.w,
              vertical: context.spacing.xl.h,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: context.spacing.maxContentWidth,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Eyebrow — first to arrive
                    RevealOnScroll(
                      delay: _d0,
                      child: Text(
                        '// ${AppStrings.heroEyebrow.tr()}',
                        style: AppTypography.eyebrowMono.copyWith(
                          color: context.colors.primary,
                        ),
                      ),
                    ),
                    SizedBox(height: context.spacing.lg.h),

                    // Display name — second
                    RevealOnScroll(
                      delay: _d1,
                      child: Text(
                        name,
                        style: context.text.displayLarge?.copyWith(
                          fontSize: heroSize,
                        ),
                      ),
                    ),
                    SizedBox(height: context.spacing.lg.h),

                    // Tagline — third
                    RevealOnScroll(
                      delay: _d2,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 640.w),
                        child: Text(
                          AppStrings.heroTagline.tr(),
                          style: context.text.bodyLarge?.copyWith(
                            color: context.colors.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: context.spacing.xl.h),

                    // CTA row — fourth
                    RevealOnScroll(
                      delay: _d3,
                      child: Wrap(
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
                    ),
                    SizedBox(height: context.spacing.xl.h),

                    // Terminal status strip — last, as the "build complete" signal
                    RevealOnScroll(
                      delay: _d4,
                      child: const TerminalStatusStrip(
                        text:
                            'apps_shipped: 42 | platforms: ios + android | status: live', // no-tr
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

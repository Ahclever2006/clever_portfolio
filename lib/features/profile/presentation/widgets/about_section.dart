import 'package:clever_portfolio/core/constants/app_strings.dart';
import 'package:clever_portfolio/core/responsive/responsive.dart';
import 'package:clever_portfolio/core/theme/app_typography.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/core/widgets/section_scaffold.dart';
import 'package:clever_portfolio/features/profile/domain/entities/profile.dart';
import 'package:clever_portfolio/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:clever_portfolio/features/profile/presentation/cubit/profile_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// "About" section (folio 03, plan.md §3.4): the profile summary with an
/// accent-bordered pull-quote on the start side, paired with a mono `career.log`
/// of experience entries — two columns on desktop, stacked on mobile.
class AboutSection extends StatelessWidget {
  /// Creates an [AboutSection].
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionScaffold(
      folio: '03',
      eyebrow: AppStrings.aboutEyebrow.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.aboutTitle.tr(), style: context.text.displayMedium),
          SizedBox(height: context.spacing.lg.h),
          const _AboutBody(),
        ],
      ),
    );
  }
}

class _AboutBody extends StatelessWidget {
  const _AboutBody();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProfileCubit>().state;
    if (state is! ProfileLoaded) return const SizedBox.shrink();
    final profile = state.profile;

    final summary = _Summary(summary: profile.summary);
    final log = _CareerLog(experience: profile.experience);

    if (context.isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: summary),
          SizedBox(width: context.spacing.xl.w),
          Expanded(child: log),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        summary,
        SizedBox(height: context.spacing.xl.h),
        log,
      ],
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({required this.summary});

  final String summary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(summary, style: context.text.bodyLarge),
        SizedBox(height: context.spacing.lg.h),
        Container(
          padding: EdgeInsetsDirectional.all(context.spacing.md.w),
          decoration: BoxDecoration(
            color: context.brand.accentSoft,
            border: BorderDirectional(
              start: BorderSide(color: context.colors.primary, width: 3.w),
            ),
          ),
          child: Text(
            // no-tr
            '15 years in oilfields. Now 35 apps in the stores.',
            style: context.text.titleMedium,
          ),
        ),
      ],
    );
  }
}

class _CareerLog extends StatelessWidget {
  const _CareerLog({required this.experience});

  final List<ExperienceItem> experience;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'career.log', // no-tr
          style: AppTypography.captionMono.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
        SizedBox(height: context.spacing.md.h),
        for (final item in experience) ...[
          Text(
            '> ${item.company} — ${item.period}',
            style: AppTypography.captionMono.copyWith(
              color: context.brand.codeText,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: context.spacing.sm.h),
        ],
      ],
    );
  }
}

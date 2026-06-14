import 'package:clever_portfolio/core/constants/app_strings.dart';
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

/// Experience section (folio 07): a stack of role cards, one per
/// [ExperienceItem], each listing the role, company / location, period, and
/// outcome bullets (plan.md §4).
class ExperienceSection extends StatelessWidget {
  /// Creates an [ExperienceSection].
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionScaffold(
      folio: '07',
      eyebrow: AppStrings.experienceEyebrow.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.experienceTitle.tr(),
            style: context.text.displayMedium,
          ),
          SizedBox(height: context.spacing.lg.h),
          const _ExperienceBody(),
        ],
      ),
    );
  }
}

class _ExperienceBody extends StatelessWidget {
  const _ExperienceBody();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProfileCubit>().state;
    return switch (state) {
      ProfileLoaded(:final profile) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < profile.experience.length; i++) ...[
            if (i > 0) SizedBox(height: context.spacing.md.h),
            _RoleCard(item: profile.experience[i]),
          ],
        ],
      ),
      _ => const SizedBox.shrink(),
    };
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({required this.item});

  final ExperienceItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.spacing.lg.w),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(context.radii.card.r),
        border: Border.all(color: context.colors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.role,
            style: context.text.titleLarge,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: context.spacing.xs.h),
          Text(
            '${item.company} · ${item.location}',
            style: AppTypography.captionMono.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: context.spacing.xs.h),
          Text(
            item.period,
            style: AppTypography.captionMono.copyWith(
              color: context.brand.folio,
            ),
          ),
          SizedBox(height: context.spacing.md.h),
          for (final bullet in item.bullets)
            Padding(
              padding: EdgeInsets.only(bottom: context.spacing.xs.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '—  ', // no-tr
                    style: context.text.bodyMedium?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                  Expanded(child: Text(bullet, style: context.text.bodyMedium)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

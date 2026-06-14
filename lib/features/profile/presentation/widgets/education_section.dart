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

/// Folio 08 — education timeline (plan.md §4). One compact card per
/// [EducationItem]: degree, institution + period, and grade.
class EducationSection extends StatelessWidget {
  /// Creates an [EducationSection].
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionScaffold(
      folio: '08',
      eyebrow: AppStrings.educationEyebrow.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.educationTitle.tr(),
            style: context.text.displayMedium,
          ),
          SizedBox(height: context.spacing.lg.h),
          const _EducationBody(),
        ],
      ),
    );
  }
}

/// Reads [ProfileCubit] and lists the education cards.
class _EducationBody extends StatelessWidget {
  const _EducationBody();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProfileCubit>().state;
    if (state is! ProfileLoaded) return const SizedBox.shrink();
    final education = state.profile.education;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < education.length; i++) ...[
          if (i > 0) SizedBox(height: context.spacing.md.h),
          _EducationCard(item: education[i]),
        ],
      ],
    );
  }
}

/// Compact surface card for one [EducationItem].
class _EducationCard extends StatelessWidget {
  const _EducationCard({required this.item});

  final EducationItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
            item.degree,
            style: context.text.titleMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: context.spacing.xs.h),
          Text(
            '${item.institution} · ${item.period}', // no-tr
            style: context.text.bodySmall?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: context.spacing.sm.h),
          Text(
            item.grade,
            style: AppTypography.captionMono.copyWith(
              color: context.brand.folio,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

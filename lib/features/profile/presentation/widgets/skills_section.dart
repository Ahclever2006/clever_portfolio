import 'package:clever_portfolio/core/constants/app_strings.dart';
import 'package:clever_portfolio/core/theme/app_typography.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/core/widgets/app_skill_chip.dart';
import 'package:clever_portfolio/core/widgets/section_scaffold.dart';
import 'package:clever_portfolio/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:clever_portfolio/features/profile/presentation/cubit/profile_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Skills section (folio 04): labelled skill groups, each a mono group label
/// over a wrap of glass skill chips (plan.md §4).
class SkillsSection extends StatelessWidget {
  /// Creates a [SkillsSection].
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionScaffold(
      folio: '04',
      eyebrow: AppStrings.skillsEyebrow.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.skillsTitle.tr(), style: context.text.displayMedium),
          SizedBox(height: context.spacing.lg.h),
          const _SkillsBody(),
        ],
      ),
    );
  }
}

/// Reads [ProfileCubit] and renders the skill groups.
class _SkillsBody extends StatelessWidget {
  const _SkillsBody();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProfileCubit>().state;
    if (state is! ProfileLoaded) return const SizedBox.shrink();
    final groups = state.profile.skillGroups;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < groups.length; i++) ...[
          if (i > 0) SizedBox(height: context.spacing.lg.h),
          Text(
            groups[i].label,
            style: AppTypography.eyebrowMono.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
          SizedBox(height: context.spacing.sm.h),
          Wrap(
            spacing: context.spacing.sm.w,
            runSpacing: context.spacing.sm.h,
            children: [
              for (final skill in groups[i].skills) AppSkillChip(label: skill),
            ],
          ),
        ],
      ],
    );
  }
}

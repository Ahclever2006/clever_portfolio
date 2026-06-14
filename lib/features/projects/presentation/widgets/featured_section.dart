import 'package:clever_portfolio/core/constants/app_strings.dart';
import 'package:clever_portfolio/core/responsive/responsive.dart';
import 'package:clever_portfolio/core/theme/app_typography.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/core/widgets/section_scaffold.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_project.dart';
import 'package:clever_portfolio/features/projects/presentation/cubit/projects_cubit.dart';
import 'package:clever_portfolio/features/projects/presentation/cubit/projects_state.dart';
import 'package:clever_portfolio/features/projects/presentation/widgets/app_icon_tile.dart';
import 'package:clever_portfolio/features/projects/presentation/widgets/category_color.dart';
import 'package:clever_portfolio/features/projects/presentation/widgets/store_buttons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Featured section (folio 06): larger split cards — a screenshot (or icon)
/// hero atop name, category, tagline, and store buttons — for the apps flagged
/// `featured`, laid out two-up on desktop and one-up on mobile (plan.md §4).
class FeaturedSection extends StatelessWidget {
  /// Creates a [FeaturedSection].
  const FeaturedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionScaffold(
      folio: '06',
      eyebrow: AppStrings.featuredEyebrow.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.featuredTitle.tr(),
            style: context.text.displayMedium,
          ),
          SizedBox(height: context.spacing.lg.h),
          const _FeaturedBody(),
        ],
      ),
    );
  }
}

/// Reads [ProjectsCubit] and renders the featured cards (or nothing when the
/// catalog has not loaded yet).
class _FeaturedBody extends StatelessWidget {
  const _FeaturedBody();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProjectsCubit>().state;
    if (state is! ProjectsLoaded) return const SizedBox.shrink();

    final featured = state.all.where((p) => p.featured).toList();
    if (featured.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final gap = context.spacing.lg.w;
        final cardWidth = context.isDesktop
            ? (constraints.maxWidth - gap) / 2
            : constraints.maxWidth;
        return Wrap(
          spacing: gap,
          runSpacing: context.spacing.lg.h,
          children: [
            for (final project in featured)
              SizedBox(
                width: cardWidth,
                child: _FeaturedCard(project: project),
              ),
          ],
        );
      },
    );
  }
}

/// A single split featured card: hero media, then the project metadata.
class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard({required this.project});

  final AppProject project;

  @override
  Widget build(BuildContext context) {
    final hue = project.category.hue(context);
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(context.radii.card.r),
        border: Border.all(color: context.colors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (project.hasScreenshots)
            AspectRatio(
              aspectRatio: 16 / 10,
              child: Image.asset(project.screenshots.first, fit: BoxFit.cover),
            )
          else
            Padding(
              padding: EdgeInsets.all(context.spacing.lg.w),
              child: AppIconTile(project: project, size: 96),
            ),
          Padding(
            padding: EdgeInsets.all(context.spacing.lg.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.name,
                  style: context.text.titleLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: context.spacing.xs.h),
                Text(
                  project.category.trKey.tr(),
                  style: AppTypography.captionMono.copyWith(color: hue),
                ),
                SizedBox(height: context.spacing.sm.h),
                Text(
                  project.tagline,
                  style: context.text.bodyMedium?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: context.spacing.md.h),
                StoreButtons(project: project),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

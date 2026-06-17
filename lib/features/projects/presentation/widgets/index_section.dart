import 'package:clever_portfolio/core/constants/app_strings.dart';
import 'package:clever_portfolio/core/responsive/responsive.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/core/widgets/app_filter_chip.dart';
import 'package:clever_portfolio/core/widgets/section_scaffold.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_category.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_platform.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_project.dart';
import 'package:clever_portfolio/features/projects/presentation/cubit/projects_cubit.dart';
import 'package:clever_portfolio/features/projects/presentation/cubit/projects_state.dart';
import 'package:clever_portfolio/features/projects/presentation/widgets/category_color.dart';
import 'package:clever_portfolio/features/projects/presentation/widgets/project_card.dart';
import 'package:clever_portfolio/features/projects/presentation/widgets/project_list_row.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Folio 05 — "The Index": the 37 apps as a filterable numbered list ⇄ grid.
class IndexSection extends StatefulWidget {
  /// Creates an [IndexSection].
  const IndexSection({super.key});

  @override
  State<IndexSection> createState() => _IndexSectionState();
}

class _IndexSectionState extends State<IndexSection> {
  final TextEditingController _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    _search.addListener(
      () => context.read<ProjectsCubit>().search(_search.text),
    );
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SectionScaffold(
      folio: '05',
      eyebrow: AppStrings.workEyebrow.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.workTitle.tr(), style: context.text.displayMedium),
          SizedBox(height: context.spacing.lg.h),
          BlocBuilder<ProjectsCubit, ProjectsState>(
            builder: (context, state) => switch (state) {
              ProjectsLoaded() => _Loaded(state: state, search: _search),
              ProjectsError(:final failure) => Text(
                failure.message,
                style: context.text.bodyMedium?.copyWith(
                  color: context.colors.error,
                ),
              ),
              _ => Padding(
                padding: EdgeInsets.all(context.spacing.xl.w),
                child: const Center(child: CircularProgressIndicator()),
              ),
            },
          ),
        ],
      ),
    );
  }
}

class _Loaded extends StatelessWidget {
  const _Loaded({required this.state, required this.search});

  final ProjectsLoaded state;
  final TextEditingController search;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProjectsCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category filter chips.
        Wrap(
          spacing: context.spacing.sm.w,
          runSpacing: context.spacing.sm.h,
          children: [
            AppFilterChip(
              label: AppStrings.workFilterAll.tr(),
              selected: state.activeCategory == null,
              onTap: () => cubit.setCategory(null),
            ),
            for (final category in AppCategory.values)
              AppFilterChip(
                label: category.trKey.tr(),
                selected: state.activeCategory == category,
                accent: category.hue(context),
                onTap: () => cubit.setCategory(category),
              ),
          ],
        ),
        SizedBox(height: context.spacing.md.h),
        // Platform toggle + view toggle. The search joins this row on
        // tablet/desktop and drops to its own full-width row on mobile — a Wrap
        // can't lay out a full-width child without overflowing.
        Wrap(
          spacing: context.spacing.md.w,
          runSpacing: context.spacing.sm.h,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            AppFilterChip(
              label: AppStrings.workPlatformAll.tr(),
              selected: state.activePlatform == null,
              onTap: () => cubit.setPlatform(null),
            ),
            for (final platform in AppPlatform.values)
              AppFilterChip(
                label: platform.label,
                selected: state.activePlatform == platform,
                onTap: () => cubit.setPlatform(platform),
              ),
            if (!context.isMobile)
              SizedBox(
                width: 220.w,
                child: _SearchField(controller: search),
              ),
            _ViewToggle(mode: state.viewMode, onToggle: cubit.toggleViewMode),
          ],
        ),
        if (context.isMobile) ...[
          SizedBox(height: context.spacing.sm.h),
          _SearchField(controller: search),
        ],
        SizedBox(height: context.spacing.lg.h),
        AnimatedSwitcher(
          duration: context.motion.button,
          child: state.visible.isEmpty
              ? Padding(
                  key: const ValueKey('empty'),
                  padding: EdgeInsets.symmetric(vertical: context.spacing.xl.h),
                  child: Text(
                    AppStrings.workEmpty.tr(),
                    style: context.text.bodyMedium?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                )
              : KeyedSubtree(
                  key: ValueKey(state.viewMode),
                  child: state.viewMode == ProjectViewMode.grid
                      ? _Grid(projects: state.visible)
                      : _List(projects: state.visible),
                ),
        ),
      ],
    );
  }
}

class _ViewToggle extends StatelessWidget {
  const _ViewToggle({required this.mode, required this.onToggle});

  final ProjectViewMode mode;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final isGrid = mode == ProjectViewMode.grid;
    return IconButton(
      iconSize: 20.sp,
      tooltip: isGrid
          ? AppStrings.workViewList.tr()
          : AppStrings.workViewGrid.tr(),
      icon: Icon(isGrid ? Icons.view_list_outlined : Icons.grid_view_outlined),
      onPressed: onToggle,
    );
  }
}

/// Search field for the index — full-width on mobile, fixed-width in the
/// filter row on larger screens. Chrome (dense + content padding) comes from
/// `inputDecorationTheme`.
class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: AppStrings.workSearchHint.tr(),
        prefixIcon: Icon(Icons.search, size: 20.sp),
      ),
    );
  }
}

class _List extends StatelessWidget {
  const _List({required this.projects});

  final List<AppProject> projects;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < projects.length; i++) ...[
          if (i > 0) Divider(height: 1, color: context.colors.outline),
          ProjectListRow(project: projects[i]),
        ],
      ],
    );
  }
}

class _Grid extends StatelessWidget {
  const _Grid({required this.projects});

  final List<AppProject> projects;

  @override
  Widget build(BuildContext context) {
    final columns = context.responsive(mobile: 1, tablet: 2, desktop: 3);
    final gap = context.spacing.gridGap.w;
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth =
            (constraints.maxWidth - gap * (columns - 1)) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final project in projects)
              SizedBox(
                width: itemWidth,
                // Isolate each card's hover animation from the 42-card grid.
                child: RepaintBoundary(child: ProjectCard(project: project)),
              ),
          ],
        );
      },
    );
  }
}

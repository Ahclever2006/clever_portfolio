import 'package:clever_portfolio/core/theme/app_typography.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/core/widgets/app_platform_chip.dart';
import 'package:clever_portfolio/core/widgets/hover_region.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_project.dart';
import 'package:clever_portfolio/features/projects/presentation/widgets/app_icon_tile.dart';
import 'package:clever_portfolio/features/projects/presentation/widgets/category_color.dart';
import 'package:clever_portfolio/features/projects/presentation/widgets/store_buttons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Grid card for one app: top category-hue accent line, icon, name + index,
/// category tag, tagline, platform chips, and store buttons (plan.md §3.4).
class ProjectCard extends StatelessWidget {
  /// Creates a [ProjectCard] for [project].
  const ProjectCard({required this.project, super.key});

  /// The project.
  final AppProject project;

  @override
  Widget build(BuildContext context) {
    final hue = project.category.hue(context);
    return HoverRegion(
      builder: (context, hovered) => AnimatedContainer(
        duration: context.motion.hover,
        curve: context.motion.curveHover,
        clipBehavior: Clip.antiAlias,
        transform: Matrix4.translationValues(0, hovered ? -4 : 0, 0),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(context.radii.card.r),
          border: Border.all(
            color: hovered
                ? context.colors.outlineVariant
                : context.colors.outline,
          ),
          boxShadow: hovered
              ? [
                  BoxShadow(
                    color: hue.withValues(alpha: 0.35),
                    blurRadius: 30,
                    spreadRadius: -6,
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: context.motion.hover,
              height: hovered ? 3.h : 0,
              color: hue,
            ),
            Padding(
              padding: EdgeInsets.all(context.spacing.lg.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppIconTile(project: project, size: 52),
                      SizedBox(width: context.spacing.md.w),
                      Expanded(
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
                              style: AppTypography.captionMono.copyWith(
                                color: hue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        project.indexLabel,
                        style: AppTypography.folioMono.copyWith(
                          color: context.brand.folio,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.spacing.md.h),
                  Text(
                    project.tagline,
                    style: context.text.bodyMedium?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: context.spacing.md.h),
                  Wrap(
                    spacing: context.spacing.xs.w,
                    runSpacing: context.spacing.xs.h,
                    children: [
                      for (final p in project.platforms)
                        AppPlatformChip(label: p.label),
                    ],
                  ),
                  SizedBox(height: context.spacing.md.h),
                  StoreButtons(project: project),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

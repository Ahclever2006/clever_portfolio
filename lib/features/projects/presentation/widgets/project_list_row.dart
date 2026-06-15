import 'package:clever_portfolio/core/responsive/responsive.dart';
import 'package:clever_portfolio/core/theme/app_typography.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/core/utils/app_launcher.dart';
import 'package:clever_portfolio/core/widgets/hover_region.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_project.dart';
import 'package:clever_portfolio/features/projects/presentation/widgets/category_color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Dense numbered row for the default list view: index + category dot, name +
/// tagline, and (desktop) category tag + platform availability. Hover recolors
/// + nudges; tapping opens the primary store listing.
class ProjectListRow extends StatelessWidget {
  /// Creates a [ProjectListRow] for [project].
  const ProjectListRow({required this.project, super.key});

  /// The project.
  final AppProject project;

  @override
  Widget build(BuildContext context) {
    final hue = project.category.hue(context);
    final primaryUrl = project.iosUrl ?? project.androidUrl;
    return HoverRegion(
      builder: (context, hovered) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: primaryUrl == null ? null : () => AppLauncher.open(primaryUrl),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: context.spacing.md.h),
            child: Row(
              children: [
                Text(
                  project.indexLabel,
                  style: AppTypography.folioMono.copyWith(
                    color: hovered ? hue : context.brand.folio,
                  ),
                ),
                SizedBox(width: context.spacing.md.w),
                Container(
                  width: 6.r,
                  height: 6.r,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: hue),
                ),
                SizedBox(width: context.spacing.md.w),
                Expanded(
                  child: AnimatedPadding(
                    duration: context.motion.hover,
                    curve: context.motion.curveHover,
                    padding: EdgeInsetsDirectional.only(
                      start: hovered ? context.spacing.sm.w : 0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.name,
                          style: context.text.titleMedium?.copyWith(
                            color: hovered ? hue : context.colors.onSurface,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          project.tagline,
                          style: context.text.bodySmall?.copyWith(
                            color: context.colors.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                if (context.isDesktop) ...[
                  SizedBox(width: context.spacing.md.w),
                  Text(
                    project.category.trKey.tr(),
                    style: AppTypography.captionMono.copyWith(color: hue),
                  ),
                  SizedBox(width: context.spacing.lg.w),
                  Text(
                    project.platforms.map((p) => p.label).join(' · '),
                    style: AppTypography.captionMono.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

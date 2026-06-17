import 'package:clever_portfolio/core/responsive/responsive.dart';
import 'package:clever_portfolio/core/theme/app_typography.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/core/widgets/count_up_text.dart';
import 'package:clever_portfolio/core/widgets/reveal_on_scroll.dart';
import 'package:clever_portfolio/features/profile/domain/entities/profile.dart';
import 'package:clever_portfolio/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:clever_portfolio/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Thin full-width band of headline stat metrics (plan.md §3.4).
/// Desktop/tablet: 4-up row with vertical hairlines, each cell staggered in.
/// Mobile: 2×2 wrap.
class StatsBand extends StatelessWidget {
  /// Creates a [StatsBand].
  const StatsBand({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProfileCubit>().state;
    final stats = state is ProfileLoaded ? state.profile.stats : null;

    return RevealOnScroll(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: context.colors.outline),
            bottom: BorderSide(color: context.colors.outline),
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: context.spacing.maxContentWidth,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.symmetric(
                vertical: context.spacing.xl.h,
                horizontal: context.spacing.lg.w,
              ),
              // Render invisible placeholder cells until data arrives so
              // the band holds its layout space and doesn't cause a jump.
              child: stats == null
                  ? SizedBox(height: 80.h)
                  : context.isMobile
                  ? _MobileGrid(stats: stats)
                  : _DesktopRow(stats: stats),
            ),
          ),
        ),
      ),
    );
  }
}

/// Desktop/tablet: single row, 1px vertical hairlines between cells.
class _DesktopRow extends StatelessWidget {
  const _DesktopRow({required this.stats});

  final List<StatMetric> stats;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < stats.length; i++) ...[
            if (i > 0)
              VerticalDivider(
                width: 1,
                thickness: 1,
                color: context.colors.outline,
              ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: context.spacing.lg.w,
                ),
                child: _StatCell(stat: stats[i]),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Mobile: 2×2 wrap.
class _MobileGrid extends StatelessWidget {
  const _MobileGrid({required this.stats});

  final List<StatMetric> stats;

  @override
  Widget build(BuildContext context) {
    final halfWidth =
        (1.sw - context.spacing.lg.w * 2 - context.spacing.lg.w) / 2;
    return Wrap(
      spacing: context.spacing.lg.w,
      runSpacing: context.spacing.lg.h,
      children: [
        for (final stat in stats)
          SizedBox(
            width: halfWidth,
            child: _StatCell(stat: stat),
          ),
      ],
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({required this.stat});

  final StatMetric stat;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CountUpText(
          value: stat.value,
          style: context.text.displayMedium?.copyWith(
            color: context.colors.primary,
          ),
        ),
        SizedBox(height: context.spacing.xs.h),
        Text(
          stat.label,
          style: AppTypography.captionMono.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

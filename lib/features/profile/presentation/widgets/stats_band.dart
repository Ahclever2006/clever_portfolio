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

/// Thin full-width band of headline stat metrics (plan.md §3.4). Each cell shows
/// the metric value large in the primary accent over a mono caption label —
/// 2-up on mobile, 4-up on desktop, hairline-bordered top and bottom.
class StatsBand extends StatelessWidget {
  /// Creates a [StatsBand].
  const StatsBand({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProfileCubit>().state;
    if (state is! ProfileLoaded) return const SizedBox.shrink();
    final stats = state.profile.stats;

    final columns = context.responsive<int>(mobile: 2, desktop: 4);
    final spacing = context.spacing.lg.w;

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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final cellWidth =
                      (constraints.maxWidth - spacing * (columns - 1)) /
                      columns;
                  return Wrap(
                    spacing: spacing,
                    runSpacing: context.spacing.lg.h,
                    children: [
                      for (final stat in stats)
                        SizedBox(
                          width: cellWidth,
                          child: _StatCell(stat: stat),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
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

import 'package:clever_portfolio/core/constants/app_strings.dart';
import 'package:clever_portfolio/core/responsive/responsive.dart';
import 'package:clever_portfolio/core/theme/app_typography.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/core/widgets/reveal_on_scroll.dart';
import 'package:clever_portfolio/core/widgets/section_scaffold.dart';
import 'package:clever_portfolio/features/profile/domain/entities/profile.dart';
import 'package:clever_portfolio/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:clever_portfolio/features/profile/presentation/cubit/profile_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Experience section (folio 07): vertical timeline with period-left layout on
/// desktop and stacked layout on mobile. Current role gets an emerald dot +
/// blinking cursor; past roles get muted hollow dots.
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
          SizedBox(height: context.spacing.xl.h),
          const _ExperienceTimeline(),
        ],
      ),
    );
  }
}

class _ExperienceTimeline extends StatelessWidget {
  const _ExperienceTimeline();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProfileCubit>().state;
    if (state is! ProfileLoaded) return const SizedBox.shrink();
    final items = state.profile.experience;
    final staggerMs = context.motion.stagger.inMilliseconds * 2;

    return Column(
      children: [
        for (var i = 0; i < items.length; i++)
          RevealOnScroll(
            delay: Duration(milliseconds: (i * staggerMs).clamp(0, 320)),
            child: _RoleRow(
              item: items[i],
              isCurrent: items[i].period.toLowerCase().contains('present'),
              isLast: i == items.length - 1,
            ),
          ),
      ],
    );
  }
}

class _RoleRow extends StatelessWidget {
  const _RoleRow({
    required this.item,
    required this.isCurrent,
    required this.isLast,
  });

  final ExperienceItem item;
  final bool isCurrent;
  final bool isLast;

  // Fixed width of the period column on desktop.
  static const double _periodColWidth = 176;

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktop;

    return isDesktop
        ? _DesktopRow(item: item, isCurrent: isCurrent, isLast: isLast)
        : _MobileRow(item: item, isCurrent: isCurrent, isLast: isLast);
  }
}

// ── Desktop layout: [period 176px] [dot+line 40px] [content flex] ──────────

class _DesktopRow extends StatelessWidget {
  const _DesktopRow({
    required this.item,
    required this.isCurrent,
    required this.isLast,
  });

  final ExperienceItem item;
  final bool isCurrent;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Period column — fixed width, right-aligned.
          SizedBox(
            width: _RoleRow._periodColWidth.w,
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                end: context.spacing.lg.w,
                top: 2.h,
              ),
              child: _PeriodLabel(period: item.period, isCurrent: isCurrent),
            ),
          ),
          // Timeline spine: dot + vertical connecting line.
          _TimelineSpine(isCurrent: isCurrent, isLast: isLast),
          SizedBox(width: context.spacing.lg.w),
          // Role content.
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: isLast ? 0 : context.spacing.xl.h,
              ),
              child: _RoleContent(item: item, isCurrent: isCurrent),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Mobile layout: [period] then [dot+line | content] ──────────────────────

class _MobileRow extends StatelessWidget {
  const _MobileRow({
    required this.item,
    required this.isCurrent,
    required this.isLast,
  });

  final ExperienceItem item;
  final bool isCurrent;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PeriodLabel(period: item.period, isCurrent: isCurrent),
        SizedBox(height: context.spacing.xs.h),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TimelineSpine(isCurrent: isCurrent, isLast: isLast),
              SizedBox(width: context.spacing.md.w),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: isLast ? 0 : context.spacing.xl.h,
                  ),
                  child: _RoleContent(item: item, isCurrent: isCurrent),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Shared sub-widgets ───────────────────────────────────────────────────────

/// Dot + vertical line for the timeline spine.
class _TimelineSpine extends StatelessWidget {
  const _TimelineSpine({required this.isCurrent, required this.isLast});

  final bool isCurrent;
  final bool isLast;

  static const double _dotSize = 10;
  static const double _spineWidth = 1;
  static const double _totalWidth = 24;

  @override
  Widget build(BuildContext context) {
    final dotColor = isCurrent
        ? context.colors.primary
        : context.colors.outline;
    final lineColor = context.colors.outline;

    return SizedBox(
      width: _totalWidth.w,
      child: Column(
        children: [
          // Dot — filled for current, hollow for past.
          SizedBox(
            width: _totalWidth.w,
            child: Center(
              child: Container(
                width: _dotSize.w,
                height: _dotSize.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCurrent ? dotColor : Colors.transparent,
                  border: Border.all(
                    color: dotColor,
                    width: isCurrent ? 0 : 1.5,
                  ),
                ),
              ),
            ),
          ),
          // Connecting line — stretches to fill remaining height.
          if (!isLast)
            Expanded(
              child: Center(
                child: Container(width: _spineWidth.w, color: lineColor),
              ),
            ),
        ],
      ),
    );
  }
}

/// Period text — mono, emerald for current role, muted for past.
class _PeriodLabel extends StatelessWidget {
  const _PeriodLabel({required this.period, required this.isCurrent});

  final String period;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    return Text(
      period,
      style: AppTypography.captionMono.copyWith(
        color: isCurrent
            ? context.colors.primary
            : context.colors.onSurfaceVariant,
      ),
      textAlign: context.isDesktop ? TextAlign.end : TextAlign.start,
    );
  }
}

/// Role title, company/location, and outcome bullets.
class _RoleContent extends StatelessWidget {
  const _RoleContent({required this.item, required this.isCurrent});

  final ExperienceItem item;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Role title — optionally prefixed with a blinking cursor.
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            if (isCurrent) ...[
              _BlinkingCursor(),
              SizedBox(width: context.spacing.xs.w),
            ],
            Expanded(
              child: Text(
                item.role,
                style: context.text.titleLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        SizedBox(height: context.spacing.xs.h),
        Text(
          '${item.company} · ${item.location}', // no-tr
          style: AppTypography.captionMono.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
        SizedBox(height: context.spacing.md.h),
        for (final bullet in item.bullets)
          Padding(
            padding: EdgeInsetsDirectional.only(
              bottom: context.spacing.xs.h,
              start: context.spacing.sm.w,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '·  ', // no-tr
                  style: context.text.bodyMedium?.copyWith(
                    color: context.colors.primary,
                  ),
                ),
                Expanded(child: Text(bullet, style: context.text.bodyMedium)),
              ],
            ),
          ),
        SizedBox(height: context.spacing.sm.h),
      ],
    );
  }
}

/// Emerald `>` that blinks at ~1Hz to signal the current / active role.
class _BlinkingCursor extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables — stateful
  _BlinkingCursor();

  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).disableAnimations) {
      return Text(
        '>',
        style: AppTypography.eyebrowMono.copyWith(
          color: context.colors.primary,
        ),
      );
    }
    return FadeTransition(
      opacity: _ctrl,
      child: Text(
        '>', // no-tr
        style: AppTypography.eyebrowMono.copyWith(
          color: context.colors.primary,
        ),
      ),
    );
  }
}

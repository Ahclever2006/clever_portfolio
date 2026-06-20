import 'package:clever_portfolio/core/constants/app_strings.dart';
import 'package:clever_portfolio/core/responsive/responsive.dart';
import 'package:clever_portfolio/core/theme/app_typography.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/core/widgets/parallax_image.dart';
import 'package:clever_portfolio/core/widgets/reveal_on_scroll.dart';
import 'package:clever_portfolio/core/widgets/section_scaffold.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_project.dart';
import 'package:clever_portfolio/features/projects/presentation/cubit/projects_cubit.dart';
import 'package:clever_portfolio/features/projects/presentation/cubit/projects_state.dart';
import 'package:clever_portfolio/features/projects/presentation/widgets/app_icon_tile.dart';
import 'package:clever_portfolio/features/projects/presentation/widgets/category_color.dart';
import 'package:clever_portfolio/features/projects/presentation/widgets/screenshot_viewer.dart';
import 'package:clever_portfolio/features/projects/presentation/widgets/store_buttons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Featured section (folio 06): uniform 1/2/3-column grid of equal-size cards.
/// Per-card stagger + hover glow.
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

class _FeaturedBody extends StatelessWidget {
  const _FeaturedBody();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProjectsCubit, ProjectsState, List<AppProject>>(
      selector: (state) =>
          state is ProjectsLoaded ? state.all : const <AppProject>[],
      builder: (context, all) {
        if (all.isEmpty) return const SizedBox.shrink();
        final featured = all.where((p) => p.featured).toList();
        if (featured.isEmpty) return const SizedBox.shrink();

        final gap = context.spacing.lg.w;
        final staggerMs = context.motion.stagger.inMilliseconds;

        // Uniform grid: equal-size cards, 1 / 2 / 3 columns by breakpoint.
        final columns = context.responsive(mobile: 1, tablet: 2, desktop: 3);
        return LayoutBuilder(
          builder: (context, constraints) {
            final w = (constraints.maxWidth - gap * (columns - 1)) / columns;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                for (var i = 0; i < featured.length; i++)
                  SizedBox(
                    width: w,
                    child: RevealOnScroll(
                      delay: Duration(
                        milliseconds: (i * staggerMs).clamp(0, staggerMs * 6),
                      ),
                      child: RepaintBoundary(
                        child: _FeaturedCard(project: featured[i]),
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}

/// A featured card: swipeable screenshot gallery + metadata.
class _FeaturedCard extends StatefulWidget {
  const _FeaturedCard({required this.project});

  final AppProject project;

  @override
  State<_FeaturedCard> createState() => _FeaturedCardState();
}

class _FeaturedCardState extends State<_FeaturedCard> {
  final PageController _pager = PageController();
  int _page = 0;
  bool _hovered = false;
  double _galleryWidth = 0;

  @override
  void dispose() {
    _pager.dispose();
    super.dispose();
  }

  void _go(int delta) {
    final shots = widget.project.screenshots;
    final next = (_page + delta).clamp(0, shots.length - 1);
    _pager.animateToPage(
      next,
      duration: context.motion.button,
      curve: context.motion.curveHover,
    );
  }

  void _precacheAround(int center) {
    if (_galleryWidth <= 0 || !mounted) return;
    final shots = widget.project.screenshots;
    final width = (_galleryWidth * MediaQuery.devicePixelRatioOf(context))
        .round();
    for (final i in [center - 1, center + 1]) {
      if (i < 0 || i >= shots.length) continue;
      precacheImage(ResizeImage(AssetImage(shots[i]), width: width), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final hue = project.category.hue(context);
    final shots = project.screenshots;

    final galleryRatio = context.responsive<double>(
      mobile: 1.0,
      tablet: 0.72,
      desktop: 0.66,
    );

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: context.motion.hover,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(context.radii.card.r),
          border: Border.all(
            color: _hovered
                ? hue.withValues(alpha: 0.7)
                : context.colors.outline,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: hue.withValues(alpha: 0.18),
                    blurRadius: 28,
                    spreadRadius: 2,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () =>
                  showScreenshotViewer(context, project, initialPage: _page),
              child: AspectRatio(
                aspectRatio: galleryRatio,
                child: ColoredBox(
                  color: context.colors.surfaceContainerHighest,
                  child: shots.isEmpty
                      ? Center(child: AppIconTile(project: project, size: 88))
                      : LayoutBuilder(
                          builder: (context, constraints) {
                            if (_galleryWidth != constraints.maxWidth) {
                              _galleryWidth = constraints.maxWidth;
                              WidgetsBinding.instance.addPostFrameCallback(
                                (_) => _precacheAround(_page),
                              );
                            }
                            return Stack(
                              fit: StackFit.expand,
                              children: [
                                PageView.builder(
                                  controller: _pager,
                                  itemCount: shots.length,
                                  onPageChanged: (i) {
                                    setState(() => _page = i);
                                    _precacheAround(i);
                                  },
                                  itemBuilder: (context, i) => ParallaxImage(
                                    asset: shots[i],
                                    errorBuilder: (context, error, stack) =>
                                        Center(
                                          child: AppIconTile(
                                            project: project,
                                            size: 64,
                                          ),
                                        ),
                                  ),
                                ),
                                if (shots.length > 1) ...[
                                  _MiniArrow(start: true, onTap: () => _go(-1)),
                                  _MiniArrow(start: false, onTap: () => _go(1)),
                                  PositionedDirectional(
                                    start: 0,
                                    end: 0,
                                    bottom: context.spacing.sm.h,
                                    child: _Dots(
                                      count: shots.length,
                                      active: _page,
                                      hue: hue,
                                    ),
                                  ),
                                ],
                              ],
                            );
                          },
                        ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(context.spacing.md.w),
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
                    style: context.text.bodySmall?.copyWith(
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
      ),
    );
  }
}

/// Small overlay arrow on a card gallery.
class _MiniArrow extends StatelessWidget {
  const _MiniArrow({required this.start, required this.onTap});

  final bool start;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      start: start ? context.spacing.sm.w : null,
      end: start ? null : context.spacing.sm.w,
      top: 0,
      bottom: 0,
      child: Center(
        child: Material(
          color: context.colors.surface.withValues(alpha: 0.6),
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.all(context.spacing.xs.w),
              child: Icon(
                start ? Icons.chevron_left : Icons.chevron_right,
                size: 18.sp,
                color: context.colors.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Page-indicator dots for the screenshot gallery.
class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.active, required this.hue});

  final int count;
  final int active;
  final Color hue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: context.motion.button,
            margin: EdgeInsetsDirectional.symmetric(
              horizontal: context.spacing.xs.w / 2,
            ),
            width: (i == active ? 14 : 6).w,
            height: 6.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.radii.pill.r),
              color: i == active
                  ? hue
                  : context.colors.onSurface.withValues(alpha: 0.4),
            ),
          ),
      ],
    );
  }
}

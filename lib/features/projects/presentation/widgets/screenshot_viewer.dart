import 'package:clever_portfolio/core/theme/app_typography.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_project.dart';
import 'package:clever_portfolio/features/projects/presentation/widgets/category_color.dart';
import 'package:clever_portfolio/features/projects/presentation/widgets/store_buttons.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Opens the full-screen, swipeable screenshot viewer for [project].
Future<void> showScreenshotViewer(
  BuildContext context,
  AppProject project, {
  int initialPage = 0,
}) {
  return showDialog<void>(
    context: context,
    barrierColor: context.colors.scrim.withValues(alpha: 0.85),
    builder: (_) =>
        ScreenshotViewer(project: project, initialPage: initialPage),
  );
}

/// Full-screen viewer: swipeable screenshots (+ arrows) over the app name,
/// category, tagline, store buttons, and the store description.
class ScreenshotViewer extends StatefulWidget {
  /// Creates a [ScreenshotViewer].
  const ScreenshotViewer({
    required this.project,
    this.initialPage = 0,
    super.key,
  });

  /// The project being viewed.
  final AppProject project;

  /// Initial gallery page.
  final int initialPage;

  @override
  State<ScreenshotViewer> createState() => _ScreenshotViewerState();
}

class _ScreenshotViewerState extends State<ScreenshotViewer> {
  late final PageController _pager = PageController(
    initialPage: widget.initialPage,
  );
  late int _page = widget.initialPage;

  @override
  void dispose() {
    _pager.dispose();
    super.dispose();
  }

  void _go(int delta) {
    final next = (_page + delta).clamp(
      0,
      widget.project.screenshots.length - 1,
    );
    _pager.animateToPage(
      next,
      duration: context.motion.button,
      curve: context.motion.curveHover,
    );
  }

  bool _isRtl(String text) => RegExp(r'[؀-ۿ]').hasMatch(text);

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final shots = project.screenshots;
    final hue = project.category.hue(context);

    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: context.colors.surface,
      child: SafeArea(
        child: Column(
          children: [
            // Header.
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                context.spacing.lg.w,
                context.spacing.md.h,
                context.spacing.sm.w,
                context.spacing.md.h,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(project.name, style: context.text.titleLarge),
                  ),
                  IconButton(
                    tooltip: 'Close', // no-tr
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            // Gallery.
            Expanded(
              child: shots.isEmpty
                  ? const SizedBox.shrink()
                  : Stack(
                      children: [
                        PageView.builder(
                          controller: _pager,
                          itemCount: shots.length,
                          onPageChanged: (i) => setState(() => _page = i),
                          itemBuilder: (context, i) => Padding(
                            padding: EdgeInsets.all(context.spacing.md.w),
                            child: Image.asset(shots[i], fit: BoxFit.contain),
                          ),
                        ),
                        if (shots.length > 1) ...[
                          _Arrow(
                            start: true,
                            visible: _page > 0,
                            onTap: () => _go(-1),
                          ),
                          _Arrow(
                            start: false,
                            visible: _page < shots.length - 1,
                            onTap: () => _go(1),
                          ),
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
                    ),
            ),
            // Meta + description.
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 240.h),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(context.spacing.lg.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.category.trKey.tr(),
                      style: AppTypography.captionMono.copyWith(color: hue),
                    ),
                    SizedBox(height: context.spacing.xs.h),
                    Text(project.tagline, style: context.text.bodyLarge),
                    SizedBox(height: context.spacing.md.h),
                    StoreButtons(project: project),
                    if (project.description != null) ...[
                      SizedBox(height: context.spacing.md.h),
                      Text(
                        project.description!,
                        textDirection: _isRtl(project.description!)
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        style: context.text.bodyMedium?.copyWith(
                          color: context.colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Arrow extends StatelessWidget {
  const _Arrow({
    required this.start,
    required this.visible,
    required this.onTap,
  });

  final bool start;
  final bool visible;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      start: start ? context.spacing.md.w : null,
      end: start ? null : context.spacing.md.w,
      top: 0,
      bottom: 0,
      child: Center(
        child: AnimatedOpacity(
          opacity: visible ? 1 : 0,
          duration: context.motion.button,
          child: Material(
            color: context.colors.surface.withValues(alpha: 0.7),
            shape: const CircleBorder(),
            child: IconButton(
              icon: Icon(
                start ? Icons.chevron_left : Icons.chevron_right,
                color: context.colors.onSurface,
              ),
              onPressed: visible ? onTap : null,
            ),
          ),
        ),
      ),
    );
  }
}

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
            width: (i == active ? 16 : 7).w,
            height: 7.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.radii.pill.r),
              color: i == active
                  ? hue
                  : context.colors.onSurface.withValues(alpha: 0.35),
            ),
          ),
      ],
    );
  }
}

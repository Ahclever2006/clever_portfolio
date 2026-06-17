import 'package:clever_portfolio/core/responsive/responsive.dart';
import 'package:clever_portfolio/core/theme/app_typography.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_project.dart';
import 'package:clever_portfolio/features/projects/presentation/widgets/app_icon_tile.dart';
import 'package:clever_portfolio/features/projects/presentation/widgets/category_color.dart';
import 'package:clever_portfolio/features/projects/presentation/widgets/store_buttons.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Decode cap for the viewer screenshots: the screen's pixel width. Source shots
/// (~1MB, up to ~1290px) decode at most to the device width instead of full res;
/// larger sources are downscaled, smaller ones are untouched (no upscale).
int _decodeWidth(BuildContext context) =>
    (MediaQuery.sizeOf(context).width * MediaQuery.devicePixelRatioOf(context))
        .round();

/// Opens the project detail viewer for [project].
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

/// Project detail viewer. On tablet/desktop the app data sits on the leading
/// half and the screenshot gallery on the trailing half; on mobile the gallery
/// stacks above the (height-capped) data. Tapping a screenshot opens a
/// full-screen, pinch/scroll-zoomable view.
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

  void _openZoom(int index) =>
      showImageZoom(context, widget.project, initialIndex: index);

  bool _isRtl(String text) => RegExp(r'[؀-ۿ]').hasMatch(text);

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final shots = project.screenshots;
    final hue = project.category.hue(context);
    final sideBySide = !context.isMobile;

    final gallery = _gallery(context, project, shots, hue);
    final details = _details(context, project, hue, fillHeight: sideBySide);

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
            // Body: side-by-side on wide screens, stacked on mobile.
            Expanded(
              child: sideBySide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(child: details),
                        Expanded(child: gallery),
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(child: gallery),
                        details,
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gallery(
    BuildContext context,
    AppProject project,
    List<String> shots,
    Color hue,
  ) {
    if (shots.isEmpty) {
      return ColoredBox(
        color: context.colors.surfaceContainerHighest,
        child: Center(child: AppIconTile(project: project, size: 120)),
      );
    }
    return ColoredBox(
      color: context.colors.surfaceContainerHighest,
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: _pager,
            itemCount: shots.length,
            onPageChanged: (i) => setState(() => _page = i),
            itemBuilder: (context, i) => GestureDetector(
              onTap: () => _openZoom(i),
              child: _ParallaxPage(
                controller: _pager,
                index: i,
                child: Padding(
                  padding: EdgeInsets.all(context.spacing.md.w),
                  child: Image.asset(
                    shots[i],
                    fit: BoxFit.contain,
                    cacheWidth: _decodeWidth(context),
                  ),
                ),
              ),
            ),
          ),
          // Full-screen / zoom affordance.
          PositionedDirectional(
            top: context.spacing.sm.h,
            end: context.spacing.sm.w,
            child: _RoundIcon(
              icon: Icons.fullscreen,
              tooltip: 'Zoom', // no-tr
              onTap: () => _openZoom(_page),
            ),
          ),
          if (shots.length > 1) ...[
            _Arrow(start: true, visible: _page > 0, onTap: () => _go(-1)),
            _Arrow(
              start: false,
              visible: _page < shots.length - 1,
              onTap: () => _go(1),
            ),
            PositionedDirectional(
              start: 0,
              end: 0,
              bottom: context.spacing.sm.h,
              child: _Dots(count: shots.length, active: _page, hue: hue),
            ),
          ],
        ],
      ),
    );
  }

  Widget _details(
    BuildContext context,
    AppProject project,
    Color hue, {
    required bool fillHeight,
  }) {
    final content = SingleChildScrollView(
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
    );
    // Side-by-side: fill the column height and scroll internally.
    // Stacked (mobile): cap the height so the gallery keeps the top space.
    if (fillHeight) return content;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 240.h),
      child: content,
    );
  }
}

/// Opens a full-screen, pinch/scroll-zoomable viewer over [project]'s
/// screenshots, starting at [initialIndex].
Future<void> showImageZoom(
  BuildContext context,
  AppProject project, {
  int initialIndex = 0,
}) {
  return showDialog<void>(
    context: context,
    barrierColor: context.colors.scrim.withValues(alpha: 0.95),
    builder: (_) =>
        _ImageZoomViewer(project: project, initialIndex: initialIndex),
  );
}

class _ImageZoomViewer extends StatefulWidget {
  const _ImageZoomViewer({required this.project, required this.initialIndex});

  final AppProject project;
  final int initialIndex;

  @override
  State<_ImageZoomViewer> createState() => _ImageZoomViewerState();
}

class _ImageZoomViewerState extends State<_ImageZoomViewer> {
  late final PageController _pager = PageController(
    initialPage: widget.initialIndex,
  );
  late int _page = widget.initialIndex;

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

  @override
  Widget build(BuildContext context) {
    final shots = widget.project.screenshots;
    final hue = widget.project.category.hue(context);

    return Dialog.fullscreen(
      backgroundColor: context.colors.scrim,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Page-swipe is disabled so it never fights the pan gesture once a
          // screenshot is zoomed in; the arrows switch images instead.
          PageView.builder(
            controller: _pager,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: shots.length,
            onPageChanged: (i) => setState(() => _page = i),
            itemBuilder: (context, i) => InteractiveViewer(
              minScale: 1,
              maxScale: 5,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(context.spacing.lg.w),
                  child: Image.asset(
                    shots[i],
                    fit: BoxFit.contain,
                    cacheWidth: _decodeWidth(context),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: AlignmentDirectional.topEnd,
              child: Padding(
                padding: EdgeInsets.all(context.spacing.md.w),
                child: _RoundIcon(
                  icon: Icons.close,
                  tooltip: 'Close', // no-tr
                  onTap: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),
          if (shots.length > 1) ...[
            _Arrow(start: true, visible: _page > 0, onTap: () => _go(-1)),
            _Arrow(
              start: false,
              visible: _page < shots.length - 1,
              onTap: () => _go(1),
            ),
            PositionedDirectional(
              start: 0,
              end: 0,
              bottom: context.spacing.lg.h,
              child: _Dots(count: shots.length, active: _page, hue: hue),
            ),
          ],
        ],
      ),
    );
  }
}

/// Slides a [PageView] child horizontally against the swipe so the image lags
/// the page travel, lending the gallery depth (horizontal scroll parallax,
/// the swipe-axis sibling of [ParallaxImage]'s vertical drift).
///
/// The child drifts within its page cell, which is clipped to the cell — the
/// gallery's [ColoredBox] background shows through any reveal, so a
/// `BoxFit.contain` screenshot never exposes a blank edge whatever its aspect
/// ratio. Only a paint-time transform changes per frame; the image is never
/// re-decoded. Honors reduced-motion (renders static) and RTL (mirrors the
/// drift so it still lags the swipe).
class _ParallaxPage extends StatelessWidget {
  const _ParallaxPage({
    required this.controller,
    required this.index,
    required this.child,
  });

  /// The gallery's page controller, read each frame for its scroll offset.
  final PageController controller;

  /// This child's page index, the rest pose where the image sits centred.
  final int index;

  /// The screenshot (already padded) to drift.
  final Widget child;

  // Horizontal drift budget as a fraction of the page width, per unit of page
  // offset — larger lets the image lag the swipe more.
  static const double _travel = 0.6;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).disableAnimations) return child;
    final sign = Directionality.of(context) == TextDirection.rtl ? -1.0 : 1.0;
    return LayoutBuilder(
      builder: (context, constraints) {
        final budget = constraints.maxWidth * _travel;
        return AnimatedBuilder(
          animation: controller,
          // Signed distance of this cell from the centred page, clamped to the
          // neighbours so off-screen pages don't translate off their cell.
          builder: (context, inner) {
            var offset = 0.0;
            if (controller.hasClients && controller.position.haveDimensions) {
              final page = controller.page ?? index.toDouble();
              offset = (page - index).clamp(-1.0, 1.0);
            }
            return ClipRect(
              child: Transform.translate(
                offset: Offset(offset * budget * sign, 0),
                child: inner,
              ),
            );
          },
          child: child,
        );
      },
    );
  }
}

/// A circular icon button over a translucent surface chip.
class _RoundIcon extends StatelessWidget {
  const _RoundIcon({required this.icon, required this.onTap, this.tooltip});

  final IconData icon;
  final VoidCallback onTap;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.surface.withValues(alpha: 0.7),
      shape: const CircleBorder(),
      child: IconButton(
        tooltip: tooltip,
        icon: Icon(icon, color: context.colors.onSurface),
        onPressed: onTap,
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

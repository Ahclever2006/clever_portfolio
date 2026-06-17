import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/core/widgets/page_scroll.dart';
import 'package:flutter/material.dart';

/// A `BoxFit.cover` image whose crop window slides vertically with the page's
/// scroll position, giving an image depth as its card crosses the viewport
/// (scroll parallax, plan.md §3.5 motion language).
///
/// The image is laid out [_overflow] taller than its frame on each side and
/// clipped; as the card travels through the viewport the image is translated
/// within that hidden band, so the visible crop appears to lag the scrolling
/// card. `cover` fills the oversized box, so the band is always image — never
/// blank — whatever the source aspect ratio, and the parallax travel is a fixed
/// budget rather than whatever overflow a screenshot happens to have.
///
/// Cost discipline: the image + clip + overflow box are built **once** (laid out
/// from the [LayoutBuilder]); only the `Transform.translate` offset changes per
/// scroll frame. The asset is decoded at the card's pixel width (not its ~1MB
/// source resolution) via [cacheWidth], and the whole widget is a
/// [RepaintBoundary] so its per-frame transform doesn't dirty siblings.
///
/// Honors reduced-motion and a missing [PageScroll] ancestor by rendering the
/// crop centred and static.
class ParallaxImage extends StatefulWidget {
  /// Creates a [ParallaxImage] for the asset at [asset].
  const ParallaxImage({required this.asset, this.errorBuilder, super.key});

  /// Asset path of the image to render.
  final String asset;

  /// Optional fallback when the asset fails to decode.
  final ImageErrorWidgetBuilder? errorBuilder;

  @override
  State<ParallaxImage> createState() => _ParallaxImageState();
}

class _ParallaxImageState extends State<ParallaxImage> {
  // Marks the stable frame box (it fills the slot and never moves under the
  // transform), so measuring its on-screen position each frame is faithful.
  final GlobalKey _frameKey = GlobalKey();
  ScrollController? _controller;

  // Cached viewport height — read from MediaQuery on dependency change instead
  // of per scroll frame.
  double _viewportHeight = 0;

  // Extra image height beyond the frame, per side, as a fraction of the frame
  // height — this is the parallax travel budget. Larger => stronger drift.
  static const double _overflow = 0.18;

  @override
  void initState() {
    super.initState();
    // The first build can't measure position yet (the render box isn't laid
    // out), so it renders centred. Rebuild once after layout so a card already
    // on screen at load gets its true crop without waiting for a scroll tick.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller = PageScroll.maybeOf(context);
    _viewportHeight = MediaQuery.sizeOf(context).height;
  }

  /// Signed position of the frame's centre within the viewport: `-1` at the
  /// top, `0` at the middle, `+1` at the bottom. Clamped beyond the edges.
  double _viewportFraction() {
    final box = _frameKey.currentContext?.findRenderObject();
    // hasSize guard: the first AnimatedBuilder build runs inside the
    // LayoutBuilder's layout callback, before the frame box is laid out —
    // render centred then; scroll-driven rebuilds run post-layout with a size.
    if (box is! RenderBox || !box.attached || !box.hasSize) return 0;
    final centreY = box.localToGlobal(box.size.center(Offset.zero)).dy;
    if (_viewportHeight <= 0) return 0;
    return (centreY / _viewportHeight).clamp(0.0, 1.0) * 2 - 1;
  }

  Widget _image(int cacheWidth) {
    return Image.asset(
      widget.asset,
      fit: BoxFit.cover,
      // Decode at the card's device-pixel width, not the ~1MB source res — a
      // 1290px-wide shot in a ~400px card otherwise rasters a ~14MB bitmap.
      cacheWidth: cacheWidth,
      filterQuality: FilterQuality.medium,
      // Fade in over the placeholder once decoded instead of flashing a blank
      // rectangle. The element is reused across the per-frame transform.
      frameBuilder: (context, child, frame, wasSync) {
        if (wasSync) return child;
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: context.motion.entrance,
          curve: context.motion.curveEntrance,
          child: child,
        );
      },
      errorBuilder: widget.errorBuilder,
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    final animate =
        controller != null && !MediaQuery.disableAnimationsOf(context);
    return RepaintBoundary(
      child: SizedBox.expand(
        key: _frameKey,
        child: ClipRect(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final extra = constraints.maxHeight * _overflow;
              final dpr = MediaQuery.devicePixelRatioOf(context);
              // Built once per layout — never rebuilt on the scroll ticks.
              final band = OverflowBox(
                minWidth: constraints.maxWidth,
                maxWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight + extra * 2,
                maxHeight: constraints.maxHeight + extra * 2,
                child: _image((constraints.maxWidth * dpr).round()),
              );
              // Static (reduced-motion / no page scroll): centred crop. Keep an
              // identity Transform so the rendered structure matches the
              // animated path (one Transform per instance).
              if (!animate) {
                return Transform.translate(offset: Offset.zero, child: band);
              }
              return AnimatedBuilder(
                animation: controller,
                child: band,
                builder: (context, child) => Transform.translate(
                  offset: Offset(0, -_viewportFraction() * extra),
                  child: child,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

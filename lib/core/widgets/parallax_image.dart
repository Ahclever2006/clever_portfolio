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
/// budget rather than whatever overflow a screenshot happens to have. Only a
/// paint-time transform changes per frame; the image is never re-decoded.
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
  }

  /// Signed position of the frame's centre within the viewport: `-1` at the
  /// top, `0` at the middle, `+1` at the bottom. Clamped beyond the edges.
  double _viewportFraction() {
    final box = _frameKey.currentContext?.findRenderObject();
    if (box is! RenderBox || !box.attached) return 0;
    final centreY = box.localToGlobal(box.size.center(Offset.zero)).dy;
    final viewport = MediaQuery.sizeOf(context).height;
    if (viewport <= 0) return 0;
    return (centreY / viewport).clamp(0.0, 1.0) * 2 - 1;
  }

  Widget _image() {
    return Image.asset(
      widget.asset,
      fit: BoxFit.cover,
      // Fade in over the placeholder once decoded (screenshots are ~1MB)
      // instead of flashing a blank rectangle. Stays opaque across the
      // per-frame scroll rebuilds since the image element is reused.
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

  /// [fraction] is the viewport position in `[-1, 1]`; `0` leaves the crop
  /// centred (also the static, reduced-motion pose).
  Widget _frame(double fraction) {
    return SizedBox.expand(
      key: _frameKey,
      child: ClipRect(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final extra = constraints.maxHeight * _overflow;
            return OverflowBox(
              minWidth: constraints.maxWidth,
              maxWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight + extra * 2,
              maxHeight: constraints.maxHeight + extra * 2,
              child: Transform.translate(
                offset: Offset(0, -fraction * extra),
                child: _image(),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    if (controller == null || MediaQuery.of(context).disableAnimations) {
      return _frame(0);
    }
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) => _frame(_viewportFraction()),
    );
  }
}

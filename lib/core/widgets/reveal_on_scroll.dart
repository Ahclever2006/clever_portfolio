import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Reveals [child] once it scrolls into view — 16px upward translate + fade
/// (plan.md §3.5). Honors reduced-motion (renders [child] immediately).
class RevealOnScroll extends StatefulWidget {
  /// Creates a [RevealOnScroll] wrapping [child] with an optional [delay].
  const RevealOnScroll({
    required this.child,
    this.delay = Duration.zero,
    super.key,
  });

  /// The content to reveal.
  final Widget child;

  /// Stagger delay before the entrance animation.
  final Duration delay;

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll>
    with SingleTickerProviderStateMixin {
  /// Unique per [State] — [VisibilityDetector] keys its global registry by this.
  final Key _detectorKey = UniqueKey();

  late final AnimationController _controller = AnimationController(vsync: this);
  Curve _curve = Curves.easeOutCubic;
  bool _shown = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final motion = context.motion;
    _controller.duration = motion.entrance;
    _curve = motion.curveEntrance;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _reveal() {
    if (_shown) return;
    // Flips IgnorePointer.ignoring and — via the null callback below — detaches
    // the visibility detector.
    setState(() => _shown = true);
    if (widget.delay == Duration.zero) {
      _controller.forward();
      return;
    }
    Future<void>.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).disableAnimations) return widget.child;
    return VisibilityDetector(
      key: _detectorKey,
      // Detach once revealed: passing null makes VisibilityDetector `forget()`
      // this key and cancel its composition callback. ~70 of these stay mounted
      // for the life of the page, and every one still listening walks its
      // ancestor transforms on each frame — even on an idle, untouched page.
      //
      // Reveal as soon as ANY part enters the viewport. The previous `> 0.1`
      // gate never fired for sections taller than ~10× the viewport (e.g. the
      // 1-column featured stack on mobile), leaving them permanently hidden.
      onVisibilityChanged: _shown
          ? null
          : (info) {
              if (mounted && info.visibleFraction > 0) _reveal();
            },
      child: AnimatedBuilder(
        animation: _controller,
        // `child` is built ONCE and handed through the child slot, so revealing
        // never changes widget *type*. The previous
        // `_shown ? child.animate(…) : IgnorePointer(Opacity(0, child))` swap
        // failed `canUpdate` and re-inflated the entire subtree mid-scroll —
        // ~44 project cards on the Work boundary, 17 PageControllers on
        // Featured — costing several dropped frames at each section entrance.
        //
        // While hidden this also blocks hit-testing: a bare Opacity(0) stays
        // tappable, which let users tap "empty" space and open a hidden card.
        child: IgnorePointer(ignoring: !_shown, child: widget.child),
        builder: (context, child) {
          final t = _curve.transform(_controller.value);
          return Opacity(
            opacity: t,
            child: Transform.translate(
              offset: Offset(0, 16 * (1 - t)),
              child: child,
            ),
          );
        },
      ),
    );
  }
}

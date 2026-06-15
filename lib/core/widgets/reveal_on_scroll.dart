import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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

class _RevealOnScrollState extends State<RevealOnScroll> {
  final Key _detectorKey = UniqueKey();
  bool _shown = false;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).disableAnimations) return widget.child;
    return VisibilityDetector(
      key: _detectorKey,
      // Reveal as soon as ANY part enters the viewport. The previous `> 0.1`
      // gate never fired for sections taller than ~10× the viewport (e.g. the
      // 1-column featured stack on mobile), leaving them permanently at
      // Opacity(0) — invisible but still laid out. `> 0` reveals tall sections
      // deterministically while keeping the scroll-in entrance for the rest.
      onVisibilityChanged: (info) {
        if (!_shown && mounted && info.visibleFraction > 0) {
          setState(() => _shown = true);
        }
      },
      child: _shown
          ? widget.child
                .animate(delay: widget.delay)
                .fadeIn(
                  duration: context.motion.entrance,
                  curve: context.motion.curveEntrance,
                )
                .moveY(
                  begin: 16,
                  end: 0,
                  duration: context.motion.entrance,
                  curve: context.motion.curveEntrance,
                )
          // While hidden, also block hit-testing: Opacity(0) alone stays
          // tappable, which let users tap "empty" space and open a hidden card.
          : IgnorePointer(child: Opacity(opacity: 0, child: widget.child)),
    );
  }
}

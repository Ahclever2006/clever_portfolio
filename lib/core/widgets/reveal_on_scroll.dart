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
      onVisibilityChanged: (info) {
        if (!_shown && mounted && info.visibleFraction > 0.1) {
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
          : Opacity(opacity: 0, child: widget.child),
    );
  }
}

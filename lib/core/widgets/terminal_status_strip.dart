import 'package:clever_portfolio/core/theme/app_typography.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Hero "build status" strip — a pulsing emerald dot, a mono status line, and a
/// blinking caret (plan.md §3.6). Respects reduced-motion.
///
/// The pulse + caret are `repeat()` loops; a [TickerMode] gated by a
/// [VisibilityDetector] freezes them once the hero scrolls out of view so two
/// tickers aren't spinning at 60fps for a strip nobody can see.
class TerminalStatusStrip extends StatefulWidget {
  /// Creates a [TerminalStatusStrip]; [text] is the (already-composed) status.
  const TerminalStatusStrip({required this.text, super.key});

  /// Status text shown after the `>` prompt.
  final String text;

  @override
  State<TerminalStatusStrip> createState() => _TerminalStatusStripState();
}

class _TerminalStatusStripState extends State<TerminalStatusStrip> {
  final Key _visKey = UniqueKey();
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    final reduce = MediaQuery.disableAnimationsOf(context);
    final statusLine = '> ${widget.text}';
    const caretText = ' _';

    Widget dot = Container(
      width: 8.r,
      height: 8.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.colors.primary,
      ),
    );
    Widget caret = Text(
      caretText,
      style: AppTypography.captionMono.copyWith(color: context.colors.primary),
    );

    if (!reduce) {
      dot = dot
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .fade(
            begin: 0.4,
            end: 1,
            duration: context.motion.counter,
            curve: Curves.easeInOut,
          );
      caret = caret
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .fade(begin: 0, end: 1, duration: context.motion.link);
    }

    final row = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        dot,
        SizedBox(width: context.spacing.sm.w),
        Flexible(
          child: Text(
            statusLine,
            style: AppTypography.captionMono.copyWith(
              color: context.brand.codeText,
            ),
          ),
        ),
        caret,
      ],
    );

    if (reduce) return row;
    return VisibilityDetector(
      key: _visKey,
      onVisibilityChanged: (info) {
        final visible = info.visibleFraction > 0;
        if (visible != _visible && mounted) {
          setState(() => _visible = visible);
        }
      },
      // Freeze the pulse/caret tickers while the strip is off-screen.
      child: TickerMode(enabled: _visible, child: row),
    );
  }
}

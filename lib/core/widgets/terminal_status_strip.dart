import 'package:clever_portfolio/core/theme/app_typography.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Hero "build status" strip — a pulsing emerald dot, a mono status line, and a
/// blinking caret (plan.md §3.6). Respects reduced-motion.
class TerminalStatusStrip extends StatelessWidget {
  /// Creates a [TerminalStatusStrip]; [text] is the (already-composed) status.
  const TerminalStatusStrip({required this.text, super.key});

  /// Status text shown after the `>` prompt.
  final String text;

  @override
  Widget build(BuildContext context) {
    final reduce = MediaQuery.of(context).disableAnimations;
    final statusLine = '> $text';
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

    return Row(
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
  }
}

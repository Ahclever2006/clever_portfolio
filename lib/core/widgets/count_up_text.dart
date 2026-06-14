import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';

/// Animates a numeric metric from 0 → its value (e.g. "37", "5+"), preserving a
/// non-numeric suffix. Honors reduced-motion (shows the final value).
class CountUpText extends StatelessWidget {
  /// Creates a [CountUpText] for [value] in [style].
  const CountUpText({required this.value, this.style, super.key});

  /// The metric string (leading digits are animated; the rest is a suffix).
  final String value;

  /// Text style.
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final match = RegExp(r'^(\d+)(.*)$').firstMatch(value.trim());
    if (match == null) return Text(value, style: style);

    final target = int.parse(match.group(1)!);
    final suffix = match.group(2) ?? '';

    if (MediaQuery.of(context).disableAnimations) {
      final display = '$target$suffix';
      return Text(display, style: style);
    }

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: target.toDouble()),
      duration: context.motion.counter,
      curve: context.motion.curveEntrance,
      builder: (context, v, _) {
        final display = '${v.round()}$suffix';
        return Text(display, style: style);
      },
    );
  }
}

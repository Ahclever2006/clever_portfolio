import 'dart:math' as math;

import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';

/// A subtle living background: slow-drifting emerald/blue radial glows over the
/// canvas (replaces the flat dark fill). Reduced-motion → static glows.
class MotionBackground extends StatefulWidget {
  /// Creates a [MotionBackground].
  const MotionBackground({super.key});

  @override
  State<MotionBackground> createState() => _MotionBackgroundState();
}

class _MotionBackgroundState extends State<MotionBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 24),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final painter = _AuroraPainter(
      t: 0,
      primary: context.colors.primary,
      secondary: context.colors.secondary,
    );
    if (MediaQuery.of(context).disableAnimations) {
      return CustomPaint(painter: painter, size: Size.infinite);
    }
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => CustomPaint(
        painter: _AuroraPainter(
          t: _controller.value,
          primary: context.colors.primary,
          secondary: context.colors.secondary,
        ),
        size: Size.infinite,
      ),
    );
  }
}

class _AuroraPainter extends CustomPainter {
  _AuroraPainter({
    required this.t,
    required this.primary,
    required this.secondary,
  });

  final double t;
  final Color primary;
  final Color secondary;

  void _blob(
    Canvas canvas,
    Size size,
    Color color,
    double cx,
    double cy,
    double radiusFactor,
    double alpha,
  ) {
    final center = Offset(cx * size.width, cy * size.height);
    final radius = radiusFactor * size.shortestSide;
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          color.withValues(alpha: alpha),
          color.withValues(alpha: 0),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final a = t * 2 * math.pi;
    _blob(
      canvas,
      size,
      primary,
      0.18 + 0.05 * math.sin(a),
      0.12 + 0.04 * math.cos(a),
      0.62,
      0.16,
    );
    _blob(
      canvas,
      size,
      secondary,
      0.86 + 0.05 * math.cos(a * 0.8),
      0.42 + 0.06 * math.sin(a * 0.8),
      0.52,
      0.12,
    );
    _blob(
      canvas,
      size,
      primary,
      0.62 + 0.05 * math.sin(a * 1.2 + 1),
      0.88 + 0.03 * math.cos(a * 1.2),
      0.48,
      0.10,
    );
  }

  @override
  bool shouldRepaint(_AuroraPainter old) =>
      old.t != t || old.primary != primary || old.secondary != secondary;
}

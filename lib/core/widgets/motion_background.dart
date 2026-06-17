import 'dart:math' as math;

import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:flutter/foundation.dart' show ValueListenable;
import 'package:flutter/material.dart';

/// A subtle living background: slow-drifting emerald/blue radial glows over the
/// canvas (replaces the flat dark fill). Reduced-motion → static glows.
///
/// Cost discipline (this paints behind the whole page, so it must be cheap):
/// * The three glow shaders are built **once per size**, not per frame — their
///   gradient colours/stops never change with time, only the blob centres
///   drift, so the painter translates the canvas instead of calling
///   `createShader` 60×/sec (a CanvasKit gradient-ramp upload that dominated the
///   old idle cost).
/// * Repaints are **quantised to ~12fps** via [_tick]: a 24s drift needs no
///   more, so the painter is told to repaint a few times a second instead of
///   every vsync.
/// * The controller is **paused** when the tab is backgrounded and is never
///   started under reduced-motion.
/// Wrap this in a `RepaintBoundary` at the call site so its repaints don't
/// re-record sibling layers.
class MotionBackground extends StatefulWidget {
  /// Creates a [MotionBackground].
  const MotionBackground({super.key});

  @override
  State<MotionBackground> createState() => _MotionBackgroundState();
}

class _MotionBackgroundState extends State<MotionBackground>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 24),
  )..addListener(_onControllerTick);

  // Quantised drift clock the painter repaints from: the controller still ticks
  // at vsync, but [_tick] only changes ~[_fps]× per second, so the (relatively)
  // expensive aurora paint runs a few times a second rather than 60.
  static const int _fps = 12;
  final ValueNotifier<int> _tick = ValueNotifier<int>(0);

  bool _motionAllowed = true;
  bool _running = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Specific dependency (not MediaQuery.of) so we don't rebuild on unrelated
    // metric changes (scroll insets, keyboard, etc.).
    _motionAllowed = !MediaQuery.disableAnimationsOf(context);
    _syncRunning();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // No point drifting glows the user can't see; resume when foregrounded.
    if (state == AppLifecycleState.resumed) {
      _syncRunning();
    } else {
      _controller.stop();
      _running = false;
    }
  }

  void _syncRunning() {
    if (_motionAllowed && !_running) {
      _controller.repeat();
      _running = true;
    } else if (!_motionAllowed && _running) {
      _controller
        ..stop()
        ..value = 0;
      _running = false;
      _tick.value = 0;
    }
  }

  void _onControllerTick() {
    final bucket = (_controller.value * 24 * _fps).floor();
    if (bucket != _tick.value) _tick.value = bucket;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    _tick.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // build() runs only on theme change (colours) — never per frame; the
    // per-frame repaint is driven by [_tick] through the painter's `repaint:`.
    return CustomPaint(
      painter: _AuroraPainter(
        tick: _tick,
        fps: _fps,
        primary: context.colors.primary,
        secondary: context.colors.secondary,
      ),
      size: Size.infinite,
    );
  }
}

class _AuroraPainter extends CustomPainter {
  _AuroraPainter({
    required this.tick,
    required this.fps,
    required this.primary,
    required this.secondary,
  }) : super(repaint: tick);

  final ValueListenable<int> tick;
  final int fps;
  final Color primary;
  final Color secondary;

  // Shaders cached per size: gradient colours/stops are time-invariant, so they
  // are built once and reused every frame; only the canvas is translated.
  Size? _shaderSize;
  List<Paint>? _paints;

  static const List<_Blob> _blobs = [
    // baseCx, baseCy, driftX, driftY, radiusFactor, alpha, freq, phase, usePrimary
    _Blob(0.18, 0.12, 0.05, 0.04, 0.62, 0.16, 1, 0, true),
    _Blob(0.86, 0.42, 0.05, 0.06, 0.52, 0.12, 0.8, 0, false),
    _Blob(0.62, 0.88, 0.05, 0.03, 0.48, 0.10, 1.2, 1, true),
  ];

  void _buildPaints(Size size) {
    _paints = [
      for (final b in _blobs)
        Paint()
          ..shader =
              RadialGradient(
                colors: [
                  (b.usePrimary ? primary : secondary).withValues(
                    alpha: b.alpha,
                  ),
                  (b.usePrimary ? primary : secondary).withValues(alpha: 0),
                ],
              ).createShader(
                Rect.fromCircle(
                  center: Offset(b.baseCx * size.width, b.baseCy * size.height),
                  radius: b.radiusFactor * size.shortestSide,
                ),
              ),
    ];
    _shaderSize = size;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (_paints == null || _shaderSize != size) _buildPaints(size);
    final paints = _paints!;
    final t = (tick.value / (24 * fps)) % 1.0;
    final a = t * 2 * math.pi;

    for (var i = 0; i < _blobs.length; i++) {
      final b = _blobs[i];
      final base = Offset(b.baseCx * size.width, b.baseCy * size.height);
      final radius = b.radiusFactor * size.shortestSide;
      // Drift the blob by translating the canvas — the cached shader (anchored
      // at [base] in local coords) moves with the circle, so no re-shade.
      final dx = b.driftX * math.sin(a * b.freq + b.phase) * size.width;
      final dy = b.driftY * math.cos(a * b.freq + b.phase) * size.height;
      canvas
        ..save()
        ..translate(dx, dy)
        ..drawCircle(base, radius, paints[i])
        ..restore();
    }
  }

  @override
  bool shouldRepaint(_AuroraPainter old) =>
      old.primary != primary || old.secondary != secondary;
}

/// Static descriptor for one drifting glow.
class _Blob {
  const _Blob(
    this.baseCx,
    this.baseCy,
    this.driftX,
    this.driftY,
    this.radiusFactor,
    this.alpha,
    this.freq,
    this.phase,
    this.usePrimary,
  );

  final double baseCx;
  final double baseCy;
  final double driftX;
  final double driftY;
  final double radiusFactor;
  final double alpha;
  final double freq;
  final double phase;
  final bool usePrimary;
}

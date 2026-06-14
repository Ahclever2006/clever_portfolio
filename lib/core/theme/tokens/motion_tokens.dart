import 'package:flutter/material.dart';

/// Durations + curves for the motion language (plan.md §3.5). No inline literals
/// in widgets — read via `context.motion`.
@immutable
class MotionTokens extends ThemeExtension<MotionTokens> {
  const MotionTokens({
    this.entrance = const Duration(milliseconds: 480),
    this.hover = const Duration(milliseconds: 160),
    this.button = const Duration(milliseconds: 120),
    this.link = const Duration(milliseconds: 200),
    this.hairline = const Duration(milliseconds: 600),
    this.counter = const Duration(milliseconds: 1200),
    this.themeFade = const Duration(milliseconds: 300),
    this.stagger = const Duration(milliseconds: 60),
    this.curveEntrance = Curves.easeOutCubic,
    this.curveHover = Curves.easeOut,
  });

  final Duration entrance;
  final Duration hover;
  final Duration button;
  final Duration link;
  final Duration hairline;
  final Duration counter;
  final Duration themeFade;
  final Duration stagger;
  final Curve curveEntrance;
  final Curve curveHover;

  @override
  MotionTokens copyWith({
    Duration? entrance,
    Duration? hover,
    Duration? button,
    Duration? link,
    Duration? hairline,
    Duration? counter,
    Duration? themeFade,
    Duration? stagger,
    Curve? curveEntrance,
    Curve? curveHover,
  }) {
    return MotionTokens(
      entrance: entrance ?? this.entrance,
      hover: hover ?? this.hover,
      button: button ?? this.button,
      link: link ?? this.link,
      hairline: hairline ?? this.hairline,
      counter: counter ?? this.counter,
      themeFade: themeFade ?? this.themeFade,
      stagger: stagger ?? this.stagger,
      curveEntrance: curveEntrance ?? this.curveEntrance,
      curveHover: curveHover ?? this.curveHover,
    );
  }

  // Durations/curves don't meaningfully interpolate between themes; snap.
  @override
  MotionTokens lerp(ThemeExtension<MotionTokens>? other, double t) => this;
}

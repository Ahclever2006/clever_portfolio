import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

/// Corner-radius scale (plan.md §3.3). Raw logical px — apply `.r` at use sites.
@immutable
class AppRadii extends ThemeExtension<AppRadii> {
  const AppRadii({
    this.pill = 999,
    this.card = 16,
    this.chip = 8,
    this.input = 10,
    this.button = 10,
  });

  final double pill;
  final double card;
  final double chip;
  final double input;
  final double button;

  @override
  AppRadii copyWith({
    double? pill,
    double? card,
    double? chip,
    double? input,
    double? button,
  }) {
    return AppRadii(
      pill: pill ?? this.pill,
      card: card ?? this.card,
      chip: chip ?? this.chip,
      input: input ?? this.input,
      button: button ?? this.button,
    );
  }

  @override
  AppRadii lerp(ThemeExtension<AppRadii>? other, double t) {
    if (other is! AppRadii) return this;
    return AppRadii(
      pill: lerpDouble(pill, other.pill, t)!,
      card: lerpDouble(card, other.card, t)!,
      chip: lerpDouble(chip, other.chip, t)!,
      input: lerpDouble(input, other.input, t)!,
      button: lerpDouble(button, other.button, t)!,
    );
  }
}

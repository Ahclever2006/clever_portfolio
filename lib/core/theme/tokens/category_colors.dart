import 'package:flutter/material.dart';

/// Per-category accent hues (plan.md §3.1). AA-safe solid colors used only for
/// small accents (card accent line, category tag, filter pill, index dot).
///
/// M3 adds a `forCategory(AppCategory)` lookup once the domain enum exists; for
/// now categories are addressed by their named getters or [byName].
@immutable
class CategoryColors extends ThemeExtension<CategoryColors> {
  const CategoryColors({
    required this.ecommerce,
    required this.games,
    required this.booking,
    required this.business,
    required this.food,
    required this.services,
    required this.medical,
    required this.education,
    required this.travel,
  });

  final Color ecommerce;
  final Color games;
  final Color booking;
  final Color business;
  final Color food;
  final Color services;
  final Color medical;
  final Color education;
  final Color travel;

  /// Resolves a hue by its lowercase category key; falls back to [ecommerce].
  Color byName(String key) {
    return switch (key.toLowerCase()) {
      'ecommerce' || 'e-commerce' => ecommerce,
      'games' || 'trivia' => games,
      'booking' => booking,
      'business' || 'admin' => business,
      'food' => food,
      'services' => services,
      'medical' => medical,
      'education' => education,
      'travel' => travel,
      _ => ecommerce,
    };
  }

  @override
  CategoryColors copyWith({
    Color? ecommerce,
    Color? games,
    Color? booking,
    Color? business,
    Color? food,
    Color? services,
    Color? medical,
    Color? education,
    Color? travel,
  }) {
    return CategoryColors(
      ecommerce: ecommerce ?? this.ecommerce,
      games: games ?? this.games,
      booking: booking ?? this.booking,
      business: business ?? this.business,
      food: food ?? this.food,
      services: services ?? this.services,
      medical: medical ?? this.medical,
      education: education ?? this.education,
      travel: travel ?? this.travel,
    );
  }

  @override
  CategoryColors lerp(ThemeExtension<CategoryColors>? other, double t) {
    if (other is! CategoryColors) return this;
    return CategoryColors(
      ecommerce: Color.lerp(ecommerce, other.ecommerce, t)!,
      games: Color.lerp(games, other.games, t)!,
      booking: Color.lerp(booking, other.booking, t)!,
      business: Color.lerp(business, other.business, t)!,
      food: Color.lerp(food, other.food, t)!,
      services: Color.lerp(services, other.services, t)!,
      medical: Color.lerp(medical, other.medical, t)!,
      education: Color.lerp(education, other.education, t)!,
      travel: Color.lerp(travel, other.travel, t)!,
    );
  }
}

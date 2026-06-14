/// App category taxonomy — matches the `CategoryColors` hues + filter chips
/// (plan.md §6.2). All 37 apps bucket into exactly these nine.
enum AppCategory {
  /// E-commerce / retail.
  ecommerce,

  /// Games / trivia.
  games,

  /// Booking & reservations.
  booking,

  /// Business & admin.
  business,

  /// Food & diet.
  food,

  /// Services (barbershop, car wash, community…).
  services,

  /// Medical.
  medical,

  /// Education.
  education,

  /// Travel / places guide.
  travel;

  /// Human-readable label.
  String get label => switch (this) {
    AppCategory.ecommerce => 'E-commerce',
    AppCategory.games => 'Games',
    AppCategory.booking => 'Booking',
    AppCategory.business => 'Business',
    AppCategory.food => 'Food & Diet',
    AppCategory.services => 'Services',
    AppCategory.medical => 'Medical',
    AppCategory.education => 'Education',
    AppCategory.travel => 'Travel',
  };

  /// Parses a JSON key (the enum `name`); unknown values fall back to
  /// [AppCategory.ecommerce].
  static AppCategory fromKey(String key) => AppCategory.values.firstWhere(
    (c) => c.name == key,
    orElse: () => AppCategory.ecommerce,
  );
}

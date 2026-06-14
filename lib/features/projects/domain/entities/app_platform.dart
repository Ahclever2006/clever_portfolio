/// Distribution platform for a published app.
enum AppPlatform {
  /// Google Play.
  android,

  /// Apple App Store.
  ios;

  /// Human-readable label.
  String get label => switch (this) {
    AppPlatform.android => 'Android',
    AppPlatform.ios => 'iOS',
  };
}

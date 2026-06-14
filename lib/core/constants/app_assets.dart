/// Bundled-asset paths + web-served download URLs (plan.md §10).
abstract final class AppAssets {
  const AppAssets._();

  /// 37-app data (local data source).
  static const String appsJson = 'assets/data/apps.json';

  /// Profile / skills / experience / education / contact data.
  static const String profileJson = 'assets/data/profile.json';

  /// CV PDF (bundled).
  static const String cvPdf = 'assets/docs/Ahmed_Maher_cv.pdf';

  /// Portfolio PDF (bundled).
  static const String portfolioPdf = 'assets/docs/Ahmed_Maher_Portfolio.pdf';

  /// App Store badge SVG.
  static const String appStoreBadge = 'assets/icons/app_store.svg';

  /// Google Play badge SVG.
  static const String googlePlayBadge = 'assets/icons/google_play.svg';

  /// Web-served (relative) CV download URL — file lives under `web/docs/`.
  static const String cvDownloadUrl = 'docs/Ahmed_Maher_cv.pdf';

  /// Web-served (relative) portfolio download URL.
  static const String portfolioDownloadUrl = 'docs/Ahmed_Maher_Portfolio.pdf';
}

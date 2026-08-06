/// Bundled-asset paths + web-served download URLs (plan.md §10).
abstract final class AppAssets {
  const AppAssets._();

  /// 42-app data (local data source).
  static const String appsJson = 'assets/data/apps.json';

  /// Profile / skills / experience / education / contact data.
  static const String profileJson = 'assets/data/profile.json';

  /// CV file name — also the name the browser saves the download as.
  static const String cvFileName = 'AhmedMaher_CV_2026.pdf';

  /// CV PDF (bundled).
  static const String cvPdf = 'assets/docs/$cvFileName';

  /// App Store badge SVG.
  static const String appStoreBadge = 'assets/icons/app_store.svg';

  /// Google Play badge SVG.
  static const String googlePlayBadge = 'assets/icons/google_play.svg';

  /// Web-served (relative) CV download URL — file lives under `web/docs/`.
  static const String cvDownloadUrl = 'docs/$cvFileName';
}

/// i18n translation KEYS — the single source of `.tr()` keys.
///
/// House rule: never inline a bare key literal like `'hero.title'.tr()`. Always
/// declare the key here and use `AppStrings.heroTitle.tr()`. Keys must exist in
/// both `assets/translations/en.json` and `ar.json` (parity is hook-checked).
abstract final class AppStrings {
  const AppStrings._();

  static const String appTitle = 'app.title';

  // Nav
  static const String navAbout = 'nav.about';
  static const String navWork = 'nav.work';
  static const String navExperience = 'nav.experience';
  static const String navContact = 'nav.contact';
  static const String navDownloadCv = 'nav.downloadCv';

  // Hero
  static const String heroEyebrow = 'hero.eyebrow';
  static const String heroTitle = 'hero.title';
  static const String heroTagline = 'hero.tagline';
  static const String heroViewWork = 'hero.viewWork';
  static const String heroDownloadResume = 'hero.downloadResume';

  // Common
  static const String commonScaffolding = 'common.scaffolding';
}

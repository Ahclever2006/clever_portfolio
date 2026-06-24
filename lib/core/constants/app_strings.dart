/// i18n translation KEYS — the single source of `.tr()` keys (house rule).
///
/// Never inline a bare key literal; declare it here and use
/// `AppStrings.heroTitle.tr()`. Every key must exist in both
/// `assets/translations/en.json` and `ar.json` (parity is hook-checked).
abstract final class AppStrings {
  const AppStrings._();

  static const String appTitle = 'app.title';

  // Nav
  static const String navAbout = 'nav.about';
  static const String navSkills = 'nav.skills';
  static const String navWork = 'nav.work';
  static const String navFeatured = 'nav.featured';
  static const String navExperience = 'nav.experience';
  static const String navContact = 'nav.contact';
  static const String navDownloadCv = 'nav.downloadCv';

  // Hero
  static const String heroEyebrow = 'hero.eyebrow';
  static const String heroTagline = 'hero.tagline';
  static const String heroViewWork = 'hero.viewWork';
  static const String heroDownloadResume = 'hero.downloadResume';

  // Section eyebrows + titles (mono "// x" + display title)
  static const String aboutEyebrow = 'about.eyebrow';
  static const String aboutTitle = 'about.title';
  static const String skillsEyebrow = 'skills.eyebrow';
  static const String skillsTitle = 'skills.title';
  static const String workEyebrow = 'work.eyebrow';
  static const String workTitle = 'work.title';
  static const String featuredEyebrow = 'featured.eyebrow';
  static const String featuredTitle = 'featured.title';
  static const String experienceEyebrow = 'experience.eyebrow';
  static const String experienceTitle = 'experience.title';
  static const String educationEyebrow = 'education.eyebrow';
  static const String educationTitle = 'education.title';
  static const String contactEyebrow = 'contact.eyebrow';
  static const String contactTitle = 'contact.title';

  // Work / index controls
  static const String workSearchHint = 'work.searchHint';
  static const String workFilterAll = 'work.filterAll';
  static const String workPlatformAll = 'work.platformAll';
  static const String workViewList = 'work.viewList';
  static const String workViewGrid = 'work.viewGrid';
  static const String workEmpty = 'work.empty';
  static const String workOpenStore = 'work.openStore';

  // Category labels (for filter chips / tags — bilingual)
  static const String catEcommerce = 'category.ecommerce';
  static const String catGames = 'category.games';
  static const String catBooking = 'category.booking';
  static const String catBusiness = 'category.business';
  static const String catFood = 'category.food';
  static const String catServices = 'category.services';
  static const String catMedical = 'category.medical';
  static const String catEducation = 'category.education';
  static const String catTravel = 'category.travel';

  // Contact form
  static const String contactName = 'contact.name';
  static const String contactEmail = 'contact.email';
  static const String contactMessage = 'contact.message';
  static const String contactSend = 'contact.send';
  static const String contactSending = 'contact.sending';
  static const String contactSuccess = 'contact.success';
  static const String contactSentTitle = 'contact.sentTitle';
  static const String contactErrorFallback = 'contact.errorFallback';
  static const String contactEmailMe = 'contact.emailMe';
  static const String contactDownloadCv = 'contact.downloadCv';
  static const String contactWhatsapp = 'contact.whatsapp';
  static const String contactValidateName = 'contact.validateName';
  static const String contactValidateEmail = 'contact.validateEmail';
  static const String contactValidateMsg = 'contact.validateMsg';

  // Footer
  static const String footerBuiltWith = 'footer.builtWith';
  static const String footerBackToTop = 'footer.backToTop';
  static const String footerRights = 'footer.rights';
  static const String footerPrivacy = 'footer.privacy';
  static const String footerAnalytics = 'footer.analytics';

  // Common
  static const String commonScaffolding = 'common.scaffolding';
}

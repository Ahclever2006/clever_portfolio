/// Cross-cutting analytics abstraction (GA4 / gtag.js on web, no-op elsewhere).
///
/// The concrete implementation is selected at compile time by
/// `analytics_factory.dart` (conditional import): the gtag-backed impl on web,
/// a no-op on the Dart VM / tests. Widgets and cubits depend ONLY on this
/// interface, so the rest of the app stays platform-agnostic and `dart:js_interop`
/// never leaks past `core/analytics/`.
abstract interface class AnalyticsService {
  /// Sends a GA4 event. [name] must be snake_case (GA4: <=40 chars, start with
  /// a letter); [params] are flat key/values (string values <=100 chars).
  void logEvent(String name, {Map<String, Object?> params});

  /// Sends a manual screen/page view (used only if real routes are added; the
  /// single-route SPA relies on GA4 Enhanced Measurement for its one pageview).
  void logScreenView(String screenName);
}

/// GA4 event names — declared once (mirrors the `AppStrings` rule: never inline
/// a raw event string). GA4 names: lowercase snake_case, <=40 chars.
abstract final class AnalyticsEvent {
  const AnalyticsEvent._();

  /// A page section scrolled into view.
  static const String sectionView = 'section_view';

  /// The CV/résumé PDF was opened/downloaded.
  static const String cvDownload = 'cv_download';

  /// An App Store / Google Play listing was opened from a project.
  static const String openStoreLink = 'open_app_store_link';

  /// The contact form was submitted successfully.
  static const String contactSubmit = 'contact_submit';
}

/// GA4 event parameter keys. Register the non-reserved ones as GA4 Custom
/// definitions (Admin > Custom definitions) to surface them in reports.
abstract final class AnalyticsParam {
  const AnalyticsParam._();

  /// Section identifier (e.g. `hero`, `work`, `contact`).
  static const String sectionName = 'section_name';

  /// Where a CV download was triggered from (`hero` / `navbar` / `contact`).
  static const String source = 'source';

  /// Downloaded file name.
  static const String fileName = 'file_name';

  /// App display name for a store-link open.
  static const String appName = 'app_name';

  /// Store the link points at (`app_store` / `google_play`).
  static const String store = 'store';
}

/// Semantic helpers so call sites read intent, not raw event/param strings.
/// Available on any [AnalyticsService] — the injected instance (cubits) and the
/// static [Analytics] facade (widgets) both share this logic.
extension AnalyticsEvents on AnalyticsService {
  /// Logs that [sectionName] entered the viewport.
  void sectionView(String sectionName) => logEvent(
    AnalyticsEvent.sectionView,
    params: {AnalyticsParam.sectionName: sectionName},
  );

  /// Logs a CV download triggered from [source].
  void cvDownload(String source) => logEvent(
    AnalyticsEvent.cvDownload,
    params: {
      AnalyticsParam.source: source,
      AnalyticsParam.fileName: 'Ahmed_Maher_cv.pdf',
    },
  );

  /// Logs opening the [store] listing for [appName].
  void storeOpen({required String appName, required String store}) => logEvent(
    AnalyticsEvent.openStoreLink,
    params: {AnalyticsParam.appName: appName, AnalyticsParam.store: store},
  );

  /// Logs a successful contact-form submission.
  void contactSubmit() => logEvent(AnalyticsEvent.contactSubmit);
}

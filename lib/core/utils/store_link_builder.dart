/// Builds App Store / Google Play URLs from raw store ids (plan.md §5.3).
/// Returns `null` when the id is absent, so cards render a store button ONLY
/// for platforms the app actually ships on.
abstract final class StoreLinkBuilder {
  const StoreLinkBuilder._();

  /// `https://apps.apple.com/app/id<rawId>` (null if [rawId] is empty).
  static String? appStore(String? rawId) {
    if (rawId == null || rawId.isEmpty) return null;
    return 'https://apps.apple.com/app/id$rawId';
  }

  /// `https://play.google.com/store/apps/details?id=<packageId>` (null if empty).
  static String? googlePlay(String? packageId) {
    if (packageId == null || packageId.isEmpty) return null;
    return 'https://play.google.com/store/apps/details?id=$packageId';
  }
}

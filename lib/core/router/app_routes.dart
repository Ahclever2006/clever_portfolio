/// Route names + paths (plan.md §9). One `/` route for the single-scroll page;
/// `/work/:appId` is a future deep-link addition.
abstract final class AppRoutes {
  const AppRoutes._();

  /// The single-page home path.
  static const String home = '/';

  /// The home route name.
  static const String homeName = 'home';
}

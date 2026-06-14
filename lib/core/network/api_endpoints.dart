/// API endpoints (plan.md §5.3). Empty [baseUrl] disables remote calls — the
/// site is static; Dio is reserved for the optional contact-form POST.
abstract final class ApiEndpoints {
  const ApiEndpoints._();

  /// Injected at build time via `--dart-define=API_BASE_URL=...`; empty = none.
  static const String baseUrl = String.fromEnvironment('API_BASE_URL');

  /// Contact-form submission path (relative to [baseUrl]).
  static const String contact = '/contact';

  /// Whether a remote backend is configured.
  static bool get hasRemote => baseUrl.isNotEmpty;
}

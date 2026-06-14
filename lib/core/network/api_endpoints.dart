/// API endpoints (plan.md §5.3). The site is static; Dio is used only for the
/// contact form, relayed to email by Web3Forms (no backend to run).
abstract final class ApiEndpoints {
  const ApiEndpoints._();

  /// Web3Forms submit endpoint (CORS-enabled; safe to call from the browser).
  static const String web3formsSubmit = 'https://api.web3forms.com/submit';

  /// Web3Forms access key — create a FREE one at https://web3forms.com (enter
  /// the email you want messages delivered to), then paste it here OR pass it
  /// at build time via `--dart-define=WEB3FORMS_KEY=xxxxxxxx`.
  static const String web3formsAccessKey = String.fromEnvironment(
    'WEB3FORMS_KEY',
  );

  /// Whether the contact form can actually deliver to email.
  static bool get hasContactBackend => web3formsAccessKey.isNotEmpty;
}

import 'package:url_launcher/url_launcher.dart';

/// Thin wrapper over url_launcher for opening store links, the CV, and mailto.
abstract final class AppLauncher {
  const AppLauncher._();

  /// Opens [url] in a new browser tab.
  static Future<void> open(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, webOnlyWindowName: '_blank');
  }

  /// Opens a WhatsApp chat with [phone] (any format; non-digits are stripped).
  static Future<void> whatsApp(String phone) {
    final digits = phone.replaceAll(RegExp(r'[^0-9]'), '');
    return open('https://wa.me/$digits');
  }

  /// Opens a `mailto:` composer for [address].
  static Future<void> email(String address, {String? subject}) async {
    final uri = Uri(
      scheme: 'mailto',
      path: address,
      query: subject == null ? null : 'subject=$subject',
    );
    await launchUrl(uri);
  }
}

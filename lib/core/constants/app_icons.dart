import 'package:flutter/widgets.dart';

/// Brand glyphs — the only Font Awesome icons this portfolio uses.
///
/// These replace the `font_awesome_flutter` package. That package declares
/// three font families in its `pubspec.yaml` (Brands, Free-Regular, Free-Solid)
/// and Flutter's icon tree-shaker only rewrites a family it finds referenced
/// icons for — so Free-Regular (86 KB) and Free-Solid (401 KB) shipped whole
/// while every call site here used Brands. That was 487 KB of dead weight on
/// the pre-first-frame path, since the engine awaits `loadAssetFonts` before it
/// is allowed to paint.
///
/// Only `Font-Awesome-7-Brands-Regular-400.otf` is bundled now
/// (`assets/fonts/`, declared in `pubspec.yaml`). These are `const` with a
/// literal `fontFamily`, so the tree-shaker still strips it to the handful of
/// glyphs below.
///
/// Codepoints copied verbatim from `font_awesome_flutter` 10.12.0. Adding an
/// icon means looking up its Brands codepoint there — a wrong value renders
/// tofu rather than failing the build.
///
/// License: Font Awesome Free — icons CC BY 4.0, fonts SIL OFL 1.1. Full text
/// in `assets/fonts/LICENSE-fontawesome.txt`.
abstract final class AppIcons {
  const AppIcons._();

  static const String _brands = 'FontAwesomeBrands';

  /// GitHub mark.
  static const IconData github = IconData(0xf09b, fontFamily: _brands);

  /// LinkedIn "in" mark.
  static const IconData linkedinIn = IconData(0xf0e1, fontFamily: _brands);

  /// X (formerly Twitter) mark.
  static const IconData xTwitter = IconData(0xe61b, fontFamily: _brands);

  /// WhatsApp mark.
  static const IconData whatsapp = IconData(0xf232, fontFamily: _brands);

  /// Apple App Store mark.
  static const IconData appStoreIos = IconData(0xf370, fontFamily: _brands);

  /// Google Play mark.
  static const IconData googlePlay = IconData(0xf3ab, fontFamily: _brands);
}

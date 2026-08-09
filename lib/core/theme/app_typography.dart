import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Named text styles — the type scale from plan.md §3.2.
///
/// This file is the typography source (exempt from the design-token gate). Sizes
/// use `.sp` (flutter_screenutil) for responsive scaling.
///
/// Fonts: Space Grotesk (display) · Inter (body) · JetBrains Mono (engineer
/// signal). All three are **bundled** under `assets/fonts/` and declared in
/// `pubspec.yaml` — they are no longer fetched from gstatic at runtime, which
/// removed ~500 KB from the post-boot path and the font-swap reflow with it.
///
/// **Arabic:** seven `apps.json` descriptions are Arabic and render even in the
/// `en` locale (see `screenshot_viewer.dart`'s RTL detector), but only inside
/// the screenshot-viewer modal — never on the landing page. Rather than ship an
/// Arabic face every visitor pays for, those glyphs resolve through the engine's
/// own Noto fallback, on demand. To give Arabic an intentional typeface (or when
/// re-enabling the `ar` locale — see `bootstrap.dart` → `startLocale`), add a
/// Cairo `.ttf` to `assets/fonts/`, declare it in `pubspec.yaml`, and pass
/// `fontFamilyFallback: const ['Cairo']` on the styles below.
abstract final class AppTypography {
  const AppTypography._();

  /// Display family — Space Grotesk (w600 is the only bundled weight).
  static const String _display = 'SpaceGrotesk';

  /// Body family — Inter (w400 + w500 bundled).
  static const String _body = 'Inter';

  /// Engineer-signal family — JetBrains Mono (w400 + w500 bundled).
  static const String _mono = 'JetBrainsMono';

  /// Hero headline. Base desktop size; the hero applies a fluid clamp(48→88).
  static TextStyle get displayHero => TextStyle(
    fontFamily: _display,
    fontSize: 64.sp,
    fontWeight: FontWeight.w600,
    height: 1.02,
    letterSpacing: -1.5,
  );

  static TextStyle get displaySection => TextStyle(
    fontFamily: _display,
    fontSize: 36.sp,
    fontWeight: FontWeight.w600,
    height: 1.1,
    letterSpacing: -0.5,
  );

  static TextStyle get title => TextStyle(
    fontFamily: _display,
    fontSize: 22.sp,
    fontWeight: FontWeight.w600,
    height: 1.25,
    letterSpacing: -0.2,
  );

  static TextStyle get eyebrowMono => TextStyle(
    fontFamily: _mono,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.5,
  );

  static TextStyle get body => TextStyle(
    fontFamily: _body,
    fontSize: 17.sp,
    fontWeight: FontWeight.w400,
    height: 1.65,
  );

  static TextStyle get bodySmall => TextStyle(
    fontFamily: _body,
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    height: 1.55,
  );

  static TextStyle get label => TextStyle(
    fontFamily: _body,
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.3,
  );

  static TextStyle get folioMono => TextStyle(
    fontFamily: _mono,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.5,
  );

  static TextStyle get captionMono => TextStyle(
    fontFamily: _mono,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );
}

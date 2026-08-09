import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Named text styles — the type scale from plan.md §3.2.
///
/// This file is the typography source (exempt from the design-token gate). Sizes
/// use `.sp` (flutter_screenutil) for responsive scaling.
///
/// Fonts: Space Grotesk (display) · Inter (body) · JetBrains Mono (engineer
/// signal). **Arabic** glyphs fall back to **Cairo**, so the AR locale renders
/// correctly while Latin keeps its primary typefaces.
abstract final class AppTypography {
  const AppTypography._();

  /// Whether the Arabic (Cairo) fallback face is loaded.
  ///
  /// `false` while the app is pinned to the `en` locale (`bootstrap.dart` →
  /// `startLocale`). Every `GoogleFonts.*` call fetches its face from gstatic at
  /// runtime, so calling `GoogleFonts.cairo()` cost a ~91 KB download on every
  /// page load for glyphs no English string can use. Flip this to `true` in the
  /// same commit that removes `startLocale` to bring the AR fallback back.
  static const bool arabicFallbackEnabled = false;

  /// Arabic fallback family (loaded via google_fonts), or `null` when disabled —
  /// `copyWith(fontFamilyFallback: null)` leaves the style's fallback untouched.
  static List<String>? get _arabic =>
      arabicFallbackEnabled ? <String>[GoogleFonts.cairo().fontFamily!] : null;

  /// Hero headline. Base desktop size; the hero applies a fluid clamp(48→88).
  static TextStyle get displayHero => GoogleFonts.spaceGrotesk(
    fontSize: 64.sp,
    fontWeight: FontWeight.w600,
    height: 1.02,
    letterSpacing: -1.5,
  ).copyWith(fontFamilyFallback: _arabic);

  static TextStyle get displaySection => GoogleFonts.spaceGrotesk(
    fontSize: 36.sp,
    fontWeight: FontWeight.w600,
    height: 1.1,
    letterSpacing: -0.5,
  ).copyWith(fontFamilyFallback: _arabic);

  static TextStyle get title => GoogleFonts.spaceGrotesk(
    fontSize: 22.sp,
    fontWeight: FontWeight.w600,
    height: 1.25,
    letterSpacing: -0.2,
  ).copyWith(fontFamilyFallback: _arabic);

  static TextStyle get eyebrowMono => GoogleFonts.jetBrainsMono(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.5,
  ).copyWith(fontFamilyFallback: _arabic);

  static TextStyle get body => GoogleFonts.inter(
    fontSize: 17.sp,
    fontWeight: FontWeight.w400,
    height: 1.65,
  ).copyWith(fontFamilyFallback: _arabic);

  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    height: 1.55,
  ).copyWith(fontFamilyFallback: _arabic);

  static TextStyle get label => GoogleFonts.inter(
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.3,
  ).copyWith(fontFamilyFallback: _arabic);

  static TextStyle get folioMono => GoogleFonts.jetBrainsMono(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.5,
  ).copyWith(fontFamilyFallback: _arabic);

  static TextStyle get captionMono => GoogleFonts.jetBrainsMono(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 1.4,
  ).copyWith(fontFamilyFallback: _arabic);
}

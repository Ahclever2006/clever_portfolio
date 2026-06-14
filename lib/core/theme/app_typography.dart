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

  /// Arabic fallback family (loaded via google_fonts).
  static final List<String> _arabic = <String>[GoogleFonts.cairo().fontFamily!];

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

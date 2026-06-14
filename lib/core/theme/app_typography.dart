import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Named text styles — the type scale from plan.md §3.2.
///
/// This file is the typography source (exempt from the design-token gate). Sizes
/// use `.sp` (flutter_screenutil) for responsive scaling.
///
/// Fonts: Space Grotesk (display) · Inter (body) · JetBrains Mono (engineer
/// signal). Arabic face chosen: **Cairo** (`GoogleFonts.cairo`), wired per-locale
/// in `AppTextTheme` in M4.
abstract final class AppTypography {
  const AppTypography._();

  /// Hero headline. Base desktop size; M5 adds the fluid clamp(48→88).
  static TextStyle get displayHero => GoogleFonts.spaceGrotesk(
    fontSize: 64.sp,
    fontWeight: FontWeight.w600,
    height: 1.02,
    letterSpacing: -1.5,
  );

  static TextStyle get displaySection => GoogleFonts.spaceGrotesk(
    fontSize: 36.sp,
    fontWeight: FontWeight.w600,
    height: 1.1,
    letterSpacing: -0.5,
  );

  static TextStyle get title => GoogleFonts.spaceGrotesk(
    fontSize: 22.sp,
    fontWeight: FontWeight.w600,
    height: 1.25,
    letterSpacing: -0.2,
  );

  static TextStyle get eyebrowMono => GoogleFonts.jetBrainsMono(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.5,
  );

  static TextStyle get body => GoogleFonts.inter(
    fontSize: 17.sp,
    fontWeight: FontWeight.w400,
    height: 1.65,
  );

  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    height: 1.55,
  );

  static TextStyle get label => GoogleFonts.inter(
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.3,
  );

  static TextStyle get folioMono => GoogleFonts.jetBrainsMono(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.5,
  );

  static TextStyle get captionMono => GoogleFonts.jetBrainsMono(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );
}

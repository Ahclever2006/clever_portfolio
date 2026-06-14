import 'package:flutter/material.dart';

/// Raw brand color tokens — the single source of hex values (plan.md §3.1).
///
/// Widgets must NOT reference these directly: they consume `colorScheme` and
/// the token ThemeExtensions (`BrandColors`, `CategoryColors`) built from these.
/// The theme layer is the only place raw hex is allowed.
abstract final class AppColors {
  const AppColors._();

  // ───────────────────────── Light (#F7F8FA canvas) ─────────────────────────
  static const Color lBackground = Color(0xFFF7F8FA);
  static const Color lOnBackground = Color(0xFF0B0F14);
  static const Color lSurface = Color(0xFFFFFFFF);
  static const Color lOnSurface = Color(0xFF1A2129);
  static const Color lSurfaceVariant = Color(0xFFEEF1F4);
  static const Color lSurfaceElevated = Color(0xFFFFFFFF);
  static const Color lMuted = Color(0xFF5B6571);
  static const Color lOutline = Color(0xFFD7DCE2);
  static const Color lOutlineStrong = Color(0xFFBCC4CD);
  static const Color lPrimary = Color(0xFF0E8F6E);
  static const Color lPrimaryHover = Color(0xFF0B7559);
  static const Color lPrimaryPressed = Color(0xFF095F49);
  static const Color lOnPrimary = Color(0xFFFFFFFF);
  static const Color lSecondary = Color(0xFF1F6FEB);
  static const Color lAccent = Color(0xFF0E8F6E);
  static const Color lAccentSoft = Color(0xFFD6F2E8);
  static const Color lFocusRing = Color(0xFF0E8F6E);
  static const Color lSuccess = Color(0xFF0E8F6E);
  static const Color lWarning = Color(0xFFB7791F);
  static const Color lDanger = Color(0xFFC13C37);
  static const Color lGlassTint = Color(0xCCFFFFFF); // #FFFFFFCC
  static const Color lGlow = Color(0x00000000); // no glow in light
  static const Color lCodeText = Color(0xFF3A4452);
  static const Color lFolio = Color(0xFF9AA4B0);

  // ───────────────────────── Dark (#0A0C10 canvas, default) ─────────────────
  static const Color dBackground = Color(0xFF0A0C10);
  static const Color dOnBackground = Color(0xFFE6EDF3);
  static const Color dSurface = Color(0xFF10141A);
  static const Color dOnSurface = Color(0xFFC9D1D9);
  static const Color dSurfaceVariant = Color(0xFF161B22);
  static const Color dSurfaceElevated = Color(0xFF1B222B);
  static const Color dMuted = Color(0xFF8B97A5);
  static const Color dOutline = Color(0xFF222A33);
  static const Color dOutlineStrong = Color(0xFF303A45);
  static const Color dPrimary = Color(0xFF3DF5A3);
  static const Color dPrimaryHover = Color(0xFF56FFB4);
  static const Color dPrimaryPressed = Color(0xFF2BD98C);
  static const Color dOnPrimary = Color(0xFF04130C);
  static const Color dSecondary = Color(0xFF5AA2FF);
  static const Color dAccent = Color(0xFF3DF5A3);
  static const Color dAccentSoft = Color(0xFF0F2A20);
  static const Color dFocusRing = Color(0xFF3DF5A3);
  static const Color dSuccess = Color(0xFF3DF5A3);
  static const Color dWarning = Color(0xFFE3B341);
  static const Color dDanger = Color(0xFFFF6B6B);
  static const Color dGlassTint = Color(0xCC10141A); // #10141ACC
  static const Color dGlow = Color(0x403DF5A3); // #3DF5A340
  static const Color dCodeText = Color(0xFF7EE3B8);
  static const Color dFolio = Color(0xFF5A6470);

  // ───────────────────────── Category hues (light, ~4.5:1 on #FFFFFF) ────────
  static const Color lCatEcommerce = Color(0xFF0E8F6E);
  static const Color lCatGames = Color(0xFFC2410C);
  static const Color lCatBooking = Color(0xFF0E7490);
  static const Color lCatBusiness = Color(0xFF1F6FEB);
  static const Color lCatFood = Color(0xFFB45309);
  static const Color lCatServices = Color(0xFF2563EB);
  static const Color lCatMedical = Color(0xFF0D9488);
  static const Color lCatEducation = Color(0xFF6D28D9);
  static const Color lCatTravel = Color(0xFF0891B2);

  // ───────────────────────── Category hues (dark, on #10141A) ────────────────
  static const Color dCatEcommerce = Color(0xFF3DF5A3);
  static const Color dCatGames = Color(0xFFFB923C);
  static const Color dCatBooking = Color(0xFF22D3EE);
  static const Color dCatBusiness = Color(0xFF5AA2FF);
  static const Color dCatFood = Color(0xFFFBBF24);
  static const Color dCatServices = Color(0xFF60A5FA);
  static const Color dCatMedical = Color(0xFF2DD4BF);
  static const Color dCatEducation = Color(0xFFA78BFA);
  static const Color dCatTravel = Color(0xFF38BDF8);
}

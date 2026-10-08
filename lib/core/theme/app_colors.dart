import 'package:flutter/material.dart';

/// Celebration Luxe Design System Color Tokens
class AppColors {
  // Brand & Primary Interactive Tones
  static const Color primary = Color(0xFF903F00);
  static const Color primaryContainer = Color(0xFFB45309);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFFFFF1EB);
  static const Color deepAmber = Color(0xFFB45309);
  static const Color radiantGold = Color(0xFFD97706);
  static const Color sunlitAmber = Color(0xFFF59E0B);
  static const Color amberLight = Color(0xFFFEF3C7);

  // Secondary
  static const Color secondary = Color(0xFF904D00);
  static const Color secondaryContainer = Color(0xFFFE932C);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSecondaryContainer = Color(0xFF663500);

  // Trust, Verification & Success (Emerald Sage)
  static const Color tertiary = Color(0xFF006444);
  static const Color emeraldSage = Color(0xFF059669);
  static const Color emeraldSageLight = Color(0xFFECFDF5);
  static const Color tertiaryContainer = Color(0xFF007F58);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color onTertiaryContainer = Color(0xFFCCFFE3);

  // Surfaces & Backgrounds
  static const Color background = Color(0xFFFBF8FC);
  static const Color warmIvory = Color(0xFFFDFBF7);
  static const Color alabasterVeil = Color(0xFFF8F5EE);
  static const Color surface = Color(0xFFFBF8FC);
  static const Color surfaceDim = Color(0xFFDCD9DD);
  static const Color surfaceBright = Color(0xFFFBF8FC);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF6F2F7);
  static const Color surfaceContainer = Color(0xFFF0EDF1);
  static const Color surfaceContainerHigh = Color(0xFFEAE7EB);
  static const Color surfaceContainerHighest = Color(0xFFE4E1E6);
  static const Color surfaceVariant = Color(0xFFE4E1E6);

  // Typography & Neutrals
  static const Color onSurface = Color(0xFF1B1B1E);
  static const Color onSurfaceVariant = Color(0xFF564338);
  static const Color obsidianCharcoal = Color(0xFF18181B);
  static const Color midnightSlate = Color(0xFF27272A);
  static const Color mutedStone = Color(0xFF71717A);
  static const Color outline = Color(0xFF897267);
  static const Color outlineVariant = Color(0xFFDDC1B3);
  static const Color warmLinen = Color(0xFFEFECE6);

  // Inverse Surfaces
  static const Color inverseSurface = Color(0xFF303033);
  static const Color inverseOnSurface = Color(0xFFF3F0F4);
  static const Color inversePrimary = Color(0xFFFFB68E);

  // Error
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  // Elevation Glow Shadows
  static const BoxShadow cardRestShadow = BoxShadow(
    color: Color.fromRGBO(24, 24, 27, 0.04),
    offset: Offset(0, 2),
    blurRadius: 8,
    spreadRadius: -1,
  );

  static const BoxShadow cardAmberGlow = BoxShadow(
    color: Color.fromRGBO(180, 83, 9, 0.03),
    offset: Offset(0, 1),
    blurRadius: 3,
    spreadRadius: 0,
  );

  static const BoxShadow elevatedSheetShadow = BoxShadow(
    color: Color.fromRGBO(24, 24, 27, 0.12),
    offset: Offset(0, 16),
    blurRadius: 36,
    spreadRadius: -4,
  );

  static const BoxShadow floatingInteractiveShadow = BoxShadow(
    color: Color.fromRGBO(24, 24, 27, 0.07),
    offset: Offset(0, 8),
    blurRadius: 20,
    spreadRadius: -3,
  );
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Celebration Luxe Design System Typography
class AppTypography {
  // Display & Editorial Headers (Noto Serif)
  static TextStyle displayLarge = GoogleFonts.notoSerif(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    height: 1.22,
    letterSpacing: -0.5,
    color: AppColors.obsidianCharcoal,
  );

  static TextStyle displayMobile = GoogleFonts.notoSerif(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 1.25,
    letterSpacing: -0.3,
    color: AppColors.obsidianCharcoal,
  );

  static TextStyle headlineLarge = GoogleFonts.notoSerif(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: -0.3,
    color: AppColors.obsidianCharcoal,
  );

  static TextStyle headlineMedium = GoogleFonts.notoSerif(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.35,
    color: AppColors.obsidianCharcoal,
  );

  // Modern Functional UI & Body (Plus Jakarta Sans)
  static TextStyle headlineSmall = GoogleFonts.plusJakartaSans(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.4,
    letterSpacing: -0.2,
    color: AppColors.obsidianCharcoal,
  );

  static TextStyle titleMedium = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.45,
    color: AppColors.midnightSlate,
  );

  static TextStyle titleSmall = GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.midnightSlate,
  );

  static TextStyle bodyLarge = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.midnightSlate,
  );

  static TextStyle bodyMedium = GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.onSurfaceVariant,
  );

  static TextStyle bodySmall = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.mutedStone,
  );

  static TextStyle labelLarge = GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: 0.1,
    color: AppColors.obsidianCharcoal,
  );

  static TextStyle labelMedium = GoogleFonts.plusJakartaSans(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    height: 1.35,
    letterSpacing: 0.15,
    color: AppColors.obsidianCharcoal,
  );

  static TextStyle labelSmall = GoogleFonts.plusJakartaSans(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.4,
    color: AppColors.mutedStone,
  );

  // Currency & Tabular Numeric
  static TextStyle priceDisplay = GoogleFonts.plusJakartaSans(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.deepAmber,
  );

  static TextStyle priceCard = GoogleFonts.plusJakartaSans(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.deepAmber,
  );
}

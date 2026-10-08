import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class HeroBanner extends StatelessWidget {
  final VoidCallback onExplorePressed;

  const HeroBanner({
    super.key,
    required this.onExplorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2C1605),
            Color(0xFF532402),
            Color(0xFF903F00),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            offset: const Offset(0, 8),
            blurRadius: 20,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sub-heading tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.sunlitAmber.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(
                  color: AppColors.sunlitAmber.withValues(alpha: 0.5)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.auto_awesome,
                    size: 13, color: AppColors.sunlitAmber),
                const SizedBox(width: 5),
                Text(
                  'CURATED CELEBRATION LUXE',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.sunlitAmber,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Main editorial title
          Text(
            'Orchestrate Extraordinary\nMilestones & Galas',
            style: AppTypography.displayMobile.copyWith(
              color: Colors.white,
              fontSize: 22,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 8),

          // Subtitle
          Text(
            'Discover verified master photographers, Michelin-grade catering, and private estate venues with 100% escrow protection.',
            style: AppTypography.bodySmall.copyWith(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 13,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 16),

          // CTA button
          InkWell(
            onTap: onExplorePressed,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                  )
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Explore Collections',
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.obsidianCharcoal,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.arrow_forward,
                      size: 15, color: AppColors.obsidianCharcoal),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

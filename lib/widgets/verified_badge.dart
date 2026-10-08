import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

class VerifiedBadge extends StatelessWidget {
  final String text;
  final bool showIcon;
  final bool isCompact;

  const VerifiedBadge({
    super.key,
    this.text = 'Verified Partner',
    this.showIcon = true,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 6 : 8,
        vertical: isCompact ? 2 : 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.emeraldSageLight,
        borderRadius: BorderRadius.circular(9999),
        border: Border.all(
          color: AppColors.emeraldSage.withValues(alpha: 0.3),
          width: 0.8,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            const Icon(
              Icons.verified,
              size: 13,
              color: AppColors.emeraldSage,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.emeraldSage,
              fontWeight: FontWeight.w700,
              fontSize: isCompact ? 10 : 11,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class RatingBadge extends StatelessWidget {
  final double rating;
  final int? reviewsCount;
  final bool isCompact;

  const RatingBadge({
    super.key,
    required this.rating,
    this.reviewsCount,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.star_rounded,
          size: 16,
          color: AppColors.sunlitAmber,
        ),
        const SizedBox(width: 3),
        Text(
          rating.toStringAsFixed(2),
          style: AppTypography.labelMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.obsidianCharcoal,
            fontSize: isCompact ? 12 : 13,
          ),
        ),
        if (reviewsCount != null) ...[
          const SizedBox(width: 2),
          Text(
            ' ($reviewsCount)',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.mutedStone,
              fontSize: isCompact ? 11 : 12,
            ),
          ),
        ],
      ],
    );
  }
}

class LuxeBadge extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;

  const LuxeBadge({
    super.key,
    required this.text,
    this.backgroundColor = AppColors.amberLight,
    this.textColor = AppColors.deepAmber,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: AppTypography.labelSmall.copyWith(
              color: textColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

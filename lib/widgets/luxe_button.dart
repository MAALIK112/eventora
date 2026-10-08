import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

enum LuxeButtonVariant { primary, secondary, outline, ghost }

class LuxeButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final LuxeButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final double height;
  final double? width;

  const LuxeButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = LuxeButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.height = 48,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    if (variant == LuxeButtonVariant.primary) {
      return SizedBox(
        width: width ?? double.infinity,
        height: height,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.deepAmber,
            foregroundColor: AppColors.onPrimary,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: _buildChild(AppColors.onPrimary),
        ),
      );
    } else if (variant == LuxeButtonVariant.outline || variant == LuxeButtonVariant.secondary) {
      return SizedBox(
        width: width ?? double.infinity,
        height: height,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: AppColors.surfaceContainerLowest,
            foregroundColor: AppColors.obsidianCharcoal,
            side: const BorderSide(color: AppColors.warmLinen, width: 1.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: _buildChild(AppColors.obsidianCharcoal),
        ),
      );
    } else {
      // Ghost
      return SizedBox(
        width: width,
        height: height,
        child: TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.deepAmber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: _buildChild(AppColors.deepAmber),
        ),
      );
    }
  }

  Widget _buildChild(Color textColor) {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: textColor),
          const SizedBox(width: 8),
          Text(
            text,
            style: AppTypography.labelLarge.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    }

    return Text(
      text,
      style: AppTypography.labelLarge.copyWith(
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

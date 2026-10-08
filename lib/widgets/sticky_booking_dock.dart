import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/utils/currency_formatter.dart';
import 'luxe_button.dart';

class StickyBookingDock extends StatelessWidget {
  final double price;
  final String priceSubtitle;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final IconData? buttonIcon;
  final bool isSecondaryActionAvailable;
  final VoidCallback? onSecondaryAction;
  final IconData? secondaryIcon;

  const StickyBookingDock({
    super.key,
    required this.price,
    this.priceSubtitle = 'Total estimated',
    this.buttonText = 'Reserve Date',
    required this.onButtonPressed,
    this.buttonIcon = Icons.calendar_today_outlined,
    this.isSecondaryActionAvailable = false,
    this.onSecondaryAction,
    this.secondaryIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 14,
        bottom: MediaQuery.of(context).padding.bottom + 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.96),
        border: const Border(
          top: BorderSide(color: AppColors.warmLinen, width: 1),
        ),
        boxShadow: const [
          AppColors.elevatedSheetShadow,
        ],
      ),
      child: Row(
        children: [
          // Pricing Breakdown Summary on Left
          Expanded(
            flex: 4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  priceSubtitle.toUpperCase(),
                  style: AppTypography.labelSmall.copyWith(
                    fontSize: 10,
                    letterSpacing: 0.5,
                    color: AppColors.mutedStone,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      CurrencyFormatter.format(price),
                      style: AppTypography.priceDisplay.copyWith(fontSize: 20),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'USD',
                      style: AppTypography.bodySmall.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.mutedStone,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          if (isSecondaryActionAvailable && onSecondaryAction != null) ...[
            IconButton(
              icon: Icon(secondaryIcon ?? Icons.chat_bubble_outline,
                  color: AppColors.obsidianCharcoal),
              onPressed: onSecondaryAction,
              style: IconButton.styleFrom(
                backgroundColor: AppColors.alabasterVeil,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: AppColors.warmLinen),
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],

          // Primary Book Action on Right
          Expanded(
            flex: 5,
            child: LuxeButton(
              text: buttonText,
              icon: buttonIcon,
              onPressed: onButtonPressed,
              height: 46,
            ),
          ),
        ],
      ),
    );
  }
}

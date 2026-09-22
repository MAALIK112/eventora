import 'package:flutter/material.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_typography.dart';
import 'package:eventora/styles/app_spacing.dart';
import 'package:eventora/widgets/eventora_button.dart';
import 'package:eventora/routes/app_router.dart';

class OrderConfirmationPage extends StatelessWidget {
  const OrderConfirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppColors.canvasBase,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.marginMobile),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.successGreen.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check_circle, color: AppColors.successGreen, size: 60),
                ),
                const SizedBox(height: 24),
                Text('Booking Confirmed!', style: AppTypography.headlineLG),
                const SizedBox(height: 8),
                Text(
                  'Your booking has been successfully placed',
                  style: AppTypography.bodyMD.copyWith(color: AppColors.mutedText),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Card(
                  elevation: 0,
                  color: AppColors.surfaceContainerLowest,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text('Booking ID', style: AppTypography.bodyMD.copyWith(color: AppColors.mutedText)),
                        const SizedBox(height: 4),
                        Text('#EVT-8924-XYZ', style: AppTypography.labelLG),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Service', style: AppTypography.bodyMD.copyWith(color: AppColors.mutedText)),
                            Text('Wedding Package', style: AppTypography.labelMD),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Date', style: AppTypography.bodyMD.copyWith(color: AppColors.mutedText)),
                            Text('Oct 24, 2023', style: AppTypography.labelMD),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total', style: AppTypography.bodyMD.copyWith(color: AppColors.mutedText)),
                            Text('\$550.00', style: AppTypography.labelMD.copyWith(color: AppColors.primary)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                EventoraButton(
                  text: 'View Booking',
                  isFullWidth: true,
                  onPressed: () => Navigator.pushReplacementNamed(context, AppRouter.bookingDetail, arguments: 'EVT-8924-XYZ'),
                ),
                const SizedBox(height: 16),
                EventoraButton(
                  text: 'Back to Home',
                  isFullWidth: true,
                  isOutlined: true,
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(context, AppRouter.mainShell, (route) => false),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

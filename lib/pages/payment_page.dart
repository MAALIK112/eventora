import 'package:flutter/material.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_typography.dart';
import 'package:eventora/styles/app_spacing.dart';
import 'package:eventora/widgets/custom_app_bar.dart';
import 'package:eventora/widgets/eventora_text_field.dart';
import 'package:eventora/widgets/eventora_button.dart';
import 'package:eventora/widgets/price_breakdown.dart';
import 'package:eventora/routes/app_router.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _isProcessing = false;

  void _processPayment() {
    setState(() => _isProcessing = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isProcessing = false);
        Navigator.pushNamed(context, AppRouter.orderConfirmation);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasBase,
      appBar: const CustomAppBar(title: 'Payment'),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.marginMobile),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Card Details', style: AppTypography.headlineSM),
                const SizedBox(height: 16),
                const EventoraTextField(
                  label: 'Card Number',
                  hint: '0000 0000 0000 0000',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Expanded(
                      child: EventoraTextField(
                        label: 'Expiry Date',
                        hint: 'MM/YY',
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: EventoraTextField(
                        label: 'CVV',
                        hint: '123',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const EventoraTextField(
                  label: 'Cardholder Name',
                  hint: 'John Doe',
                ),
                const Divider(height: 32),
                Text('Billing Address', style: AppTypography.headlineSM),
                const SizedBox(height: 16),
                const EventoraTextField(
                  label: 'Address',
                  hint: '123 Main St',
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Expanded(
                      child: EventoraTextField(
                        label: 'City',
                        hint: 'New York',
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: EventoraTextField(
                        label: 'Zip Code',
                        hint: '10001',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 32),
                Text('Promo Code', style: AppTypography.headlineSM),
                const SizedBox(height: 16),
                EventoraTextField(
                  hint: 'Enter code',
                  suffixIcon: TextButton(
                    onPressed: () {},
                    child: Text('Apply',
                        style: AppTypography.labelMD
                            .copyWith(color: AppColors.primary)),
                  ),
                ),
                const Divider(height: 32),
                Card(
                  elevation: 0,
                  color: AppColors.surfaceContainerLowest,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Order Summary', style: AppTypography.labelLG),
                        const SizedBox(height: 8),
                        Text('Premium Wedding Package',
                            style: AppTypography.bodyMD),
                        Text('Oct 24, 2023',
                            style: AppTypography.bodySM
                                .copyWith(color: AppColors.mutedText)),
                        const SizedBox(height: 16),
                        const PriceBreakdown(
                          items: [
                            PriceItem(
                                name: 'Premium Wedding Package', price: 500),
                          ],
                          tax: 50,
                          total: 550,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                EventoraButton(
                  text: 'Complete Payment',
                  isFullWidth: true,
                  onPressed: _processPayment,
                ),
              ],
            ),
          ),
          if (_isProcessing)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            ),
        ],
      ),
    );
  }
}

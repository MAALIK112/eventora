import 'package:flutter/material.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_typography.dart';
import 'package:eventora/styles/app_spacing.dart';
import 'package:eventora/widgets/custom_app_bar.dart';
import 'package:eventora/widgets/custom_button.dart';
import 'package:eventora/widgets/price_breakdown.dart';
import 'package:eventora/widgets/payment_method_tile.dart';
import 'package:eventora/routes/app_router.dart';

class BookingConfirmationPage extends StatefulWidget {
  const BookingConfirmationPage({super.key});

  @override
  State<BookingConfirmationPage> createState() =>
      _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<BookingConfirmationPage> {
  int quantity = 1;
  final double basePrice = 500.0;
  String selectedPaymentMethod = 'Card';

  @override
  Widget build(BuildContext context) {
    final subtotal = basePrice * quantity;
    final tax = subtotal * 0.1;
    final total = subtotal + tax;

    return Scaffold(
      backgroundColor: AppColors.canvasBase,
      appBar: const CustomAppBar(title: 'Confirm Booking'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.marginMobile),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 160,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(height: 16),
            Text('Premium Wedding Package', style: AppTypography.headlineMD),
            Text('Oct 24, 2023',
                style:
                    AppTypography.bodyMD.copyWith(color: AppColors.mutedText)),
            const Divider(height: 32),
            Text('Selected Services', style: AppTypography.headlineSM),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Wedding Package x$quantity', style: AppTypography.bodyLG),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        if (quantity > 1) setState(() => quantity--);
                      },
                    ),
                    Text('$quantity', style: AppTypography.labelLG),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () => setState(() => quantity++),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(height: 32),
            PriceBreakdown(
              items: const [
                PriceItem(name: 'Wedding Package', price: 500.0),
              ],
              tax: tax,
              total: total,
            ),
            const Divider(height: 32),
            Text('Payment Method', style: AppTypography.headlineSM),
            const SizedBox(height: 16),
            PaymentMethodTile(
              name: 'Credit/Debit Card',
              icon: Icons.credit_card,
              isSelected: selectedPaymentMethod == 'Card',
              onTap: () => setState(() => selectedPaymentMethod = 'Card'),
            ),
            PaymentMethodTile(
              name: 'PayPal',
              icon: Icons.account_balance_wallet,
              isSelected: selectedPaymentMethod == 'PayPal',
              onTap: () => setState(() => selectedPaymentMethod = 'PayPal'),
            ),
            PaymentMethodTile(
              name: 'Cash on Delivery',
              icon: Icons.money,
              isSelected: selectedPaymentMethod == 'Cash',
              onTap: () => setState(() => selectedPaymentMethod = 'Cash'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.marginMobile),
          child: EventoraButton(
            text: 'Proceed to Pay',
            isFullWidth: true,
            onPressed: () => Navigator.pushNamed(context, AppRouter.payment),
          ),
        ),
      ),
    );
  }
}

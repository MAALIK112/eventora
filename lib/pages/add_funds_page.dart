import 'package:flutter/material.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_typography.dart';
import 'package:eventora/styles/app_spacing.dart';
import 'package:eventora/widgets/custom_app_bar.dart';
import 'package:eventora/widgets/payment_method_tile.dart';
import 'package:eventora/widgets/custom_button.dart';

class AddFundsPage extends StatefulWidget {
  const AddFundsPage({super.key});

  @override
  State<AddFundsPage> createState() => _AddFundsPageState();
}

class _AddFundsPageState extends State<AddFundsPage> {
  final TextEditingController _amountController = TextEditingController();
  String selectedPaymentMethod = 'Card';

  void _setAmount(String amount) {
    _amountController.text = amount;
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasBase,
      appBar: const CustomAppBar(title: 'Add Funds'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.marginMobile),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            TextField(
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.center,
              style: AppTypography.headlineXLMobile,
              decoration: InputDecoration(
                prefixText: '\$',
                prefixStyle: AppTypography.headlineXLMobile,
                border: InputBorder.none,
                hintText: '0.00',
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildQuickAmount('50'),
                _buildQuickAmount('100'),
                _buildQuickAmount('250'),
                _buildQuickAmount('500'),
              ],
            ),
            const Divider(height: 48),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Payment Method', style: AppTypography.headlineSM),
            ),
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
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.marginMobile),
          child: EventoraButton(
            text: 'Add Funds',
            isFullWidth: true,
            onPressed: () {
              // Handle adding funds
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAmount(String amount) {
    return ActionChip(
      label: Text('\$$amount'),
      labelStyle: AppTypography.labelMD.copyWith(color: AppColors.primary),
      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      side: BorderSide.none,
      onPressed: () => _setAmount(amount),
    );
  }
}

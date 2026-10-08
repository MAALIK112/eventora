import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/currency_formatter.dart';
import '../../providers/wallet_provider.dart';
import '../../widgets/luxe_button.dart';

class TopUpModal extends StatefulWidget {
  const TopUpModal({super.key});

  @override
  State<TopUpModal> createState() => _TopUpModalState();
}

class _TopUpModalState extends State<TopUpModal> {
  final TextEditingController _amountController = TextEditingController(text: '1000');
  String _selectedFunding = 'Apple Pay';

  final List<double> _presetAmounts = [500, 1000, 2500, 5000];

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _confirmTopUp() {
    final amount = double.tryParse(_amountController.text.replaceAll(',', '')) ?? 0.0;
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid top-up amount')),
      );
      return;
    }

    context.read<WalletProvider>().topUpWallet(
          amount: amount,
          fundingSource: _selectedFunding,
        );

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Successfully deposited ${CurrencyFormatter.format(amount)} to your Luxe Wallet!'),
        backgroundColor: AppColors.emeraldSage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.surfaceDim,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          Text(
            'Deposit Funds to Escrow Wallet',
            style: AppTypography.headlineMedium.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 4),
          Text(
            'Instant reload for uninterrupted luxury bookings and escrow holds.',
            style: AppTypography.bodySmall,
          ),
          const SizedBox(height: 16),

          // Quick preset buttons
          Row(
            children: _presetAmounts.map((amt) {
              final isCurrent = _amountController.text == amt.toInt().toString();
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _amountController.text = amt.toInt().toString();
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: isCurrent ? AppColors.deepAmber : AppColors.alabasterVeil,
                      foregroundColor: isCurrent ? Colors.white : AppColors.obsidianCharcoal,
                      side: BorderSide(
                        color: isCurrent ? AppColors.deepAmber : AppColors.warmLinen,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      minimumSize: const Size(0, 36),
                    ),
                    child: Text(
                      CurrencyFormatter.format(amt),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: isCurrent ? Colors.white : AppColors.obsidianCharcoal,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // Custom amount input
          Text(
            'Deposit Amount (USD)',
            style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            style: AppTypography.priceDisplay,
            decoration: const InputDecoration(
              prefixText: '\$ ',
              prefixStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.deepAmber,
              ),
              hintText: '0',
            ),
          ),
          const SizedBox(height: 16),

          // Source selection
          Text(
            'Funding Source',
            style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: ['Apple Pay', 'Amex Platinum (•••• 4018)', 'Chase Wire'].map((source) {
              final isSelected = _selectedFunding == source;
              return ChoiceChip(
                label: Text(source),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) setState(() => _selectedFunding = source);
                },
                selectedColor: AppColors.obsidianCharcoal,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 12,
                ),
                backgroundColor: AppColors.alabasterVeil,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9999),
                  side: const BorderSide(color: AppColors.warmLinen),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          LuxeButton(
            text: 'Authorize Instant Deposit',
            icon: Icons.bolt,
            onPressed: _confirmTopUp,
          ),
        ],
      ),
    );
  }
}

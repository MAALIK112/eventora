import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../models/wallet_model.dart';
import '../../../providers/booking_provider.dart';
import '../../../providers/wallet_provider.dart';
import '../../../widgets/luxe_card.dart';

class Step4PaymentMethod extends StatefulWidget {
  const Step4PaymentMethod({super.key});

  @override
  State<Step4PaymentMethod> createState() => _Step4PaymentMethodState();
}

class _Step4PaymentMethodState extends State<Step4PaymentMethod> {
  final TextEditingController _couponController = TextEditingController();
  String _couponFeedback = '';

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  void _applyPromoCode() {
    final booking = context.read<BookingProvider>();
    final success = booking.applyCoupon(_couponController.text);
    setState(() {
      if (success) {
        _couponFeedback =
            'Promo code applied: \$100 Luxe celebration credit deducted!';
      } else {
        _couponFeedback = 'Invalid code. Try LUXE100 or EVENTORA2026.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingProvider>();
    final wallet = context.watch<WalletProvider>();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment & Escrow Lock',
            style: AppTypography.headlineMedium.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 4),
          Text(
            'Choose how you wish to fund your reservation. 100% held in protected escrow until event completion.',
            style: AppTypography.bodySmall,
          ),
          const SizedBox(height: 20),

          // Payment Methods List
          Text(
            'Select Payment Instrument',
            style:
                AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),

          Column(
            children: wallet.paymentMethods.map((pm) {
              final isSelected = booking.draftPaymentMethod == pm.title;
              final isWallet = pm.type == PaymentMethodType.wallet;

              return GestureDetector(
                onTap: () => booking.setDraftPaymentMethod(pm.title),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.amberLight.withValues(alpha: 0.3)
                        : AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.deepAmber
                          : AppColors.warmLinen,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        color: isSelected
                            ? AppColors.deepAmber
                            : AppColors.mutedStone,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.alabasterVeil,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          isWallet
                              ? Icons.account_balance_wallet
                              : (pm.type == PaymentMethodType.applePay
                                  ? Icons.apple
                                  : Icons.credit_card),
                          color: AppColors.obsidianCharcoal,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pm.title,
                              style: AppTypography.titleSmall
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                            Text(
                              isWallet
                                  ? 'Available: ${CurrencyFormatter.format(wallet.balance)}'
                                  : pm.subtitle,
                              style: AppTypography.bodySmall.copyWith(
                                color: isWallet
                                    ? AppColors.emeraldSage
                                    : AppColors.mutedStone,
                                fontWeight: isWallet
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          // Promo / Privilege Code
          Text(
            'VIP Privilege Code / Voucher',
            style:
                AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _couponController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                    hintText: 'Enter code (e.g. LUXE100)',
                    prefixIcon:
                        Icon(Icons.card_giftcard, color: AppColors.deepAmber),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _applyPromoCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.obsidianCharcoal,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(88, 48),
                ),
                child: const Text('Apply'),
              ),
            ],
          ),
          if (_couponFeedback.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              _couponFeedback,
              style: AppTypography.bodySmall.copyWith(
                color: booking.draftDiscount > 0
                    ? AppColors.emeraldSage
                    : AppColors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          const SizedBox(height: 20),

          // Escrow & Insurance Guarantee toggle
          LuxeCard(
            padding: const EdgeInsets.all(14),
            backgroundColor: AppColors.emeraldSageLight,
            child: Row(
              children: [
                const Icon(Icons.verified_user_outlined,
                    color: AppColors.emeraldSage, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Eventora 100% Escrow Protection',
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.emeraldSage,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Payment remains securely locked until celebration signoff.',
                        style: AppTypography.bodySmall.copyWith(fontSize: 11),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: booking.draftInsuranceSelected,
                  activeThumbColor: AppColors.emeraldSage,
                  onChanged: (val) => booking.toggleDraftInsurance(val),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

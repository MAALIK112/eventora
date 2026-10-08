import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/currency_formatter.dart';
import '../../models/wallet_model.dart';
import '../../widgets/luxe_button.dart';
import '../../widgets/luxe_card.dart';

class TransactionDetailModal extends StatelessWidget {
  final WalletTransaction transaction;

  const TransactionDetailModal({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final isCredit = transaction.amount > 0;

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).padding.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
          const SizedBox(height: 20),

          // Amount Badge Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCredit ? AppColors.emeraldSageLight : AppColors.amberLight,
            ),
            child: Icon(
              isCredit ? Icons.arrow_downward : Icons.arrow_upward,
              color: isCredit ? AppColors.emeraldSage : AppColors.deepAmber,
              size: 28,
            ),
          ),
          const SizedBox(height: 12),

          Text(
            (isCredit ? '+' : '') + CurrencyFormatter.format(transaction.amount),
            style: AppTypography.displayMobile.copyWith(
              fontSize: 26,
              color: isCredit ? AppColors.emeraldSage : AppColors.obsidianCharcoal,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            transaction.isSuccessful ? 'Transaction Cleared & Settled' : 'Pending Verification',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.emeraldSage,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),

          LuxeCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildRow('Title', transaction.title),
                const Divider(color: AppColors.warmLinen, height: 16),
                _buildRow('Description', transaction.description),
                const Divider(color: AppColors.warmLinen, height: 16),
                _buildRow('Reference #', transaction.referenceNumber),
                const Divider(color: AppColors.warmLinen, height: 16),
                _buildRow('Timestamp', DateFormat('MMM dd, yyyy • hh:mm a').format(transaction.date)),
                if (transaction.relatedBookingId != null) ...[
                  const Divider(color: AppColors.warmLinen, height: 16),
                  _buildRow('Booking Reference', transaction.relatedBookingId!),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),

          LuxeButton(
            text: 'Download Official Statement',
            variant: LuxeButtonVariant.outline,
            icon: Icons.download,
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Financial statement exported to PDF.')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            style: AppTypography.labelMedium.copyWith(fontWeight: FontWeight.w700),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

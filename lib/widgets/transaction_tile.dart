import 'package:flutter/material.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_typography.dart';

enum TransactionType { credit, debit }

class TransactionTile extends StatelessWidget {
  final String description;
  final double amount;
  final TransactionType type;
  final DateTime date;

  const TransactionTile({
    Key? key,
    required this.description,
    required this.amount,
    required this.type,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isCredit = type == TransactionType.credit;
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.subtleDivider, width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: isCredit ? AppColors.emeraldTintBg : AppColors.errorContainer,
            child: Icon(
              isCredit ? Icons.arrow_upward : Icons.arrow_downward,
              color: isCredit ? AppColors.successGreen : AppColors.error,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(description, style: AppTypography.labelLG),
                const SizedBox(height: 4),
                Text(
                  '${date.day}/${date.month}/${date.year}',
                  style: AppTypography.bodySM.copyWith(color: AppColors.mutedText),
                ),
              ],
            ),
          ),
          Text(
            '${isCredit ? '+' : '-'}\$${amount.toStringAsFixed(2)}',
            style: AppTypography.labelLG.copyWith(
              color: isCredit ? AppColors.successGreen : AppColors.error,
            ),
          ),
        ],
      ),
    );
  }
}

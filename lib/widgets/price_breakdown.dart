import 'package:flutter/material.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_typography.dart';
import 'package:eventora/styles/app_spacing.dart';

class PriceItem {
  final String name;
  final double price;
  const PriceItem({required this.name, required this.price});
}

class PriceBreakdown extends StatelessWidget {
  final List<PriceItem> items;
  final double? tax;
  final double total;

  const PriceBreakdown({
    Key? key,
    required this.items,
    this.tax,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...items.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.name, style: AppTypography.bodyMD),
                  Text('\$${item.price.toStringAsFixed(2)}', style: AppTypography.bodyMD),
                ],
              ),
            )),
        const Divider(color: AppColors.subtleDivider, thickness: 1, height: 16),
        if (tax != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tax', style: AppTypography.bodyMD),
              Text('\$${tax!.toStringAsFixed(2)}', style: AppTypography.bodyMD),
            ],
          ),
          const Divider(color: AppColors.outlineVariant, thickness: 1.5, height: 24),
        ],
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColors.deepOnyx,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: AppTypography.headlineMD.copyWith(color: Colors.white),
              ),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: AppTypography.headlineMD.copyWith(color: AppColors.primary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

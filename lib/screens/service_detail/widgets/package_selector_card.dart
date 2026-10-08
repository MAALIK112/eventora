import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../models/service_model.dart';

class PackageSelectorCard extends StatelessWidget {
  final ServicePackage package;
  final bool isSelected;
  final VoidCallback onSelect;

  const PackageSelectorCard({
    super.key,
    required this.package,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.surfaceContainerLowest : AppColors.alabasterVeil,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.deepAmber : AppColors.warmLinen,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? const [
                  AppColors.floatingInteractiveShadow,
                  AppColors.cardAmberGlow,
                ]
              : const [AppColors.cardRestShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Tier, Popular tag and Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.deepAmber : AppColors.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        package.tier.toUpperCase(),
                        style: AppTypography.labelSmall.copyWith(
                          color: isSelected ? Colors.white : AppColors.obsidianCharcoal,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    if (package.isPopular) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.sunlitAmber,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'MOST POPULAR',
                          style: AppTypography.labelSmall.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 9,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  CurrencyFormatter.format(package.price),
                  style: AppTypography.priceCard.copyWith(
                    color: isSelected ? AppColors.deepAmber : AppColors.obsidianCharcoal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Package Title & Duration
            Text(
              package.name,
              style: AppTypography.headlineSmall.copyWith(fontSize: 17),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                const Icon(Icons.schedule, size: 13, color: AppColors.mutedStone),
                const SizedBox(width: 4),
                Text(
                  package.duration,
                  style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Description
            Text(
              package.description,
              style: AppTypography.bodyMedium,
            ),
            const SizedBox(height: 12),

            // Features Checklist
            Column(
              children: package.features.map((feature) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle, size: 15, color: AppColors.emeraldSage),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          feature,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),

            // Selection Radio / Button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.deepAmber : AppColors.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isSelected ? Icons.check : Icons.circle_outlined,
                        size: 14,
                        color: isSelected ? Colors.white : AppColors.mutedStone,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isSelected ? 'Selected Package' : 'Choose Package',
                        style: AppTypography.labelSmall.copyWith(
                          color: isSelected ? Colors.white : AppColors.obsidianCharcoal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

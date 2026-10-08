import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../providers/booking_provider.dart';
import '../../service_detail/widgets/package_selector_card.dart';

class Step1PackageAddons extends StatelessWidget {
  const Step1PackageAddons({super.key});

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingProvider>();
    final service = booking.draftService;

    if (service == null) {
      return const Center(child: Text('No service selected'));
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Confirm Service Tier',
            style: AppTypography.headlineMedium.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 4),
          Text(
            'Choose the package tier that best suits your guest size and timeline.',
            style: AppTypography.bodySmall,
          ),
          const SizedBox(height: 16),

          // Packages
          Column(
            children: service.packages.map((pkg) {
              final isSelected = booking.draftPackage?.id == pkg.id;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: PackageSelectorCard(
                  package: pkg,
                  isSelected: isSelected,
                  onSelect: () => booking.setDraftPackage(pkg),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          // Add-ons
          if (service.availableAddons.isNotEmpty) ...[
            Text(
              'Select Bespoke Add-ons',
              style: AppTypography.headlineMedium.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Column(
              children: service.availableAddons.map((addon) {
                final isAdded =
                    booking.draftAddons.any((a) => a.id == addon.id);
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isAdded
                        ? AppColors.amberLight.withValues(alpha: 0.3)
                        : AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:
                          isAdded ? AppColors.deepAmber : AppColors.warmLinen,
                    ),
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: isAdded,
                        activeColor: AppColors.deepAmber,
                        onChanged: (_) => booking.toggleDraftAddon(addon),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              addon.name,
                              style: AppTypography.titleSmall
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                            Text(
                              addon.description,
                              style: AppTypography.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '+${CurrencyFormatter.format(addon.price)}',
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.deepAmber,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

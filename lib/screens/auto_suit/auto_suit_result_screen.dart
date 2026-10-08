import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/currency_formatter.dart';
import '../../models/auto_suit_model.dart';
import '../../providers/auto_suit_provider.dart';
import '../../providers/booking_provider.dart';
import '../../widgets/custom_app_bar.dart';
import '../booking/booking_wizard_screen.dart';

class AutoSuitResultScreen extends StatelessWidget {
  const AutoSuitResultScreen({super.key});

  void _bookSuitedBundle(BuildContext context, AutoSuitedBundle bundle) {
    final bookingProvider = context.read<BookingProvider>();
    final autoSuit = context.read<AutoSuitProvider>();

    // Initialize booking draft with primary suited component
    final primary = bundle.components.first.service;
    bookingProvider.initDraft(
      service: primary,
      package: bundle.components.first.selectedPackage,
    );
    bookingProvider.setDraftDate(autoSuit.targetDate);
    bookingProvider.setDraftGuestCount(bundle.guestCapacity);
    bookingProvider.setDraftEventType(bundle.eventType);
    bookingProvider.setDraftSpecialRequests(
      'AUTO-SUITED BUNDLE: ${bundle.title} (${bundle.components.length} Synchronized Curators: ${bundle.components.map((c) => c.service.provider.name).join(", ")})',
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const BookingWizardScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final autoSuit = context.watch<AutoSuitProvider>();
    final bundles = autoSuit.generatedBundles;

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: CustomAppBar(
        title: 'Auto-Suited Packages',
        subtitleWidget: Text(
          '${bundles.length} Optimal Multi-Vendor Bundles Generated',
          style: AppTypography.bodySmall
              .copyWith(color: AppColors.deepAmber, fontSize: 11),
        ),
      ),
      body: bundles.isEmpty
          ? const Center(child: Text('No suited packages generated'))
          : ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
              itemCount: bundles.length,
              separatorBuilder: (_, __) => const SizedBox(height: 24),
              itemBuilder: (context, index) {
                final bundle = bundles[index];
                final isTop = index == 0;

                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isTop ? AppColors.deepAmber : AppColors.warmLinen,
                      width: isTop ? 1.8 : 1,
                    ),
                    boxShadow: const [
                      AppColors.cardRestShadow,
                      AppColors.cardAmberGlow,
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Match Score & Discount Badge
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.emeraldSageLight,
                                borderRadius: BorderRadius.circular(9999),
                                border: Border.all(
                                    color: AppColors.emeraldSage
                                        .withValues(alpha: 0.3)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.bolt,
                                      size: 14, color: AppColors.emeraldSage),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${bundle.matchScore}% HARMONY MATCH',
                                    style: AppTypography.labelSmall.copyWith(
                                      color: AppColors.emeraldSage,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.amberLight,
                                borderRadius: BorderRadius.circular(9999),
                              ),
                              child: Text(
                                'SAVE ${bundle.bundleDiscountPercent.toInt()}% (\$${CurrencyFormatter.formatWithoutSymbol(bundle.discountAmount)})',
                                style: AppTypography.labelSmall.copyWith(
                                  color: AppColors.deepAmber,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Title
                        Text(
                          bundle.title,
                          style: AppTypography.headlineMedium
                              .copyWith(fontSize: 20),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${bundle.theme} • Capacity for ${bundle.guestCapacity} Guests',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.midnightSlate,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Match Rationale Box
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.alabasterVeil,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.warmLinen),
                          ),
                          child: Text(
                            bundle.matchRationale,
                            style: AppTypography.bodySmall.copyWith(
                              height: 1.45,
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Component Services
                        Text(
                          'Included Synchronized Services (${bundle.components.length})',
                          style: AppTypography.titleSmall
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 8),

                        Column(
                          children: bundle.components.map((comp) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceContainerLowest,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColors.warmLinen),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      comp.service.images.isNotEmpty
                                          ? comp.service.images.first
                                          : '',
                                      width: 44,
                                      height: 44,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                        width: 44,
                                        height: 44,
                                        color: AppColors.surfaceContainerHigh,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          comp.role.toUpperCase(),
                                          style:
                                              AppTypography.labelSmall.copyWith(
                                            color: AppColors.deepAmber,
                                            fontSize: 9,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          comp.service.title,
                                          style:
                                              AppTypography.titleSmall.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          'Provider: ${comp.service.provider.name}',
                                          style: AppTypography.bodySmall
                                              .copyWith(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        CurrencyFormatter.format(
                                            comp.suitedPrice),
                                        style:
                                            AppTypography.labelMedium.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.obsidianCharcoal,
                                        ),
                                      ),
                                      Text(
                                        CurrencyFormatter.format(
                                            comp.originalPrice),
                                        style: AppTypography.bodySmall.copyWith(
                                          fontSize: 10,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: AppColors.mutedStone,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 12),

                        // Included Perks
                        Text(
                          'Exclusive Bundle Perks',
                          style: AppTypography.titleSmall
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 6),
                        Column(
                          children: bundle.includedPerks.map((perk) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.check_circle,
                                      size: 14, color: AppColors.emeraldSage),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      perk,
                                      style: AppTypography.bodySmall
                                          .copyWith(fontSize: 11),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                        const Divider(color: AppColors.warmLinen, height: 24),

                        // Financial commitment & CTA
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'SUITED PACKAGE PRICE',
                                  style: AppTypography.labelSmall.copyWith(
                                    color: AppColors.mutedStone,
                                    fontSize: 10,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      CurrencyFormatter.format(
                                          bundle.finalBundlePrice),
                                      style: AppTypography.priceDisplay
                                          .copyWith(fontSize: 22),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      CurrencyFormatter.format(
                                          bundle.originalSubtotal),
                                      style: AppTypography.bodySmall.copyWith(
                                        decoration: TextDecoration.lineThrough,
                                        color: AppColors.mutedStone,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            ElevatedButton.icon(
                              onPressed: () =>
                                  _bookSuitedBundle(context, bundle),
                              icon: const Icon(Icons.calendar_today, size: 16),
                              label: const Text('Book Complete Suite'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.deepAmber,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

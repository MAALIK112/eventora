import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../providers/booking_provider.dart';
import '../../../widgets/luxe_card.dart';

class Step5OrderSummary extends StatelessWidget {
  const Step5OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingProvider>();
    final service = booking.draftService;
    final package = booking.draftPackage;

    if (service == null || package == null) {
      return const Center(child: Text('Incomplete booking configuration'));
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Review Reservation & Escrow',
            style: AppTypography.headlineMedium.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 4),
          Text(
            'Please review your event specifications and financial commitment breakdown.',
            style: AppTypography.bodySmall,
          ),
          const SizedBox(height: 16),

          // Service Overview Card
          LuxeCard(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    service.images.isNotEmpty ? service.images.first : '',
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 70,
                      height: 70,
                      color: AppColors.surfaceContainerHigh,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.category.toUpperCase(),
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.deepAmber,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        service.title,
                        style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w700),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Tier: ${package.tier} (${package.name})',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.obsidianCharcoal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Schedule & Event Details Card
          LuxeCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildInfoRow('Event Type', booking.draftEventType, Icons.celebration),
                const Divider(color: AppColors.warmLinen, height: 16),
                _buildInfoRow(
                  'Date & Time',
                  '${DateFormat('MMM d, yyyy').format(booking.draftDate)} (${booking.draftTime.split(' ').first})',
                  Icons.calendar_today,
                ),
                const Divider(color: AppColors.warmLinen, height: 16),
                _buildInfoRow(
                  'Location',
                  booking.draftLocation.isNotEmpty ? booking.draftLocation : service.location,
                  Icons.location_on_outlined,
                ),
                const Divider(color: AppColors.warmLinen, height: 16),
                _buildInfoRow('Guests', '${booking.draftGuestCount} attendees', Icons.people_outline),
                const Divider(color: AppColors.warmLinen, height: 16),
                _buildInfoRow('Funding Instrument', booking.draftPaymentMethod, Icons.payment),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Itemized Pricing Breakdown
          Text(
            'Transparent Pricing Breakdown',
            style: AppTypography.headlineMedium.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 10),

          LuxeCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildPriceRow('Package Base (${package.name})', booking.draftPackagePrice),
                if (booking.draftAddons.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  ...booking.draftAddons.map((addon) {
                    return _buildPriceRow('• ${addon.name}', addon.price, isSubItem: true);
                  }),
                ],
                const SizedBox(height: 8),
                _buildPriceRow('Concierge Coordination (4%)', booking.draftServiceFee),
                const SizedBox(height: 8),
                _buildPriceRow('Estimated State & Local Taxes (7%)', booking.draftTax),
                if (booking.draftInsuranceSelected) ...[
                  const SizedBox(height: 8),
                  _buildPriceRow('Comprehensive Event Protection', booking.draftInsuranceFee),
                ],
                if (booking.draftDiscount > 0) ...[
                  const SizedBox(height: 8),
                  _buildPriceRow('Privilege Voucher Discount', -booking.draftDiscount, isDiscount: true),
                ],
                const Divider(color: AppColors.warmLinen, height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Escrow Commitment',
                      style: AppTypography.titleSmall.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.obsidianCharcoal,
                      ),
                    ),
                    Text(
                      CurrencyFormatter.format(booking.draftGrandTotal),
                      style: AppTypography.priceDisplay.copyWith(fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Terms notice
          Text(
            'By tapping "Authorize & Confirm Reservation", you agree to the Eventora Master Hospitality terms and authorize the designated escrow deposit. 100% refundable up to 7 days prior.',
            style: AppTypography.bodySmall.copyWith(fontSize: 11, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.deepAmber),
        const SizedBox(width: 10),
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        Expanded(
          flex: 2,
          child: Text(
            value,
            style: AppTypography.labelSmall.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.obsidianCharcoal,
            ),
            textAlign: TextAlign.end,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow(String title, double amount, {bool isSubItem = false, bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: isSubItem
                ? AppTypography.bodySmall.copyWith(color: AppColors.onSurfaceVariant)
                : AppTypography.bodyMedium,
          ),
        ),
        Text(
          isDiscount
              ? '-${CurrencyFormatter.format(amount.abs())}'
              : CurrencyFormatter.format(amount),
          style: AppTypography.labelMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: isDiscount ? AppColors.emeraldSage : AppColors.obsidianCharcoal,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../models/booking_model.dart';
import '../../../widgets/luxe_card.dart';

class BookingTicketCard extends StatelessWidget {
  final Booking booking;
  final VoidCallback onTap;

  const BookingTicketCard({
    super.key,
    required this.booking,
    required this.onTap,
  });

  Color _getStatusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.confirmed:
      case BookingStatus.vendorAssigned:
      case BookingStatus.inProgress:
        return AppColors.emeraldSage;
      case BookingStatus.requested:
        return AppColors.sunlitAmber;
      case BookingStatus.completed:
        return AppColors.midnightSlate;
      case BookingStatus.cancelled:
        return AppColors.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(booking.status);

    return LuxeCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header ID & Status Pill
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                booking.id,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.deepAmber,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(9999),
                  border: Border.all(
                      color: statusColor.withValues(alpha: 0.3), width: 0.8),
                ),
                child: Text(
                  booking.status.shortLabel.toUpperCase(),
                  style: AppTypography.labelSmall.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Service Image & Title
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  booking.service.images.isNotEmpty
                      ? booking.service.images.first
                      : '',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 60,
                    height: 60,
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
                      booking.service.category.toUpperCase(),
                      style: AppTypography.labelSmall.copyWith(
                        fontSize: 10,
                        color: AppColors.mutedStone,
                      ),
                    ),
                    Text(
                      booking.service.title,
                      style: AppTypography.titleSmall
                          .copyWith(fontWeight: FontWeight.w700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${booking.selectedPackage.tier} Tier • ${booking.selectedPackage.name}',
                      style: AppTypography.bodySmall.copyWith(fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(color: AppColors.warmLinen, height: 20),

          // Date & Price Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_month,
                      size: 14, color: AppColors.deepAmber),
                  const SizedBox(width: 6),
                  Text(
                    DateFormat('MMM d, yyyy').format(booking.eventDate),
                    style: AppTypography.labelMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.obsidianCharcoal,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    CurrencyFormatter.format(booking.totalAmount),
                    style: AppTypography.priceCard.copyWith(fontSize: 16),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_forward_ios,
                      size: 12, color: AppColors.mutedStone),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

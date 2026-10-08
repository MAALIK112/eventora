import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../models/booking_model.dart';
import '../../../widgets/luxe_button.dart';
import '../../../widgets/luxe_card.dart';
import '../../../widgets/status_tracker_timeline.dart';
import '../bookings/booking_detail_screen.dart';
import '../main_navigation_screen.dart';

class BookingSuccessScreen extends StatelessWidget {
  final Booking booking;

  const BookingSuccessScreen({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (_) => const MainNavigationScreen(initialIndex: 2)),
          (route) => false,
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.close, color: AppColors.obsidianCharcoal),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (_) =>
                          const MainNavigationScreen(initialIndex: 2)),
                  (route) => false,
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
          child: Column(
            children: [
              // Celebration badge & Icon
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.emeraldSageLight,
                  border: Border.all(color: AppColors.emeraldSage, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.emeraldSage.withValues(alpha: 0.2),
                      offset: const Offset(0, 8),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: const Center(
                  child:
                      Icon(Icons.check, size: 40, color: AppColors.emeraldSage),
                ),
              ),
              const SizedBox(height: 18),

              Text(
                'Reservation Confirmed!',
                style: AppTypography.displayMobile.copyWith(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                'Your milestone booking is locked and guaranteed with 100% Escrow Protection.',
                style: AppTypography.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Booking Pass / Receipt Card
              LuxeCard(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    // Header reference & status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'BOOKING PASS',
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.deepAmber,
                                letterSpacing: 0.6,
                              ),
                            ),
                            Text(
                              booking.id,
                              style: AppTypography.titleSmall.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.emeraldSageLight,
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Text(
                            booking.status.shortLabel.toUpperCase(),
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.emeraldSage,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: AppColors.warmLinen, height: 24),

                    // Service Details
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            booking.service.images.isNotEmpty
                                ? booking.service.images.first
                                : '',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 50,
                              height: 50,
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
                                booking.service.title,
                                style: AppTypography.titleSmall
                                    .copyWith(fontWeight: FontWeight.w700),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${booking.selectedPackage.tier} Tier • ${booking.selectedPackage.name}',
                                style: AppTypography.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: AppColors.warmLinen, height: 24),

                    // Schedule Info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTicketField(
                            'EVENT DATE',
                            DateFormat('MMM dd, yyyy')
                                .format(booking.eventDate)),
                        _buildTicketField(
                            'TIME', booking.eventTime.split(' ').first),
                        _buildTicketField('ESCROW TOTAL',
                            CurrencyFormatter.format(booking.totalAmount)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Live Status Milestones
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Execution Milestones',
                  style: AppTypography.headlineMedium.copyWith(fontSize: 18),
                ),
              ),
              const SizedBox(height: 12),
              StatusTrackerTimeline(events: booking.timeline),
              const SizedBox(height: 24),

              // Action Buttons
              LuxeButton(
                text: 'View Booking & Timeline',
                icon: Icons.receipt_long,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          BookingDetailScreen(bookingId: booking.id),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              LuxeButton(
                text: 'Go to Bookings Dashboard',
                variant: LuxeButtonVariant.outline,
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (_) =>
                            const MainNavigationScreen(initialIndex: 2)),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTicketField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.labelSmall
              .copyWith(fontSize: 10, color: AppColors.mutedStone),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppTypography.labelMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.obsidianCharcoal,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/currency_formatter.dart';
import '../../models/booking_model.dart';
import '../../providers/booking_provider.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/luxe_button.dart';
import '../../widgets/luxe_card.dart';
import '../../widgets/status_tracker_timeline.dart';
import '../support/live_chat_screen.dart';

class BookingDetailScreen extends StatelessWidget {
  final String bookingId;

  const BookingDetailScreen({
    super.key,
    required this.bookingId,
  });

  void _showCancelDialog(BuildContext context, Booking booking) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceContainerLowest,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Cancel Reservation?',
          style: AppTypography.headlineSmall,
        ),
        content: Text(
          'Are you sure you want to cancel booking ${booking.id}? Under Eventora Guarantee, 100% of your escrow deposit (${CurrencyFormatter.format(booking.totalAmount)}) will be refunded immediately to your Luxe Wallet.',
          style: AppTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Keep Reservation'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<BookingProvider>().cancelBooking(booking.id);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'Reservation cancelled. 100% funds refunded to Wallet.'),
                  backgroundColor: AppColors.emeraldSage,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Confirm Cancellation'),
          ),
        ],
      ),
    );
  }

  void _showRescheduleDialog(BuildContext context, Booking booking) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: booking.eventDate.add(const Duration(days: 7)),
      firstDate: DateTime.now().add(const Duration(days: 2)),
      lastDate: DateTime.now().add(const Duration(days: 730)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.deepAmber,
              onPrimary: Colors.white,
              onSurface: AppColors.obsidianCharcoal,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && context.mounted) {
      context.read<BookingProvider>().rescheduleBooking(
            booking.id,
            pickedDate,
            booking.eventTime,
          );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Reservation rescheduled to ${DateFormat('MMM dd, yyyy').format(pickedDate)}!'),
          backgroundColor: AppColors.emeraldSage,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingProvider>().getBookingById(bookingId);

    if (booking == null) {
      return const Scaffold(
        appBar: CustomAppBar(title: 'Booking Details'),
        body: Center(child: Text('Booking not found')),
      );
    }

    final isCancelled = booking.status == BookingStatus.cancelled;
    final isCompleted = booking.status == BookingStatus.completed;

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: CustomAppBar(
        title: booking.id,
        subtitleWidget: Text(
          booking.service.title,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.deepAmber,
            fontSize: 11,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Header Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isCancelled
                    ? AppColors.errorContainer
                    : (isCompleted
                        ? AppColors.alabasterVeil
                        : AppColors.emeraldSageLight),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isCancelled
                      ? AppColors.error
                      : (isCompleted
                          ? AppColors.warmLinen
                          : AppColors.emeraldSage.withValues(alpha: 0.3)),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isCancelled
                        ? Icons.cancel_outlined
                        : (isCompleted
                            ? Icons.check_circle_outline
                            : Icons.verified_user),
                    color: isCancelled
                        ? AppColors.error
                        : (isCompleted
                            ? AppColors.obsidianCharcoal
                            : AppColors.emeraldSage),
                    size: 26,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking.status.label,
                          style: AppTypography.titleSmall.copyWith(
                            fontWeight: FontWeight.w700,
                            color: isCancelled
                                ? AppColors.error
                                : AppColors.obsidianCharcoal,
                          ),
                        ),
                        Text(
                          isCancelled
                              ? 'This booking was cancelled and refunded.'
                              : 'Protected under Eventora Escrow Guarantee.',
                          style: AppTypography.bodySmall.copyWith(fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Service & Provider Overview
            Text(
              'Curated Service',
              style: AppTypography.headlineMedium.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            LuxeCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          booking.service.images.isNotEmpty
                              ? booking.service.images.first
                              : '',
                          width: 65,
                          height: 65,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 65,
                            height: 65,
                            color: AppColors.surfaceContainerHigh,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking.service.category.toUpperCase(),
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.deepAmber,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              booking.service.title,
                              style: AppTypography.titleSmall
                                  .copyWith(fontWeight: FontWeight.w700),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Provider: ${booking.service.provider.name}',
                              style: AppTypography.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: AppColors.warmLinen, height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => const LiveChatScreen()),
                          );
                        },
                        icon: const Icon(Icons.chat_bubble_outline, size: 16),
                        label: const Text('Message Provider'),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => const LiveChatScreen()),
                          );
                        },
                        icon: const Icon(Icons.support_agent, size: 16),
                        label: const Text('VIP Concierge'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Reservation Specifications
            Text(
              'Event Logistics',
              style: AppTypography.headlineMedium.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            LuxeCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildDetailRow('Event Date',
                      DateFormat('MMMM dd, yyyy').format(booking.eventDate)),
                  const Divider(color: AppColors.warmLinen, height: 16),
                  _buildDetailRow('Time Window', booking.eventTime),
                  const Divider(color: AppColors.warmLinen, height: 16),
                  _buildDetailRow('Location', booking.eventLocation),
                  const Divider(color: AppColors.warmLinen, height: 16),
                  _buildDetailRow('Event Type', booking.eventType),
                  const Divider(color: AppColors.warmLinen, height: 16),
                  _buildDetailRow(
                      'Guest Attendance', '${booking.guestCount} Guests'),
                  if (booking.specialRequests.isNotEmpty) ...[
                    const Divider(color: AppColors.warmLinen, height: 16),
                    _buildDetailRow(
                        'Special Requests', booking.specialRequests),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Live Milestone Tracking Timeline
            Text(
              'Live Status & Timeline',
              style: AppTypography.headlineMedium.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 12),
            StatusTrackerTimeline(events: booking.timeline),
            const SizedBox(height: 20),

            // Financial Summary
            Text(
              'Payment & Invoicing',
              style: AppTypography.headlineMedium.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            LuxeCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildPriceLine(
                      'Package Tier (${booking.selectedPackage.tier})',
                      booking.packagePrice),
                  if (booking.selectedAddons.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    ...booking.selectedAddons.map((addon) {
                      return _buildPriceLine('• ${addon.name}', addon.price);
                    }),
                  ],
                  const SizedBox(height: 6),
                  _buildPriceLine('Service Fee (4%)', booking.serviceFee),
                  const SizedBox(height: 6),
                  _buildPriceLine('Taxes & Local Fees (7%)', booking.tax),
                  if (booking.insuranceFee > 0) ...[
                    const SizedBox(height: 6),
                    _buildPriceLine(
                        'Escrow Insurance Protection', booking.insuranceFee),
                  ],
                  if (booking.discount > 0) ...[
                    const SizedBox(height: 6),
                    _buildPriceLine('Voucher Discount', -booking.discount,
                        isDiscount: true),
                  ],
                  const Divider(color: AppColors.warmLinen, height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Escrow Commitment',
                        style: AppTypography.titleSmall
                            .copyWith(fontWeight: FontWeight.w800),
                      ),
                      Text(
                        CurrencyFormatter.format(booking.totalAmount),
                        style:
                            AppTypography.priceDisplay.copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.payment,
                          size: 14, color: AppColors.mutedStone),
                      const SizedBox(width: 6),
                      Text(
                        'Paid via ${booking.paymentMethodTitle} • Ref #${booking.paymentTransactionId}',
                        style: AppTypography.bodySmall.copyWith(fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Management Action Buttons (Reschedule / Cancel)
            if (!isCancelled && !isCompleted) ...[
              LuxeButton(
                text: 'Reschedule Event Date',
                icon: Icons.edit_calendar,
                variant: LuxeButtonVariant.outline,
                onPressed: () => _showRescheduleDialog(context, booking),
              ),
              const SizedBox(height: 12),
              LuxeButton(
                text: 'Cancel Reservation (100% Refund)',
                variant: LuxeButtonVariant.ghost,
                onPressed: () => _showCancelDialog(context, booking),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            value,
            style:
                AppTypography.labelMedium.copyWith(fontWeight: FontWeight.w700),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceLine(String title, double amount,
      {bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTypography.bodySmall,
          ),
        ),
        Text(
          isDiscount
              ? '-${CurrencyFormatter.format(amount.abs())}'
              : CurrencyFormatter.format(amount),
          style: AppTypography.labelMedium.copyWith(
            fontWeight: FontWeight.w700,
            color:
                isDiscount ? AppColors.emeraldSage : AppColors.obsidianCharcoal,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:eventora/models/booking_model.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_typography.dart';
import 'package:eventora/styles/app_spacing.dart';
import 'package:eventora/widgets/custom_app_bar.dart';
import 'package:eventora/widgets/price_breakdown.dart';
import 'package:eventora/widgets/custom_button.dart';
import 'package:eventora/providers/bookings_provider.dart';
import 'package:provider/provider.dart';

class BookingDetailPage extends StatelessWidget {
  final String bookingId;

  const BookingDetailPage({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    final bookingsProvider = context.watch<BookingsProvider>();
    final booking = bookingsProvider.getBookingById(bookingId);

    if (booking == null) {
      return const Scaffold(
        appBar: CustomAppBar(title: 'Booking Details'),
        body: Center(child: Text('Booking not found')),
      );
    }

    Color statusColor;
    switch (booking.status.name) {
      case 'upcoming':
        statusColor = AppColors.primary;
        break;
      case 'completed':
        statusColor = AppColors.successGreen;
        break;
      case 'cancelled':
        statusColor = AppColors.error;
        break;
      default:
        statusColor = AppColors.mutedText;
    }

    return Scaffold(
      backgroundColor: AppColors.canvasBase,
      appBar: const CustomAppBar(title: 'Booking Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.marginMobile),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(booking.serviceImageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(booking.serviceName,
                          style: AppTypography.headlineMD),
                      const SizedBox(height: 4),
                      Text(
                        '${booking.bookingDate.day}/${booking.bookingDate.month}/${booking.bookingDate.year}',
                        style: AppTypography.bodyMD
                            .copyWith(color: AppColors.mutedText),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    booking.status.name.toUpperCase(),
                    style: AppTypography.labelSM.copyWith(color: statusColor),
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            Text('Booking ID',
                style:
                    AppTypography.bodyMD.copyWith(color: AppColors.mutedText)),
            Text(booking.id, style: AppTypography.labelLG),
            const Divider(height: 32),
            Text('Booked Items', style: AppTypography.headlineSM),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${booking.serviceName} x1', style: AppTypography.bodyLG),
                Text('\$${booking.total.toStringAsFixed(2)}',
                    style: AppTypography.labelMD),
              ],
            ),
            const Divider(height: 32),
            PriceBreakdown(
              items: [
                PriceItem(
                    name: booking.serviceName,
                    price: booking.total - (booking.total * 0.1)),
              ],
              tax: booking.total * 0.1,
              total: booking.total,
            ),
            const Divider(height: 32),
            Text('Payment Method', style: AppTypography.headlineSM),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.credit_card, color: AppColors.primary),
                const SizedBox(width: 8),
                Text('Credit Card ending in 4242', style: AppTypography.bodyMD),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.marginMobile),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _buildActionButtons(booking.status),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildActionButtons(BookingStatus status) {
    if (status == BookingStatus.upcoming) {
      return [
        EventoraButton(
          text: 'Reschedule',
          isFullWidth: true,
          onPressed: () {},
        ),
        const SizedBox(height: 16),
        EventoraButton(
          text: 'Cancel Booking',
          isFullWidth: true,
          isOutlined: true,
          // Assuming you want the outline text/border to be red, you'd need to extend EventoraButton
          // For now, standard outlined
          onPressed: () {},
        ),
      ];
    } else if (status == BookingStatus.completed) {
      return [
        EventoraButton(
          text: 'Leave Review',
          isFullWidth: true,
          onPressed: () {},
        ),
        const SizedBox(height: 16),
        EventoraButton(
          text: 'Book Again',
          isFullWidth: true,
          isOutlined: true,
          onPressed: () {},
        ),
      ];
    } else {
      // Cancelled
      return [
        EventoraButton(
          text: 'Book Again',
          isFullWidth: true,
          onPressed: () {},
        ),
      ];
    }
  }
}

import 'package:flutter/material.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_typography.dart';
import 'package:eventora/styles/app_spacing.dart';
import 'package:eventora/widgets/custom_app_bar.dart';
import 'package:eventora/widgets/price_breakdown.dart';
import 'package:eventora/widgets/eventora_button.dart';
import 'package:eventora/providers/bookings_provider.dart';
import 'package:provider/provider.dart';

class BookingDetailPage extends StatelessWidget {
  final String bookingId;

  const BookingDetailPage({Key? key, required this.bookingId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingsProvider = context.watch<BookingsProvider>();
    final booking = bookingsProvider.getBookingById(bookingId);

    if (booking == null) {
      return Scaffold(
        appBar: const CustomAppBar(title: 'Booking Details'),
        body: const Center(child: Text('Booking not found')),
      );
    }

    Color statusColor;
    switch (booking.status.toLowerCase()) {
      case 'upcoming':
        statusColor = AppColors.primary;
        break;
      case 'past':
      case 'completed':
        statusColor = AppColors.successGreen;
        break;
      case 'cancelled':
        statusColor = AppColors.errorRed;
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
                  image: NetworkImage(booking.service.imageUrl),
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
                      Text(booking.service.name, style: AppTypography.headlineMD),
                      const SizedBox(height: 4),
                      Text(booking.date, style: AppTypography.bodyMD.copyWith(color: AppColors.mutedText)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    booking.status.toUpperCase(),
                    style: AppTypography.labelSM.copyWith(color: statusColor),
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            Text('Booking ID', style: AppTypography.bodyMD.copyWith(color: AppColors.mutedText)),
            Text(booking.id, style: AppTypography.labelLG),
            const Divider(height: 32),
            Text('Booked Items', style: AppTypography.headlineSM),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${booking.service.name} x1', style: AppTypography.bodyLG),
                Text('\$${booking.totalPrice.toStringAsFixed(2)}', style: AppTypography.labelMD),
              ],
            ),
            const Divider(height: 32),
            PriceBreakdown(
              subtotal: booking.totalPrice - (booking.totalPrice * 0.1),
              tax: booking.totalPrice * 0.1,
              total: booking.totalPrice,
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

  List<Widget> _buildActionButtons(String status) {
    if (status.toLowerCase() == 'upcoming') {
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
    } else if (status.toLowerCase() == 'past' || status.toLowerCase() == 'completed') {
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

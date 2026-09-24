import 'package:flutter/material.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_typography.dart';
import 'package:eventora/styles/app_spacing.dart';
import 'package:eventora/widgets/booking_card.dart';
import 'package:eventora/providers/bookings_provider.dart';
import 'package:provider/provider.dart';

class MyBookingsPage extends StatelessWidget {
  const MyBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.canvasBase,
        appBar: AppBar(
          backgroundColor: AppColors.canvasBase,
          elevation: 0,
          title: Text('My Bookings', style: AppTypography.headlineMD),
          bottom: const TabBar(
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.mutedText,
            indicatorColor: AppColors.amberAccent,
            tabs: [
              Tab(text: 'Upcoming'),
              Tab(text: 'Past'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildBookingList(context, 'upcoming'),
            _buildBookingList(context, 'past'),
            _buildBookingList(context, 'cancelled'),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingList(BuildContext context, String status) {
    final bookingsProvider = context.watch<BookingsProvider>();
    final bookings = bookingsProvider.getBookingsByStatus(status);

    if (bookingsProvider.isLoading) {
      return const Center(
          child: CircularProgressIndicator(color: AppColors.primary));
    }

    if (bookings.isEmpty) {
      return Center(
        child: Text('No $status bookings found.',
            style: AppTypography.bodyMD.copyWith(color: AppColors.mutedText)),
      );
    }

    return RefreshIndicator(
      onRefresh: () =>
          Future.delayed(const Duration(seconds: 1)), // Placeholder refresh
      color: AppColors.primary,
      child: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.marginMobile),
        itemCount: bookings.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return BookingCard(
            serviceName: booking.serviceName,
            serviceImageUrl: booking.serviceImageUrl,
            bookingDate: booking.bookingDate,
            status: BookingStatus.values.firstWhere(
              (status) => status.name == booking.status.name,
              orElse: () => BookingStatus.pending,
            ),
            total: booking.total,
            bookingId: booking.id,
            onTap: () {
              // browse booking details later
            },
          );
        },
      ),
    );
  }
}

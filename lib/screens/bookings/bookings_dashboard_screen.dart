import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../models/booking_model.dart';
import '../../providers/booking_provider.dart';
import 'booking_detail_screen.dart';
import 'widgets/booking_ticket_card.dart';

class BookingsDashboardScreen extends StatefulWidget {
  const BookingsDashboardScreen({super.key});

  @override
  State<BookingsDashboardScreen> createState() => _BookingsDashboardScreenState();
}

class _BookingsDashboardScreenState extends State<BookingsDashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _openDetail(Booking booking) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BookingDetailScreen(bookingId: booking.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.watch<BookingProvider>();

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Text(
          'My Celebrations',
          style: AppTypography.headlineMedium.copyWith(fontSize: 20),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.deepAmber,
          indicatorWeight: 3,
          labelColor: AppColors.deepAmber,
          unselectedLabelColor: AppColors.mutedStone,
          labelStyle: AppTypography.labelMedium.copyWith(fontWeight: FontWeight.w700),
          tabs: [
            Tab(text: 'Upcoming (${bookingProvider.upcomingBookings.length})'),
            Tab(text: 'Past (${bookingProvider.pastBookings.length})'),
            Tab(text: 'Cancelled (${bookingProvider.cancelledBookings.length})'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookingList(
            bookings: bookingProvider.upcomingBookings,
            emptyTitle: 'No Upcoming Reservations',
            emptySubtitle: 'Explore our curated collections of photographers, venues, and catering to plan your next milestone.',
          ),
          _buildBookingList(
            bookings: bookingProvider.pastBookings,
            emptyTitle: 'No Past Celebrations Yet',
            emptySubtitle: 'Completed events and review histories will be cataloged here.',
          ),
          _buildBookingList(
            bookings: bookingProvider.cancelledBookings,
            emptyTitle: 'No Cancelled Bookings',
            emptySubtitle: 'Any cancelled reservations with escrow refund records appear here.',
          ),
        ],
      ),
    );
  }

  Widget _buildBookingList({
    required List<Booking> bookings,
    required String emptyTitle,
    required String emptySubtitle,
  }) {
    if (bookings.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: AppColors.alabasterVeil,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.event_seat_outlined, size: 48, color: AppColors.mutedStone),
              ),
              const SizedBox(height: 16),
              Text(
                emptyTitle,
                style: AppTypography.headlineSmall.copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                emptySubtitle,
                style: AppTypography.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      itemCount: bookings.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return BookingTicketCard(
          booking: booking,
          onTap: () => _openDetail(booking),
        );
      },
    );
  }
}

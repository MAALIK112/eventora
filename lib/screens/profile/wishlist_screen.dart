import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../providers/service_provider.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/service_card.dart';
import '../service_detail/service_detail_screen.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final serviceProvider = context.watch<ServiceProvider>();
    final savedServices = serviceProvider.wishlistServices;

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: CustomAppBar(
        title: 'Saved Curations',
        subtitleWidget: Text(
          '${savedServices.length} Collections Bookmarked',
          style: AppTypography.bodySmall.copyWith(fontSize: 11),
        ),
      ),
      body: savedServices.isEmpty
          ? Center(
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
                      child: const Icon(Icons.favorite_border, size: 48, color: AppColors.mutedStone),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Your Wishlist is Empty',
                      style: AppTypography.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap the heart icon on any master photographer, estate venue, or culinary service to save for upcoming milestones.',
                      style: AppTypography.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: savedServices.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final service = savedServices[index];
                return ServiceCard(
                  service: service,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ServiceDetailScreen(serviceId: service.id),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

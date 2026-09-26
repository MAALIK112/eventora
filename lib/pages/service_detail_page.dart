import 'package:flutter/material.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_typography.dart';
import 'package:eventora/styles/app_spacing.dart';
import 'package:eventora/widgets/custom_button.dart';
import 'package:eventora/widgets/rating_stars.dart';
import 'package:eventora/widgets/review_card.dart';
import 'package:eventora/routes/app_router.dart';
import 'package:eventora/providers/services_provider.dart';
import 'package:provider/provider.dart';

class ServiceDetailPage extends StatelessWidget {
  final String serviceId;

  const ServiceDetailPage({super.key, required this.serviceId});

  @override
  Widget build(BuildContext context) {
    final servicesProvider = context.watch<ServicesProvider>();
    final service = servicesProvider.getServiceById(serviceId);

    if (service == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Service not found')),
        body: const Center(child: Text('Error loading service')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.canvasBase,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                service.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: Colors.grey),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.surfaceContainerLowest,
              padding: const EdgeInsets.all(AppSpacing.marginMobile),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(service.name, style: AppTypography.headlineLG),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          service.category.name,
                          style: AppTypography.labelSM
                              .copyWith(color: AppColors.primary),
                        ),
                      ),
                      const SizedBox(width: 16),
                      RatingStars(rating: service.rating),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('\$${service.price.toStringAsFixed(2)}',
                      style: AppTypography.headlineMD
                          .copyWith(color: AppColors.primary)),
                  const Divider(height: 32),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    labelColor: AppColors.primary,
                    unselectedLabelColor: AppColors.mutedText,
                    indicatorColor: AppColors.primary,
                    tabs: [
                      Tab(text: 'Overview'),
                      Tab(text: 'Reviews'),
                      Tab(text: 'Pricing'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.all(AppSpacing.marginMobile),
                          child: Text(service.description,
                              style: AppTypography.bodyLG),
                        ),
                        ListView.builder(
                          padding:
                              const EdgeInsets.all(AppSpacing.marginMobile),
                          itemCount: 1,
                          itemBuilder: (context, index) => ReviewCard(
                            userName: 'John Doe',
                            rating: 5,
                            comment: 'Great service! Highly recommended.',
                            date: DateTime(2023, 10, 1),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(AppSpacing.marginMobile),
                          child: Text('Pricing tiers breakdown here.'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.marginMobile),
          child: EventoraButton(
            text: 'Book Now',
            isFullWidth: true,
            onPressed: () =>
                Navigator.pushNamed(context, AppRouter.bookingConfirmation),
          ),
        ),
      ),
    );
  }
}

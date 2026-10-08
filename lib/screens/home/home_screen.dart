import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../models/service_model.dart';
import '../../providers/service_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/service_card.dart';
import '../auto_suit/auto_suit_screen.dart';
import '../service_detail/service_detail_screen.dart';
import 'widgets/category_carousel.dart';
import 'widgets/hero_banner.dart';
import 'widgets/popular_services_section.dart';
import 'widgets/verified_vendors_section.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onSearchTabRequested;

  const HomeScreen({
    super.key,
    required this.onSearchTabRequested,
  });

  void _openDetail(BuildContext context, EventService service) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ServiceDetailScreen(serviceId: service.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final serviceProvider = context.watch<ServiceProvider>();
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(user.avatarUrl),
              backgroundColor: AppColors.surfaceContainerHigh,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Eventora Private Member',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.deepAmber,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  user.fullName,
                  style: AppTypography.titleSmall.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.warmLinen),
                  ),
                  child: const Icon(Icons.notifications_outlined,
                      size: 20, color: AppColors.obsidianCharcoal),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: AppColors.deepAmber,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text(
                        'VIP Notification: Concierge is active for your upcoming bookings.')),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Search quick bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: GestureDetector(
                onTap: onSearchTabRequested,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.warmLinen, width: 1),
                    boxShadow: const [AppColors.cardRestShadow],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search,
                          color: AppColors.deepAmber, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Search luxury photographers, estates, catering...',
                          style: AppTypography.bodyMedium
                              .copyWith(color: AppColors.mutedStone),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.alabasterVeil,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.tune,
                            size: 16, color: AppColors.obsidianCharcoal),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Hero Editorial Banner
          SliverToBoxAdapter(
            child: HeroBanner(onExplorePressed: onSearchTabRequested),
          ),

          // Auto-Suiting AI Intelligent Matcher Callout Banner
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const AutoSuitScreen()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: AppColors.deepAmber.withValues(alpha: 0.5),
                        width: 1.2),
                    boxShadow: const [
                      AppColors.cardRestShadow,
                      AppColors.cardAmberGlow,
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.amberLight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.auto_awesome,
                            color: AppColors.deepAmber, size: 24),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'AI Auto-Suiting Engine',
                                  style: AppTypography.titleSmall.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.deepAmber,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: AppColors.emeraldSageLight,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '15% OFF BUNDLES',
                                    style: AppTypography.labelSmall.copyWith(
                                      color: AppColors.emeraldSage,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Auto-match & bundle Venue + Chef + Photo in one click',
                              style: AppTypography.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios,
                          size: 14, color: AppColors.deepAmber),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Categories horizontal list
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: CategoryCarousel(
                selectedCategory: serviceProvider.selectedCategory,
                onCategorySelected: (cat) =>
                    serviceProvider.selectCategory(cat),
              ),
            ),
          ),

          // Curated Masters / Verified vendors
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: VerifiedVendorsSection(
                services: serviceProvider.services,
                onServiceTap: (s) => _openDetail(context, s),
              ),
            ),
          ),

          // Featured Collections Carousel
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: PopularServicesSection(
                title: 'Featured Milestones & Galas',
                subtitle:
                    'Signature experiences handpicked by Eventora curators',
                services: serviceProvider.featuredServices,
                onServiceTap: (s) => _openDetail(context, s),
              ),
            ),
          ),

          // Category Filtered Collection Heading
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    serviceProvider.selectedCategory == 'All'
                        ? 'All Signature Services'
                        : '${serviceProvider.selectedCategory} Collection',
                    style: AppTypography.headlineMedium.copyWith(fontSize: 19),
                  ),
                  Text(
                    '${serviceProvider.filteredByCategory.length} Available',
                    style: AppTypography.bodySmall
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),

          // Category Filtered Services List
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final service = serviceProvider.filteredByCategory[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ServiceCard(
                      service: service,
                      onTap: () => _openDetail(context, service),
                    ),
                  );
                },
                childCount: serviceProvider.filteredByCategory.length,
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 32),
          ),
        ],
      ),
    );
  }
}

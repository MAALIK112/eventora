import 'package:flutter/material.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_typography.dart';
import 'package:eventora/styles/app_spacing.dart';
import 'package:eventora/widgets/eventora_search_bar.dart';
import 'package:eventora/widgets/promo_banner.dart';
import 'package:eventora/widgets/service_grid_item.dart';
import 'package:eventora/widgets/service_card.dart';
import 'package:eventora/routes/app_router.dart';
import 'package:eventora/providers/services_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final servicesProvider = context.watch<ServicesProvider>();
    final popularServices = servicesProvider.getPopularServices();

    return Scaffold(
      backgroundColor: AppColors.canvasBase,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.marginMobile),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Hello, User', style: AppTypography.headlineLG),
                  const CircleAvatar(
                    backgroundColor: AppColors.primary,
                    child: Icon(Icons.person, color: AppColors.surfaceContainerLowest),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const EventoraSearchBar(),
              const SizedBox(height: 24),
              const PromoBanner(
                title: 'Plan Your Perfect Event',
                subtitle: 'Discover premium services for your special occasions',
              ),
              const SizedBox(height: 24),
              Text('Our Services', style: AppTypography.headlineMD),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  ServiceGridItem(
                    icon: Icons.event_note_rounded,
                    label: 'Event Planning',
                    onTap: () => Navigator.pushNamed(context, AppRouter.eventPlanning),
                  ),
                  ServiceGridItem(
                    icon: Icons.location_city_rounded,
                    label: 'Venue Booking',
                    onTap: () => Navigator.pushNamed(context, AppRouter.serviceList, arguments: 'Venue Booking'),
                  ),
                  ServiceGridItem(
                    icon: Icons.people_rounded,
                    label: 'Staff Hiring',
                    onTap: () => Navigator.pushNamed(context, AppRouter.serviceList, arguments: 'Staff Hiring'),
                  ),
                  ServiceGridItem(
                    icon: Icons.security_rounded,
                    label: 'Security Services',
                    onTap: () => Navigator.pushNamed(context, AppRouter.serviceList, arguments: 'Security'),
                  ),
                  ServiceGridItem(
                    icon: Icons.room_service_rounded,
                    label: 'Reception',
                    onTap: () => Navigator.pushNamed(context, AppRouter.serviceList, arguments: 'Reception'),
                  ),
                  ServiceGridItem(
                    icon: Icons.more_horiz_rounded,
                    label: 'More',
                    onTap: () => Navigator.pushNamed(context, AppRouter.serviceList, arguments: 'All Services'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Popular Services', style: AppTypography.headlineMD),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, AppRouter.serviceList, arguments: 'Popular'),
                    child: Text('See All', style: AppTypography.labelMD.copyWith(color: AppColors.primary)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 280,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: popularServices.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 240,
                      child: ServiceCard(
                        service: popularServices[index],
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRouter.serviceDetail,
                          arguments: popularServices[index].id,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

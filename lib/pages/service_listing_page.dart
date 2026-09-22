import 'package:flutter/material.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_spacing.dart';
import 'package:eventora/widgets/custom_app_bar.dart';
import 'package:eventora/widgets/service_card.dart';
import 'package:eventora/routes/app_router.dart';
import 'package:eventora/providers/services_provider.dart';
import 'package:provider/provider.dart';

class ServiceListingPage extends StatelessWidget {
  final String category;

  const ServiceListingPage({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final servicesProvider = context.watch<ServicesProvider>();
    final services = servicesProvider.getServicesByCategory(category);

    return Scaffold(
      backgroundColor: AppColors.canvasBase,
      appBar: CustomAppBar(title: category),
      body: services.isEmpty
          ? const Center(child: Text('No services found in this category.'))
          : GridView.builder(
              padding: const EdgeInsets.all(AppSpacing.marginMobile),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemCount: services.length,
              itemBuilder: (context, index) {
                return ServiceCard(
                  service: services[index],
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRouter.serviceDetail,
                    arguments: services[index].id,
                  ),
                );
              },
            ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/service_model.dart';
import '../../../widgets/service_card.dart';

class PopularServicesSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<EventService> services;
  final ValueChanged<EventService> onServiceTap;

  const PopularServicesSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.services,
    required this.onServiceTap,
  });

  @override
  Widget build(BuildContext context) {
    if (services.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.headlineMedium.copyWith(fontSize: 19),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: AppTypography.bodySmall,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 310,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: services.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final service = services[index];
              return ServiceCard(
                service: service,
                isHorizontalCompact: true,
                onTap: () => onServiceTap(service),
              );
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/service_model.dart';
import '../../../widgets/luxe_card.dart';
import '../../../widgets/verified_badge.dart';

class ProviderProfileCard extends StatelessWidget {
  final ProviderInfo provider;
  final VoidCallback onContactPressed;

  const ProviderProfileCard({
    super.key,
    required this.provider,
    required this.onContactPressed,
  });

  @override
  Widget build(BuildContext context) {
    return LuxeCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(provider.avatar),
                backgroundColor: AppColors.surfaceContainerHigh,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            provider.name,
                            style: AppTypography.headlineSmall.copyWith(fontSize: 16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 6),
                        if (provider.isVerified)
                          const Icon(Icons.verified, size: 16, color: AppColors.emeraldSage),
                      ],
                    ),
                    Text(
                      provider.title,
                      style: AppTypography.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    const VerifiedBadge(text: 'Licensed & Insured Partner'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          Text(
            provider.bio,
            style: AppTypography.bodyMedium.copyWith(height: 1.45),
          ),
          const SizedBox(height: 14),

          // Provider key statistics strip
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.alabasterVeil,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.warmLinen),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Rating', '${provider.rating} ★'),
                _buildDivider(),
                _buildStatItem('Completed', '${provider.eventsCompleted}+'),
                _buildDivider(),
                _buildStatItem('Response', provider.responseTime),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Contact concierge inquiry button
          OutlinedButton.icon(
            onPressed: onContactPressed,
            icon: const Icon(Icons.chat_outlined, size: 16),
            label: const Text('Direct Concierge Inquiry'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.labelMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.obsidianCharcoal,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 24,
      color: AppColors.warmLinen,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/utils/currency_formatter.dart';
import '../models/service_model.dart';
import '../providers/service_provider.dart';
import 'verified_badge.dart';

class ServiceCard extends StatelessWidget {
  final EventService service;
  final VoidCallback onTap;
  final bool isHorizontalCompact;

  const ServiceCard({
    super.key,
    required this.service,
    required this.onTap,
    this.isHorizontalCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final serviceProvider = context.watch<ServiceProvider>();
    final isWishlisted = serviceProvider.isWishlisted(service.id);

    return Container(
      width: isHorizontalCompact ? 280 : double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.warmLinen, width: 1),
        boxShadow: const [
          AppColors.cardRestShadow,
          AppColors.cardAmberGlow,
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Media Header (16:9 aspect ratio)
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: isHorizontalCompact ? 16 / 10 : 16 / 9,
                      child: Image.network(
                        service.images.isNotEmpty
                            ? service.images.first
                            : 'https://images.unsplash.com/photo-1519741497674-611481863552?auto=format&fit=crop&w=800&q=80',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: AppColors.surfaceContainerHigh,
                          child: const Center(
                            child: Icon(Icons.celebration,
                                color: AppColors.deepAmber, size: 36),
                          ),
                        ),
                      ),
                    ),
                    // Gradient scrim
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.35),
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.4),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Category Tag at Top Left
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.92),
                          borderRadius: BorderRadius.circular(9999),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                            )
                          ],
                        ),
                        child: Text(
                          service.category.toUpperCase(),
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.deepAmber,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                    ),
                    // Wishlist Heart Button at Top Right
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Material(
                        color: Colors.transparent,
                        child: IconButton(
                          icon: CircleAvatar(
                            radius: 16,
                            backgroundColor:
                                Colors.white.withValues(alpha: 0.9),
                            child: Icon(
                              isWishlisted
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isWishlisted
                                  ? Colors.redAccent
                                  : AppColors.obsidianCharcoal,
                              size: 18,
                            ),
                          ),
                          onPressed: () {
                            serviceProvider.toggleWishlist(service.id);
                          },
                        ),
                      ),
                    ),
                    // Location info bottom scrim
                    Positioned(
                      bottom: 8,
                      left: 12,
                      right: 12,
                      child: Row(
                        children: [
                          const Icon(Icons.location_on,
                              color: Colors.white, size: 14),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              service.location,
                              style: AppTypography.bodySmall.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Content Body
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Provider header & Verified status
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundImage:
                              NetworkImage(service.provider.avatar),
                          backgroundColor: AppColors.surfaceContainerHigh,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            service.provider.name,
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (service.provider.isVerified)
                          const VerifiedBadge(isCompact: true),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Service Title
                    Text(
                      service.title,
                      style: AppTypography.headlineSmall.copyWith(
                        fontSize: isHorizontalCompact ? 15 : 16,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),

                    // Divider hairline
                    const Divider(color: AppColors.warmLinen, height: 1),
                    const SizedBox(height: 10),

                    // Footer with Rating & Pricing
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RatingBadge(
                          rating: service.rating,
                          reviewsCount: service.reviewsCount,
                          isCompact: isHorizontalCompact,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Starting from',
                              style: AppTypography.bodySmall.copyWith(
                                fontSize: 10,
                                color: AppColors.mutedStone,
                              ),
                            ),
                            Text(
                              CurrencyFormatter.format(service.startingPrice),
                              style: AppTypography.priceCard.copyWith(
                                fontSize: isHorizontalCompact ? 16 : 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

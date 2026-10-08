import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/review_model.dart';
import '../../../widgets/luxe_card.dart';

class ReviewsListSection extends StatelessWidget {
  final List<Review> reviews;
  final double rating;
  final int totalCount;

  const ReviewsListSection({
    super.key,
    required this.reviews,
    required this.rating,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ratings & Reviews',
              style: AppTypography.headlineMedium.copyWith(fontSize: 19),
            ),
            Row(
              children: [
                const Icon(Icons.star, color: AppColors.sunlitAmber, size: 18),
                const SizedBox(width: 4),
                Text(
                  rating.toStringAsFixed(2),
                  style: AppTypography.headlineSmall.copyWith(fontSize: 16),
                ),
                Text(
                  ' ($totalCount)',
                  style: AppTypography.bodySmall,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),

        if (reviews.isEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.alabasterVeil,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.warmLinen),
            ),
            child: Row(
              children: [
                const Icon(Icons.stars_outlined, color: AppColors.deepAmber),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Exclusive verified service. Be one of the first VIP clients to review this partner.',
                    style: AppTypography.bodySmall,
                  ),
                ),
              ],
            ),
          )
        else
          Column(
            children: reviews.map((review) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: LuxeCard(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(review.userAvatar),
                            backgroundColor: AppColors.surfaceContainerHigh,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  review.userName,
                                  style: AppTypography.labelMedium.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  '${review.eventType} • ${review.date}',
                                  style: AppTypography.bodySmall.copyWith(fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: List.generate(5, (starIdx) {
                              return Icon(
                                starIdx < review.rating.floor()
                                    ? Icons.star
                                    : Icons.star_half,
                                size: 14,
                                color: AppColors.sunlitAmber,
                              );
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        review.comment,
                        style: AppTypography.bodyMedium.copyWith(height: 1.45),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}

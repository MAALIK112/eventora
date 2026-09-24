import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_typography.dart';
import 'package:eventora/widgets/rating_stars.dart';

class ReviewCard extends StatelessWidget {
  final String userName;
  final String? userImageUrl;
  final double rating;
  final String comment;
  final DateTime date;

  const ReviewCard({
    super.key,
    required this.userName,
    this.userImageUrl,
    required this.rating,
    required this.comment,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: userImageUrl != null ? CachedNetworkImageProvider(userImageUrl!) : null,
            child: userImageUrl == null ? Text(userName[0].toUpperCase()) : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(userName, style: AppTypography.labelLG),
                    Text(
                      '${date.day}/${date.month}/${date.year}',
                      style: AppTypography.bodySM.copyWith(color: AppColors.mutedText),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                RatingStars(rating: rating, size: 14),
                const SizedBox(height: 8),
                Text(
                  comment,
                  style: AppTypography.bodyMD,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

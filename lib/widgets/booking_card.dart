import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_typography.dart';
import 'package:eventora/styles/app_spacing.dart';
import 'package:eventora/styles/app_shadows.dart';
import 'package:eventora/widgets/status_badge.dart';

enum BookingStatus { pending, confirmed, cancelled, completed }

class BookingCard extends StatelessWidget {
  final String serviceName;
  final String serviceImageUrl;
  final DateTime bookingDate;
  final BookingStatus status;
  final double total;
  final String bookingId;
  final VoidCallback? onTap;

  const BookingCard({
    Key? key,
    required this.serviceName,
    required this.serviceImageUrl,
    required this.bookingDate,
    required this.status,
    required this.total,
    required this.bookingId,
    this.onTap,
  }) : super(key: key);

  StatusType _mapStatus(BookingStatus s) {
    switch (s) {
      case BookingStatus.pending: return StatusType.pending;
      case BookingStatus.confirmed: return StatusType.confirmed;
      case BookingStatus.cancelled: return StatusType.cancelled;
      case BookingStatus.completed: return StatusType.completed;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
        boxShadow: AppShadows.level1,
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: serviceImageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 80,
                      height: 80,
                      color: AppColors.amberTintBg,
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 80,
                      height: 80,
                      color: AppColors.amberTintBg,
                      child: const Icon(Icons.error, color: AppColors.amberTintText),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        serviceName,
                        style: AppTypography.labelLG,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${bookingDate.day}/${bookingDate.month}/${bookingDate.year}',
                        style: AppTypography.bodySM.copyWith(color: AppColors.mutedText),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          StatusBadge(
                            label: status.name,
                            type: _mapStatus(status),
                          ),
                          const Spacer(),
                          Text(
                            '\$${total.toStringAsFixed(2)}',
                            style: AppTypography.labelLG.copyWith(color: AppColors.primary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ID: $bookingId',
                        style: AppTypography.labelSM.copyWith(color: AppColors.mutedText),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../models/booking_model.dart';

class StatusTrackerTimeline extends StatelessWidget {
  final List<BookingTimelineEvent> events;

  const StatusTrackerTimeline({
    super.key,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(events.length, (index) {
        final event = events[index];
        final isLast = index == events.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline indicator line & icon
            Column(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: event.isCompleted
                        ? AppColors.emeraldSage
                        : AppColors.surfaceContainerHigh,
                    border: Border.all(
                      color: event.isCompleted
                          ? AppColors.emeraldSageLight
                          : AppColors.warmLinen,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      event.isCompleted ? Icons.check : Icons.circle,
                      size: event.isCompleted ? 16 : 8,
                      color: event.isCompleted
                          ? Colors.white
                          : AppColors.mutedStone,
                    ),
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 48,
                    color: event.isCompleted
                        ? AppColors.emeraldSage
                        : AppColors.surfaceContainerHigh,
                  ),
              ],
            ),
            const SizedBox(width: 14),

            // Event description details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            event.title,
                            style: AppTypography.titleSmall.copyWith(
                              color: event.isCompleted
                                  ? AppColors.obsidianCharcoal
                                  : AppColors.mutedStone,
                              fontWeight: event.isCompleted
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          event.time,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.mutedStone,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      event.description,
                      style: AppTypography.bodySmall.copyWith(
                        color: event.isCompleted
                            ? AppColors.onSurfaceVariant
                            : AppColors.mutedStone.withValues(alpha: 0.8),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

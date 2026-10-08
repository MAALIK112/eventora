import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

class StepProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final List<String> stepLabels;

  const StepProgressBar({
    super.key,
    required this.currentStep,
    this.totalSteps = 5,
    required this.stepLabels,
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
              'Step $currentStep of $totalSteps: ${stepLabels[currentStep - 1]}',
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.deepAmber,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '${((currentStep / totalSteps) * 100).toInt()}% Completed',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.mutedStone,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(totalSteps, (index) {
            final isCompleted = index < currentStep;
            final isCurrent = index == currentStep - 1;

            return Expanded(
              child: Container(
                height: 4,
                margin: EdgeInsets.only(right: index == totalSteps - 1 ? 0 : 4),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? AppColors.deepAmber
                      : (isCurrent
                          ? AppColors.sunlitAmber
                          : AppColors.surfaceContainerHigh),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_typography.dart';
import 'package:eventora/styles/app_spacing.dart';

enum StatusType { pending, confirmed, cancelled, completed }

class StatusBadge extends StatelessWidget {
  final String label;
  final StatusType type;

  const StatusBadge({
    Key? key,
    required this.label,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (type) {
      case StatusType.pending:
        bgColor = AppColors.amberTintBg;
        textColor = AppColors.amberTintText;
        break;
      case StatusType.confirmed:
      case StatusType.completed:
        bgColor = AppColors.emeraldTintBg;
        textColor = AppColors.emeraldTintText;
        break;
      case StatusType.cancelled:
        bgColor = AppColors.errorContainer;
        textColor = AppColors.error;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
      child: Text(
        label.toUpperCase(),
        style: AppTypography.labelSM.copyWith(color: textColor),
      ),
    );
  }
}

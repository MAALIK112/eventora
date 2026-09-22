import 'package:flutter/material.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_typography.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final Widget? trailing;
  final VoidCallback? onBack;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showBack = true,
    this.trailing,
    this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.transparent,
        height: preferredSize.height,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            if (showBack)
              IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
                onPressed: onBack ?? () => Navigator.of(context).pop(),
              )
            else
              const SizedBox(width: 48), // Placeholder to balance title centering if needed
            Expanded(
              child: Text(
                title,
                style: AppTypography.headlineMD.copyWith(color: AppColors.onSurface),
                textAlign: TextAlign.center,
              ),
            ),
            if (trailing != null) trailing! else const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

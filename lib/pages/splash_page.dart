import 'package:flutter/material.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_typography.dart';
import 'package:eventora/styles/app_spacing.dart';
import 'package:eventora/widgets/eventora_button.dart';
import 'package:eventora/routes/app_router.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasBase,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.marginMobile),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.deepOnyx,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.star_rounded,
                  color: AppColors.amberAccent,
                  size: 40,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Eventora',
                style: AppTypography.headlineXLMobile.copyWith(color: AppColors.deepOnyx),
              ),
              const SizedBox(height: 8),
              Text(
                'Plan • Book • Manage • Enjoy',
                style: AppTypography.bodyMD.copyWith(color: AppColors.mutedText),
              ),
              const Spacer(),
              EventoraButton(
                text: 'Get Started',
                onPressed: () => Navigator.pushNamed(context, AppRouter.signup),
                isFullWidth: true,
              ),
              const SizedBox(height: 16),
              EventoraButton(
                text: 'Log In',
                onPressed: () => Navigator.pushNamed(context, AppRouter.login),
                isFullWidth: true,
                isOutlined: true,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

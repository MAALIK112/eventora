import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_typography.dart';
import 'package:eventora/styles/app_spacing.dart';

class PromoBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? imageUrl;
  final VoidCallback? onTap;

  const PromoBanner({
    super.key,
    required this.title,
    required this.subtitle,
    this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: AppColors.deepOnyx,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
        boxShadow: const [
          BoxShadow(
            color: AppColors.luminousCaramel,
            blurRadius: 10,
            spreadRadius: -2,
          )
        ], // Subtle amber glow
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: AppTypography.headlineMD
                              .copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: AppTypography.bodySM
                              .copyWith(color: Colors.white70),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.amberAccent,
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Text(
                            'Book Now',
                            style: AppTypography.labelMD
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl ??
                        'https://images.unsplash.com/photo-1519741497674-611481863552?auto=format&fit=crop&w=900&q=80',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    placeholder: (context, url) => Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.deepOnyx, AppColors.amberAccent],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.deepOnyx, AppColors.amberAccent],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
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

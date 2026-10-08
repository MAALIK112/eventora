import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class ServiceGalleryView extends StatefulWidget {
  final List<String> images;

  const ServiceGalleryView({
    super.key,
    required this.images,
  });

  @override
  State<ServiceGalleryView> createState() => _ServiceGalleryViewState();
}

class _ServiceGalleryViewState extends State<ServiceGalleryView> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imgs = widget.images.isNotEmpty
        ? widget.images
        : [
            'https://images.unsplash.com/photo-1519741497674-611481863552?auto=format&fit=crop&w=1200&q=80'
          ];

    return Stack(
      children: [
        SizedBox(
          height: 320,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (idx) => setState(() => _currentIndex = idx),
            itemCount: imgs.length,
            itemBuilder: (context, index) {
              return Image.network(
                imgs[index],
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.surfaceContainerHigh,
                  child: const Center(
                    child: Icon(Icons.celebration,
                        color: AppColors.deepAmber, size: 48),
                  ),
                ),
              );
            },
          ),
        ),

        // Gradient overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.5),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.6),
                ],
              ),
            ),
          ),
        ),

        // Page Indicator dots
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(imgs.length, (index) {
              final isCurrent = index == _currentIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: isCurrent ? 24 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isCurrent
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

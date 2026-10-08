import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/luxe_chip.dart';

class CategoryCarousel extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategoryCarousel({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Photography':
        return Icons.camera_alt_outlined;
      case 'Venues':
        return Icons.villa_outlined;
      case 'Catering':
        return Icons.restaurant_outlined;
      case 'Event Planning':
        return Icons.event_note_outlined;
      case 'Decorations':
        return Icons.palette_outlined;
      case 'Entertainment':
        return Icons.music_note_outlined;
      case 'Florals':
        return Icons.local_florist_outlined;
      case 'Lighting & Sound':
        return Icons.lightbulb_outline;
      default:
        return Icons.auto_awesome_mosaic_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: AppConstants.categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = AppConstants.categories[index];
          final isSelected = selectedCategory.toLowerCase() == category.toLowerCase();
          return LuxeChip(
            label: category,
            isSelected: isSelected,
            icon: _getCategoryIcon(category),
            onTap: () => onCategorySelected(category),
          );
        },
      ),
    );
  }
}

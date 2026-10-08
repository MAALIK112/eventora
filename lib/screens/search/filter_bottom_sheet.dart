import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/currency_formatter.dart';
import '../../providers/search_filter_provider.dart';
import '../../widgets/luxe_button.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late String _tempCategory;
  late RangeValues _tempPriceRange;
  late double _tempMinRating;
  late bool _tempVerifiedOnly;
  late String _tempSortBy;

  @override
  void initState() {
    super.initState();
    final filter = context.read<SearchFilterProvider>();
    _tempCategory = filter.category;
    _tempPriceRange = RangeValues(filter.minPrice, filter.maxPrice);
    _tempMinRating = filter.minRating;
    _tempVerifiedOnly = filter.verifiedOnly;
    _tempSortBy = filter.sortBy;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.surfaceDim,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),

          // Header with Reset button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter & Sort Services',
                style: AppTypography.headlineMedium.copyWith(fontSize: 20),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _tempCategory = 'All';
                    _tempPriceRange = const RangeValues(500, 20000);
                    _tempMinRating = 0.0;
                    _tempVerifiedOnly = false;
                    _tempSortBy = 'Popularity';
                  });
                },
                child: Text(
                  'Reset All',
                  style: AppTypography.labelMedium
                      .copyWith(color: AppColors.deepAmber),
                ),
              ),
            ],
          ),
          const Divider(color: AppColors.warmLinen),
          const SizedBox(height: 12),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sort By Section
                  Text(
                    'Sort By',
                    style: AppTypography.titleSmall
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      'Popularity',
                      'Top Rated',
                      'Price: Low to High',
                      'Price: High to Low',
                    ].map((sort) {
                      final isSelected = _tempSortBy == sort;
                      return ChoiceChip(
                        label: Text(sort),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) setState(() => _tempSortBy = sort);
                        },
                        selectedColor: AppColors.obsidianCharcoal,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : AppColors.onSurfaceVariant,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w400,
                          fontSize: 13,
                        ),
                        backgroundColor: AppColors.alabasterVeil,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9999),
                          side: BorderSide(
                            color: isSelected
                                ? AppColors.obsidianCharcoal
                                : AppColors.warmLinen,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // Category Section
                  Text(
                    'Category',
                    style: AppTypography.titleSmall
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: AppConstants.categories.map((cat) {
                      final isSelected =
                          _tempCategory.toLowerCase() == cat.toLowerCase();
                      return ChoiceChip(
                        label: Text(cat),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) setState(() => _tempCategory = cat);
                        },
                        selectedColor: AppColors.deepAmber,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : AppColors.onSurfaceVariant,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w400,
                          fontSize: 13,
                        ),
                        backgroundColor: AppColors.alabasterVeil,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9999),
                          side: BorderSide(
                            color: isSelected
                                ? AppColors.deepAmber
                                : AppColors.warmLinen,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Price Range Slider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Price Range',
                        style: AppTypography.titleSmall
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '${CurrencyFormatter.format(_tempPriceRange.start)} - ${CurrencyFormatter.format(_tempPriceRange.end)}',
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.deepAmber,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  RangeSlider(
                    values: _tempPriceRange,
                    min: 500,
                    max: 20000,
                    divisions: 39,
                    activeColor: AppColors.deepAmber,
                    inactiveColor: AppColors.surfaceContainerHigh,
                    onChanged: (values) {
                      setState(() => _tempPriceRange = values);
                    },
                  ),
                  const SizedBox(height: 16),

                  // Minimum Rating
                  Text(
                    'Minimum Rating',
                    style: AppTypography.titleSmall
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [0.0, 4.5, 4.8, 4.9].map((rating) {
                      final isSelected = _tempMinRating == rating;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          avatar: rating > 0
                              ? Icon(Icons.star,
                                  size: 14,
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.sunlitAmber)
                              : null,
                          label: Text(rating == 0.0 ? 'Any' : '$rating+'),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() => _tempMinRating = rating);
                            }
                          },
                          selectedColor: AppColors.obsidianCharcoal,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : AppColors.onSurfaceVariant,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                          backgroundColor: AppColors.alabasterVeil,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9999),
                            side: const BorderSide(color: AppColors.warmLinen),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // Verified Partners Only Switch
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.alabasterVeil,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.warmLinen),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.verified,
                                color: AppColors.emeraldSage, size: 22),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Verified Partners Only',
                                  style: AppTypography.titleSmall
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  'Insured & fully vetted curators',
                                  style: AppTypography.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Switch(
                          value: _tempVerifiedOnly,
                          activeThumbColor: AppColors.emeraldSage,
                          onChanged: (val) {
                            setState(() => _tempVerifiedOnly = val);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Apply button
          LuxeButton(
            text: 'Apply Filters',
            onPressed: () {
              final filter = context.read<SearchFilterProvider>();
              filter.setCategory(_tempCategory);
              filter.setPriceRange(_tempPriceRange.start, _tempPriceRange.end);
              filter.setMinRating(_tempMinRating);
              filter.toggleVerifiedOnly(_tempVerifiedOnly);
              filter.setSortBy(_tempSortBy);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

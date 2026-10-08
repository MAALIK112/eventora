import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../models/service_model.dart';
import '../../providers/search_filter_provider.dart';
import '../../providers/service_provider.dart';
import '../../widgets/service_card.dart';
import '../service_detail/service_detail_screen.dart';
import 'filter_bottom_sheet.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const FilterBottomSheet(),
    );
  }

  void _openDetail(EventService service) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ServiceDetailScreen(serviceId: service.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchFilter = context.watch<SearchFilterProvider>();
    final serviceProvider = context.watch<ServiceProvider>();
    final filteredServices = searchFilter.filterServices(serviceProvider.services);

    final bool hasActiveFilters = searchFilter.category != 'All' ||
        searchFilter.minPrice > 500 ||
        searchFilter.maxPrice < 20000 ||
        searchFilter.minRating > 0.0 ||
        searchFilter.verifiedOnly ||
        searchFilter.sortBy != 'Popularity';

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Text(
          'Explore Services',
          style: AppTypography.headlineMedium.copyWith(fontSize: 20),
        ),
        actions: [
          if (hasActiveFilters)
            TextButton(
              onPressed: () => searchFilter.resetFilters(),
              child: Text(
                'Clear',
                style: AppTypography.labelMedium.copyWith(color: AppColors.deepAmber),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          // Search Input Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (val) => searchFilter.setSearchQuery(val),
                    decoration: InputDecoration(
                      hintText: 'Search service, venue, chef, photographer...',
                      prefixIcon: const Icon(Icons.search, color: AppColors.deepAmber),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 18),
                              onPressed: () {
                                _searchController.clear();
                                searchFilter.setSearchQuery('');
                              },
                            )
                          : null,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _showFilterSheet,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: hasActiveFilters ? AppColors.obsidianCharcoal : AppColors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: hasActiveFilters ? AppColors.obsidianCharcoal : AppColors.warmLinen,
                      ),
                      boxShadow: const [AppColors.cardRestShadow],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.tune,
                          color: hasActiveFilters ? Colors.white : AppColors.obsidianCharcoal,
                          size: 20,
                        ),
                        if (hasActiveFilters)
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.sunlitAmber,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Active criteria summary banner
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${filteredServices.length} Results Found',
                  style: AppTypography.labelMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.obsidianCharcoal,
                  ),
                ),
                Text(
                  'Sorted by ${searchFilter.sortBy}',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.mutedStone,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),

          // Search results
          Expanded(
            child: filteredServices.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              color: AppColors.alabasterVeil,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.search_off, size: 48, color: AppColors.mutedStone),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No luxury services match your criteria',
                            style: AppTypography.headlineSmall.copyWith(fontSize: 17),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Try loosening your price filter, changing category, or searching for other keywords.',
                            style: AppTypography.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          OutlinedButton(
                            onPressed: () {
                              _searchController.clear();
                              searchFilter.resetFilters();
                            },
                            child: const Text('Reset All Filters'),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    itemCount: filteredServices.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final service = filteredServices[index];
                      return ServiceCard(
                        service: service,
                        onTap: () => _openDetail(service),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

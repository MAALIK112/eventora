import 'package:flutter/foundation.dart';
import '../models/service_model.dart';

class SearchFilterProvider extends ChangeNotifier {
  String _searchQuery = '';
  String _category = 'All';
  double _minPrice = 500;
  double _maxPrice = 20000;
  double _minRating = 0.0;
  bool _verifiedOnly = false;
  String _sortBy = 'Popularity'; // 'Popularity', 'Price: Low to High', 'Price: High to Low', 'Top Rated'

  String get searchQuery => _searchQuery;
  String get category => _category;
  double get minPrice => _minPrice;
  double get maxPrice => _maxPrice;
  double get minRating => _minRating;
  bool get verifiedOnly => _verifiedOnly;
  String get sortBy => _sortBy;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setCategory(String cat) {
    _category = cat;
    notifyListeners();
  }

  void setPriceRange(double min, double max) {
    _minPrice = min;
    _maxPrice = max;
    notifyListeners();
  }

  void setMinRating(double rating) {
    _minRating = rating;
    notifyListeners();
  }

  void toggleVerifiedOnly(bool val) {
    _verifiedOnly = val;
    notifyListeners();
  }

  void setSortBy(String sort) {
    _sortBy = sort;
    notifyListeners();
  }

  void resetFilters() {
    _category = 'All';
    _minPrice = 500;
    _maxPrice = 20000;
    _minRating = 0.0;
    _verifiedOnly = false;
    _sortBy = 'Popularity';
    notifyListeners();
  }

  List<EventService> filterServices(List<EventService> allServices) {
    var result = allServices.where((service) {
      // Query filter
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final matchesTitle = service.title.toLowerCase().contains(q);
        final matchesCat = service.category.toLowerCase().contains(q);
        final matchesDesc = service.description.toLowerCase().contains(q);
        final matchesLoc = service.location.toLowerCase().contains(q);
        final matchesProv = service.provider.name.toLowerCase().contains(q);
        if (!matchesTitle && !matchesCat && !matchesDesc && !matchesLoc && !matchesProv) {
          return false;
        }
      }

      // Category filter
      if (_category != 'All' && service.category.toLowerCase() != _category.toLowerCase()) {
        return false;
      }

      // Price filter
      if (service.startingPrice < _minPrice || service.startingPrice > _maxPrice) {
        return false;
      }

      // Rating filter
      if (service.rating < _minRating) {
        return false;
      }

      // Verified filter
      if (_verifiedOnly && !service.provider.isVerified) {
        return false;
      }

      return true;
    }).toList();

    // Sorting
    switch (_sortBy) {
      case 'Price: Low to High':
        result.sort((a, b) => a.startingPrice.compareTo(b.startingPrice));
        break;
      case 'Price: High to Low':
        result.sort((a, b) => b.startingPrice.compareTo(a.startingPrice));
        break;
      case 'Top Rated':
        result.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Popularity':
      default:
        result.sort((a, b) => b.reviewsCount.compareTo(a.reviewsCount));
        break;
    }

    return result;
  }
}

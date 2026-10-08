import 'package:flutter/foundation.dart';
import '../models/service_model.dart';
import '../services/mock_data_service.dart';

class ServiceProvider extends ChangeNotifier {
  List<EventService> _services = [];
  final Set<String> _wishlistIds = {'srv-photo-01'};
  String _selectedCategory = 'All';

  ServiceProvider() {
    _loadServices();
  }

  List<EventService> get services => _services;
  String get selectedCategory => _selectedCategory;
  Set<String> get wishlistIds => _wishlistIds;

  List<EventService> get featuredServices =>
      _services.where((s) => s.isFeatured).toList();

  List<EventService> get topRatedServices =>
      _services.where((s) => s.isTopRated).toList();

  List<EventService> get wishlistServices =>
      _services.where((s) => _wishlistIds.contains(s.id)).toList();

  List<EventService> get filteredByCategory {
    if (_selectedCategory == 'All') return _services;
    return _services.where((s) => s.category.toLowerCase() == _selectedCategory.toLowerCase()).toList();
  }

  void _loadServices() {
    _services = MockDataService.getServices();
    notifyListeners();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  bool isWishlisted(String serviceId) {
    return _wishlistIds.contains(serviceId);
  }

  void toggleWishlist(String serviceId) {
    if (_wishlistIds.contains(serviceId)) {
      _wishlistIds.remove(serviceId);
    } else {
      _wishlistIds.add(serviceId);
    }
    notifyListeners();
  }

  EventService? getServiceById(String id) {
    try {
      return _services.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }
}

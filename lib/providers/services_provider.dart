import 'package:flutter/foundation.dart';
import 'package:eventora/apis/services_api.dart';
import 'package:eventora/models/service_model.dart';
import 'package:eventora/providers/auth_provider.dart';

class ServicesProvider extends ChangeNotifier {
  final ServicesApi _servicesApi = ServicesApi();

  ServicesProvider() {
    loadServices();
  }

  List<Service> _services = [];
  Service? _selectedService;
  ViewState _state = ViewState.idle;
  String? _errorMessage;

  List<Service> get services => _services;
  Service? get selectedService => _selectedService;
  ViewState get state => _state;
  String? get errorMessage => _errorMessage;

  Future<void> loadServices({String? category}) async {
    _state = ViewState.loading;
    notifyListeners();

    try {
      final data = await _servicesApi.getServices(category: category);
      _services = data.map((json) => Service.fromJson(json)).toList();
      _state = ViewState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = ViewState.error;
    }
    notifyListeners();
  }

  Future<void> loadServiceDetails(String id) async {
    _state = ViewState.loading;
    notifyListeners();

    try {
      final data = await _servicesApi.getServiceById(id);
      _selectedService = Service.fromJson(data);
      _state = ViewState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = ViewState.error;
    }
    notifyListeners();
  }

  Future<void> searchServices(String query) async {
    _state = ViewState.loading;
    notifyListeners();

    try {
      final data = await _servicesApi.searchServices(query);
      _services = data.map((json) => Service.fromJson(json)).toList();
      _state = ViewState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = ViewState.error;
    }
    notifyListeners();
  }

  List<Service> getServicesByCategory(String category) {
    return _services.where((s) => s.category.name == category || s.category.name.toLowerCase() == category.toLowerCase()).toList();
  }

  Service? getServiceById(String id) {
    try {
      return _services.firstWhere((service) => service.id == id);
    } catch (_) {
      return null;
    }
  }

  List<Service> getPopularServices() {
    return _services.take(5).toList();
  }
}

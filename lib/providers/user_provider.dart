import 'package:flutter/foundation.dart';
import 'package:eventora/apis/user_api.dart';
import 'package:eventora/models/user_model.dart';
import 'package:eventora/models/service_model.dart';
import 'package:eventora/providers/auth_provider.dart';

class UserProvider extends ChangeNotifier {
  final UserApi _userApi = UserApi();

  User? _user;
  List<String> _addresses = [];
  List<Service> _favorites = [];
  ViewState _state = ViewState.idle;

  User? get user => _user;
  User? get currentUser => _user;
  List<String> get addresses => _addresses;
  List<Service> get favorites => _favorites;
  ViewState get state => _state;

  Future<void> loadProfile() async {
    _state = ViewState.loading;
    notifyListeners();

    try {
      final data = await _userApi.getProfile();
      _user = User.fromJson(data);
      _state = ViewState.success;
    } catch (e) {
      _state = ViewState.error;
    }
    notifyListeners();
  }

  Future<bool> updateProfile(User user) async {
    _state = ViewState.loading;
    notifyListeners();

    try {
      final data = await _userApi.updateProfile(user.toJson());
      _user = User.fromJson(data);
      _state = ViewState.success;
      notifyListeners();
      return true;
    } catch (e) {
      _state = ViewState.error;
      notifyListeners();
      return false;
    }
  }

  Future<void> loadAddresses() async {
    try {
      _addresses = await _userApi.getSavedAddresses();
      notifyListeners();
    } catch (e) {
      // Handle silently
    }
  }

  Future<void> loadFavorites() async {
    try {
      final data = await _userApi.getFavoriteServices();
      _favorites = data.map((json) => Service.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      // Handle silently
    }
  }

  Future<void> toggleFavorite(String serviceId) async {
    try {
      await _userApi.toggleFavorite(serviceId);
      await loadFavorites(); // Reload favorites to sync with backend
    } catch (e) {
      // Handle error
    }
  }
}

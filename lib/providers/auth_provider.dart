import 'package:flutter/foundation.dart';
import 'package:eventora/apis/auth_api.dart';
import 'package:eventora/utils/storage_service.dart';
import 'package:eventora/models/user_model.dart';

enum ViewState { idle, loading, success, error }

class AuthProvider extends ChangeNotifier {
  final AuthApi _authApi = AuthApi();
  final StorageService _storage = StorageService();

  User? _currentUser;
  String? _token;
  String? _errorMessage;
  ViewState _state = ViewState.idle;

  User? get currentUser => _currentUser;
  String? get token => _token;
  String? get errorMessage => _errorMessage;
  ViewState get state => _state;
  bool get isAuthenticated => _token != null && _currentUser != null;
  bool get isLoading => _state == ViewState.loading;

  Future<void> checkAuthStatus() async {
    _state = ViewState.loading;
    notifyListeners();

    try {
      _token = _storage.getToken();
      if (_token != null) {
        final userData = await _authApi.getCurrentUser();
        _currentUser = User.fromJson(userData);
      }
      _state = ViewState.idle;
    } catch (e) {
      _token = null;
      _currentUser = null;
      _state = ViewState.error;
    }
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _state = ViewState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _authApi.login(email, password);
      _currentUser = User.fromJson(response['user']);
      _token = response['token'];
      await _storage.setToken(_token!);
      
      _state = ViewState.success;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _state = ViewState.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signup([String name = '', String email = '', String password = '', String phone = '']) async {
    _state = ViewState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _authApi.signup(name, email, password, phone);
      _currentUser = User.fromJson(response['user']);
      _token = response['token'];
      await _storage.setToken(_token!);
      
      _state = ViewState.success;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _state = ViewState.error;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _state = ViewState.loading;
    notifyListeners();

    try {
      await _authApi.logout();
    } finally {
      _currentUser = null;
      _token = null;
      await _storage.clear();
      _state = ViewState.idle;
      notifyListeners();
    }
  }
}

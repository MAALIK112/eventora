import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();

  factory StorageService() => _instance;

  StorageService._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<SharedPreferences> get _instancePrefs async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<void> setToken(String token) async {
    final prefs = await _instancePrefs;
    await prefs.setString('auth_token', token);
  }

  String? getToken() {
    return _prefs?.getString('auth_token');
  }

  Future<void> setUserId(String id) async {
    final prefs = await _instancePrefs;
    await prefs.setString('user_id', id);
  }

  String? getUserId() {
    return _prefs?.getString('user_id');
  }

  Future<void> setBool(String key, bool value) async {
    final prefs = await _instancePrefs;
    await prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  Future<void> clear() async {
    final prefs = await _instancePrefs;
    await prefs.clear();
  }
}

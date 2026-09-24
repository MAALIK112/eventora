import 'dart:async';

class AuthApi {
  Future<Map<String, dynamic>> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'user': {
        'id': '1',
        'name': 'John Doe',
        'email': email,
        'phone': '+1234567890',
      },
      'token': 'mock_jwt_token_123',
    };
  }

  Future<Map<String, dynamic>> signup(
      String name, String email, String password, String phone) async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'user': {
        'id': '2',
        'name': name,
        'email': email,
        'phone': phone,
      },
      'token': 'mock_jwt_token_456',
    };
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<Map<String, dynamic>> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {
      'id': '1',
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'phone': '+1234567890',
    };
  }
}

import 'dart:async';

class UserApi {
  Map<String, dynamic> _mockProfile = {
    'id': '1',
    'name': 'John Doe',
    'email': 'john.doe@example.com',
    'phone': '+1234567890',
    'avatarUrl': 'https://mock.com/avatar.jpg',
  };

  final List<String> _mockAddresses = [
    '123 Main St, New York, NY 10001',
    '456 Elm St, San Francisco, CA 94101',
  ];

  final List<Map<String, dynamic>> _mockFavorites = [
    {
      'id': 's1',
      'name': 'Premium Wedding Planning',
      'category': 'Event Planning',
      'price': 5000.0,
      'rating': 4.9,
    },
    {
      'id': 's3',
      'name': 'Grand Ballroom Venue',
      'category': 'Venue Booking',
      'price': 2500.0,
      'rating': 4.8,
    }
  ];

  Future<Map<String, dynamic>> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockProfile;
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 800));
    _mockProfile = { ..._mockProfile, ...data };
    return _mockProfile;
  }

  Future<List<String>> getSavedAddresses() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockAddresses;
  }

  Future<void> addAddress(String address) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _mockAddresses.add(address);
  }

  Future<List<Map<String, dynamic>>> getFavoriteServices() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _mockFavorites;
  }

  Future<void> toggleFavorite(String serviceId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _mockFavorites.indexWhere((s) => s['id'] == serviceId);
    if (index != -1) {
      _mockFavorites.removeAt(index);
    } else {
      _mockFavorites.add({
        'id': serviceId,
        'name': 'Mock Service $serviceId',
        'category': 'Mock Category',
        'price': 1000.0,
        'rating': 4.0,
      });
    }
  }
}

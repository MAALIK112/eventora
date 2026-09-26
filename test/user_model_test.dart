import 'package:flutter_test/flutter_test.dart';
import 'package:eventora/models/user_model.dart';

void main() {
  test('parses auth response without optional profile fields', () {
    final user = User.fromJson({
      'id': 'admin-1',
      'name': 'Admin User',
      'email': 'admin@eventora.com',
      'phone': '+1234567890',
    });

    expect(user.profileImageUrl, isEmpty);
    expect(user.savedAddresses, isEmpty);
    expect(user.favoriteServiceIds, isEmpty);
    expect(user.createdAt, isA<DateTime>());
  });
}

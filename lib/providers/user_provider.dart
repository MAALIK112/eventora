import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../core/security/secure_storage_service.dart';
import '../core/security/input_validator.dart';

class UserProvider extends ChangeNotifier {
  static const demoPassword = 'CelebrationMember2026!';
  String _password = demoPassword;

  UserProfile _user = const UserProfile(
    id: 'usr-90210',
    fullName: 'Lady Genevieve Sinclair',
    email: 'genevieve.sinclair@eventora.luxury',
    phone: '+1 (310) 555-0198',
    avatarUrl:
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80',
    location: 'Beverly Hills, CA',
    memberTier: 'Celebration Luxe Member',
    eventsHosted: 6,
    biometricsEnabled: true,
    twoFactorEnabled: true,
    emailNotifications: true,
    pushNotifications: true,
    preferredCurrency: 'USD',
  );

  final SecureStorageService _secureStorage = SecureStorageService();

  UserProfile get user => _user;

  bool authenticate({required String email, required String password}) {
    return email.trim().toLowerCase() == _user.email.toLowerCase() &&
        password == _password;
  }

  bool signUp({
    required String fullName,
    required String email,
    required String password,
  }) {
    final normalizedEmail = email.trim().toLowerCase();
    if (normalizedEmail.isEmpty ||
        InputValidator.validateEmail(normalizedEmail) != null ||
        normalizedEmail == _user.email.toLowerCase() ||
        fullName.trim().isEmpty ||
        password.length < 8) {
      return false;
    }

    _user = UserProfile(
      id: 'usr-${DateTime.now().microsecondsSinceEpoch}',
      fullName: fullName.trim(),
      email: normalizedEmail,
      phone: '',
      avatarUrl: _user.avatarUrl,
      location: '',
      eventsHosted: 0,
    );
    _password = password;
    notifyListeners();
    return true;
  }

  void updateProfile({
    required String fullName,
    required String email,
    required String phone,
    required String location,
  }) {
    _user = _user.copyWith(
      fullName: fullName,
      email: email,
      phone: phone,
      location: location,
    );
    notifyListeners();
  }

  void toggleBiometrics(bool enabled) {
    _user = _user.copyWith(biometricsEnabled: enabled);
    _secureStorage.setBiometricsEnabled(enabled);
    notifyListeners();
  }

  void toggleTwoFactor(bool enabled) {
    _user = _user.copyWith(twoFactorEnabled: enabled);
    _secureStorage.setTwoFactorEnabled(enabled);
    notifyListeners();
  }

  void toggleEmailNotifications(bool enabled) {
    _user = _user.copyWith(emailNotifications: enabled);
    notifyListeners();
  }

  void togglePushNotifications(bool enabled) {
    _user = _user.copyWith(pushNotifications: enabled);
    notifyListeners();
  }
}

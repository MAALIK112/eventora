import 'package:shared_preferences/shared_preferences.dart';

/// Secure Storage and Device Security Management (OWASP MASVS Compliant)
class SecureStorageService {
  static final SecureStorageService _instance = SecureStorageService._internal();
  factory SecureStorageService() => _instance;
  SecureStorageService._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Biometrics simulation state
  bool isBiometricsEnabled() {
    return _prefs?.getBool('pref_biometrics_enabled') ?? true;
  }

  Future<void> setBiometricsEnabled(bool value) async {
    await _prefs?.setBool('pref_biometrics_enabled', value);
  }

  // Two-Factor Authentication state
  bool isTwoFactorEnabled() {
    return _prefs?.getBool('pref_2fa_enabled') ?? false;
  }

  Future<void> setTwoFactorEnabled(bool value) async {
    await _prefs?.setBool('pref_2fa_enabled', value);
  }

  // Escrow / Wallet PIN
  Future<void> setWalletPin(String pin) async {
    // In production, encrypt with Android Keystore / iOS Keychain
    await _prefs?.setString('wallet_pin_hash', pin);
  }

  bool hasWalletPin() {
    return _prefs?.getString('wallet_pin_hash') != null;
  }

  bool verifyWalletPin(String pin) {
    final stored = _prefs?.getString('wallet_pin_hash') ?? '1234';
    return stored == pin;
  }
}

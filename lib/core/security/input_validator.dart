/// Mobile Input Validation and Sanitization based on OWASP MASVS guidelines
class InputValidator {
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  static final RegExp _phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
  static final RegExp _cardRegex = RegExp(r'^[0-9]{13,19}$');

  /// Validates email address format
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email address is required';
    }
    final trimmed = value.trim();
    if (!_emailRegex.hasMatch(trimmed)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Validates full name
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  /// Validates phone number
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    final cleaned = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    if (!_phoneRegex.hasMatch(cleaned)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  /// Validates credit card number with Luhn algorithm
  static String? validateCardNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Card number is required';
    }
    final cleaned = value.replaceAll(RegExp(r'\s+'), '');
    if (!_cardRegex.hasMatch(cleaned)) {
      return 'Invalid card number format';
    }
    if (!_luhnCheck(cleaned)) {
      return 'Invalid card checksum';
    }
    return null;
  }

  /// Luhn algorithm for card validation
  static bool _luhnCheck(String cardNumber) {
    int sum = 0;
    bool alternate = false;
    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int n = int.parse(cardNumber[i]);
      if (alternate) {
        n *= 2;
        if (n > 9) n = (n % 10) + 1;
      }
      sum += n;
      alternate = !alternate;
    }
    return (sum % 10 == 0);
  }

  /// Sanitizes text input to prevent injection & malicious script tags
  static String sanitizeText(String input) {
    return input
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll(RegExp(r'[<>&"\x27]'), '')
        .trim();
  }

  /// Masks sensitive card numbers (e.g., **** **** **** 1234)
  static String maskCardNumber(String number) {
    final cleaned = number.replaceAll(' ', '');
    if (cleaned.length < 4) return '****';
    final lastFour = cleaned.substring(cleaned.length - 4);
    return '•••• •••• •••• $lastFour';
  }
}

import 'package:flutter/foundation.dart';

class NavigationProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  String get currentLabel {
    switch (_currentIndex) {
      case 0:
        return 'Home';
      case 1:
        return 'Bookings';
      case 2:
        return 'Wallet';
      case 3:
        return 'Profile';
      default:
        return 'Home';
    }
  }
}

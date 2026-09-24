import 'package:flutter/foundation.dart';
import 'package:eventora/apis/bookings_api.dart';
import 'package:eventora/models/booking_model.dart';
import 'package:eventora/providers/auth_provider.dart';

class BookingsProvider extends ChangeNotifier {
  final BookingsApi _bookingsApi = BookingsApi();

  List<Booking> _bookings = [];
  Booking? _selectedBooking;
  ViewState _state = ViewState.idle;

  List<Booking> get bookings => _bookings;
  Booking? get selectedBooking => _selectedBooking;
  ViewState get state => _state;
  bool get isLoading => _state == ViewState.loading;

  List<Booking> get upcomingBookings =>
      _bookings.where((b) => b.status.name == 'upcoming').toList();
  List<Booking> get pastBookings =>
      _bookings.where((b) => b.status.name == 'completed').toList();
  List<Booking> get cancelledBookings =>
      _bookings.where((b) => b.status.name == 'cancelled').toList();

  List<Booking> getBookingsByStatus(String status) {
    return _bookings.where((booking) => booking.status.name == status).toList();
  }

  Booking? getBookingById(String id) {
    try {
      return _bookings.firstWhere((booking) => booking.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<void> loadBookings({String? status}) async {
    _state = ViewState.loading;
    notifyListeners();

    try {
      final data = await _bookingsApi.getBookings(status: status);
      _bookings = data.map((json) => Booking.fromJson(json)).toList();
      _state = ViewState.success;
    } catch (e) {
      _state = ViewState.error;
    }
    notifyListeners();
  }

  Future<bool> createBooking(Booking booking) async {
    _state = ViewState.loading;
    notifyListeners();

    try {
      await _bookingsApi.createBooking(booking.toJson());
      await loadBookings();
      return true;
    } catch (e) {
      _state = ViewState.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> cancelBooking(String id) async {
    _state = ViewState.loading;
    notifyListeners();

    try {
      await _bookingsApi.cancelBooking(id);
      await loadBookings();
      return true;
    } catch (e) {
      _state = ViewState.error;
      notifyListeners();
      return false;
    }
  }
}

import 'dart:async';

class BookingsApi {
  final List<Map<String, dynamic>> _mockBookings = [
    {
      'id': 'b1',
      'serviceId': 's1',
      'serviceName': 'Premium Wedding Planning',
      'date': DateTime.now().add(const Duration(days: 30)).toIso8601String(),
      'status': 'upcoming',
      'price': 5000.0,
    },
    {
      'id': 'b2',
      'serviceId': 's4',
      'serviceName': 'Professional Security Team',
      'date': DateTime.now().subtract(const Duration(days: 10)).toIso8601String(),
      'status': 'completed',
      'price': 800.0,
    },
    {
      'id': 'b3',
      'serviceId': 's6',
      'serviceName': 'Live Band Entertainment',
      'date': DateTime.now().add(const Duration(days: 15)).toIso8601String(),
      'status': 'upcoming',
      'price': 1200.0,
    },
    {
      'id': 'b4',
      'serviceId': 's3',
      'serviceName': 'Grand Ballroom Venue',
      'date': DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
      'status': 'cancelled',
      'price': 2500.0,
    },
    {
      'id': 'b5',
      'serviceId': 's2',
      'serviceName': 'Corporate Conference Package',
      'date': DateTime.now().subtract(const Duration(days: 45)).toIso8601String(),
      'status': 'completed',
      'price': 3500.0,
    },
  ];

  Future<List<Map<String, dynamic>>> getBookings({String? status}) async {
    await Future.delayed(const Duration(milliseconds: 600));
    if (status != null && status.isNotEmpty) {
      return _mockBookings.where((b) => b['status'] == status).toList();
    }
    return _mockBookings;
  }

  Future<Map<String, dynamic>> getBookingById(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockBookings.firstWhere((b) => b['id'] == id, orElse: () => throw Exception('Booking not found'));
  }

  Future<Map<String, dynamic>> createBooking(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final newBooking = {
      'id': 'b${DateTime.now().millisecondsSinceEpoch}',
      ...data,
      'status': 'upcoming',
    };
    _mockBookings.add(newBooking);
    return newBooking;
  }

  Future<void> cancelBooking(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _mockBookings.indexWhere((b) => b['id'] == id);
    if (index != -1) {
      _mockBookings[index]['status'] = 'cancelled';
    }
  }

  Future<void> rescheduleBooking(String id, DateTime newDate) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final index = _mockBookings.indexWhere((b) => b['id'] == id);
    if (index != -1) {
      _mockBookings[index]['date'] = newDate.toIso8601String();
    }
  }
}

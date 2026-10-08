import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/booking_model.dart';
import '../models/service_model.dart';
import '../services/mock_data_service.dart';

class BookingProvider extends ChangeNotifier {
  List<Booking> _bookings = [];

  // Wizard Draft State
  EventService? _draftService;
  ServicePackage? _draftPackage;
  List<ServiceAddon> _draftAddons = [];
  DateTime _draftDate = DateTime.now().add(const Duration(days: 30));
  String _draftTime = '16:00 - 22:00';
  String _draftLocation = '';
  String _draftEventType = 'Wedding & Gala';
  int _draftGuestCount = 100;
  String _draftSpecialRequests = '';
  String _draftPaymentMethod = 'Eventora Luxe Wallet';
  String _draftCouponCode = '';
  double _draftDiscount = 0.0;
  bool _draftInsuranceSelected = true;

  BookingProvider() {
    _loadBookings();
  }

  List<Booking> get bookings => _bookings;

  List<Booking> get upcomingBookings => _bookings
      .where((b) =>
          b.status == BookingStatus.requested ||
          b.status == BookingStatus.confirmed ||
          b.status == BookingStatus.vendorAssigned ||
          b.status == BookingStatus.inProgress)
      .toList();

  List<Booking> get pastBookings =>
      _bookings.where((b) => b.status == BookingStatus.completed).toList();

  List<Booking> get cancelledBookings =>
      _bookings.where((b) => b.status == BookingStatus.cancelled).toList();

  // Draft Getters
  EventService? get draftService => _draftService;
  ServicePackage? get draftPackage => _draftPackage;
  List<ServiceAddon> get draftAddons => _draftAddons;
  DateTime get draftDate => _draftDate;
  String get draftTime => _draftTime;
  String get draftLocation => _draftLocation;
  String get draftEventType => _draftEventType;
  int get draftGuestCount => _draftGuestCount;
  String get draftSpecialRequests => _draftSpecialRequests;
  String get draftPaymentMethod => _draftPaymentMethod;
  String get draftCouponCode => _draftCouponCode;
  double get draftDiscount => _draftDiscount;
  bool get draftInsuranceSelected => _draftInsuranceSelected;

  // Calculation Getters
  double get draftPackagePrice => _draftPackage?.price ?? 0.0;
  double get draftAddonsTotal =>
      _draftAddons.fold(0.0, (sum, item) => sum + item.price);
  double get draftServiceFee => (draftPackagePrice + draftAddonsTotal) * 0.04;
  double get draftTax => (draftPackagePrice + draftAddonsTotal) * 0.07;
  double get draftInsuranceFee => _draftInsuranceSelected ? 95.0 : 0.0;
  double get draftGrandTotal =>
      (draftPackagePrice +
          draftAddonsTotal +
          draftServiceFee +
          draftTax +
          draftInsuranceFee) -
      _draftDiscount;

  void _loadBookings() {
    _bookings = MockDataService.getInitialBookings();
    notifyListeners();
  }

  void initDraft({
    required EventService service,
    ServicePackage? package,
  }) {
    _draftService = service;
    _draftPackage = package ??
        (service.packages.isNotEmpty ? service.packages.first : null);
    _draftAddons = [];
    _draftDate = DateTime.now().add(const Duration(days: 30));
    _draftTime = '16:00 - 22:00';
    _draftLocation = service.location;
    _draftEventType = 'Wedding & Gala';
    _draftGuestCount = 100;
    _draftSpecialRequests = '';
    _draftPaymentMethod = 'Eventora Luxe Wallet';
    _draftCouponCode = '';
    _draftDiscount = 0.0;
    _draftInsuranceSelected = true;
    notifyListeners();
  }

  void setDraftPackage(ServicePackage package) {
    _draftPackage = package;
    notifyListeners();
  }

  void toggleDraftAddon(ServiceAddon addon) {
    if (_draftAddons.any((a) => a.id == addon.id)) {
      _draftAddons.removeWhere((a) => a.id == addon.id);
    } else {
      _draftAddons.add(addon);
    }
    notifyListeners();
  }

  void setDraftDate(DateTime date) {
    _draftDate = date;
    notifyListeners();
  }

  void setDraftTime(String time) {
    _draftTime = time;
    notifyListeners();
  }

  void setDraftLocation(String loc) {
    _draftLocation = loc;
    notifyListeners();
  }

  void setDraftEventType(String type) {
    _draftEventType = type;
    notifyListeners();
  }

  void setDraftGuestCount(int count) {
    _draftGuestCount = count;
    notifyListeners();
  }

  void setDraftSpecialRequests(String req) {
    _draftSpecialRequests = req;
    notifyListeners();
  }

  void setDraftPaymentMethod(String method) {
    _draftPaymentMethod = method;
    notifyListeners();
  }

  void toggleDraftInsurance(bool val) {
    _draftInsuranceSelected = val;
    notifyListeners();
  }

  bool applyCoupon(String code) {
    if (code.trim().toUpperCase() == 'LUXE100' ||
        code.trim().toUpperCase() == 'EVENTORA2026') {
      _draftCouponCode = code.trim().toUpperCase();
      _draftDiscount = 100.0;
      notifyListeners();
      return true;
    }
    return false;
  }

  Booking confirmDraftBooking() {
    final newId =
        'EVT-${DateTime.now().year}-${(1000 + _bookings.length * 123).toString()}';
    final newBooking = Booking(
      id: newId,
      service: _draftService!,
      selectedPackage: _draftPackage!,
      selectedAddons: List.from(_draftAddons),
      eventDate: _draftDate,
      eventTime: _draftTime,
      eventLocation:
          _draftLocation.isNotEmpty ? _draftLocation : _draftService!.location,
      eventType: _draftEventType,
      guestCount: _draftGuestCount,
      specialRequests: _draftSpecialRequests,
      status: BookingStatus.confirmed,
      createdAt: DateTime.now(),
      packagePrice: draftPackagePrice,
      addonsTotal: draftAddonsTotal,
      serviceFee: draftServiceFee,
      tax: draftTax,
      insuranceFee: draftInsuranceFee,
      discount: _draftDiscount,
      totalAmount: draftGrandTotal,
      paymentMethodTitle: _draftPaymentMethod,
      paymentTransactionId:
          'TXN-${const Uuid().v4().substring(0, 8).toUpperCase()}',
      isEscrowProtected: true,
      timeline: [
        BookingTimelineEvent(
          title: 'Reservation Confirmed',
          time: 'Just now',
          description:
              'Payment escrow locked and booking dispatched to ${_draftService!.provider.name}.',
          isCompleted: true,
        ),
        const BookingTimelineEvent(
          title: 'Provider Calendar Locked',
          time: 'Estimated within 2 hrs',
          description: 'Lead team calendar allocation confirmation.',
          isCompleted: false,
        ),
        const BookingTimelineEvent(
          title: 'Pre-Event Consultation',
          time: '14 Days Prior to Event',
          description: 'Customization check-in with lead coordinator.',
          isCompleted: false,
        ),
        const BookingTimelineEvent(
          title: 'Day-of Master Execution',
          time: 'Event Date',
          description: 'On-site white-glove arrival and setup.',
          isCompleted: false,
        ),
      ],
    );

    _bookings.insert(0, newBooking);
    notifyListeners();
    return newBooking;
  }

  void cancelBooking(String bookingId) {
    final index = _bookings.indexWhere((b) => b.id == bookingId);
    if (index != -1) {
      _bookings[index] = _bookings[index].copyWith(
        status: BookingStatus.cancelled,
        timeline: [
          ..._bookings[index].timeline,
          const BookingTimelineEvent(
            title: 'Booking Cancelled',
            time: 'Just now',
            description:
                '100% Escrow refund automatically credited back to your Eventora Luxe Wallet.',
            isCompleted: true,
          ),
        ],
      );
      notifyListeners();
    }
  }

  void rescheduleBooking(String bookingId, DateTime newDate, String newTime) {
    final index = _bookings.indexWhere((b) => b.id == bookingId);
    if (index != -1) {
      final old = _bookings[index];
      _bookings[index] = Booking(
        id: old.id,
        service: old.service,
        selectedPackage: old.selectedPackage,
        selectedAddons: old.selectedAddons,
        eventDate: newDate,
        eventTime: newTime,
        eventLocation: old.eventLocation,
        eventType: old.eventType,
        guestCount: old.guestCount,
        specialRequests: old.specialRequests,
        status: old.status,
        createdAt: old.createdAt,
        packagePrice: old.packagePrice,
        addonsTotal: old.addonsTotal,
        serviceFee: old.serviceFee,
        tax: old.tax,
        insuranceFee: old.insuranceFee,
        discount: old.discount,
        totalAmount: old.totalAmount,
        paymentMethodTitle: old.paymentMethodTitle,
        paymentTransactionId: old.paymentTransactionId,
        isEscrowProtected: old.isEscrowProtected,
        timeline: [
          ...old.timeline,
          BookingTimelineEvent(
            title: 'Date Rescheduled',
            time: 'Just now',
            description:
                'New date set for ${newDate.month}/${newDate.day}/${newDate.year} ($newTime).',
            isCompleted: true,
          ),
        ],
      );
      notifyListeners();
    }
  }

  Booking? getBookingById(String id) {
    try {
      return _bookings.firstWhere((b) => b.id == id);
    } catch (_) {
      return null;
    }
  }
}

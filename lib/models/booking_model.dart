import 'service_model.dart';

enum BookingStatus {
  requested,
  confirmed,
  vendorAssigned,
  inProgress,
  completed,
  cancelled,
}

extension BookingStatusExtension on BookingStatus {
  String get label {
    switch (this) {
      case BookingStatus.requested:
        return 'Reservation Requested';
      case BookingStatus.confirmed:
        return 'Confirmed & Guaranteed';
      case BookingStatus.vendorAssigned:
        return 'Vendor Crew Assigned';
      case BookingStatus.inProgress:
        return 'Event in Progress';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
    }
  }

  String get shortLabel {
    switch (this) {
      case BookingStatus.requested:
        return 'Requested';
      case BookingStatus.confirmed:
        return 'Confirmed';
      case BookingStatus.vendorAssigned:
        return 'Assigned';
      case BookingStatus.inProgress:
        return 'In Progress';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
    }
  }
}

class BookingTimelineEvent {
  final String title;
  final String time;
  final String description;
  final bool isCompleted;

  const BookingTimelineEvent({
    required this.title,
    required this.time,
    required this.description,
    required this.isCompleted,
  });
}

class Booking {
  final String id;
  final EventService service;
  final ServicePackage selectedPackage;
  final List<ServiceAddon> selectedAddons;
  final DateTime eventDate;
  final String eventTime;
  final String eventLocation;
  final String eventType;
  final int guestCount;
  final String specialRequests;
  final BookingStatus status;
  final DateTime createdAt;
  final double packagePrice;
  final double addonsTotal;
  final double serviceFee;
  final double tax;
  final double insuranceFee;
  final double discount;
  final double totalAmount;
  final String paymentMethodTitle;
  final String paymentTransactionId;
  final bool isEscrowProtected;
  final List<BookingTimelineEvent> timeline;

  const Booking({
    required this.id,
    required this.service,
    required this.selectedPackage,
    required this.selectedAddons,
    required this.eventDate,
    required this.eventTime,
    required this.eventLocation,
    required this.eventType,
    required this.guestCount,
    required this.specialRequests,
    required this.status,
    required this.createdAt,
    required this.packagePrice,
    required this.addonsTotal,
    required this.serviceFee,
    required this.tax,
    required this.insuranceFee,
    required this.discount,
    required this.totalAmount,
    required this.paymentMethodTitle,
    required this.paymentTransactionId,
    this.isEscrowProtected = true,
    required this.timeline,
  });

  Booking copyWith({
    BookingStatus? status,
    List<BookingTimelineEvent>? timeline,
  }) {
    return Booking(
      id: id,
      service: service,
      selectedPackage: selectedPackage,
      selectedAddons: selectedAddons,
      eventDate: eventDate,
      eventTime: eventTime,
      eventLocation: eventLocation,
      eventType: eventType,
      guestCount: guestCount,
      specialRequests: specialRequests,
      status: status ?? this.status,
      createdAt: createdAt,
      packagePrice: packagePrice,
      addonsTotal: addonsTotal,
      serviceFee: serviceFee,
      tax: tax,
      insuranceFee: insuranceFee,
      discount: discount,
      totalAmount: totalAmount,
      paymentMethodTitle: paymentMethodTitle,
      paymentTransactionId: paymentTransactionId,
      isEscrowProtected: isEscrowProtected,
      timeline: timeline ?? this.timeline,
    );
  }
}

enum BookingStatus { upcoming, confirmed, completed, cancelled }

class BookingItem {
  final String name;
  final int quantity;
  final double price;

  const BookingItem({
    required this.name,
    required this.quantity,
    required this.price,
  });

  factory BookingItem.fromJson(Map<String, dynamic> json) {
    return BookingItem(
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }
}

class BookingModel {
  final String id;
  final String userId;
  final String serviceId;
  final String serviceName;
  final String serviceImageUrl;
  final DateTime bookingDate;
  final DateTime createdAt;
  final BookingStatus status;
  final double subtotal;
  final double tax;
  final double total;
  final List<BookingItem> items;
  final String? paymentMethodId;

  const BookingModel({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.serviceName,
    required this.serviceImageUrl,
    required this.bookingDate,
    required this.createdAt,
    required this.status,
    required this.subtotal,
    required this.tax,
    required this.total,
    required this.items,
    this.paymentMethodId,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      serviceId: json['serviceId'] as String,
      serviceName: json['serviceName'] as String,
      serviceImageUrl: json['serviceImageUrl'] as String,
      bookingDate: DateTime.parse(json['bookingDate'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: BookingStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => BookingStatus.upcoming,
      ),
      subtotal: (json['subtotal'] as num).toDouble(),
      tax: (json['tax'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      items: (json['items'] as List<dynamic>?)
              ?.map((item) => BookingItem.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      paymentMethodId: json['paymentMethodId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'serviceId': serviceId,
      'serviceName': serviceName,
      'serviceImageUrl': serviceImageUrl,
      'bookingDate': bookingDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'status': status.name,
      'subtotal': subtotal,
      'tax': tax,
      'total': total,
      'items': items.map((item) => item.toJson()).toList(),
      'paymentMethodId': paymentMethodId,
    };
  }
}

typedef Booking = BookingModel;

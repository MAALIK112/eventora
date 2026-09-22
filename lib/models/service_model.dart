enum ServiceCategory {
  eventPlanning,
  venueBooking,
  staffHiring,
  securityServices,
  receptionServices,
  corporateEvents,
  weddings,
  privateParties,
  conferences,
  more,
}

class ServiceModel {
  final String id;
  final String name;
  final String description;
  final ServiceCategory category;
  final String imageUrl;
  final double price;
  final double rating;
  final int reviewCount;
  final List<String> features;
  final bool isAvailable;

  const ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.features,
    required this.isAvailable,
  });

  ServiceModel copyWith({
    String? id,
    String? name,
    String? description,
    ServiceCategory? category,
    String? imageUrl,
    double? price,
    double? rating,
    int? reviewCount,
    List<String>? features,
    bool? isAvailable,
  }) {
    return ServiceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      features: features ?? this.features,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      category: ServiceCategory.values.firstWhere(
        (e) => e.name == json['category'],
        orElse: () => ServiceCategory.more,
      ),
      imageUrl: json['imageUrl'] as String,
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      features: List<String>.from(json['features'] ?? []),
      isAvailable: json['isAvailable'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category.name,
      'imageUrl': imageUrl,
      'price': price,
      'rating': rating,
      'reviewCount': reviewCount,
      'features': features,
      'isAvailable': isAvailable,
    };
  }
}

typedef Service = ServiceModel;

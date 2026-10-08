import 'review_model.dart';

class ServicePackage {
  final String id;
  final String name;
  final String tier; // e.g. 'Silver', 'Gold', 'Platinum Luxe'
  final double price;
  final String duration;
  final String description;
  final List<String> features;
  final bool isPopular;

  const ServicePackage({
    required this.id,
    required this.name,
    required this.tier,
    required this.price,
    required this.duration,
    required this.description,
    required this.features,
    this.isPopular = false,
  });
}

class ServiceAddon {
  final String id;
  final String name;
  final double price;
  final String description;

  const ServiceAddon({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });
}

class ProviderInfo {
  final String id;
  final String name;
  final String avatar;
  final String title;
  final double rating;
  final int reviewsCount;
  final int eventsCompleted;
  final bool isVerified;
  final String responseTime;
  final String bio;
  final String location;

  const ProviderInfo({
    required this.id,
    required this.name,
    required this.avatar,
    required this.title,
    required this.rating,
    required this.reviewsCount,
    required this.eventsCompleted,
    this.isVerified = true,
    required this.responseTime,
    required this.bio,
    required this.location,
  });
}

class EventService {
  final String id;
  final String title;
  final String category;
  final String description;
  final String location;
  final double startingPrice;
  final double rating;
  final int reviewsCount;
  final List<String> images;
  final ProviderInfo provider;
  final List<ServicePackage> packages;
  final List<ServiceAddon> availableAddons;
  final List<Review> reviews;
  final List<String> highlights;
  final bool isFeatured;
  final bool isTopRated;
  final String cancellationPolicy;

  const EventService({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.location,
    required this.startingPrice,
    required this.rating,
    required this.reviewsCount,
    required this.images,
    required this.provider,
    required this.packages,
    required this.availableAddons,
    required this.reviews,
    required this.highlights,
    this.isFeatured = false,
    this.isTopRated = false,
    this.cancellationPolicy = 'Free cancellation up to 7 days before event. 50% refund up to 48 hours.',
  });
}

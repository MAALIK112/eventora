import 'service_model.dart';

class SuitedComponent {
  final EventService service;
  final ServicePackage selectedPackage;
  final double originalPrice;
  final double suitedPrice;
  final String role; // e.g. 'Primary Venue', 'Haute Catering', 'Cinematic Photography'

  const SuitedComponent({
    required this.service,
    required this.selectedPackage,
    required this.originalPrice,
    required this.suitedPrice,
    required this.role,
  });
}

class AutoSuitedBundle {
  final String id;
  final String title;
  final String theme;
  final String eventType;
  final int guestCapacity;
  final List<SuitedComponent> components;
  final double originalSubtotal;
  final double bundleDiscountPercent; // e.g. 15.0
  final double discountAmount;
  final double finalBundlePrice;
  final double matchScore; // e.g. 98.5%
  final String matchRationale;
  final List<String> includedPerks;

  const AutoSuitedBundle({
    required this.id,
    required this.title,
    required this.theme,
    required this.eventType,
    required this.guestCapacity,
    required this.components,
    required this.originalSubtotal,
    required this.bundleDiscountPercent,
    required this.discountAmount,
    required this.finalBundlePrice,
    required this.matchScore,
    required this.matchRationale,
    required this.includedPerks,
  });
}

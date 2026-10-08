import 'package:flutter/foundation.dart';
import '../models/auto_suit_model.dart';
import '../services/mock_data_service.dart';

class AutoSuitProvider extends ChangeNotifier {
  // Input parameters
  String _eventType = 'Wedding & Gala';
  int _guestCount = 150;
  double _targetBudget = 14000.0;
  String _preferredAesthetic = 'Royal Opulence & Estate Glasshouse';
  DateTime _targetDate = DateTime.now().add(const Duration(days: 45));

  bool _isGenerating = false;
  List<AutoSuitedBundle> _generatedBundles = [];
  AutoSuitedBundle? _selectedBundle;

  AutoSuitProvider() {
    generateSuitedBundles();
  }

  String get eventType => _eventType;
  int get guestCount => _guestCount;
  double get targetBudget => _targetBudget;
  String get preferredAesthetic => _preferredAesthetic;
  DateTime get targetDate => _targetDate;
  bool get isGenerating => _isGenerating;
  List<AutoSuitedBundle> get generatedBundles => _generatedBundles;
  AutoSuitedBundle? get selectedBundle => _selectedBundle;

  void setEventType(String type) {
    _eventType = type;
    notifyListeners();
  }

  void setGuestCount(int count) {
    _guestCount = count;
    notifyListeners();
  }

  void setTargetBudget(double budget) {
    _targetBudget = budget;
    notifyListeners();
  }

  void setPreferredAesthetic(String aesthetic) {
    _preferredAesthetic = aesthetic;
    notifyListeners();
  }

  void setTargetDate(DateTime date) {
    _targetDate = date;
    notifyListeners();
  }

  void selectBundle(AutoSuitedBundle bundle) {
    _selectedBundle = bundle;
    notifyListeners();
  }

  void generateSuitedBundles() {
    _isGenerating = true;
    notifyListeners();

    final allServices = MockDataService.getServices();
    final photo = allServices.firstWhere((s) => s.category == 'Photography');
    final venue = allServices.firstWhere((s) => s.category == 'Venues');
    final catering = allServices.firstWhere((s) => s.category == 'Catering');
    final planning =
        allServices.firstWhere((s) => s.category == 'Event Planning');
    final music = allServices.firstWhere((s) => s.category == 'Entertainment');

    // 1. Signature Curated Luxe Bundle
    final c1 = [
      SuitedComponent(
        service: venue,
        selectedPackage: venue.packages.length > 1
            ? venue.packages[1]
            : venue.packages[0], // Gold Glasshouse
        originalPrice: 8500.0,
        suitedPrice: 7225.0, // 15% synergy discount
        role: 'Exclusive Venue & Crystal Glasshouse',
      ),
      SuitedComponent(
        service: catering,
        selectedPackage: catering.packages.length > 1
            ? catering.packages[1]
            : catering.packages[0], // 5-Course
        originalPrice: 4800.0,
        suitedPrice: 4080.0,
        role: 'Michelin-Trained Haute Catering',
      ),
      SuitedComponent(
        service: photo,
        selectedPackage: photo.packages.length > 1
            ? photo.packages[1]
            : photo.packages[0], // Gold 10hr
        originalPrice: 3400.0,
        suitedPrice: 2890.0,
        role: 'Fine Art Cinematic Photography & Drone Reel',
      ),
      SuitedComponent(
        service: music,
        selectedPackage: music.packages[0], // String Quartet & DJ
        originalPrice: 1950.0,
        suitedPrice: 1657.5,
        role: 'Live Electric Symphony & DJ Ensemble',
      ),
    ];

    final subtotal1 = c1.fold(0.0, (s, c) => s + c.originalPrice);
    final total1 = c1.fold(0.0, (s, c) => s + c.suitedPrice);
    final discount1 = subtotal1 - total1;

    final bundle1 = AutoSuitedBundle(
      id: 'SUIT-LUXE-01',
      title: 'Grand Gala Royal Suited Collection',
      theme: 'Royal Opulence & Crystal Glasshouse',
      eventType: _eventType,
      guestCapacity: _guestCount,
      components: c1,
      originalSubtotal: subtotal1,
      bundleDiscountPercent: 15.0,
      discountAmount: discount1,
      finalBundlePrice: total1,
      matchScore: 99.2,
      matchRationale:
          'Perfect alignment with your $_guestCount guest scale. Synchronizes Bel-Air Pavilion load-in timeline with Chef Antoine’s 5-course plating and Elena Rostova’s sunset lighting schedule.',
      includedPerks: [
        'Dedicated VIP Master Producer Assigned Free (Worth \$3,500)',
        'Unified Single-Deposit Escrow Commitment',
        'Guaranteed Zero Schedule Conflicts Between Vendors',
        'Complimentary Dom Pérignon Champagne Tower Setup',
      ],
    );

    // 2. Modern Editorial Boutique Bundle
    final c2 = [
      SuitedComponent(
        service: venue,
        selectedPackage: venue.packages[0], // Sunset terrace
        originalPrice: 4500.0,
        suitedPrice: 3960.0,
        role: 'Sunset Terrace & Fountain Lawn',
      ),
      SuitedComponent(
        service: catering,
        selectedPackage: catering.packages[0], // Cocktail salon
        originalPrice: 2200.0,
        suitedPrice: 1936.0,
        role: 'Haute Canapés & Sommelier Salon',
      ),
      SuitedComponent(
        service: photo,
        selectedPackage: photo.packages[0], // Silver 6hr
        originalPrice: 1850.0,
        suitedPrice: 1628.0,
        role: 'Editorial Fine Art Photography',
      ),
      SuitedComponent(
        service: planning,
        selectedPackage: planning.packages[0], // Month-of coordination
        originalPrice: 3500.0,
        suitedPrice: 3080.0,
        role: 'Bespoke Logistics Producer',
      ),
    ];

    final subtotal2 = c2.fold(0.0, (s, c) => s + c.originalPrice);
    final total2 = c2.fold(0.0, (s, c) => s + c.suitedPrice);

    final bundle2 = AutoSuitedBundle(
      id: 'SUIT-BOUTIQUE-02',
      title: 'Boutique Intimate Milestone Suite',
      theme: 'Sunset Terraces & Cocktail Salon',
      eventType: _eventType,
      guestCapacity: (_guestCount * 0.7).toInt().clamp(20, 150),
      components: c2,
      originalSubtotal: subtotal2,
      bundleDiscountPercent: 12.0,
      discountAmount: subtotal2 - total2,
      finalBundlePrice: total2,
      matchScore: 96.8,
      matchRationale:
          'Optimized for high-impact visual elegance with lower logistics overhead. Includes full month-of coordination to handle all vendor timings.',
      includedPerks: [
        'Complimentary Vintage 35mm Analog Film Roll Included',
        '100% Escrow Protection & Flexible 7-Day Refund',
        'Single Master Timeline Managed by Haute Couture Producer',
      ],
    );

    _generatedBundles = [bundle1, bundle2];
    _selectedBundle = bundle1;
    _isGenerating = false;
    notifyListeners();
  }
}

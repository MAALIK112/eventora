import 'package:flutter/foundation.dart';
import '../models/admin_model.dart';

class AdminProvider extends ChangeNotifier {
  static const demoAdminEmail = 'admin@eventora.luxury';
  static const demoAdminPassword = 'EventoraAdmin2026!';

  bool _isAdminAuthenticated = false;

  AdminAnalytics _analytics = const AdminAnalytics(
    totalGmv: 248650.0,
    activeEscrowHold: 4275.0,
    totalCommissionEarned: 18640.0,
    totalBookingsCount: 38,
    activeVendorsCount: 24,
    activeUsersCount: 1420,
    satisfactionRate: 99.4,
  );

  int _nextVendorId = 103;

  final List<VendorApplication> _applications = [
    VendorApplication(
      id: 'APP-101',
      businessName: 'Lumière Pyrotechnics & Laser Displays',
      applicantName: 'Marc Dubost',
      category: 'Entertainment',
      location: 'Malibu & Santa Monica, CA',
      startingPrice: 3200.0,
      portfolioUrl: 'https://lumiere-pyro.com/portfolio',
      insuranceDocRef: 'INS-LLOYDS-9920-VAL',
      appliedAt: DateTime.now().subtract(const Duration(days: 2)),
      isApproved: false,
    ),
    VendorApplication(
      id: 'APP-102',
      businessName: 'Château Vintage Rolls-Royce & Bentley Fleet',
      applicantName: 'Arthur Kensington',
      category: 'Event Planning',
      location: 'Beverly Hills, CA',
      startingPrice: 1500.0,
      portfolioUrl: 'https://chateau-fleet.luxury',
      insuranceDocRef: 'INS-CHUBB-8831-VAL',
      appliedAt: DateTime.now().subtract(const Duration(days: 5)),
      isApproved: true,
    ),
  ];

  bool get isAdminAuthenticated => _isAdminAuthenticated;
  AdminAnalytics get analytics => _analytics;
  List<VendorApplication> get applications => List.unmodifiable(_applications);

  bool authenticateAdmin({required String email, required String password}) {
    final authenticated = email.trim().toLowerCase() == demoAdminEmail &&
        password == demoAdminPassword;
    if (_isAdminAuthenticated != authenticated) {
      _isAdminAuthenticated = authenticated;
      notifyListeners();
    }
    return authenticated;
  }

  void endAdminSession() {
    if (_isAdminAuthenticated) {
      _isAdminAuthenticated = false;
      notifyListeners();
    }
  }

  VendorApplication addVendorApplication({
    required String businessName,
    required String applicantName,
    required String category,
    required String location,
    required double startingPrice,
    required String portfolioUrl,
    required String insuranceDocRef,
  }) {
    _requireAdminSession();
    final application = VendorApplication(
      id: 'APP-${_nextVendorId++}',
      businessName: _requiredText(businessName, 'businessName'),
      applicantName: _requiredText(applicantName, 'applicantName'),
      category: _requiredText(category, 'category'),
      location: _requiredText(location, 'location'),
      startingPrice: _validatedPrice(startingPrice),
      portfolioUrl: _requiredText(portfolioUrl, 'portfolioUrl'),
      insuranceDocRef: _requiredText(insuranceDocRef, 'insuranceDocRef'),
      appliedAt: DateTime.now(),
    );
    _applications.insert(0, application);
    notifyListeners();
    return application;
  }

  void updateVendorApplication({
    required String id,
    required String businessName,
    required String applicantName,
    required String category,
    required String location,
    required double startingPrice,
    required String portfolioUrl,
    required String insuranceDocRef,
  }) {
    _requireAdminSession();
    final index =
        _applications.indexWhere((application) => application.id == id);
    if (index == -1) throw ArgumentError.value(id, 'id', 'Vendor not found');

    _applications[index] = _applications[index].copyWith(
      businessName: _requiredText(businessName, 'businessName'),
      applicantName: _requiredText(applicantName, 'applicantName'),
      category: _requiredText(category, 'category'),
      location: _requiredText(location, 'location'),
      startingPrice: _validatedPrice(startingPrice),
      portfolioUrl: _requiredText(portfolioUrl, 'portfolioUrl'),
      insuranceDocRef: _requiredText(insuranceDocRef, 'insuranceDocRef'),
    );
    notifyListeners();
  }

  bool deleteVendorApplication(String id) {
    _requireAdminSession();
    final index =
        _applications.indexWhere((application) => application.id == id);
    if (index == -1) return false;

    final wasApproved = _applications[index].isApproved;
    _applications.removeAt(index);
    if (wasApproved) {
      _analytics = _analytics.copyWith(
        activeVendorsCount: _analytics.activeVendorsCount > 0
            ? _analytics.activeVendorsCount - 1
            : 0,
      );
    }
    notifyListeners();
    return true;
  }

  void approveVendorApplication(String appId) {
    _requireAdminSession();
    final index = _applications.indexWhere((a) => a.id == appId);
    if (index != -1 && !_applications[index].isApproved) {
      final old = _applications[index];
      _applications[index] = VendorApplication(
        id: old.id,
        businessName: old.businessName,
        applicantName: old.applicantName,
        category: old.category,
        location: old.location,
        startingPrice: old.startingPrice,
        portfolioUrl: old.portfolioUrl,
        insuranceDocRef: old.insuranceDocRef,
        appliedAt: old.appliedAt,
        isApproved: true,
      );
      _analytics = AdminAnalytics(
        totalGmv: _analytics.totalGmv,
        activeEscrowHold: _analytics.activeEscrowHold,
        totalCommissionEarned: _analytics.totalCommissionEarned,
        totalBookingsCount: _analytics.totalBookingsCount,
        activeVendorsCount: _analytics.activeVendorsCount + 1,
        activeUsersCount: _analytics.activeUsersCount,
        satisfactionRate: _analytics.satisfactionRate,
      );
      notifyListeners();
    }
  }

  void releaseEscrowToVendor(double amount) {
    _requireAdminSession();
    if (!amount.isFinite ||
        amount <= 0 ||
        amount > _analytics.activeEscrowHold) {
      throw ArgumentError.value(
          amount, 'amount', 'Invalid escrow release amount');
    }

    _analytics = AdminAnalytics(
      totalGmv: _analytics.totalGmv,
      activeEscrowHold:
          (_analytics.activeEscrowHold - amount).clamp(0, double.infinity),
      totalCommissionEarned: _analytics.totalCommissionEarned + (amount * 0.04),
      totalBookingsCount: _analytics.totalBookingsCount,
      activeVendorsCount: _analytics.activeVendorsCount,
      activeUsersCount: _analytics.activeUsersCount,
      satisfactionRate: _analytics.satisfactionRate,
    );
    notifyListeners();
  }

  void _requireAdminSession() {
    if (!_isAdminAuthenticated) {
      throw StateError('Admin sign-in is required for this operation.');
    }
  }

  String _requiredText(String value, String field) {
    final normalized = value.trim();
    if (normalized.isEmpty) {
      throw ArgumentError.value(value, field, 'This field is required');
    }
    return normalized;
  }

  double _validatedPrice(double value) {
    if (!value.isFinite || value < 0) {
      throw ArgumentError.value(
          value, 'startingPrice', 'Price must be positive');
    }
    return value;
  }
}

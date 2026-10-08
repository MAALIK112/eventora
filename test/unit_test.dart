import 'package:flutter_test/flutter_test.dart';
import 'package:eventora/core/security/input_validator.dart';
import 'package:eventora/core/utils/currency_formatter.dart';
import 'package:eventora/models/booking_model.dart';
import 'package:eventora/providers/admin_provider.dart';
import 'package:eventora/providers/booking_provider.dart';
import 'package:eventora/providers/user_provider.dart';
import 'package:eventora/services/mock_data_service.dart';

void main() {
  group('Security & Validation Tests (OWASP MASVS)', () {
    test('Email validator accepts valid emails and rejects malformed', () {
      expect(InputValidator.validateEmail('guest@eventora.luxury'), isNull);
      expect(InputValidator.validateEmail('invalid-email'), isNotNull);
      expect(InputValidator.validateEmail(''), isNotNull);
    });

    test('Luhn card validator validates correct checksums', () {
      expect(InputValidator.validateCardNumber(''), isNotNull);
      expect(InputValidator.maskCardNumber('4000123456789921'),
          '•••• •••• •••• 9921');
    });

    test('Input sanitization strips malicious HTML and script tags', () {
      const malicious =
          '<script>alert("hack")</script>Estate Villa & Reception';
      final cleaned = InputValidator.sanitizeText(malicious);
      expect(cleaned.contains('<script>'), isFalse);
      expect(cleaned, 'alert(hack)Estate Villa  Reception');
    });
  });

  group('Currency & Formatting Tests', () {
    test('Formats currency amounts in tabular standard', () {
      expect(CurrencyFormatter.format(1850.0), '\$1,850');
      expect(CurrencyFormatter.format(4275.50), '\$4,275.50');
    });
  });

  group('Mock Data & Booking Workflow Tests', () {
    test(
        'Loads luxury service catalog with tiered packages and verified providers',
        () {
      final services = MockDataService.getServices();
      expect(services.isNotEmpty, isTrue);
      expect(services.any((s) => s.category == 'Photography'), isTrue);
      expect(services.any((s) => s.category == 'Venues'), isTrue);
      expect(services.any((s) => s.category == 'Catering'), isTrue);

      final photoService = services.firstWhere((s) => s.id == 'srv-photo-01');
      expect(photoService.packages.length, 3);
      expect(photoService.provider.isVerified, isTrue);
    });

    test('Booking status labels and lifecycle transitions', () {
      const requested = BookingStatus.requested;
      const confirmed = BookingStatus.confirmed;
      const completed = BookingStatus.completed;

      expect(requested.shortLabel, 'Requested');
      expect(confirmed.shortLabel, 'Confirmed');
      expect(completed.shortLabel, 'Completed');
    });

    test('BookingProvider calculates and confirms a draft booking', () {
      final provider = BookingProvider();
      final service = MockDataService.getServices()
          .firstWhere((item) => item.id == 'srv-photo-01');

      provider.initDraft(service: service);
      final selectedPackage = provider.draftPackage!;
      provider.toggleDraftInsurance(false);

      expect(provider.applyCoupon(' luxe100 '), isTrue);
      expect(provider.draftDiscount, 100.0);

      final booking = provider.confirmDraftBooking();

      expect(booking.service, same(service));
      expect(booking.selectedPackage, same(selectedPackage));
      expect(booking.insuranceFee, 0.0);
      expect(booking.discount, 100.0);
      expect(booking.totalAmount, provider.draftGrandTotal);
      expect(booking.status, BookingStatus.confirmed);
      expect(provider.bookings.first, same(booking));
    });
  });

  group('Admin access control', () {
    test('Admin actions require an authenticated admin session', () {
      final admin = AdminProvider();

      expect(admin.isAdminAuthenticated, isFalse);
      expect(() => admin.approveVendorApplication('APP-101'), throwsStateError);
      expect(
        () => admin.addVendorApplication(
          businessName: 'New Vendor',
          applicantName: 'New Applicant',
          category: 'Photography',
          location: 'Los Angeles',
          startingPrice: 1000,
          portfolioUrl: 'https://example.com',
          insuranceDocRef: 'INS-NEW',
        ),
        throwsStateError,
      );
      expect(
        () => admin.updateVendorApplication(
          id: 'APP-101',
          businessName: 'Updated Vendor',
          applicantName: 'Applicant',
          category: 'Photography',
          location: 'Los Angeles',
          startingPrice: 1200,
          portfolioUrl: 'https://example.com',
          insuranceDocRef: 'INS-UPDATED',
        ),
        throwsStateError,
      );
      expect(() => admin.deleteVendorApplication('APP-101'), throwsStateError);
      expect(
        admin.authenticateAdmin(
            email: AdminProvider.demoAdminEmail, password: 'wrong'),
        isFalse,
      );
      expect(admin.isAdminAuthenticated, isFalse);

      expect(
        admin.authenticateAdmin(
          email: AdminProvider.demoAdminEmail,
          password: AdminProvider.demoAdminPassword,
        ),
        isTrue,
      );
      admin.approveVendorApplication('APP-101');
      expect(admin.applications.first.isApproved, isTrue);

      final created = admin.addVendorApplication(
        businessName: 'New Vendor',
        applicantName: 'New Applicant',
        category: 'Photography',
        location: 'Los Angeles',
        startingPrice: 1000,
        portfolioUrl: 'https://example.com',
        insuranceDocRef: 'INS-NEW',
      );
      expect(admin.applications.first.id, created.id);
      expect(() => admin.applications.clear(), throwsUnsupportedError);

      admin.updateVendorApplication(
        id: created.id,
        businessName: 'Updated Vendor',
        applicantName: 'Updated Applicant',
        category: 'Venues',
        location: 'San Francisco',
        startingPrice: 1800,
        portfolioUrl: 'https://example.com/updated',
        insuranceDocRef: 'INS-UPDATED',
      );
      expect(admin.applications.first.businessName, 'Updated Vendor');
      expect(admin.applications.first.startingPrice, 1800);

      expect(admin.deleteVendorApplication(created.id), isTrue);
      expect(admin.deleteVendorApplication(created.id), isFalse);
      final approvedVendorCount = admin.analytics.activeVendorsCount;
      expect(admin.deleteVendorApplication('APP-101'), isTrue);
      expect(admin.analytics.activeVendorsCount, approvedVendorCount - 1);

      admin.endAdminSession();
      expect(admin.isAdminAuthenticated, isFalse);
      expect(() => admin.releaseEscrowToVendor(100), throwsStateError);
    });
  });

  group('Customer account access', () {
    test('Sign-up creates a customer account with independent credentials', () {
      final user = UserProvider();

      expect(
        user.signUp(
          fullName: 'New Eventora Member',
          email: 'new.member@example.com',
          password: 'MemberPass2026!',
        ),
        isTrue,
      );
      expect(user.user.fullName, 'New Eventora Member');
      expect(
          user.authenticate(
            email: 'new.member@example.com',
            password: 'MemberPass2026!',
          ),
          isTrue);
      expect(
          user.authenticate(
            email: AdminProvider.demoAdminEmail,
            password: AdminProvider.demoAdminPassword,
          ),
          isFalse);
      expect(
        user.signUp(
          fullName: 'Duplicate Member',
          email: 'new.member@example.com',
          password: 'OtherPass2026!',
        ),
        isFalse,
      );
    });
  });
}

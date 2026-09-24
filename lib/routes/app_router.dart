import 'package:flutter/material.dart';
import 'package:eventora/pages/splash_page.dart';
import 'package:eventora/pages/login_page.dart';
import 'package:eventora/pages/signup_page.dart';
import 'package:eventora/pages/main_shell.dart';
import 'package:eventora/pages/home_page.dart';
import 'package:eventora/pages/service_listing_page.dart';
import 'package:eventora/pages/service_detail_page.dart';
import 'package:eventora/pages/event_planning_page.dart';
import 'package:eventora/pages/booking_confirmation_page.dart';
import 'package:eventora/pages/payment_page.dart';
import 'package:eventora/pages/order_confirmation_page.dart';
import 'package:eventora/pages/my_bookings_page.dart';
import 'package:eventora/pages/booking_detail_page.dart';
import 'package:eventora/pages/wallet_page.dart';
import 'package:eventora/pages/add_funds_page.dart';
import 'package:eventora/pages/profile_page.dart';
import 'package:eventora/pages/edit_profile_page.dart';
import 'package:eventora/pages/settings_page.dart';
import 'package:eventora/pages/support_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String mainShell = '/mainShell';
  static const String serviceList = '/serviceList';
  static const String serviceDetail = '/serviceDetail';
  static const String eventPlanning = '/eventPlanning';
  static const String bookingConfirmation = '/bookingConfirmation';
  static const String payment = '/payment';
  static const String orderConfirmation = '/orderConfirmation';
  static const String myBookings = '/myBookings';
  static const String bookingDetail = '/bookingDetail';
  static const String wallet = '/wallet';
  static const String addFunds = '/addFunds';
  static const String profile = '/profile';
  static const String editProfile = '/editProfile';
  static const String settings = '/settings';
  static const String support = '/support';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupPage());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case mainShell:
        return MaterialPageRoute(builder: (_) => const MainShell());
      case serviceList:
        final args = routeSettings.arguments as String?;
        return MaterialPageRoute(
            builder: (_) => ServiceListingPage(category: args ?? 'Services'));
      case serviceDetail:
        final args = routeSettings.arguments as String?;
        return MaterialPageRoute(
            builder: (_) => ServiceDetailPage(serviceId: args ?? ''));
      case eventPlanning:
        return MaterialPageRoute(builder: (_) => const EventPlanningPage());
      case bookingConfirmation:
        return MaterialPageRoute(
            builder: (_) => const BookingConfirmationPage());
      case payment:
        return MaterialPageRoute(builder: (_) => const PaymentPage());
      case orderConfirmation:
        return MaterialPageRoute(builder: (_) => const OrderConfirmationPage());
      case myBookings:
        return MaterialPageRoute(builder: (_) => const MyBookingsPage());
      case bookingDetail:
        final args = routeSettings.arguments as String?;
        return MaterialPageRoute(
            builder: (_) => BookingDetailPage(bookingId: args ?? ''));
      case wallet:
        return MaterialPageRoute(builder: (_) => const WalletPage());
      case addFunds:
        return MaterialPageRoute(builder: (_) => const AddFundsPage());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfilePage());
      case settings:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      case support:
        return MaterialPageRoute(builder: (_) => const SupportPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
                child: Text('No route defined for ${routeSettings.name}')),
          ),
        );
    }
  }
}

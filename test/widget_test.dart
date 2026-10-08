// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:eventora/providers/admin_provider.dart';
import 'package:eventora/providers/booking_provider.dart';
import 'package:eventora/providers/support_provider.dart';
import 'package:eventora/providers/user_provider.dart';
import 'package:eventora/screens/auth/login_screen.dart';
import 'package:eventora/screens/auth/sign_up_screen.dart';

void main() {
  testWidgets('BookingProvider notifies dashboard consumers',
      (WidgetTester tester) async {
    final provider = BookingProvider();
    final booking = provider.upcomingBookings.first;
    final initialCount = provider.upcomingBookings.length;

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: provider,
        child: MaterialApp(
          home: Builder(
            builder: (context) => Text(
              '${context.watch<BookingProvider>().upcomingBookings.length} upcoming',
            ),
          ),
        ),
      ),
    );
    expect(find.text('$initialCount upcoming'), findsOneWidget);

    provider.cancelBooking(booking.id);
    await tester.pump();

    expect(find.text('${initialCount - 1} upcoming'), findsOneWidget);
  });

  testWidgets('Admin login opens the protected operations console',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AdminProvider()),
          ChangeNotifierProvider(create: (_) => BookingProvider()),
          ChangeNotifierProvider(create: (_) => SupportProvider()),
        ],
        child: const MaterialApp(
          home: LoginScreen.admin(),
        ),
      ),
    );

    await tester.enterText(
      find.byType(TextFormField).at(0),
      AdminProvider.demoAdminEmail,
    );
    await tester.enterText(
      find.byType(TextFormField).at(1),
      AdminProvider.demoAdminPassword,
    );
    await tester.tap(find.text('Sign in to admin console'));
    await tester.pumpAndSettle();

    expect(find.text('Eventora Master Operations'), findsOneWidget);

    await tester.tap(find.text('Vendor Onboarding'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add vendor'));
    await tester.pumpAndSettle();

    Future<void> enterField(int index, String value) async {
      final field = find.byType(TextFormField).at(index);
      await tester.enterText(field, value);
      await tester.pump();
    }

    await enterField(0, 'Test Vendor');
    await enterField(1, 'Taylor Vendor');
    await enterField(2, 'Photography');
    await enterField(3, 'Los Angeles');
    await enterField(4, '1250');
    await enterField(5, 'https://example.com/portfolio');
    await enterField(6, 'INS-TEST-01');
    await tester.tap(find.widgetWithText(FilledButton, 'Add vendor').last);
    await tester.pumpAndSettle();

    expect(find.text('Test Vendor'), findsOneWidget);
    await tester.tap(find.byTooltip('Edit Test Vendor'));
    await tester.pumpAndSettle();
    await enterField(0, 'Edited Test Vendor');
    await tester.tap(find.text('Save changes'));
    await tester.pumpAndSettle();

    expect(find.text('Edited Test Vendor'), findsOneWidget);
    await tester.tap(find.byTooltip('Delete Edited Test Vendor'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(find.text('Edited Test Vendor'), findsNothing);
  });

  testWidgets('Customer login offers one role and customer-only sign-up',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AdminProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
        ],
        child: const MaterialApp(home: LoginScreen()),
      ),
    );

    expect(find.byType(SegmentedButton<bool>), findsNothing);
    expect(find.text('Create a customer account'), findsOneWidget);

    await tester.tap(find.text('Create a customer account'));
    await tester.pumpAndSettle();

    expect(find.byType(SignUpScreen), findsOneWidget);
    expect(find.text('Create customer account'), findsOneWidget);
    expect(find.text('Administrator sign in'), findsNothing);
  });
}

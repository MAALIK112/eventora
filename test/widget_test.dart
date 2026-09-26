// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:eventora/app.dart';
import 'package:eventora/widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Eventora app loads on mobile', (WidgetTester tester) async {
    await tester.pumpWidget(const EventoraApp());

    expect(find.text('Log In'), findsOneWidget);
    expect(find.text('Create Account'), findsNothing);
  });

  testWidgets('successful login opens the main app shell',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const EventoraApp());

    await tester.tap(find.text('Log In'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(EventoraButton, 'Log In'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text('Our Services'), findsOneWidget);
  });
}

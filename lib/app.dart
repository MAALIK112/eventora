import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eventora/providers/auth_provider.dart';
import 'package:eventora/providers/bookings_provider.dart';
import 'package:eventora/providers/navigation_provider.dart';
import 'package:eventora/providers/services_provider.dart';
import 'package:eventora/providers/wallet_provider.dart';
import 'package:eventora/routes/app_router.dart';
import 'package:eventora/styles/app_theme.dart';

class EventoraApp extends StatelessWidget {
  const EventoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ServicesProvider()),
        ChangeNotifierProvider(create: (_) => BookingsProvider()),
        ChangeNotifierProvider(create: (_) => WalletProvider()),
      ],
      child: MaterialApp(
        title: 'Eventora',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: AppRouter.splash,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}

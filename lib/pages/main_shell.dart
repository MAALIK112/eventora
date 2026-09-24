import 'package:flutter/material.dart';
import 'package:eventora/pages/home_page.dart';
import 'package:eventora/pages/my_bookings_page.dart';
import 'package:eventora/pages/wallet_page.dart';
import 'package:eventora/pages/profile_page.dart';
import 'package:eventora/providers/navigation_provider.dart';
import 'package:eventora/widgets/bottom_navigation.dart';
import 'package:provider/provider.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavigationProvider>();

    return Scaffold(
      body: IndexedStack(
        index: navProvider.currentIndex,
        children: const [
          HomePage(),
          MyBookingsPage(),
          WalletPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: EventoraBottomNav(
        currentIndex: navProvider.currentIndex,
        onTap: (index) => navProvider.setIndex(index),
      ),
    );
  }
}

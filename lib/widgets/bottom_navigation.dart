import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eventora/providers/navigation_provider.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_typography.dart';
import 'package:eventora/styles/app_shadows.dart';

class EventoraBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const EventoraBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    context.watch<NavigationProvider>();
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: Border(
          top: BorderSide(color: AppColors.warmLinenBorder, width: 1.0),
        ),
        boxShadow: AppShadows.level2,
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.mutedText,
        selectedLabelStyle:
            AppTypography.labelMD.copyWith(fontWeight: FontWeight.bold),
        unselectedLabelStyle: AppTypography.labelMD,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_rounded),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

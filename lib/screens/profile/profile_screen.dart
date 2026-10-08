import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../providers/admin_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/luxe_card.dart';
import '../auto_suit/auto_suit_screen.dart';
import '../support/support_screen.dart';
import '../auth/login_screen.dart';
import 'edit_profile_screen.dart';
import 'security_center_screen.dart';
import 'settings_screen.dart';
import 'wishlist_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Text(
          'Private Membership',
          style: AppTypography.headlineMedium.copyWith(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        child: Column(
          children: [
            // User Avatar & Name Card
            LuxeCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 42,
                        backgroundImage: NetworkImage(user.avatarUrl),
                        backgroundColor: AppColors.surfaceContainerHigh,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: AppColors.deepAmber,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.star,
                              color: Colors.white, size: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    user.fullName,
                    style: AppTypography.headlineMedium.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    user.email,
                    style: AppTypography.bodySmall,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.amberLight,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      user.memberTier.toUpperCase(),
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.deepAmber,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const Divider(color: AppColors.warmLinen, height: 24),

                  // Membership metrics
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildProfileStat(
                          'Celebrations Hosted', '${user.eventsHosted}'),
                      Container(
                          width: 1, height: 28, color: AppColors.warmLinen),
                      _buildProfileStat('Escrow Status', 'Protected'),
                      Container(
                          width: 1, height: 28, color: AppColors.warmLinen),
                      _buildProfileStat('VIP Concierge', 'Priority Access'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Navigation Menu Options
            LuxeCard(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  _buildMenuItem(
                    icon: Icons.person_outline,
                    title: 'Edit Personal Profile',
                    subtitle: 'Manage name, phone, email & residence',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const EditProfileScreen()),
                      );
                    },
                  ),
                  const Divider(color: AppColors.warmLinen),
                  _buildMenuItem(
                    icon: Icons.security_outlined,
                    title: 'Security & Vault Center',
                    subtitle: 'Biometrics, 2FA, PIN & hardware encryption',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const SecurityCenterScreen()),
                      );
                    },
                  ),
                  const Divider(color: AppColors.warmLinen),
                  _buildMenuItem(
                    icon: Icons.favorite_border,
                    title: 'Saved Curations (Wishlist)',
                    subtitle: 'View saved vendors and venues',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const WishlistScreen()),
                      );
                    },
                  ),
                  const Divider(color: AppColors.warmLinen),
                  _buildMenuItem(
                    icon: Icons.auto_awesome,
                    title: 'AI Auto-Suiting Concierge',
                    subtitle: 'Synthesize & bundle multi-vendor packages',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const AutoSuitScreen()),
                      );
                    },
                  ),
                  const Divider(color: AppColors.warmLinen),
                  _buildMenuItem(
                    icon: Icons.support_agent_outlined,
                    title: 'Help & Concierge Support',
                    subtitle: '24/7 Live chat, ticket resolution & FAQs',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const SupportScreen()),
                      );
                    },
                  ),
                  const Divider(color: AppColors.warmLinen),
                  _buildMenuItem(
                    icon: Icons.tune_outlined,
                    title: 'Settings & Notifications',
                    subtitle: 'Currency, notifications & preferences',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const SettingsScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Log out button
            TextButton.icon(
              onPressed: () {
                context.read<AdminProvider>().endAdminSession();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (_) => false,
                );
              },
              icon: const Icon(Icons.logout, color: AppColors.error, size: 18),
              label: Text(
                'Log Out of Eventora Account',
                style:
                    AppTypography.labelMedium.copyWith(color: AppColors.error),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.titleSmall.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.deepAmber,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.alabasterVeil,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.deepAmber, size: 20),
        ),
        title: Text(
          title,
          style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          subtitle,
          style: AppTypography.bodySmall.copyWith(fontSize: 11),
        ),
        trailing: const Icon(Icons.arrow_forward_ios,
            size: 14, color: AppColors.mutedStone),
        onTap: onTap,
      ),
    );
  }
}

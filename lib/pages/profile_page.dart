import 'package:flutter/material.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_typography.dart';
import 'package:eventora/styles/app_spacing.dart';
import 'package:eventora/widgets/eventora_button.dart';
import 'package:eventora/routes/app_router.dart';
import 'package:eventora/providers/auth_provider.dart';
import 'package:eventora/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.currentUser;

    return Scaffold(
      backgroundColor: AppColors.canvasBase,
      appBar: AppBar(
        backgroundColor: AppColors.canvasBase,
        elevation: 0,
        title: Text('Profile', style: AppTypography.headlineMD),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.marginMobile),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.primary,
              child: Icon(Icons.person, size: 40, color: AppColors.surfaceContainerLowest),
            ),
            const SizedBox(height: 16),
            Text(user?.name ?? 'User Name', style: AppTypography.headlineLG),
            const SizedBox(height: 4),
            Text(user?.email ?? 'user@example.com', style: AppTypography.bodyMD.copyWith(color: AppColors.mutedText)),
            const SizedBox(height: 24),
            EventoraButton(
              text: 'Edit Profile',
              isOutlined: true,
              onPressed: () => Navigator.pushNamed(context, AppRouter.editProfile),
            ),
            const SizedBox(height: 32),
            _buildMenuTile(
              icon: Icons.location_on_outlined,
              title: 'Saved Addresses',
              onTap: () {},
            ),
            _buildMenuTile(
              icon: Icons.favorite_border,
              title: 'Favorite Services',
              onTap: () {},
            ),
            _buildMenuTile(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () => Navigator.pushNamed(context, AppRouter.settings),
            ),
            _buildMenuTile(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () => Navigator.pushNamed(context, AppRouter.support),
            ),
            const SizedBox(height: 32),
            EventoraButton(
              text: 'Log Out',
              isFullWidth: true,
              isOutlined: true,
              onPressed: () async {
                await context.read<AuthProvider>().logout();
                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(context, AppRouter.splash, (route) => false);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuTile({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(title, style: AppTypography.labelLG),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.mutedText),
      onTap: onTap,
    );
  }
}

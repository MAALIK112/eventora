import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../providers/user_provider.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/luxe_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const CustomAppBar(title: 'Settings & Preferences'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notification Preferences',
              style: AppTypography.headlineMedium.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 10),
            LuxeCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Push Notifications',
                        style: AppTypography.titleSmall
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(
                        'Live status updates, milestones, and concierge alerts',
                        style: AppTypography.bodySmall,
                      ),
                      value: user.pushNotifications,
                      activeThumbColor: AppColors.deepAmber,
                      onChanged: (val) =>
                          userProvider.togglePushNotifications(val),
                    ),
                  ),
                  const Divider(color: AppColors.warmLinen),
                  Material(
                    color: Colors.transparent,
                    child: SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Email Invoices & Statements',
                        style: AppTypography.titleSmall
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(
                        'Automated receipts and provider contracts sent to your inbox',
                        style: AppTypography.bodySmall,
                      ),
                      value: user.emailNotifications,
                      activeThumbColor: AppColors.deepAmber,
                      onChanged: (val) =>
                          userProvider.toggleEmailNotifications(val),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Localization & Currency',
              style: AppTypography.headlineMedium.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 10),
            LuxeCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildSettingRow(
                    context,
                    'Display Currency',
                    'USD (\$)',
                    Icons.monetization_on_outlined,
                  ),
                  const Divider(color: AppColors.warmLinen, height: 20),
                  _buildSettingRow(
                    context,
                    'Language',
                    'English (US)',
                    Icons.language_outlined,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Legal & Compliance',
              style: AppTypography.headlineMedium.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 10),
            LuxeCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildSettingRow(
                    context,
                    'Eventora Master Service Terms',
                    '',
                    Icons.description_outlined,
                  ),
                  const Divider(color: AppColors.warmLinen, height: 20),
                  _buildSettingRow(
                    context,
                    'Privacy & Data Retention Policy',
                    '',
                    Icons.privacy_tip_outlined,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingRow(
      BuildContext context, String title, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.deepAmber),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style:
                AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        if (value.isNotEmpty)
          Text(
            value,
            style:
                AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w700),
          ),
        const SizedBox(width: 6),
        const Icon(Icons.arrow_forward_ios,
            size: 14, color: AppColors.mutedStone),
      ],
    );
  }
}

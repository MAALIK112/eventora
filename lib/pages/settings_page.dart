import 'package:flutter/material.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_typography.dart';
import 'package:eventora/widgets/custom_app_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;
  bool darkModeEnabled = false;
  bool locationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasBase,
      appBar: const CustomAppBar(title: 'Settings'),
      body: ListView(
        children: [
          _buildSectionHeader('Preferences'),
          SwitchListTile(
            title: Text('Push Notifications', style: AppTypography.bodyLG),
            value: notificationsEnabled,
            onChanged: (val) => setState(() => notificationsEnabled = val),
            activeColor: AppColors.primary,
          ),
          SwitchListTile(
            title: Text('Dark Mode', style: AppTypography.bodyLG),
            value: darkModeEnabled,
            onChanged: (val) => setState(() => darkModeEnabled = val),
            activeColor: AppColors.primary,
          ),
          SwitchListTile(
            title: Text('Location Services', style: AppTypography.bodyLG),
            value: locationEnabled,
            onChanged: (val) => setState(() => locationEnabled = val),
            activeColor: AppColors.primary,
          ),
          const Divider(),
          _buildSectionHeader('General'),
          ListTile(
            title: Text('Language', style: AppTypography.bodyLG),
            trailing: Text('English', style: AppTypography.bodyMD.copyWith(color: AppColors.mutedText)),
            onTap: () {},
          ),
          ListTile(
            title: Text('Privacy Policy', style: AppTypography.bodyLG),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          ListTile(
            title: Text('Terms of Service', style: AppTypography.bodyLG),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: Text('App Version', style: AppTypography.bodyLG),
            trailing: Text('1.0.0', style: AppTypography.bodyMD.copyWith(color: AppColors.mutedText)),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: AppTypography.labelLG.copyWith(color: AppColors.primary),
      ),
    );
  }
}

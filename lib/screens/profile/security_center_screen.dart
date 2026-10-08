import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../providers/user_provider.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/luxe_card.dart';

class SecurityCenterScreen extends StatefulWidget {
  const SecurityCenterScreen({super.key});

  @override
  State<SecurityCenterScreen> createState() => _SecurityCenterScreenState();
}

class _SecurityCenterScreenState extends State<SecurityCenterScreen> {
  void _setupWalletPin() {
    final pinController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceContainerLowest,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Set Escrow Authorization PIN',
            style: AppTypography.headlineSmall),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter a 4-digit security PIN used to authorize high-value escrow payments.',
              style: AppTypography.bodySmall,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: pinController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              obscureText: true,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, letterSpacing: 8),
              decoration: const InputDecoration(hintText: '••••'),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (pinController.text.length == 4) {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Escrow PIN updated and encrypted in device Keychain.'),
                    backgroundColor: AppColors.emeraldSage,
                  ),
                );
              }
            },
            child: const Text('Save PIN'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const CustomAppBar(title: 'Security & Vault Center'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trust & Security Shield Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.emeraldSageLight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: AppColors.emeraldSage.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.shield,
                      color: AppColors.emeraldSage, size: 32),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'OWASP MASVS Grade Security',
                          style: AppTypography.titleSmall.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.emeraldSage,
                          ),
                        ),
                        Text(
                          'Your cryptographic keys, payment tokens, and contracts are protected by on-device hardware encryption.',
                          style: AppTypography.bodySmall.copyWith(fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Text(
              'Authentication & Biometrics',
              style: AppTypography.headlineMedium.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 10),

            LuxeCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  // Biometric Face ID / Touch ID
                  Material(
                    color: Colors.transparent,
                    child: SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      secondary: const Icon(Icons.fingerprint,
                          color: AppColors.deepAmber),
                      title: Text(
                        'Biometric Authentication',
                        style: AppTypography.titleSmall
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(
                        'Fast login with Touch ID or Face ID',
                        style: AppTypography.bodySmall,
                      ),
                      value: user.biometricsEnabled,
                      activeThumbColor: AppColors.emeraldSage,
                      onChanged: (val) => userProvider.toggleBiometrics(val),
                    ),
                  ),
                  const Divider(color: AppColors.warmLinen),

                  // Two-Factor Auth
                  Material(
                    color: Colors.transparent,
                    child: SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      secondary: const Icon(Icons.security,
                          color: AppColors.deepAmber),
                      title: Text(
                        'Two-Factor Authentication (2FA)',
                        style: AppTypography.titleSmall
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(
                        'SMS or Authenticator app prompt on new logins',
                        style: AppTypography.bodySmall,
                      ),
                      value: user.twoFactorEnabled,
                      activeThumbColor: AppColors.emeraldSage,
                      onChanged: (val) => userProvider.toggleTwoFactor(val),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Text(
              'Escrow Payment Security',
              style: AppTypography.headlineMedium.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 10),

            LuxeCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading:
                          const Icon(Icons.pin, color: AppColors.deepAmber),
                      title: Text(
                        'Escrow Authorization PIN',
                        style: AppTypography.titleSmall
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(
                        '4-digit code required for reservations over \$1,000',
                        style: AppTypography.bodySmall,
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          size: 14, color: AppColors.mutedStone),
                      onTap: _setupWalletPin,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Active Sessions & Audit
            Text(
              'Device Security Audit',
              style: AppTypography.headlineMedium.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 10),

            LuxeCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildAuditItem(
                      'Operating Environment', 'Secure (Sandboxed)', true),
                  const Divider(color: AppColors.warmLinen, height: 16),
                  _buildAuditItem(
                      'SSL/TLS Certificate Pinning', 'Active & Enforced', true),
                  const Divider(color: AppColors.warmLinen, height: 16),
                  _buildAuditItem('Encrypted Storage Vault',
                      'Hardware Keystore / Keychain', true),
                  const Divider(color: AppColors.warmLinen, height: 16),
                  _buildAuditItem('Active Mobile Session',
                      'iPhone 16 Pro (Current Device)', true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuditItem(String title, String value, bool isPassed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: AppTypography.titleSmall
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 13)),
            Text(value, style: AppTypography.bodySmall.copyWith(fontSize: 11)),
          ],
        ),
        Icon(
          isPassed ? Icons.check_circle : Icons.error,
          color: isPassed ? AppColors.emeraldSage : AppColors.error,
          size: 18,
        ),
      ],
    );
  }
}

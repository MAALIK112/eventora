import 'package:flutter/material.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_typography.dart';
import 'package:eventora/styles/app_spacing.dart';
import 'package:eventora/widgets/custom_app_bar.dart';
import 'package:eventora/widgets/custom_button.dart';
import 'package:eventora/widgets/custom_text_field.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasBase,
      appBar: const CustomAppBar(title: 'Help & Support'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.marginMobile),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Frequently Asked Questions', style: AppTypography.headlineSM),
            const SizedBox(height: 16),
            _buildFAQ('How do I book a service?',
                'You can browse services by category, select a provider, and choose a date. Then proceed to payment to confirm your booking.'),
            _buildFAQ('Can I cancel my booking?',
                'Yes, bookings can be cancelled up to 48 hours before the event date for a full refund.'),
            _buildFAQ('How do I add funds to my wallet?',
                'Go to the Wallet tab and tap "Add Funds". You can use a credit card or PayPal.'),
            const Divider(height: 48),
            Text('Contact Us', style: AppTypography.headlineSM),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.email, color: AppColors.primary),
              title: Text('support@eventora.com', style: AppTypography.bodyLG),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.phone, color: AppColors.primary),
              title: Text('+1 (555) 123-4567', style: AppTypography.bodyLG),
            ),
            const Divider(height: 48),
            Text('Send us a message', style: AppTypography.headlineSM),
            const SizedBox(height: 16),
            const EventoraTextField(
              hint: 'How can we help you?',
              maxLines: 4,
            ),
            const SizedBox(height: 24),
            EventoraButton(
              text: 'Send Message',
              isFullWidth: true,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQ(String question, String answer) {
    return Theme(
      data: ThemeData(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(question, style: AppTypography.labelLG),
        childrenPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        expandedAlignment: Alignment.centerLeft,
        children: [
          Text(answer,
              style: AppTypography.bodyMD.copyWith(color: AppColors.mutedText)),
        ],
      ),
    );
  }
}

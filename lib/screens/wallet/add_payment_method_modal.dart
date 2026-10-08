import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/security/input_validator.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../providers/wallet_provider.dart';
import '../../widgets/luxe_button.dart';

class AddPaymentMethodModal extends StatefulWidget {
  const AddPaymentMethodModal({super.key});

  @override
  State<AddPaymentMethodModal> createState() => _AddPaymentMethodModalState();
}

class _AddPaymentMethodModalState extends State<AddPaymentMethodModal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardholderController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  String _detectedBrand = 'VISA';

  @override
  void dispose() {
    _cardholderController.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _onCardChanged(String val) {
    if (val.startsWith('34') || val.startsWith('37')) {
      setState(() => _detectedBrand = 'AMEX');
    } else if (val.startsWith('5')) {
      setState(() => _detectedBrand = 'MASTERCARD');
    } else {
      setState(() => _detectedBrand = 'VISA');
    }
  }

  void _saveCard() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<WalletProvider>().addPaymentCard(
            cardBrand: _detectedBrand,
            cardNumber: _cardNumberController.text,
            expiryDate: _expiryController.text,
            cardholderName: _cardholderController.text,
          );

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$_detectedBrand card added securely to your Eventora Wallet!'),
          backgroundColor: AppColors.emeraldSage,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceDim,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Text(
                'Add Payment Card',
                style: AppTypography.headlineMedium.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 4),
              Text(
                'Encrypted with 256-bit bank-grade PCI-DSS tokenization.',
                style: AppTypography.bodySmall,
              ),
              const SizedBox(height: 20),

              // Cardholder Name
              Text(
                'Cardholder Full Name',
                style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _cardholderController,
                validator: InputValidator.validateName,
                decoration: const InputDecoration(
                  hintText: 'e.g. Genevieve Sinclair',
                  prefixIcon: Icon(Icons.person_outline, color: AppColors.deepAmber),
                ),
              ),
              const SizedBox(height: 14),

              // Card Number
              Text(
                'Card Number',
                style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _cardNumberController,
                keyboardType: TextInputType.number,
                onChanged: _onCardChanged,
                validator: (val) {
                  if (val == null || val.replaceAll(' ', '').length < 13) {
                    return 'Please enter a valid card number';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: '4000 1234 5678 9010',
                  prefixIcon: const Icon(Icons.credit_card, color: AppColors.deepAmber),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Center(
                      widthFactor: 1,
                      child: Text(
                        _detectedBrand,
                        style: AppTypography.labelSmall.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.deepAmber,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Expiry and CVV Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Expires (MM/YY)',
                          style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _expiryController,
                          keyboardType: TextInputType.datetime,
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) return 'Required';
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: '12/28',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Security CVV',
                          style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _cvvController,
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val == null || val.trim().length < 3) return 'Invalid';
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: '•••',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              LuxeButton(
                text: 'Save Card to Vault',
                icon: Icons.lock_outline,
                onPressed: _saveCard,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/security/input_validator.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../providers/user_provider.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/luxe_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    final user = context.read<UserProvider>().user;
    _nameController = TextEditingController(text: user.fullName);
    _emailController = TextEditingController(text: user.email);
    _phoneController = TextEditingController(text: user.phone);
    _locationController = TextEditingController(text: user.location);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<UserProvider>().updateProfile(
            fullName: _nameController.text.trim(),
            email: _emailController.text.trim(),
            phone: _phoneController.text.trim(),
            location: _locationController.text.trim(),
          );

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile details updated successfully!'),
          backgroundColor: AppColors.emeraldSage,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const CustomAppBar(title: 'Edit Profile Information'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Personal Identity',
                style: AppTypography.headlineMedium.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 4),
              Text(
                'Used for provider contracts, VIP event passes, and billing receipts.',
                style: AppTypography.bodySmall,
              ),
              const SizedBox(height: 20),

              // Full Name
              Text('Full Name', style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _nameController,
                validator: InputValidator.validateName,
                decoration: const InputDecoration(
                  hintText: 'Full Name',
                  prefixIcon: Icon(Icons.person_outline, color: AppColors.deepAmber),
                ),
              ),
              const SizedBox(height: 16),

              // Email Address
              Text('Email Address', style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: InputValidator.validateEmail,
                decoration: const InputDecoration(
                  hintText: 'Email Address',
                  prefixIcon: Icon(Icons.email_outlined, color: AppColors.deepAmber),
                ),
              ),
              const SizedBox(height: 16),

              // Phone Number
              Text('Mobile Number', style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                validator: InputValidator.validatePhone,
                decoration: const InputDecoration(
                  hintText: '+1 (555) 000-0000',
                  prefixIcon: Icon(Icons.phone_outlined, color: AppColors.deepAmber),
                ),
              ),
              const SizedBox(height: 16),

              // Location
              Text('Primary Residence / City', style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  hintText: 'e.g. Beverly Hills, CA',
                  prefixIcon: Icon(Icons.location_city_outlined, color: AppColors.deepAmber),
                ),
              ),
              const SizedBox(height: 32),

              LuxeButton(
                text: 'Save Changes',
                onPressed: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

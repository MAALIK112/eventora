import 'package:flutter/material.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_typography.dart';
import 'package:eventora/styles/app_spacing.dart';
import 'package:eventora/widgets/eventora_button.dart';
import 'package:eventora/widgets/eventora_text_field.dart';
import 'package:eventora/widgets/custom_app_bar.dart';
import 'package:eventora/routes/app_router.dart';
import 'package:eventora/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: AppColors.surfaceContainerLowest,
      appBar: const CustomAppBar(title: 'Log In'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.marginMobile),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome back', style: AppTypography.headlineLG),
                const SizedBox(height: 8),
                Text(
                  'Log in to continue planning your events.',
                  style: AppTypography.bodyMD.copyWith(color: AppColors.mutedText),
                ),
                const SizedBox(height: 32),
                const EventoraTextField(
                  label: 'Email',
                  hint: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                EventoraTextField(
                  label: 'Password',
                  hint: 'Enter your password',
                  obscureText: _obscureText,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.mutedText,
                    ),
                    onPressed: () => setState(() => _obscureText = !_obscureText),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: AppTypography.labelMD.copyWith(color: AppColors.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                EventoraButton(
                  text: 'Log In',
                  isLoading: authProvider.isLoading,
                  isFullWidth: true,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await authProvider.login();
                      if (mounted) {
                        Navigator.pushNamedAndRemoveUntil(context, AppRouter.mainShell, (route) => false);
                      }
                    }
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?", style: AppTypography.bodyMD),
                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, AppRouter.signup),
                      child: Text('Sign Up', style: AppTypography.labelLG.copyWith(color: AppColors.primary)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

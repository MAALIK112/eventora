import 'package:flutter/material.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_typography.dart';
import 'package:eventora/styles/app_spacing.dart';
import 'package:eventora/widgets/custom_button.dart';
import 'package:eventora/widgets/custom_text_field.dart';
import 'package:eventora/widgets/custom_app_bar.dart';
import 'package:eventora/routes/app_router.dart';
import 'package:eventora/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'admin@eventora.com');
  final _passwordController = TextEditingController(text: 'admin123');
  bool _obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                  style:
                      AppTypography.bodyMD.copyWith(color: AppColors.mutedText),
                ),
                const SizedBox(height: 32),
                EventoraTextField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    }
                    if (!value.contains('@')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                EventoraTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: 'Enter your password',
                  obscureText: _obscureText,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.mutedText,
                    ),
                    onPressed: () =>
                        setState(() => _obscureText = !_obscureText),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: AppTypography.labelMD
                          .copyWith(color: AppColors.primary),
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
                      final email = _emailController.text.trim();
                      final password = _passwordController.text.trim();
                      final navigator = Navigator.of(context);
                      final messenger = ScaffoldMessenger.maybeOf(context);
                      final success = await authProvider.login(
                        email.isNotEmpty ? email : 'admin@eventora.com',
                        password.isNotEmpty ? password : 'admin123',
                      );
                      if (!mounted) return;
                      if (success) {
                        navigator.pushNamedAndRemoveUntil(
                            AppRouter.mainShell, (route) => false);
                      } else {
                        messenger?.showSnackBar(
                          SnackBar(
                            content: Text(
                              authProvider.errorMessage ??
                                  'Login failed. Please try again.',
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
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
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, AppRouter.signup),
                      child: Text('Sign Up',
                          style: AppTypography.labelLG
                              .copyWith(color: AppColors.primary)),
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

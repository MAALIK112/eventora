import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/security/input_validator.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../providers/admin_provider.dart';
import '../../providers/user_provider.dart';
import '../admin/admin_dashboard_screen.dart';
import '../main_navigation_screen.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  final bool adminMode;

  const LoginScreen({super.key}) : adminMode = false;

  const LoginScreen.admin({super.key}) : adminMode = true;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String? _errorMessage;

  bool get _adminMode => widget.adminMode;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (_adminMode) {
      final isAuthenticated = context.read<AdminProvider>().authenticateAdmin(
            email: _emailController.text,
            password: _passwordController.text,
          );
      if (!isAuthenticated) {
        setState(() => _errorMessage = 'Admin email or password is incorrect.');
        return;
      }

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const AdminDashboardScreen()),
        (_) => false,
      );
      return;
    }

    final isAuthenticated = context.read<UserProvider>().authenticate(
          email: _emailController.text,
          password: _passwordController.text,
        );
    if (!isAuthenticated) {
      setState(() => _errorMessage = 'Email or password is incorrect.');
      return;
    }

    context.read<AdminProvider>().endAdminSession();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.auto_awesome,
                    color: AppColors.deepAmber,
                    size: 34,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'EVENTORA',
                    textAlign: TextAlign.center,
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.deepAmber,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _adminMode ? 'Administrator sign in' : 'Welcome back',
                    textAlign: TextAlign.center,
                    style: AppTypography.headlineMedium.copyWith(fontSize: 25),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _adminMode
                        ? 'Access the separate operations console.'
                        : 'Sign in to plan and manage your celebrations.',
                    textAlign: TextAlign.center,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.username],
                          decoration: const InputDecoration(
                            labelText: 'Email address',
                            prefixIcon: Icon(Icons.mail_outline),
                          ),
                          validator: (value) =>
                              InputValidator.validateEmail(value ?? ''),
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          autofillHints: const [AutofillHints.password],
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              tooltip: _obscurePassword
                                  ? 'Show password'
                                  : 'Hide password',
                              onPressed: () => setState(
                                () => _obscurePassword = !_obscurePassword,
                              ),
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                            ),
                          ),
                          validator: (value) => (value ?? '').length < 6
                              ? 'Enter at least 6 characters.'
                              : null,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _adminMode
                              ? 'Prototype credentials: '
                                  '${AdminProvider.demoAdminEmail} / '
                                  '${AdminProvider.demoAdminPassword}'
                              : 'Prototype credentials: '
                                  'genevieve.sinclair@eventora.luxury / '
                                  '${UserProvider.demoPassword}',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                        if (_errorMessage != null) ...[
                          const SizedBox(height: 12),
                          Text(
                            _errorMessage!,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.error,
                            ),
                          ),
                        ],
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _signIn,
                            child: Text(
                              _adminMode
                                  ? 'Sign in to admin console'
                                  : 'Sign in',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (_adminMode)
                    TextButton(
                      onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
                        ),
                      ),
                      child: const Text('Customer sign in'),
                    )
                  else ...[
                    TextButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const SignUpScreen(),
                        ),
                      ),
                      child: const Text('Create a customer account'),
                    ),
                    TextButton.icon(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen.admin(),
                        ),
                      ),
                      icon: const Icon(Icons.admin_panel_settings_outlined),
                      label: const Text('Administrator sign in'),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

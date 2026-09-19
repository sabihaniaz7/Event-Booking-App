import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await ref
        .read(authControllerProvider.notifier)
        .login(_email.text.trim(), _password.text);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final authState = ref.watch(authControllerProvider);

    // Show inline error if login failed (without disturbing the form).
    ref.listen(authControllerProvider, (prev, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error.toString()),
            backgroundColor: c.error,
          ),
        );
      }
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.l24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSizes.xl64),
                // Brand mark — simple, no logo asset dependency.
                // Container(
                //   width: AppSizes.xl48,
                //   height: AppSizes.xl48,
                //   decoration: BoxDecoration(
                //     color: c.primary,
                //     borderRadius: BorderRadius.circular(AppSizes.radiusM16),
                //   ),
                //   child: Icon(
                //     Icons.confirmation_num_rounded,
                //     color: c.onPrimary,
                //   ),
                // ),
                const SizedBox(height: AppSizes.l24),
                Text(
                  'Welcome Back',
                  style: AppTextStyles.displayXl34(c.textPrimary),
                ),
                const SizedBox(height: AppSizes.xs4),
                Text(
                  'Log in to find and book your next event.',
                  style: AppTextStyles.bodyM15(c.textSecondary),
                ),
                const SizedBox(height: AppSizes.l32),
                AuthTextField(
                  controller: _email,
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => (v == null || !v.contains('@'))
                      ? 'Enter a valid email'
                      : null,
                ),
                const SizedBox(height: AppSizes.m16),
                AuthTextField(
                  controller: _password,
                  label: 'Password',
                  obscureText: true,
                  validator: (v) => (v == null || v.length < 6)
                      ? 'At least 6 characters'
                      : null,
                ),
                const SizedBox(height: AppSizes.l32),
                FilledButton(
                  onPressed: authState.isLoading ? null : _submit,
                  child: authState.isLoading
                      ? SizedBox(
                          height: AppSizes.iconM20,
                          width: AppSizes.iconM20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: c.onPrimary,
                          ),
                        )
                      : const Text('Log In'),
                ),
                const SizedBox(height: AppSizes.l24),
                Center(
                  child: TextButton(
                    onPressed: () => context.push(AppRoutes.signup),
                    child: Text.rich(
                      TextSpan(
                        text: "Don't have an account? ",
                        style: AppTextStyles.bodyM15(c.textSecondary),
                        children: [
                          TextSpan(
                            text: 'Sign up',
                            style: AppTextStyles.labelM16(c.primary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

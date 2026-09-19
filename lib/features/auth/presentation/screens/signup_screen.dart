import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_text_field.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});
  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await ref
        .read(authControllerProvider.notifier)
        .signup(_name.text.trim(), _email.text.trim(), _password.text);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final authState = ref.watch(authControllerProvider);

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
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the automatic back button
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.l24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create account',
                  style: AppTextStyles.displayXl34(c.textPrimary),
                ),
                const SizedBox(height: AppSizes.xs4),
                Text(
                  'Join to start booking events near you.',
                  style: AppTextStyles.bodyM15(c.textSecondary),
                ),
                const SizedBox(height: AppSizes.l32),
                AuthTextField(
                  controller: _name,
                  label: 'Full name',
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Enter your name'
                      : null,
                ),
                const SizedBox(height: AppSizes.m16),
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
                      : const Text('Create Account'),
                ),
                const SizedBox(height: AppSizes.l24),
                // Login Link Option
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: AppTextStyles.bodyM15(c.textSecondary),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to Login
                        Navigator.of(context).pop();
                        // Navigate to Login
                        // Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        'Log in',
                        style: AppTextStyles.bodyM15(c.primary)
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.l24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

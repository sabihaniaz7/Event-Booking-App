import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    return Scaffold(
      body: const Center(child: Text('Profile - coming next')),
      floatingActionButton: FloatingActionButton.small(
        heroTag: 'user_profile_logout_fab',
        backgroundColor: c.chipBg,
        onPressed: () => ref.read(authControllerProvider.notifier).logout(),
        child: Icon(Icons.logout_rounded, color: c.textPrimary),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../controllers/admin_controller.dart';

class AdminUsersScreen extends ConsumerWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final users = ref.watch(adminUsersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Registered Users')),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(adminUsersProvider),
        child: users.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
            child: Text(
              'Couldn\'t load users',
              style: AppTextStyles.bodyM15(c.textSecondary),
            ),
          ),
          data: (list) => ListView.separated(
            padding: const EdgeInsets.all(AppSizes.l24),
            itemCount: list.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSizes.s8),
            itemBuilder: (_, i) {
              final u = list[i];
              return Container(
                padding: const EdgeInsets.all(AppSizes.m12),
                decoration: BoxDecoration(
                  color: c.surface,
                  borderRadius: BorderRadius.circular(AppSizes.radiusM12),
                  border: Border.all(color: c.border),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: c.chipBg,
                      child: Text(
                        u.name.isNotEmpty ? u.name[0].toUpperCase() : '?',
                        style: AppTextStyles.labelM16(c.textPrimary),
                      ),
                    ),
                    const SizedBox(width: AppSizes.m12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            u.name,
                            style: AppTextStyles.labelM16(c.textPrimary),
                          ),
                          Text(
                            u.email,
                            style: AppTextStyles.bodyS13(c.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Joined ${DateFormat('MMM yyyy').format(u.joinedAt)}',
                      style: AppTextStyles.captionXs11(c.textSecondary),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

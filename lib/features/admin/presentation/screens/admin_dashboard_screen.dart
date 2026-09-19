import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../controllers/admin_controller.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final stats = ref.watch(adminStatsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(adminStatsProvider),
        child: stats.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
            child: Text(
              'Couldn\'t load stats',
              style: AppTextStyles.bodyM15(c.textSecondary),
            ),
          ),
          data: (s) => ListView(
            padding: const EdgeInsets.all(AppSizes.l24),
            children: [
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: AppSizes.m12,
                mainAxisSpacing: AppSizes.m12,
                childAspectRatio: 1.2,
                children: [
                  _StatCard(
                    icon: Icons.people_rounded,
                    label: 'Users',
                    value: '${s.totalUsers}',
                    color: c.primary,
                  ),
                  _StatCard(
                    icon: Icons.event_rounded,
                    label: 'Events',
                    value: '${s.totalEvents}',
                    color: c.accent,
                  ),
                  _StatCard(
                    icon: Icons.confirmation_num_rounded,
                    label: 'Bookings',
                    value: '${s.totalBookings}',
                    color: c.success,
                  ),
                  _StatCard(
                    icon: Icons.attach_money_rounded,
                    label: 'Revenue',
                    value: '\$${s.totalRevenue.toStringAsFixed(0)}',
                    color: c.warning,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsets.all(AppSizes.m16),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusM16),
        border: Border.all(color: c.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSizes.s8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppSizes.radiusM12),
            ),
            child: Icon(icon, color: color, size: AppSizes.iconM20),
          ),
          Text(value, style: AppTextStyles.headlineXl28(c.textPrimary)),
          Text(label, style: AppTextStyles.bodyS13(c.textSecondary)),
        ],
      ),
    );
  }
}

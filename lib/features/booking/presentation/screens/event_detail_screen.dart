import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../events/domain/entities/event_entity.dart';
import '../controllers/booking_controller.dart';

class EventDetailsScreen extends ConsumerWidget {
  const EventDetailsScreen({super.key, required this.eventId});
  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final eventAsync = ref.watch(eventDetailsProvider(eventId));

    return Scaffold(
      body: eventAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text(
            'Couldn\'t load event',
            style: AppTextStyles.bodyM15(c.textSecondary),
          ),
        ),
        data: (event) => CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 280,
              pinned: true,
              backgroundColor: c.bg,
              leading: _CircleIconButton(
                icon: Icons.arrow_back_rounded,
                onTap: () => context.pop(),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(event.imageUrl, fit: BoxFit.cover),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.l24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.s8,
                        vertical: AppSizes.xs4,
                      ),
                      decoration: BoxDecoration(
                        color: c.chipBg,
                        borderRadius: BorderRadius.circular(
                          AppSizes.radiusFull999,
                        ),
                      ),
                      child: Text(
                        event.category.label,
                        style: AppTextStyles.labelS13(c.primary),
                      ),
                    ),
                    const SizedBox(height: AppSizes.m12),
                    Text(
                      event.title,
                      style: AppTextStyles.headlineXl28(c.textPrimary),
                    ),
                    const SizedBox(height: AppSizes.l24),
                    _InfoRow(
                      icon: Icons.calendar_today_rounded,
                      title: DateFormat('EEEE, MMM d, yyyy').format(event.date),
                      subtitle: DateFormat('h:mm a').format(event.date),
                    ),
                    const SizedBox(height: AppSizes.m16),
                    _InfoRow(
                      icon: Icons.location_on_rounded,
                      title: event.location,
                      subtitle: 'Tap to view on map',
                    ),
                    const SizedBox(height: AppSizes.l24),
                    Text('About', style: AppTextStyles.titleL20(c.textPrimary)),
                    const SizedBox(height: AppSizes.s8),
                    Text(
                      event.description,
                      style: AppTextStyles.bodyM15(c.textSecondary),
                    ),
                    const SizedBox(height: AppSizes.l32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: eventAsync.maybeWhen(
        data: (event) => SafeArea(
          minimum: const EdgeInsets.all(AppSizes.l24),
          child: Material(
            color: c.bg,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price',
                      style: AppTextStyles.bodyS13(c.textSecondary),
                    ),
                    Text(
                      event.ticketPrice == 0
                          ? 'Free'
                          : '\$${event.ticketPrice.toStringAsFixed(0)}',
                      style: AppTextStyles.priceL20(c.primary),
                    ),
                  ],
                ),
                const SizedBox(width: AppSizes.m16),
                Expanded(
                  child: FilledButton(
                    onPressed: event.isSoldOut
                        ? null
                        : () => context.push('/event/$eventId/book'),
                    child: Text(event.isSoldOut ? 'Sold Out' : 'Book a Ticket'),
                  ),
                ),
              ],
            ),
          ),
        ),
        orElse: () => null,
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSizes.s8),
          decoration: BoxDecoration(
            color: c.chipBg,
            borderRadius: BorderRadius.circular(AppSizes.radiusM12),
          ),
          child: Icon(icon, color: c.primary, size: AppSizes.iconM20),
        ),
        const SizedBox(width: AppSizes.m12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.labelM16(c.textPrimary)),
            Text(subtitle, style: AppTextStyles.bodyS13(c.textSecondary)),
          ],
        ),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.s8),
      child: CircleAvatar(
        backgroundColor: Colors.black.withValues(alpha: 0.35),
        child: IconButton(
          icon: Icon(icon, color: Colors.white),
          onPressed: onTap,
        ),
      ),
    );
  }
}

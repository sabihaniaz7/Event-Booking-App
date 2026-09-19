import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../events/domain/entities/event_entity.dart';
import '../controllers/admin_controller.dart';
import 'admin_event_form_screen.dart';

class AdminEventsScreen extends ConsumerWidget {
  const AdminEventsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final events = ref.watch(adminEventsListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Manage Events')),
      floatingActionButton: FloatingActionButton(
        heroTag: 'admin_events_fab',
        onPressed: () => Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const AdminEventFormScreen())),
        child: const Icon(Icons.add_rounded),
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(adminEventsListProvider),
        child: events.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
            child: Text(
              'Couldn\'t load events',
              style: AppTextStyles.bodyM15(c.textSecondary),
            ),
          ),
          data: (list) => ListView.separated(
            padding: const EdgeInsets.all(AppSizes.l24),
            itemCount: list.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSizes.m12),
            itemBuilder: (_, i) => _AdminEventTile(event: list[i]),
          ),
        ),
      ),
    );
  }
}

class _AdminEventTile extends ConsumerWidget {
  const _AdminEventTile({required this.event});
  final EventEntity event;

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete event?'),
        content: Text('This will permanently remove "${event.title}".'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(adminEventFormProvider.notifier).delete(event.id);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsets.all(AppSizes.s8),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusM16),
        border: Border.all(color: c.border),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusM12),
            child: Image.network(
              event.imageUrl,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) =>
                  Container(width: 56, height: 56, color: c.chipBg),
            ),
          ),
          const SizedBox(width: AppSizes.m12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: AppTextStyles.labelM16(c.textPrimary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${event.seatsAvailable}/${event.totalSeats} seats left',
                  style: AppTextStyles.bodyS13(c.textSecondary),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit_rounded, color: c.textSecondary),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AdminEventFormScreen(existing: event),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete_rounded, color: c.error),
            onPressed: () => _confirmDelete(context, ref),
          ),
        ],
      ),
    );
  }
}

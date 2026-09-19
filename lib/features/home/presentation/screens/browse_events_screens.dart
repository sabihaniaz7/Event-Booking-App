import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../events/presentation/controllers/events_controller.dart';
import '../../../events/presentation/widgets/category_chip_row.dart';
import '../../../events/presentation/widgets/event_cards.dart';

class BrowseEventsScreen extends ConsumerStatefulWidget {
  const BrowseEventsScreen({super.key});
  @override
  ConsumerState<BrowseEventsScreen> createState() => _BrowseEventsScreenState();
}

class _BrowseEventsScreenState extends ConsumerState<BrowseEventsScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final filter = ref.watch(eventFilterProvider);
    final results = ref.watch(filteredEventsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Browse Events')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.l24),
        child: Column(
          children: [
            const SizedBox(height: AppSizes.s8),
            TextField(
              controller: _searchController,
              onChanged: (v) =>
                  ref.read(eventFilterProvider.notifier).setSearch(v),
              decoration: InputDecoration(
                hintText: 'Search by name, location...',
                prefixIcon: Icon(Icons.search_rounded, color: c.textSecondary),
              ),
            ),
            const SizedBox(height: AppSizes.m16),
            CategoryChipRow(
              selected: filter.category,
              onSelect: (cat) =>
                  ref.read(eventFilterProvider.notifier).setCategory(cat),
            ),
            const SizedBox(height: AppSizes.m16),
            Expanded(
              child: results.when(
                data: (events) => events.isEmpty
                    ? Center(
                        child: Text(
                          'No events match your search',
                          style: AppTextStyles.bodyM15(c.textSecondary),
                        ),
                      )
                    : ListView.separated(
                        itemCount: events.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(height: AppSizes.m12),
                        itemBuilder: (_, i) => EventListCard(
                          event: events[i],
                          onTap: () => context.push('/event/${events[i].id}'),
                        ),
                      ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(
                  child: Text(
                    'Something went wrong',
                    style: AppTextStyles.bodyM15(c.textSecondary),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

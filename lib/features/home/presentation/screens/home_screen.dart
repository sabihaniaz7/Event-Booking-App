import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../events/presentation/controllers/events_controller.dart';
import '../../../events/presentation/widgets/event_cards.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final featured = ref.watch(featuredEventsProvider);
    final upcoming = ref.watch(upcomingEventsProvider);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(featuredEventsProvider);
            ref.invalidate(upcomingEventsProvider);
          },
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppSizes.l24,
                  AppSizes.l24,
                  AppSizes.l24,
                  0,
                ),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Discover events',
                            style: AppTextStyles.headlineXl28(c.textPrimary),
                          ),
                          Text(
                            'Find something happening near you',
                            style: AppTextStyles.labelS13(c.textSecondary),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => context.push(AppRoutes.profile),
                        icon: CircleAvatar(
                          backgroundColor: c.chipBg,
                          child: Icon(
                            Icons.person_rounded,
                            color: c.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppSizes.l24,
                  AppSizes.l24,
                  AppSizes.l24,
                  AppSizes.s8,
                ),
                sliver: SliverToBoxAdapter(
                  child: GestureDetector(
                    onTap: () => context.push(AppRoutes.browse),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.m16,
                        vertical: AppSizes.m12,
                      ),
                      decoration: BoxDecoration(
                        color: c.surfaceRaised,
                        borderRadius: BorderRadius.circular(AppSizes.radiusM12),
                        border: Border.all(color: c.border),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search_rounded, color: c.textSecondary),
                          const SizedBox(width: AppSizes.s8),
                          Text(
                            'Search events...',
                            style: AppTextStyles.bodyM15(c.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: _SectionHeader(title: 'Featured')),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 190,
                  child: featured.when(
                    data: (events) => ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.l24,
                      ),
                      itemCount: events.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(width: AppSizes.m12),
                      itemBuilder: (_, i) => FeaturedEventCard(
                        event: events[i],
                        onTap: () => context.push('/event/${events[i].id}'),
                      ),
                    ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Center(
                      child: Text(
                        'Couldn\'t load events',
                        style: AppTextStyles.bodyS13(c.textSecondary),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: _SectionHeader(title: 'Upcoming')),
              upcoming.when(
                data: (events) => SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSizes.l24,
                    0,
                    AppSizes.l24,
                    AppSizes.l32,
                  ),
                  sliver: SliverList.separated(
                    itemCount: events.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSizes.m12),
                    itemBuilder: (_, i) => EventListCard(
                      event: events[i],
                      onTap: () => context.push('/event/${events[i].id}'),
                    ),
                  ),
                ),
                loading: () => const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(AppSizes.l32),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
                error: (e, _) => SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSizes.l32),
                    child: Center(
                      child: Text(
                        'Couldn\'t load events',
                        style: AppTextStyles.bodyS13(c.textSecondary),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.l24,
        AppSizes.l24,
        AppSizes.l24,
        AppSizes.m12,
      ),
      child: Text(title, style: AppTextStyles.titleL20(c.textPrimary)),
    );
  }
}

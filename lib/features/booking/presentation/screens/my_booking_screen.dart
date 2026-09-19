import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../controllers/booking_controller.dart';
import '../widgets/qr_ticket_card.dart';

class MyBookingsScreen extends ConsumerWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final bookings = ref.watch(myBookingsProvider);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) context.go(AppRoutes.home);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            tooltip: 'Home',
            onPressed: () => context.go(AppRoutes.home),
            icon: const Icon(Icons.home_rounded),
          ),
          title: const Text('My Bookings'),
        ),
        body: RefreshIndicator(
          onRefresh: () async => ref.invalidate(myBookingsProvider),
          child: bookings.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(
              child: Text(
                'Couldn\'t load bookings',
                style: AppTextStyles.bodyM15(c.textSecondary),
              ),
            ),
            data: (list) => list.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSizes.l32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.confirmation_num_outlined,
                            size: AppSizes.iconL32 * 1.5,
                            color: c.textSecondary,
                          ),
                          const SizedBox(height: AppSizes.m16),
                          Text(
                            'No bookings yet',
                            style: AppTextStyles.titleL20(c.textPrimary),
                          ),
                          Text(
                            'Book an event to see your ticket here',
                            style: AppTextStyles.bodyS13(c.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(AppSizes.l24),
                    itemCount: list.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSizes.l24),
                    itemBuilder: (_, i) => QrTicketCard(booking: list[i]),
                  ),
          ),
        ),
      ),
    );
  }
}

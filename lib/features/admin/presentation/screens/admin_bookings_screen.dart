import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../booking/domain/entities/booking_entity.dart';
import '../controllers/admin_controller.dart';

class AdminBookingsScreen extends ConsumerWidget {
  const AdminBookingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final bookings = ref.watch(adminBookingsListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('All Bookings')),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(adminBookingsListProvider),
        child: bookings.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
            child: Text(
              'Couldn\'t load bookings',
              style: AppTextStyles.bodyM15(c.textSecondary),
            ),
          ),
          data: (list) => ListView.separated(
            padding: const EdgeInsets.all(AppSizes.l24),
            itemCount: list.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSizes.m12),
            itemBuilder: (_, i) => _BookingTile(booking: list[i]),
          ),
        ),
      ),
    );
  }
}

class _BookingTile extends ConsumerWidget {
  const _BookingTile({required this.booking});
  final BookingEntity booking;

  Color _statusColor(AppColorsExtension c, BookingStatus s) {
    switch (s) {
      case BookingStatus.confirmed:
        return c.success;
      case BookingStatus.cancelled:
        return c.error;
      case BookingStatus.checkedIn:
        return c.primary;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  booking.event.title,
                  style: AppTextStyles.labelM16(c.textPrimary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.s8,
                  vertical: AppSizes.xs4,
                ),
                decoration: BoxDecoration(
                  color: _statusColor(
                    c,
                    booking.status,
                  ).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppSizes.radiusFull999),
                ),
                child: Text(
                  booking.status.label,
                  style: AppTextStyles.captionXs11(
                    _statusColor(c, booking.status),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.xs4),
          Text(
            '${booking.userName ?? 'Unknown'} · ${booking.userEmail ?? ''}',
            style: AppTextStyles.bodyS13(c.textSecondary),
          ),
          Text(
            '${booking.quantity} ticket(s) · \$${booking.totalPrice.toStringAsFixed(0)} · ${booking.bookingCode}',
            style: AppTextStyles.bodyS13(c.textSecondary),
          ),
          Text(
            DateFormat('MMM d, yyyy h:mm a').format(booking.createdAt),
            style: AppTextStyles.captionXs11(c.textSecondary),
          ),
          const SizedBox(height: AppSizes.s8),
          if (booking.status != BookingStatus.cancelled)
            Row(
              children: [
                if (booking.status == BookingStatus.confirmed)
                  TextButton(
                    onPressed: () => ref
                        .read(adminBookingActionsProvider.notifier)
                        .updateStatus(booking.id, BookingStatus.checkedIn),
                    child: const Text('Mark checked-in'),
                  ),
                TextButton(
                  onPressed: () => ref
                      .read(adminBookingActionsProvider.notifier)
                      .updateStatus(booking.id, BookingStatus.cancelled),
                  style: TextButton.styleFrom(foregroundColor: c.error),
                  child: const Text('Cancel'),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../controllers/booking_controller.dart';

class BookTicketScreen extends ConsumerWidget {
  const BookTicketScreen({super.key, required this.eventId});
  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final eventAsync = ref.watch(eventDetailsProvider(eventId));
    final quantity = ref.watch(ticketQuantityProvider);
    final submitState = ref.watch(bookingSubmitProvider);

    ref.listen(bookingSubmitProvider, (prev, next) {
      next.whenData((booking) {
        if (booking != null) {
          // Confirmation is shown via the booking's own screen route,
          // reusing My Bookings' detail view keeps one QR design everywhere.
          context.go('/my-bookings');
        }
      });
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
      appBar: AppBar(title: const Text('Book Ticket')),
      body: eventAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text(
            'Couldn\'t load event',
            style: AppTextStyles.bodyM15(c.textSecondary),
          ),
        ),
        data: (event) => Padding(
          padding: const EdgeInsets.all(AppSizes.l24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(event.title, style: AppTextStyles.titleL24(c.textPrimary)),
              const SizedBox(height: AppSizes.xs4),
              Text(
                '${event.seatsAvailable} seats available',
                style: AppTextStyles.bodyS13(c.textSecondary),
              ),
              const SizedBox(height: AppSizes.l32),
              Text(
                'Number of tickets',
                style: AppTextStyles.titleL20(c.textPrimary),
              ),
              const SizedBox(height: AppSizes.m16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _QtyButton(
                    icon: Icons.remove_rounded,
                    onTap: () =>
                        ref.read(ticketQuantityProvider.notifier).decrement(),
                  ),
                  Container(
                    width: 64,
                    alignment: Alignment.center,
                    child: Text(
                      '$quantity',
                      style: AppTextStyles.displayXl34(c.textPrimary),
                    ),
                  ),
                  _QtyButton(
                    icon: Icons.add_rounded,
                    onTap: () => ref
                        .read(ticketQuantityProvider.notifier)
                        .increment(event.seatsAvailable),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(AppSizes.m16),
                decoration: BoxDecoration(
                  color: c.chipBg,
                  borderRadius: BorderRadius.circular(AppSizes.radiusM16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: AppTextStyles.labelM16(c.textPrimary)),
                    Text(
                      event.ticketPrice == 0
                          ? 'Free'
                          : '\$${(event.ticketPrice * quantity).toStringAsFixed(0)}',
                      style: AppTextStyles.priceL20(c.primary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.m16),
              FilledButton(
                onPressed: submitState.isLoading
                    ? null
                    : () => ref
                          .read(bookingSubmitProvider.notifier)
                          .submit(eventId: eventId, quantity: quantity),
                child: submitState.isLoading
                    ? SizedBox(
                        height: AppSizes.iconM20,
                        width: AppSizes.iconM20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: c.onPrimary,
                        ),
                      )
                    : const Text('Confirm Booking'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radiusFull999),
      child: Container(
        width: AppSizes.xl40,
        height: AppSizes.xl40,
        decoration: BoxDecoration(color: c.chipBg, shape: BoxShape.circle),
        child: Icon(icon, color: c.textPrimary),
      ),
    );
  }
}

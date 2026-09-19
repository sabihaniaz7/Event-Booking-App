import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../auth/presentation/controllers/auth_controller.dart'
    show dioProvider;
import '../../../events/domain/entities/event_entity.dart';
import '../../../events/presentation/controllers/events_controller.dart'
    show eventsRepositoryProvider;
import '../../data/datasources/booking_remote_data_source.dart';
import '../../data/repositories/booking_repository_impl.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/repositories/booking_repository.dart';

part 'booking_controller.g.dart';

final bookingRepositoryProvider = Provider<BookingRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return BookingRepositoryImpl(BookingRemoteDataSource(dio));
});

/// One event, fetched fresh for the details screen (separate from the
/// list providers on Home/Browse so navigating in never shows stale data).
@riverpod
Future<EventEntity> eventDetails(Ref ref, String eventId) {
  return ref.watch(eventsRepositoryProvider).getEventById(eventId);
}

/// Drives the "Book Ticket" screen: quantity selector + submit.
@riverpod
class TicketQuantity extends _$TicketQuantity {
  @override
  int build() => 1;

  void increment(int maxSeats) {
    if (state < maxSeats) state++;
  }

  void decrement() {
    if (state > 1) state--;
  }
}

@riverpod
class BookingSubmit extends _$BookingSubmit {
  @override
  AsyncValue<BookingEntity?> build() => const AsyncData(null);

  Future<void> submit({required String eventId, required int quantity}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(bookingRepositoryProvider)
          .createBooking(eventId: eventId, quantity: quantity),
    );
  }
}

@riverpod
Future<List<BookingEntity>> myBookings(Ref ref) {
  return ref.watch(bookingRepositoryProvider).getMyBookings();
}

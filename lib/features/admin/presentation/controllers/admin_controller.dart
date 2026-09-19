import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../auth/presentation/controllers/auth_controller.dart'
    show dioProvider;
import '../../../booking/domain/entities/booking_entity.dart';
import '../../../booking/presentation/controllers/booking_controller.dart'
    show bookingRepositoryProvider;
import '../../../events/domain/entities/event_entity.dart';
import '../../../events/presentation/controllers/events_controller.dart'
    show eventsRepositoryProvider;
import '../../data/admin_data.dart';
import '../../domain/entities/admin_stats_entity.dart';
import '../../domain/repositories/admin_repository.dart';

part 'admin_controller.g.dart';

final adminRepositoryProvider = Provider<AdminRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AdminRepositoryImpl(AdminRemoteDataSource(dio));
});

@riverpod
Future<AdminStatsEntity> adminStats(Ref ref) {
  return ref.watch(adminRepositoryProvider).getDashboardStats();
}

@riverpod
Future<List<AdminUserEntity>> adminUsers(Ref ref) {
  return ref.watch(adminRepositoryProvider).getAllUsers();
}

/// Admin's own event list — same repository as the public browse screen,
/// just without search/category filtering applied.
@riverpod
Future<List<EventEntity>> adminEventsList(Ref ref) {
  return ref.watch(eventsRepositoryProvider).getEvents();
}

@riverpod
Future<List<BookingEntity>> adminBookingsList(Ref ref) {
  return ref.watch(bookingRepositoryProvider).getAllBookings();
}

/// Handles create/update/delete submissions from the event form screen.
/// Kept separate from the read-only list provider above so a form submit
/// doesn't put the whole list into a loading state.
@riverpod
class AdminEventForm extends _$AdminEventForm {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<bool> create({
    required String title,
    required String description,
    required EventCategory category,
    required String location,
    required DateTime date,
    required double ticketPrice,
    required int totalSeats,
    required bool isFeatured,
    required String imagePath,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(eventsRepositoryProvider)
          .createEvent(
            title: title,
            description: description,
            category: category,
            location: location,
            date: date,
            ticketPrice: ticketPrice,
            totalSeats: totalSeats,
            isFeatured: isFeatured,
            imagePath: imagePath,
          ),
    );
    if (!state.hasError) ref.invalidate(adminEventsListProvider);
    return !state.hasError;
  }

  Future<bool> update({
    required String id,
    required String title,
    required String description,
    required EventCategory category,
    required String location,
    required DateTime date,
    required double ticketPrice,
    required int totalSeats,
    required bool isFeatured,
    String? imagePath,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(eventsRepositoryProvider)
          .updateEvent(
            id: id,
            title: title,
            description: description,
            category: category,
            location: location,
            date: date,
            ticketPrice: ticketPrice,
            totalSeats: totalSeats,
            isFeatured: isFeatured,
            imagePath: imagePath,
          ),
    );
    if (!state.hasError) ref.invalidate(adminEventsListProvider);
    return !state.hasError;
  }

  Future<bool> delete(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(eventsRepositoryProvider).deleteEvent(id),
    );
    if (!state.hasError) ref.invalidate(adminEventsListProvider);
    return !state.hasError;
  }
}

@riverpod
class AdminBookingActions extends _$AdminBookingActions {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> updateStatus(String bookingId, BookingStatus status) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(bookingRepositoryProvider)
          .updateBookingStatus(bookingId: bookingId, status: status),
    );
    if (!state.hasError) ref.invalidate(adminBookingsListProvider);
  }
}

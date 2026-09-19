import 'package:event_booking_app/features/events/domain/repositories/event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../auth/presentation/controllers/auth_controller.dart'
    show dioProvider;
import '../../data/datasources/events_remote_data_source.dart';
import '../../domain/entities/event_entity.dart';
import '../../domain/repositories/events_repository_impl.dart';

part 'events_controller.g.dart';

final eventsRepositoryProvider = Provider<EventsRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return EventsRepositoryImpl(EventsRemoteDataSource(dio));
});

/// Home screen feed: featured + upcoming. Kept separate from the
/// search/browse controller below so pull-to-refresh on Home never
/// clobbers an in-progress search on another screen.
@riverpod
Future<List<EventEntity>> featuredEvents(Ref ref) {
  return ref.watch(eventsRepositoryProvider).getEvents(featuredOnly: true);
}

@riverpod
Future<List<EventEntity>> upcomingEvents(Ref ref) {
  return ref.watch(eventsRepositoryProvider).getEvents();
}

/// Holds the current search text + selected category filter for the
/// Browse/Search screen. Family-free single instance is fine — there's
/// only ever one active browse session on screen at a time.
class EventFilterState {
  const EventFilterState({this.search = '', this.category});
  final String search;
  final EventCategory? category;

  EventFilterState copyWith({
    String? search,
    EventCategory? category,
    bool clearCategory = false,
  }) {
    return EventFilterState(
      search: search ?? this.search,
      category: clearCategory ? null : (category ?? this.category),
    );
  }
}

@riverpod
class EventFilter extends _$EventFilter {
  @override
  EventFilterState build() => const EventFilterState();

  void setSearch(String value) => state = state.copyWith(search: value);
  void setCategory(EventCategory? value) => value == null
      ? state = state.copyWith(clearCategory: true)
      : state = state.copyWith(category: value);
}

/// Re-fetches automatically whenever search text or category changes —
/// that's the whole "live filtering" behavior, no manual listeners needed.
@riverpod
Future<List<EventEntity>> filteredEvents(Ref ref) {
  final filter = ref.watch(eventFilterProvider);
  return ref
      .watch(eventsRepositoryProvider)
      .getEvents(search: filter.search, category: filter.category);
}

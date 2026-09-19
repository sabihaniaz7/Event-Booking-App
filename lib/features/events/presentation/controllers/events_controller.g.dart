// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Home screen feed: featured + upcoming. Kept separate from the
/// search/browse controller below so pull-to-refresh on Home never
/// clobbers an in-progress search on another screen.

@ProviderFor(featuredEvents)
final featuredEventsProvider = FeaturedEventsProvider._();

/// Home screen feed: featured + upcoming. Kept separate from the
/// search/browse controller below so pull-to-refresh on Home never
/// clobbers an in-progress search on another screen.

final class FeaturedEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<EventEntity>>,
          List<EventEntity>,
          FutureOr<List<EventEntity>>
        >
    with
        $FutureModifier<List<EventEntity>>,
        $FutureProvider<List<EventEntity>> {
  /// Home screen feed: featured + upcoming. Kept separate from the
  /// search/browse controller below so pull-to-refresh on Home never
  /// clobbers an in-progress search on another screen.
  FeaturedEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'featuredEventsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$featuredEventsHash();

  @$internal
  @override
  $FutureProviderElement<List<EventEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<EventEntity>> create(Ref ref) {
    return featuredEvents(ref);
  }
}

String _$featuredEventsHash() => r'73ec9f20c60962fc98ff28931948a513f10a9b7b';

@ProviderFor(upcomingEvents)
final upcomingEventsProvider = UpcomingEventsProvider._();

final class UpcomingEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<EventEntity>>,
          List<EventEntity>,
          FutureOr<List<EventEntity>>
        >
    with
        $FutureModifier<List<EventEntity>>,
        $FutureProvider<List<EventEntity>> {
  UpcomingEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'upcomingEventsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$upcomingEventsHash();

  @$internal
  @override
  $FutureProviderElement<List<EventEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<EventEntity>> create(Ref ref) {
    return upcomingEvents(ref);
  }
}

String _$upcomingEventsHash() => r'd10ddba379e09ff3d56e7d78cc04a551dcfdd6fb';

@ProviderFor(EventFilter)
final eventFilterProvider = EventFilterProvider._();

final class EventFilterProvider
    extends $NotifierProvider<EventFilter, EventFilterState> {
  EventFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventFilterHash();

  @$internal
  @override
  EventFilter create() => EventFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EventFilterState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EventFilterState>(value),
    );
  }
}

String _$eventFilterHash() => r'afcdc30bf0aec84a427f9122faccd41a5bf936a8';

abstract class _$EventFilter extends $Notifier<EventFilterState> {
  EventFilterState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<EventFilterState, EventFilterState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EventFilterState, EventFilterState>,
              EventFilterState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Re-fetches automatically whenever search text or category changes —
/// that's the whole "live filtering" behavior, no manual listeners needed.

@ProviderFor(filteredEvents)
final filteredEventsProvider = FilteredEventsProvider._();

/// Re-fetches automatically whenever search text or category changes —
/// that's the whole "live filtering" behavior, no manual listeners needed.

final class FilteredEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<EventEntity>>,
          List<EventEntity>,
          FutureOr<List<EventEntity>>
        >
    with
        $FutureModifier<List<EventEntity>>,
        $FutureProvider<List<EventEntity>> {
  /// Re-fetches automatically whenever search text or category changes —
  /// that's the whole "live filtering" behavior, no manual listeners needed.
  FilteredEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredEventsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredEventsHash();

  @$internal
  @override
  $FutureProviderElement<List<EventEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<EventEntity>> create(Ref ref) {
    return filteredEvents(ref);
  }
}

String _$filteredEventsHash() => r'5c97d14246f251e97270f3979fd15fcb5e5bbb22';

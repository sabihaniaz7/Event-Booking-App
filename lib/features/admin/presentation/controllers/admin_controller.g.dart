// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(adminStats)
final adminStatsProvider = AdminStatsProvider._();

final class AdminStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<AdminStatsEntity>,
          AdminStatsEntity,
          FutureOr<AdminStatsEntity>
        >
    with $FutureModifier<AdminStatsEntity>, $FutureProvider<AdminStatsEntity> {
  AdminStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminStatsHash();

  @$internal
  @override
  $FutureProviderElement<AdminStatsEntity> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AdminStatsEntity> create(Ref ref) {
    return adminStats(ref);
  }
}

String _$adminStatsHash() => r'eb63aaf9b04273384ec51d5c5294ef257ae13c02';

@ProviderFor(adminUsers)
final adminUsersProvider = AdminUsersProvider._();

final class AdminUsersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AdminUserEntity>>,
          List<AdminUserEntity>,
          FutureOr<List<AdminUserEntity>>
        >
    with
        $FutureModifier<List<AdminUserEntity>>,
        $FutureProvider<List<AdminUserEntity>> {
  AdminUsersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminUsersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminUsersHash();

  @$internal
  @override
  $FutureProviderElement<List<AdminUserEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AdminUserEntity>> create(Ref ref) {
    return adminUsers(ref);
  }
}

String _$adminUsersHash() => r'45adc381fab290a8afa552eb498e50dd6e8920e3';

/// Admin's own event list — same repository as the public browse screen,
/// just without search/category filtering applied.

@ProviderFor(adminEventsList)
final adminEventsListProvider = AdminEventsListProvider._();

/// Admin's own event list — same repository as the public browse screen,
/// just without search/category filtering applied.

final class AdminEventsListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<EventEntity>>,
          List<EventEntity>,
          FutureOr<List<EventEntity>>
        >
    with
        $FutureModifier<List<EventEntity>>,
        $FutureProvider<List<EventEntity>> {
  /// Admin's own event list — same repository as the public browse screen,
  /// just without search/category filtering applied.
  AdminEventsListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminEventsListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminEventsListHash();

  @$internal
  @override
  $FutureProviderElement<List<EventEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<EventEntity>> create(Ref ref) {
    return adminEventsList(ref);
  }
}

String _$adminEventsListHash() => r'b5a3e8804d37cadfb38f8ca8e286383a4ccdf45b';

@ProviderFor(adminBookingsList)
final adminBookingsListProvider = AdminBookingsListProvider._();

final class AdminBookingsListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BookingEntity>>,
          List<BookingEntity>,
          FutureOr<List<BookingEntity>>
        >
    with
        $FutureModifier<List<BookingEntity>>,
        $FutureProvider<List<BookingEntity>> {
  AdminBookingsListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminBookingsListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminBookingsListHash();

  @$internal
  @override
  $FutureProviderElement<List<BookingEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<BookingEntity>> create(Ref ref) {
    return adminBookingsList(ref);
  }
}

String _$adminBookingsListHash() => r'da2edafe0c5ed12d5a8986e3cef675da564fbdcc';

/// Handles create/update/delete submissions from the event form screen.
/// Kept separate from the read-only list provider above so a form submit
/// doesn't put the whole list into a loading state.

@ProviderFor(AdminEventForm)
final adminEventFormProvider = AdminEventFormProvider._();

/// Handles create/update/delete submissions from the event form screen.
/// Kept separate from the read-only list provider above so a form submit
/// doesn't put the whole list into a loading state.
final class AdminEventFormProvider
    extends $NotifierProvider<AdminEventForm, AsyncValue<void>> {
  /// Handles create/update/delete submissions from the event form screen.
  /// Kept separate from the read-only list provider above so a form submit
  /// doesn't put the whole list into a loading state.
  AdminEventFormProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminEventFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminEventFormHash();

  @$internal
  @override
  AdminEventForm create() => AdminEventForm();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$adminEventFormHash() => r'8ddd4d92eb48181eb2a3e0c188675ed4b6743b9f';

/// Handles create/update/delete submissions from the event form screen.
/// Kept separate from the read-only list provider above so a form submit
/// doesn't put the whole list into a loading state.

abstract class _$AdminEventForm extends $Notifier<AsyncValue<void>> {
  AsyncValue<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, AsyncValue<void>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, AsyncValue<void>>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(AdminBookingActions)
final adminBookingActionsProvider = AdminBookingActionsProvider._();

final class AdminBookingActionsProvider
    extends $NotifierProvider<AdminBookingActions, AsyncValue<void>> {
  AdminBookingActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminBookingActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminBookingActionsHash();

  @$internal
  @override
  AdminBookingActions create() => AdminBookingActions();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$adminBookingActionsHash() =>
    r'798dbff00aca5a672de4bd472087877df05da538';

abstract class _$AdminBookingActions extends $Notifier<AsyncValue<void>> {
  AsyncValue<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, AsyncValue<void>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, AsyncValue<void>>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

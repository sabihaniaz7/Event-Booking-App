// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// One event, fetched fresh for the details screen (separate from the
/// list providers on Home/Browse so navigating in never shows stale data).

@ProviderFor(eventDetails)
final eventDetailsProvider = EventDetailsFamily._();

/// One event, fetched fresh for the details screen (separate from the
/// list providers on Home/Browse so navigating in never shows stale data).

final class EventDetailsProvider
    extends
        $FunctionalProvider<
          AsyncValue<EventEntity>,
          EventEntity,
          FutureOr<EventEntity>
        >
    with $FutureModifier<EventEntity>, $FutureProvider<EventEntity> {
  /// One event, fetched fresh for the details screen (separate from the
  /// list providers on Home/Browse so navigating in never shows stale data).
  EventDetailsProvider._({
    required EventDetailsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'eventDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventDetailsHash();

  @override
  String toString() {
    return r'eventDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<EventEntity> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EventEntity> create(Ref ref) {
    final argument = this.argument as String;
    return eventDetails(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EventDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventDetailsHash() => r'364edf223d06c5c0730c8df8b5f746e3aa09b98c';

/// One event, fetched fresh for the details screen (separate from the
/// list providers on Home/Browse so navigating in never shows stale data).

final class EventDetailsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<EventEntity>, String> {
  EventDetailsFamily._()
    : super(
        retry: null,
        name: r'eventDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// One event, fetched fresh for the details screen (separate from the
  /// list providers on Home/Browse so navigating in never shows stale data).

  EventDetailsProvider call(String eventId) =>
      EventDetailsProvider._(argument: eventId, from: this);

  @override
  String toString() => r'eventDetailsProvider';
}

/// Drives the "Book Ticket" screen: quantity selector + submit.

@ProviderFor(TicketQuantity)
final ticketQuantityProvider = TicketQuantityProvider._();

/// Drives the "Book Ticket" screen: quantity selector + submit.
final class TicketQuantityProvider
    extends $NotifierProvider<TicketQuantity, int> {
  /// Drives the "Book Ticket" screen: quantity selector + submit.
  TicketQuantityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ticketQuantityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ticketQuantityHash();

  @$internal
  @override
  TicketQuantity create() => TicketQuantity();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$ticketQuantityHash() => r'7b84ac71867335d52418177984a3cf582449267e';

/// Drives the "Book Ticket" screen: quantity selector + submit.

abstract class _$TicketQuantity extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(BookingSubmit)
final bookingSubmitProvider = BookingSubmitProvider._();

final class BookingSubmitProvider
    extends $NotifierProvider<BookingSubmit, AsyncValue<BookingEntity?>> {
  BookingSubmitProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookingSubmitProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookingSubmitHash();

  @$internal
  @override
  BookingSubmit create() => BookingSubmit();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<BookingEntity?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<BookingEntity?>>(value),
    );
  }
}

String _$bookingSubmitHash() => r'f0667d99d92225077d9332e6f0957bc6c598c3f9';

abstract class _$BookingSubmit extends $Notifier<AsyncValue<BookingEntity?>> {
  AsyncValue<BookingEntity?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<BookingEntity?>, AsyncValue<BookingEntity?>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<BookingEntity?>,
                AsyncValue<BookingEntity?>
              >,
              AsyncValue<BookingEntity?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(myBookings)
final myBookingsProvider = MyBookingsProvider._();

final class MyBookingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BookingEntity>>,
          List<BookingEntity>,
          FutureOr<List<BookingEntity>>
        >
    with
        $FutureModifier<List<BookingEntity>>,
        $FutureProvider<List<BookingEntity>> {
  MyBookingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myBookingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myBookingsHash();

  @$internal
  @override
  $FutureProviderElement<List<BookingEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<BookingEntity>> create(Ref ref) {
    return myBookings(ref);
  }
}

String _$myBookingsHash() => r'62740511ee354f89de8af34d58c03dce27cb3964';

import '../../domain/entities/booking_entity.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasources/booking_remote_data_source.dart';

class BookingRepositoryImpl implements BookingRepository {
  BookingRepositoryImpl(this._remote);
  final BookingRemoteDataSource _remote;

  @override
  Future<BookingEntity> createBooking({
    required String eventId,
    required int quantity,
  }) {
    return _remote.createBooking(eventId, quantity);
  }

  @override
  Future<List<BookingEntity>> getMyBookings() => _remote.getMyBookings();

  @override
  Future<List<BookingEntity>> getAllBookings() => _remote.getAllBookings();

  @override
  Future<BookingEntity> updateBookingStatus({
    required String bookingId,
    required BookingStatus status,
  }) {
    return _remote.updateBookingStatus(bookingId, status.toApi);
  }
}

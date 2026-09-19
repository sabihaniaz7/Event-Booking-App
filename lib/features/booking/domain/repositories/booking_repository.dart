import '../entities/booking_entity.dart';

abstract class BookingRepository {
  Future<BookingEntity> createBooking({
    required String eventId,
    required int quantity,
  });
  Future<List<BookingEntity>> getMyBookings();

  // --- Admin ---
  Future<List<BookingEntity>> getAllBookings();
  Future<BookingEntity> updateBookingStatus({
    required String bookingId,
    required BookingStatus status,
  });
}

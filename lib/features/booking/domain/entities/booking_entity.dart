import '../../../events/domain/entities/event_entity.dart';

enum BookingStatus { confirmed, cancelled, checkedIn }

extension BookingStatusX on BookingStatus {
  String get label {
    switch (this) {
      case BookingStatus.confirmed:
        return 'Confirmed';
      case BookingStatus.cancelled:
        return 'Cancelled';
      case BookingStatus.checkedIn:
        return 'Checked In';
    }
  }

  static BookingStatus fromApi(String value) {
    switch (value) {
      case 'checked_in':
        return BookingStatus.checkedIn;
      case 'cancelled':
        return BookingStatus.cancelled;
      default:
        return BookingStatus.confirmed;
    }
  }

  String get toApi {
    switch (this) {
      case BookingStatus.checkedIn:
        return 'checked_in';
      case BookingStatus.cancelled:
        return 'cancelled';
      case BookingStatus.confirmed:
        return 'confirmed';
    }
  }
}

class BookingEntity {
  const BookingEntity({
    required this.id,
    required this.event,
    required this.quantity,
    required this.totalPrice,
    required this.bookingCode,
    required this.status,
    required this.createdAt,
    this.userName,
    this.userEmail,
  });

  final String id;
  final EventEntity event;
  final int quantity;
  final double totalPrice;
  final String bookingCode;
  final BookingStatus status;
  final DateTime createdAt;
  // Populated only on admin's "all bookings" endpoint.
  final String? userName;
  final String? userEmail;
}

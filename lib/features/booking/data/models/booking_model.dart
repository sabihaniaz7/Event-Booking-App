import '../../../events/data/models/event_model.dart';
import '../../domain/entities/booking_entity.dart';

class BookingModel extends BookingEntity {
  const BookingModel({
    required super.id,
    required super.event,
    required super.quantity,
    required super.totalPrice,
    required super.bookingCode,
    required super.status,
    required super.createdAt,
    super.userName,
    super.userEmail,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['_id'] as String,
      // `event` is populated (full object) by the backend's .populate('event'),
      // so it parses just like a normal EventModel.
      event: EventModel.fromJson(json['event'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      bookingCode: json['bookingCode'] as String,
      status: BookingStatusX.fromApi(json['status'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      // Only present when the backend populated `user` (admin's all-bookings route).
      userName: json['user'] is Map ? json['user']['name'] as String? : null,
      userEmail: json['user'] is Map ? json['user']['email'] as String? : null,
    );
  }
}

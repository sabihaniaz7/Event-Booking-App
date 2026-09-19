import 'package:dio/dio.dart';

import '../models/booking_model.dart';

class BookingRemoteDataSource {
  BookingRemoteDataSource(this._dio);
  final Dio _dio;

  Future<BookingModel> createBooking(String eventId, int quantity) async {
    final res = await _dio.post(
      '/bookings',
      data: {'eventId': eventId, 'quantity': quantity},
    );
    return BookingModel.fromJson(res.data as Map<String, dynamic>);
  }

  Future<List<BookingModel>> getMyBookings() async {
    final res = await _dio.get('/bookings/mine');
    return (res.data as List)
        .map((b) => BookingModel.fromJson(b as Map<String, dynamic>))
        .toList();
  }

  Future<List<BookingModel>> getAllBookings() async {
    final res = await _dio.get('/bookings');
    return (res.data as List)
        .map((b) => BookingModel.fromJson(b as Map<String, dynamic>))
        .toList();
  }

  Future<BookingModel> updateBookingStatus(
    String bookingId,
    String status,
  ) async {
    final res = await _dio.patch(
      '/bookings/$bookingId/status',
      data: {'status': status},
    );
    return BookingModel.fromJson(res.data as Map<String, dynamic>);
  }
}

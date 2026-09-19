import 'package:event_booking_app/features/events/domain/repositories/event_repository.dart';

import '../../data/datasources/events_remote_data_source.dart';
import '../../domain/entities/event_entity.dart';

class EventsRepositoryImpl implements EventsRepository {
  EventsRepositoryImpl(this._remote);
  final EventsRemoteDataSource _remote;

  @override
  Future<List<EventEntity>> getEvents({
    String? search,
    EventCategory? category,
    bool? featuredOnly,
  }) {
    return _remote.getEvents(
      search: search,
      category: category?.label,
      featuredOnly: featuredOnly,
    );
  }

  @override
  Future<EventEntity> getEventById(String id) => _remote.getEventById(id);

  Map<String, dynamic> _fields({
    required String title,
    required String description,
    required EventCategory category,
    required String location,
    required DateTime date,
    required double ticketPrice,
    required int totalSeats,
    required bool isFeatured,
  }) {
    return {
      'title': title,
      'description': description,
      'category': category.label,
      'location': location,
      'date': date.toIso8601String(),
      'ticketPrice': ticketPrice.toString(),
      'totalSeats': totalSeats.toString(),
      'isFeatured': isFeatured.toString(),
    };
  }

  @override
  Future<EventEntity> createEvent({
    required String title,
    required String description,
    required EventCategory category,
    required String location,
    required DateTime date,
    required double ticketPrice,
    required int totalSeats,
    required bool isFeatured,
    required String imagePath,
  }) {
    final fields = _fields(
      title: title,
      description: description,
      category: category,
      location: location,
      date: date,
      ticketPrice: ticketPrice,
      totalSeats: totalSeats,
      isFeatured: isFeatured,
    );
    return _remote.createEvent(fields, imagePath);
  }

  @override
  Future<EventEntity> updateEvent({
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
  }) {
    final fields = _fields(
      title: title,
      description: description,
      category: category,
      location: location,
      date: date,
      ticketPrice: ticketPrice,
      totalSeats: totalSeats,
      isFeatured: isFeatured,
    );
    return _remote.updateEvent(id, fields, imagePath);
  }

  @override
  Future<void> deleteEvent(String id) => _remote.deleteEvent(id);
}

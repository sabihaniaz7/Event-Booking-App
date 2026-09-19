import '../entities/event_entity.dart';

abstract class EventsRepository {
  /// One method covers home feed, category browse, search AND filter —
  /// all optional params, matching the backend's single flexible endpoint.
  Future<List<EventEntity>> getEvents({
    String? search,
    EventCategory? category,
    bool? featuredOnly,
  });

  Future<EventEntity> getEventById(String id);

  // --- Admin-only operations below ---
  // `imagePath` is a local file path from image_picker; null on update
  // means "keep the existing image".
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
  });

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
  });

  Future<void> deleteEvent(String id);
}

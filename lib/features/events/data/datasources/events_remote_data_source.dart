import 'package:dio/dio.dart';

import '../models/event_model.dart';

class EventsRemoteDataSource {
  EventsRemoteDataSource(this._dio);
  final Dio _dio;

  Future<List<EventModel>> getEvents({
    String? search,
    String? category,
    bool? featuredOnly,
  }) async {
    final res = await _dio.get(
      '/events',
      queryParameters: {
        if (search != null && search.isNotEmpty) 'search': search,
        'category': ?category,
        if (featuredOnly == true) 'featured': 'true',
      },
    );
    return (res.data as List)
        .map((e) => EventModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<EventModel> getEventById(String id) async {
    final res = await _dio.get('/events/$id');
    return EventModel.fromJson(res.data as Map<String, dynamic>);
  }

  // --- Admin operations ---
  // Uses FormData (multipart) because the backend's multer middleware
  // expects a file field named "image" alongside the other text fields.
  Future<EventModel> createEvent(
    Map<String, dynamic> fields,
    String imagePath,
  ) async {
    final formData = FormData.fromMap({
      ...fields,
      'image': await MultipartFile.fromFile(imagePath),
    });
    final res = await _dio.post('/events', data: formData);
    return EventModel.fromJson(res.data as Map<String, dynamic>);
  }

  Future<EventModel> updateEvent(
    String id,
    Map<String, dynamic> fields,
    String? imagePath,
  ) async {
    final formData = FormData.fromMap({
      ...fields,
      if (imagePath != null) 'image': await MultipartFile.fromFile(imagePath),
    });
    final res = await _dio.put('/events/$id', data: formData);
    return EventModel.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> deleteEvent(String id) => _dio.delete('/events/$id');
}

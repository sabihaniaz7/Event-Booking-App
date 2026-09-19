import '../../../../core/network/dio_client.dart';
import '../../domain/entities/event_entity.dart';

class EventModel extends EventEntity {
  const EventModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.imageUrl,
    required super.location,
    required super.date,
    required super.ticketPrice,
    required super.totalSeats,
    required super.bookedSeats,
    required super.isFeatured,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: EventCategoryX.fromLabel(json['category'] as String),
      // Backend returns a relative path like "/uploads/xyz.jpg" —
      // prefix with the API host so <Image.network> can load it.
      imageUrl: '${kBaseUrl.replaceAll('/api', '')}${json['imageUrl']}',
      location: json['location'] as String,
      date: DateTime.parse(json['date'] as String),
      ticketPrice: (json['ticketPrice'] as num).toDouble(),
      totalSeats: json['totalSeats'] as int,
      bookedSeats: json['bookedSeats'] as int,
      isFeatured: json['isFeatured'] as bool? ?? false,
    );
  }
}

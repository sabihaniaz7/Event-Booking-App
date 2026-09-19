enum EventCategory { music, sports, arts, business, food, tech, community }

extension EventCategoryX on EventCategory {
  String get label {
    switch (this) {
      case EventCategory.music:
        return 'Music';
      case EventCategory.sports:
        return 'Sports';
      case EventCategory.arts:
        return 'Arts';
      case EventCategory.business:
        return 'Business';
      case EventCategory.food:
        return 'Food';
      case EventCategory.tech:
        return 'Tech';
      case EventCategory.community:
        return 'Community';
    }
  }

  static EventCategory fromLabel(String label) =>
      EventCategory.values.firstWhere(
        (c) => c.label.toLowerCase() == label.toLowerCase(),
        orElse: () => EventCategory.community,
      );
}

class EventEntity {
  const EventEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.location,
    required this.date,
    required this.ticketPrice,
    required this.totalSeats,
    required this.bookedSeats,
    required this.isFeatured,
  });

  final String id;
  final String title;
  final String description;
  final EventCategory category;
  final String imageUrl;
  final String location;
  final DateTime date;
  final double ticketPrice;
  final int totalSeats;
  final int bookedSeats;
  final bool isFeatured;

  int get seatsAvailable => totalSeats - bookedSeats;
  bool get isSoldOut => seatsAvailable <= 0;
}

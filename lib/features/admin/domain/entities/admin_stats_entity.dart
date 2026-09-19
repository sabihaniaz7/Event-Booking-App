class AdminStatsEntity {
  const AdminStatsEntity({
    required this.totalUsers,
    required this.totalEvents,
    required this.totalBookings,
    required this.totalRevenue,
  });

  final int totalUsers;
  final int totalEvents;
  final int totalBookings;
  final double totalRevenue;
}

class AdminUserEntity {
  const AdminUserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.joinedAt,
  });

  final String id;
  final String name;
  final String email;
  final DateTime joinedAt;
}

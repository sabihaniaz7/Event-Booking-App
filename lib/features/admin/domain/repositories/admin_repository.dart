import '../entities/admin_stats_entity.dart';

abstract class AdminRepository {
  Future<AdminStatsEntity> getDashboardStats();
  Future<List<AdminUserEntity>> getAllUsers();
}

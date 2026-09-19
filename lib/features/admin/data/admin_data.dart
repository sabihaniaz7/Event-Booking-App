import 'package:dio/dio.dart';

import '../domain/entities/admin_stats_entity.dart';
import '../domain/repositories/admin_repository.dart';

class AdminRemoteDataSource {
  AdminRemoteDataSource(this._dio);
  final Dio _dio;

  Future<AdminStatsEntity> getStats() async {
    final res = await _dio.get('/admin/stats');
    final d = res.data as Map<String, dynamic>;
    return AdminStatsEntity(
      totalUsers: d['totalUsers'] as int,
      totalEvents: d['totalEvents'] as int,
      totalBookings: d['totalBookings'] as int,
      totalRevenue: (d['totalRevenue'] as num).toDouble(),
    );
  }

  Future<List<AdminUserEntity>> getUsers() async {
    final res = await _dio.get('/admin/users');
    return (res.data as List).map((u) {
      final m = u as Map<String, dynamic>;
      return AdminUserEntity(
        id: m['_id'] as String,
        name: m['name'] as String,
        email: m['email'] as String,
        joinedAt: DateTime.parse(m['createdAt'] as String),
      );
    }).toList();
  }
}

class AdminRepositoryImpl implements AdminRepository {
  AdminRepositoryImpl(this._remote);
  final AdminRemoteDataSource _remote;

  @override
  Future<AdminStatsEntity> getDashboardStats() => _remote.getStats();

  @override
  Future<List<AdminUserEntity>> getAllUsers() => _remote.getUsers();
}

import '../../../../core/network/dio_client.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remote);
  final AuthRemoteDataSource _remote;

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final res = await _remote.login(email, password);
    await DioClient.saveToken(res.token);
    return res.user;
  }

  @override
  Future<UserEntity> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    final res = await _remote.signup(name, email, password);
    await DioClient.saveToken(res.token);
    return res.user;
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final token = await DioClient.readToken();
    if (token == null) return null;
    try {
      return await _remote.getMe();
    } catch (_) {
      // Token invalid/expired — clear it so the app doesn't loop.
      await DioClient.clearToken();
      return null;
    }
  }

  @override
  Future<void> logout() => DioClient.clearToken();
}

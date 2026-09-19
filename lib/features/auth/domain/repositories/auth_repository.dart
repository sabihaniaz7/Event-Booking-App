import '../entities/user_entity.dart';

/// Contract only. `presentation/` depends on this, never on the concrete
/// implementation — that's what lets you swap the data source later
/// (e.g. add offline caching) without touching a single screen.
abstract class AuthRepository {
  Future<UserEntity> login({required String email, required String password});

  Future<UserEntity> signup({
    required String name,
    required String email,
    required String password,
  });

  Future<UserEntity?> getCurrentUser();

  Future<void> logout();
}

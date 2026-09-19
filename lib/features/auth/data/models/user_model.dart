import '../../domain/entities/user_entity.dart';

/// Data-layer model. This is the ONLY place that knows what the backend's
/// JSON shape looks like. If the backend response ever changes,
/// edit this one file — nothing else in the app needs to know.
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    super.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: (json['role'] as String?) == 'admin'
          ? UserRole.admin
          : UserRole.user,
      avatarUrl: json['avatarUrl'] as String?,
    );
  }
}

/// Wraps the login/signup response: { token, user }
class AuthResponseModel {
  AuthResponseModel({required this.token, required this.user});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      token: json['token'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  final String token;
  final UserModel user;
}

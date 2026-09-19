enum UserRole { user, admin }

/// Domain entity — what the rest of the app works with.
/// Never has `fromJson`/`toJson` here; that belongs to UserModel in `data/`.
class UserEntity {
  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.avatarUrl,
  });

  final String id;
  final String name;
  final String email;
  final UserRole role;
  final String? avatarUrl;

  bool get isAdmin => role == UserRole.admin;
}

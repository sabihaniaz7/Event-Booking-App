import 'package:dio/dio.dart';

import '../models/user_model.dart';

/// Talks to the backend's /api/auth/* endpoints. Nothing here knows about
/// Riverpod or UI — it just returns models or throws.
class AuthRemoteDataSource {
  AuthRemoteDataSource(this._dio);
  final Dio _dio;

  Future<AuthResponseModel> login(String email, String password) async {
    final res = await _dio.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    return AuthResponseModel.fromJson(res.data as Map<String, dynamic>);
  }

  Future<AuthResponseModel> signup(
    String name,
    String email,
    String password,
  ) async {
    final res = await _dio.post(
      '/auth/signup',
      data: {'name': name, 'email': email, 'password': password},
    );
    return AuthResponseModel.fromJson(res.data as Map<String, dynamic>);
  }

  Future<UserModel> getMe() async {
    final res = await _dio.get('/auth/me');
    return UserModel.fromJson(res.data as Map<String, dynamic>);
  }
}

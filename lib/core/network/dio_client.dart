import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'api_exception.dart';

import 'package:flutter/foundation.dart';

String get kBaseUrl {
  if (kIsWeb) {
    return 'http://localhost:5000/api';
  } else if (defaultTargetPlatform == TargetPlatform.android) {
    // computer's local Wi-Fi IP address.
    // This allows both physical devices and emulators to connect to your backend.
    return 'http://[IP_ADDRESS]/api';
  } else {
    return 'http://[IP_ADDRESS]/api';
  }
}

const _storage = FlutterSecureStorage();
const _tokenKey = 'auth_token';

/// Single Dio instance for the whole app. Every repository's remote
/// data source takes this in its constructor — never creates its own —
/// so the auth token and error handling stay consistent everywhere.
class DioClient {
  DioClient._();

  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: kBaseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.read(key: _tokenKey);
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) {
          // Normalize every failure into ApiException so UI code
          // never has to know about Dio/HTTP details.
          final message = error.response?.data is Map
              ? (error.response?.data['message'] ?? 'Something went wrong')
              : 'Network error. Please check your connection.';
          debugPrint(message);
          handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              error: ApiException(
                message,
                statusCode: error.response?.statusCode,
              ),
            ),
          );
        },
      ),
    );

    return dio;
  }

  static Future<void> saveToken(String token) =>
      _storage.write(key: _tokenKey, value: token);
  static Future<String?> readToken() => _storage.read(key: _tokenKey);
  static Future<void> clearToken() => _storage.delete(key: _tokenKey);
}

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:parcial_2/helpers/interceptor.dart';


class AuthService {
  static final dio = Dio()..interceptors.add(AuthInterceptor());
  static final url = 'https://api.escuelajs.co/api/v1';
  static const _storage = FlutterSecureStorage();

  static Future<String?> getToken(String email, String password) async {
    final Response response = await dio.post(
      '$url/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 201) {
      final token = response.data['access_token'];
      await _storage.write(key: 'token', value: token);
      return null; // éxito
    } else {
      return response.data['message'] ?? 'Error al iniciar sesión';
    }
  }
}
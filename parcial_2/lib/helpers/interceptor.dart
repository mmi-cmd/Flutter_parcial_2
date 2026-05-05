import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  static final _storage = FlutterSecureStorage();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String token = await _storage.read(key: 'token') ?? '';
    options.headers['Authorization'] = 'Bearer $token';
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage = 'Error inesperado.';

    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      errorMessage = 'Error de conexión. Revisa tu conexión a internet.';
    } else if (err.type == DioExceptionType.badResponse) {
      final statusCode = err.response?.statusCode;
      if (statusCode == 400) {
        errorMessage = 'Petición incorrecta.';
      } else if (statusCode == 401) {
        errorMessage = 'Usuario no autorizado';
      } else if (statusCode == 500) {
        errorMessage = 'Servicio no disponible';
      } else {
        errorMessage = 'Servicio no disponible';
      }
    } else if (err.response != null) {
      errorMessage = 'Error del servidor: ${err.response?.statusCode}';
    }

    // Solo una llamada a handler — sin el handler.next(err) previo
    return handler.next(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: errorMessage,
      ),
    );
  }
}
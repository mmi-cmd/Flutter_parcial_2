import 'package:dio/dio.dart';
import 'package:parcial_2/helpers/interceptor.dart';
import 'package:parcial_2/model/user_model.dart';


class UserService {
  static final dio = Dio()..interceptors.add(AuthInterceptor());
  static final url = 'https://api.escuelajs.co/api/v1';

  static Future<UserModel?> getProfile() async {
    final Response response = await dio.get('$url/auth/profile');

    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw Exception('Error al obtener el perfil del usuario');
    }
  }
}
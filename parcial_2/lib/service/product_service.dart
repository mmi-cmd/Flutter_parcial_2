import 'package:dio/dio.dart';
import 'package:parcial_2/helpers/interceptor.dart';
import 'package:parcial_2/model/product_model.dart';


class ProductService {
  static final dio = Dio()..interceptors.add(AuthInterceptor());
  static final url = 'https://api.escuelajs.co/api/v1';

  static Future<List<ProductModel>> getProducts({
    int offset = 0,
    int limit = 8,
  }) async {
    try {
      final Response response = await dio.get(
        '$url/products?offset=$offset&limit=$limit',
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((item) => ProductModel.fromJson(item)).toList();
      }
      throw Exception('Error al cargar productos');
    } on DioException catch (e) {
      throw Exception(e.error ?? 'Error al cargar productos');
    }
  }

  static Future<String?> createProduct({
    required String title,
    required double price,
    required String description,
    required int categoryId,
    required String imageUrl,
  }) async {
    try {
      final Response response = await dio.post(
        '$url/products/',
        data: {
          'title': title,
          'price': price,
          'description': description,
          'categoryId': categoryId,
          'images': [imageUrl],
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return null;
      }
      return 'Error al crear producto';
    } on DioException catch (e) {
      return e.error?.toString() ?? 'Error al crear producto';
    } catch (e) {
      return e.toString();
    }
  }
}
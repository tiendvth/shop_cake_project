import 'package:common/common.dart';

abstract class ListFoodRepository {
  Future listFood(search);

  Future addFoodToOrder(foodId, quantity);

  Future listCategory(search);
}

class ListFoodRepositoryImpl implements ListFoodRepository {
  final Dio _dio;

  ListFoodRepositoryImpl(this._dio);

  @override
  Future<Map<String, dynamic>> listFood(search) async {
    try {
      final respone = await _dio.post(
        '/api/cake/getAll',
        queryParameters: {"name": "", "size": 2, "page": 2, "priceTo": 10, "priceFrom": 100, "token": ""},
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );
      if (respone.statusCode == 200) {
        return respone.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load data!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }

  @override
  Future<Map<String, dynamic>> addFoodToOrder(foodId, quantity) async {
    final respone = await _dio.post('/api/v1/carts', data: {"foodId": foodId, "quantity": quantity});
    return respone.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> listCategory(search) async {
    try {
      final respone = await _dio.post(
        '/api/category/getAll',
        queryParameters: {"name": "", "size": 10, "page": 1, "token": ""},
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );
      if (respone.statusCode == 200) {
        return respone.data as Map<String, dynamic>;
      }
      else {
        throw Exception('Failed to load data!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }
}

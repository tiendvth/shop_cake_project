import 'package:common/common.dart';
import 'package:shop_cake/auth/AuthServiceImpl.dart';

abstract class ListFoodRepository {
  Future listFood(search);

  Future addFoodToOrder(foodId, quantity);

  Future listCategory(search);
}

class ListFoodRepositoryImpl implements ListFoodRepository {
  final Dio _dio;
  final AuthServiceImpl _authService = AuthServiceImpl();

  ListFoodRepositoryImpl(this._dio);

  @override
  Future<Map<String, dynamic>> listFood(search) async {
    try {
      Map<String, dynamic> body = {
        "name": "",
        "size": 10,
        "page": 1,
        "priceTo": 10,
        "token": "${_authService.getAccessToken()}"
      };
      final respone = await _dio.post(
        '/api/cake/getAll',
        data: body
      );
      if (respone.statusCode == 200) {
        print('responeFoood: $respone');
        return respone.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load data!');
      }
    } catch (e) {
      print('ExceptionError: $e');
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
      Map<String, dynamic> body = {
        "name": "",
        "size": 10,
        "page": 1,
        "token": "${_authService.getAccessToken()}"
      };
      final respone = await _dio.post(
        '/api/category/getAll',
        data: body,
      );
      print('respone: $respone');
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

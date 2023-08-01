import 'package:common/common.dart';
import 'package:shop_cake/auth/AuthServiceImpl.dart';

abstract class ListFoodRepository {
  Future listFood(search, priceFrom, priceTo);

  Future addFoodToOrder(cakeId, price, quantity);

  Future listCategory(search);
}

class ListFoodRepositoryImpl implements ListFoodRepository {
  final Dio _dio;
  final AuthServiceImpl _authService = AuthServiceImpl();

  ListFoodRepositoryImpl(this._dio);

  @override
  Future<Map<String, dynamic>> listFood(search, priceFrom, priceTo) async {
    try {
      Map<String, dynamic> body = {
        "name": search,
        "size": 100,
        "page": 1,
        "priceTo": priceTo,
        "priceFrom": priceFrom,
        "token": "${_authService.getAccessToken()}"
      };
      final respone = await _dio.post(
          '/api/cake/getAll',
          data: body
      );
      if (respone.statusCode == 200 && respone.data['data'] != null && respone.data['data'].isNotEmpty) {
        return respone.data as Map<String, dynamic>;
      } else if (respone.statusCode == 200 && respone.data['code'] == 204 && respone.data['data'] == null) {
        return respone.data as Map<String, dynamic>;
      }
      else {
        throw Exception('Failed to load data!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }

  @override
  Future<Map<String, dynamic>> addFoodToOrder(cakeId, price, quantity) async {
    final respone = await _dio.post('/api/shoppingCartTmt/create',
        data: {"cakeId": cakeId,
              "price": price,
              "quantity": quantity
              });
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

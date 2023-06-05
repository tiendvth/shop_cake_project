import 'package:common/common.dart';

abstract class ListFoodRepository {
  Future listFood(search);

  Future addFoodToOrder(foodId, quantity);
}

class ListFoodRepositoryImpl implements ListFoodRepository {
  final Dio _dio;

  ListFoodRepositoryImpl(this._dio);

  @override
  Future<Map<String, dynamic>> listFood(search) async {
    final respone = await _dio.get('/api/v1/foods',queryParameters: {
      "status":"ACTIVE",
      "page":1,
      "limit":100,
      "name":search
    });
    return respone.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> addFoodToOrder(foodId, quantity) async {
    final respone = await _dio
        .post('/api/v1/carts', data: {"foodId": foodId, "quantity": quantity});
    return respone.data as Map<String, dynamic>;
  }
}

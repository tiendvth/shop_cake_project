import 'package:common/common.dart';

abstract class DetailFoodRepository {
  Future detailFood(int? id);

  Future creatNew(data);

  Future addFoodToOrder(foodId, price, quantity);
}

class DetailFoodRepositoryImpl implements DetailFoodRepository {
  final Dio _dio;

  DetailFoodRepositoryImpl(this._dio);

  @override
  Future<Map<String, dynamic>> detailFood(int? id) async {
    final respone = await _dio.get('/api/cake/findById/${id}');
    print("-----------------------------${respone.statusCode}");
    return respone.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> creatNew(data) async {
    final result = await _dio.post(
      '/api/v1/foods/create',
    );
    return result.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> addFoodToOrder(cakeId, price, quantity) async {
    final respone = await _dio
        .post('/api/shoppingCartTmt/create', data: {
          "cakeId": cakeId,
          "price": price,
          "quantity": quantity.toString()
        });
    return respone.data as Map<String, dynamic>;
  }
}

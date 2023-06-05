import 'package:network/network.dart';

abstract class CartRepository {
  Future ListCart();

  Future updateFoodToCart(foodId, quantity);

  Future removeFoodToCart(foodId);
}

class CartRepositoryImpl implements CartRepository {
  final Dio _dio;

  CartRepositoryImpl(this._dio);

  @override
  Future<Map<String, dynamic>> ListCart() async {
    final result = await _dio.get(
      "/api/v1/carts",
    );
    print('+++++++++++++++++++++${result.statusCode}');
    return result.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> updateFoodToCart(foodId, quantity) async {
    final result = await _dio.post("/api/v1/carts", data: {
      "foodId": foodId,
      "quantity": quantity,
      "type": "UPDATE",
    });
    return result.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> removeFoodToCart(foodId) async {
    final result = await _dio.delete(
      "/api/v1/carts/${foodId}",
    );
    return result.data as Map<String, dynamic>;
  }
}

import 'package:network/network.dart';

abstract class CartRepository {
  Future listCart();

  Future updateFoodToCart(foodId, quantity);

  Future removeFoodToCart(foodId);
}

class CartRepositoryImpl implements CartRepository {
  final Dio _dio;

  CartRepositoryImpl(this._dio);

  @override
  Future<Map<String, dynamic>> listCart() async {
    try {
      final result = await _dio.post("/api/shoppingCartTmt/getAll", data: {
        "size": 10,
        "page": 1,
      });
      return result.data as Map<String, dynamic>;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Map<String, dynamic>> updateFoodToCart(
      shoppingCartTmtId, quantity) async {
    final result = await _dio.post(
      "/api/shoppingCartTmt/update/${shoppingCartTmtId}",
      data: {
        "quantity": quantity,
      },
    );
    return result.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> removeFoodToCart(shoppingCartTmtId) async {
    final result = await _dio.get(
      "/api/shoppingCartTmt/delete/${shoppingCartTmtId}",
    );
    return result.data as Map<String, dynamic>;
  }
}

import 'package:network/network.dart';

abstract class PaymentRepository {
  // Future listCart();

  Future Payment( // String noteController,
      // String addressController,
      // String nameController,
      // String phoneController,
      // String typeController,
      {
    int? deliveryAddressId,
    String? note,
    String? reason,
    String? deliveryDate,
    List? orderDetails,
  });
}

class PaymentRepositoryImpl implements PaymentRepository {
  final Dio _dio;

  PaymentRepositoryImpl(this._dio);

  // @override
  // Future<Map<String, dynamic>> listCart() async {
  //   final result = await _dio.post("/api/shoppingCartTmt/getAll", data: {
  //     "size": 10,
  //     "page": 1,
  //   });
  //   return result.data as Map<String, dynamic>;
  // }

  @override
  Future<Map<String, dynamic>> Payment( // String noteController,
      // String addressController,
      // String nameController,
      // String phoneController,
      // String typeController,
      {
    int? deliveryAddressId,
    String? note,
    String? reason,
    String? deliveryDate,
    List? orderDetails,
  }) async {
    try {
      final result = await _dio.post('/api/order/create', data: {
        "deliveryAddressId": deliveryAddressId,
        "note": note,
        "reason": reason,
        "deliveryDate": deliveryDate,
        "orderDetails": orderDetails,
      });
      return result.data as Map<String, dynamic>;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}

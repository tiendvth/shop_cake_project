import 'dart:ffi';

import 'package:network/network.dart';

abstract class PaymentRepository {
  Future listCart();

  Future addOrder(
    Int deliveryAddressId,
    String note,
    String reason,
    String deliveryDate
  );

  Future Payment(
    String noteController,
    String addressController,
    String nameController,
    String phoneController,
    String typeController,
  );
}

class PaymentRepositoryImpl implements PaymentRepository {
  final Dio _dio;

  PaymentRepositoryImpl(this._dio);

  @override
  Future<Map<String, dynamic>> listCart() async {
    final result = await _dio.post("/api/shoppingCartTmt/getAll", data: {
      "size": 10,
      "page": 1,
    });
    return result.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> Payment(
    String noteController,
    String addressController,
    String nameController,
    String phoneController,
    String typeController,
  ) async {
    final result = await _dio.post('/api/v1/orders', data: {
      "note": noteController,
      "shipAddress": addressController,
      "shipName": nameController,
      "shipPhone": phoneController,
      "shipType": typeController
    });
    return result.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> addOrder(
      Int deliveryAddressId,
      String note,
      String reason,
      String deliveryDate

      ) async {
    final result = await _dio.post('/api/order/create', data: {
      "deliveryAddressId":1,
      "note":"không có gì",
      "reason":"không có gì",
      "status":1,
      "deliveryDate":"2023-12-12 06:00",
      "orderDetails" : [
          {
          "cakeId":1,
          "price":100,
          "quantity":1
          },
          {
          "cakeId":2,
          "price":100,
          "quantity":1
          }
        ]
      });
    return result.data as Map<String, dynamic>;
  }

}

import 'package:network/network.dart';

abstract class PaymentRepository {
  Future listCart();

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
    final result = await _dio.get(
      "/api/v1/carts",
    );
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
}

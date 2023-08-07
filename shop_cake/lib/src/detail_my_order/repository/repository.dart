import 'package:common/common.dart';

abstract class DetailMyOrderRepository{
  Future detailMyOrder(int? id);
  Future canCel(int id, String canCelController,);
  Future procedure(int id);
}
class DetailMyOrderRepositoryImpl implements DetailMyOrderRepository{
  final Dio _dio;
  DetailMyOrderRepositoryImpl(this._dio);
  @override
  Future<Map<String, dynamic>> detailMyOrder(int? id) async {
    final respone = await _dio.get('/api/order/findById/${id}');
    return respone.data as Map<String, dynamic>;
  }
  @override
  Future<Map<String, dynamic>> canCel(int id, String canCelController,) async {
    final result = await _dio.put('/api/v1/orders/$id', data: {
      'id':id,
      "reason": canCelController,
    });
    return result.data as Map<String, dynamic>;
  }

  @override
  Future procedure(int id) async{
    final result = await _dio.post('/api/order/procedure/$id', data: {
      "procedure": "hoàn thành"
      }
    );
    return result.data as Map<String, dynamic>;
  }

}
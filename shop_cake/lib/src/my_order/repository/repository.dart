import 'package:common/common.dart';

abstract class MyOderRepository {
  Future listOrder(status);
}

class MyOderRepositoryImpl implements MyOderRepository{
  final Dio _dio;
  MyOderRepositoryImpl(this._dio);
  @override
  Future<Map<String, dynamic>> listOrder(status) async{
    final reposne = await _dio.get('/api/v1/orders',queryParameters: {
      "status":status
    });
    return reposne.data as Map<String, dynamic>;
  }
}
import 'package:common/common.dart';

abstract class MyOderRepository {
  Future listOrder(status);
}

class MyOderRepositoryImpl implements MyOderRepository{
  final Dio _dio;
  MyOderRepositoryImpl(this._dio);
  @override
  Future<Map<String, dynamic>> listOrder(status) async{
    final reposne = await _dio.post('/api/order/getAll',data: {
        "size": 100,
        "page": 1,
        "userId": 1
    });
    return reposne.data as Map<String, dynamic>;
  }
}
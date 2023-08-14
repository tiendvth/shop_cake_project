import 'package:common/common.dart';
import 'package:shop_cake/src/favourite/repository/favourite_repository.dart';

class FavouriteRepoImpl implements FavouriteRepository {
  final Dio _dio;

  FavouriteRepoImpl(this._dio);

  @override
  Future<Map<String, dynamic>> addFavourite(int? id) async {
    try {
      final response = await _dio.post('/api/cakeLove/create', queryParameters: {
        "cakeId": id,
      });
      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
  }
}

  @override
  Future<Map<String, dynamic>> deleteFavourite(int? id) async {
    try {
      final response = await _dio.post('/api/cakeLove/delete', queryParameters: {
        "cakeId": id,
      });
      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getFavourite() async {
    try {
      final response = await _dio.get('/api/cakeLove/getByUser');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }
  
}
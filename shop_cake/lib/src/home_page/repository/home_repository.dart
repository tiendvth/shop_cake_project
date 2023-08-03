// File user_repository
// @project food
// @author phanmanhha198 on 15-07-2021
import 'package:network/network.dart';


abstract class HomeRepository {
  //Future login(String username, String password);
  Future deviceToken(String? device_token);
  Future getAll(search, priceTo,priceFrom);
  Future getBySpecial();
  Future getByCategory({int? id});
}

class HomeRepositoryImpl implements HomeRepository {
  final Dio _dio;

  HomeRepositoryImpl(this._dio);

  // @override
  // Future<Map<String,dynamic>> login(String username, String password) async {
  //    final result = await _dio.post("iam/api/v0/login-with-ldap",
  //       data: {"username": username, "password": password});
  //    return result.data as Map<String,dynamic>;
  // }

  @override
  Future<Map<String,dynamic>> deviceToken(String? device_token) async {
     final result = await _dio.post("/api/v1/device-tokens",
        data: {
          "token": device_token,
          "type": "ANDROID"
        });
     return result.data as Map<String,dynamic>;
  }

  @override
  Future<Map<String,dynamic>> getAll(search, priceTo,priceFrom) async {
    try{
      Map<String, dynamic> body = {
        "name": search,
        "size": 100,
        "page": 1,
        "priceTo": priceTo,
        "priceFrom": priceFrom,
      };
      final respone = await _dio.post(
          '/api/cake/getAll',
          data: body
      );
      if (respone.statusCode == 200 && respone.data['data'] != null && respone.data['data'].isNotEmpty) {
        return respone.data as Map<String, dynamic>;
      } else if (respone.statusCode == 200 && respone.data['code'] == 204 && respone.data['data'] == null) {
        return respone.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load data!');
      }
    }catch (e) {
      throw Exception('Failed to load data!');
    }
  }

  Future<Map<String, dynamic>> getBySpecial() async {
    try{
      final respone = await _dio.get(
          '/api/cake/getBySpecial',
      );
      if (respone.statusCode == 200 && respone.data['data'] != null && respone.data['data'].isNotEmpty) {
        return respone.data as Map<String, dynamic>;
      } else if (respone.statusCode == 200 && respone.data['code'] == 204 && respone.data['data'] == null) {
        return respone.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load data!');
      }
    }catch (e) {
      throw Exception('Failed to load data!');
    }
  }

  @override
  Future<Map<String, dynamic>> getByCategory({int? id}) async {
    try {
      final response = await _dio.post(
        '/api/cake/findByCategory/$id',
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }
}
